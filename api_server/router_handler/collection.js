const db = require('../db/index')
// 导入处理路径的 path 核心模块
const path = require('path')

// 添加分类
exports.addcate = (req, res) => {
  const cateInfo = req.body
  // 查询添加分类是否已存在
  const sql = `select * from ms_cate where catename=?`
  db.query(sql, cateInfo.catename, (err, results) => {
    if (err) return res.send({status: 1, msg: err.message})
    if (results.length > 0) return res.send({status: 1, msg: '分类已存在'})
    // 添加分类
    const sqlStr = `insert into ms_cate set?`
    db.query(sqlStr, cateInfo, (err, results) => {
      if (err) return res.send({status: 1, msg: err.message})
      if (results.affectedRows !== 1) return res.send({ status: 1, message: '添加分类失败' })
      res.send({status: 0, msg: '添加分类成功'})
    })
  })
}

// 获取分类名称
exports.getCate = (req, res) => {
  const queryInfo = req.query
  let sql = queryInfo.cate_id?`select * from ms_cate where id=?`:`select * from ms_cate`
  db.query(sql, queryInfo.cate_id, (err, results) => {
    if (err) return res.send({status: 1, msg: err.message})
    res.send({
      status: 0,
      cateList: results
    })
  })
}

// 上传图片
exports.upload = (req, res) => {
  res.send({
    status: 0,
    msg: '上传成功',
    // 图片在服务器端的存放路径
    picUrl: path.join('/uploads', req.file.filename)
  })
}

// 添加藏品
exports.addCollection = (req, res) => {
  let colInfo = {
    ...req.body,
    // 藏品被查看次数默认0
    view: 0
  }
  // 查询是否已存在同名藏品
  const sql = `select * from ms_collection where title=?`
  db.query(sql, colInfo.title, (err, results) => {
    if (err) return res.send({status: 1, msg: err.message})
    if (results.length > 0) return res.send({status: 1, msg: '藏品已存在'})
    // 添加藏品
    const sqlStr =`insert into ms_collection set?`
    db.query(sqlStr, colInfo, (err, results) => {
      if (err) return res.send({status: 1, msg: err.message})
      if (results.affectedRows !== 1) return res.send({ status: 1, message: '添加藏品失败' })
      res.send({status: 0, msg: '添加藏品成功'})
    })
  })
}

// 获取藏品信息
exports.getCol = (req, res) => {
  const queryInfo = req.query
  let sql = ''
  let query = ''
  const start = queryInfo.pagesize * (queryInfo.pagenum-1)
  const end = parseInt(start) + parseInt(queryInfo.pagesize)
  // 根据参数 col_id、cate_id、query 定义查询语句
  if (queryInfo.col_id && queryInfo.col_id !== '') {
    sql = `select * from ms_collection where id=?`
    query = parseInt(queryInfo.col_id)
  }
  else if (queryInfo.cate_id && queryInfo.cate_id !== '') {
    sql = `select * from ms_collection where cate_id=?`
    query = parseInt(queryInfo.cate_id)
  }
  else if (queryInfo.query) {
    sql = `select * from ms_collection where title like concat('%',?,'%')`
    query = queryInfo.query
  }
  else sql = `select * from ms_collection`
  db.query(sql, query, (err, results) => {
    if (err) return res.send({status: 1, msg: err.message})
    // 根据页码值返回数组切片
    let colList = []
    colList = results.reverse()
    if (sql === 'select * from ms_collection') {
      colList = results.slice(start, end)
    }
    res.send({
      status: 0,
      colList,
      total: results.length
    })
  })
}

// 删除藏品
exports.deleteCol = (req, res) => {
  const queryInfo = req.query
  const sql = `delete from ms_collection where id=?`
  // 省略查询藏品是否存在
  db.query(sql, queryInfo.id, (err, results) => {
    if (err) return res.send({status: 1, msg: err.message})
    res.send({status: 0, message: '删除藏品成功'})
  })
}

// 编辑藏品信息
exports.updateColInfo = (req, res) => {
  const sql = `update ms_collection set ? where id=?`
  db.query(sql, [req.body, req.body.id], (err, results) => {
    if (err) return res.send({status: 1, msg: err.message})
    res.send({status:0, msg: '更新藏品信息成功'})
  })
}

// 增加藏品被浏览次数
exports.addView = (req, res) => {
  const sql = `update ms_collection set ? where id=?`
  db.query(sql, [req.body, req.body.id], (err, results) => {
    if (err) return res.send({status: 1, msg: err.message})
    res.send({status:0, msg: 'view +1'})
  })
}

// 添加小程序首页轮播图数据
exports.addSlideShow = (req, res) => {
  const slideShowPic = req.body
  const sqlStr =`insert into ms_slideShow set?`
    db.query(sqlStr, slideShowPic, (err, results) => {
      if (err) return res.send({status: 1, msg: err.message})
      if (results.affectedRows !== 1) return res.send({ status: 1, message: '添加轮播图失败' })
      res.send({status: 0, msg: '添加轮播图成功'})
    })
}

// 添加用户反馈信息
exports.addUserFeedback = (req, res) => {
  let data = req.body
  let timestamp = new Date()
  timestamp = timestamp.toLocaleDateString()

  data = {
    ...data,
    timestamp: timestamp
  }
  const sql =`insert into ms_feedback set?`
    db.query(sql, data, (err, results) => {
      if (err) return res.send({status: 1, msg: err.message})
      if (results.affectedRows !== 1) return res.send({ status: 1, message: '添加反馈信息失败' })
      res.send({status: 0, msg: '添加反馈信息成功'})
    })
}

// 获取后台首页数据
exports.getOverviews = (req, res) => {
  let collectionData = []
  let slideShowData = []
  let feedbackData = []
  let announcementData = []

  // 1. 获取明星藏品数据
  const sql1 = `select * from ms_collection where cate_id=?`
  db.query(sql1, 18, (err,results) => {
    collectionData = results
  })
  // 2. 获取轮播图数据
  const sql2 = `select * from ms_slideshow`
  db.query(sql2, (err,results) => {
    slideShowData = results
  })
  // 3. 获取反馈信息
  const sql3 = `select * from ms_feedback`
  db.query(sql3, (err,results) => {
    feedbackData = results.reverse()
  })

  // 4. 获取公告信息
  const sql4 = `select * from ms_announcement`
  db.query(sql4, (err,results) => {
    announcementData = results.reverse()
  })

  setTimeout(() => {
    res.send({
      status: 0,
      msg: '获取信息成功',
      collectionData,
      slideShowData,
      feedbackData,
      announcementData
    })
  }, 50)
}

// 获取轮播图
exports.getSlideShow = (req, res) => {
  const sql2 = `select * from ms_slideshow`
  db.query(sql2, (err,results) => {
    res.send({
      status: 0,
      msg: '成功',
      slideShowData: results
    })
  })
}

// 获取公告
exports.getAnnounment = (req, res) => {
  const sql4 = `select * from ms_announcement`
  db.query(sql4, (err,results) => {
    res.send({
      status: 0,
      msg: '成功',
      announmentList: results
    })
  })
}

// 获取反馈
exports.getFeedback = (req, res) => {
  const user_id = req.body.user_id
  const sql = `select * from ms_feedback where user_id=?`
  db.query(sql, user_id, (err,results) => {
    res.send({
      status: 0,
      msg: '成功',
      feedbackData: results
    })
  })
}

