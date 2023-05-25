// 导入数据库操作模块
const db = require('../db/index')
// 导入生成 token 的包
const jwt = require('jsonwebtoken')
// 导入全局配置文件
const config = require('../config')

// 用户注册
exports.register = (req, res) => {
  let userinfo = req.body
  if ( !userinfo.username || !userinfo.password ) {
    return res.send({ status: 1, message: '用户名或密码不合法' })
  }
  // 查询用户名是否被占用
  const sqlStr = `select * from ms_user where username=?`
  db.query(sqlStr, userinfo.username, (err, results) => {
    if (err) return res.send({ status: 1, message: res.message })
    if (results.length > 0) return res.send({ status: 1, message: '用户名被占用' })
    // 数据校验通过
    const sql = `insert into ms_user set ?`
    // 获取当前时间
    let myDate = new Date()
    myDate = myDate.toLocaleDateString()
    userinfo = {...userinfo, date: myDate, state: 0}
    db.query(sql, userinfo, (err, results) => {
      if (err) return res.send({ status: 1, message: res.message })
      if (results.affectedRows !== 1) return res.send({ status: 1, message: '用户注册失败' })
      res.send({ status: 0, message: '注册成功' })
    })
  })
}

// 用户登录
exports.login = (req, res) => {
  const userinfo = req.body
  const sql = `select * from ms_user where username=?`
  db.query(sql, userinfo.username, (err, results) => {
    if (err) return res.send({status: 1, message: err.message})
    if (results.length !== 1) return res.send({status: 1, message: '登录失败'})
    if (userinfo.password !== results[0].password) return res.send({status: 1, message: '密码错误'})
    let user_id = results[0].id
    const user = { ...results[0], password: '' }
    // 对用户信息加密 生成 token 字符串
    const tokenStr = jwt.sign(user, config.jwtSecretKey, {expiresIn: config.expiresIn})
    res.send({
      status: 0,
      message: '登录成功',
      user_id,
      token: 'Bearer ' + tokenStr
    })
  })
}

// 获取用户数据
exports.getUserInfo = (req, res) => {
  const queryInfo = req.query
  const sql = queryInfo.query? `select * from ms_user where username like concat('%',?,'%')`:`select * from ms_user`
  db.query(sql, queryInfo.query, (err, results) => {
    if (err) return res.send({status: 1, message: res.message})
    // 用户状态为0时 返回 true
    results.forEach(element => {
      element.state = element.state === 0 ? true : false
    })
    const start = queryInfo.pagesize * (queryInfo.pagenum-1)
    const end = parseInt(start) + parseInt(queryInfo.pagesize)
    res.send({
      status: 0,
      userList: results.slice(start, end),
      total: results.length
    })
  })
}

// 删除用户
exports.deleteUser= (req, res) => {
  const queryInfo = req.query
  const sql = `delete from ms_user where id=?`
  // 省略查询用户是否存在
  db.query(sql, queryInfo.id, (err, results) => {
    if (err) return res.send({status: 1, message: res.message})
    res.send({status: 0, message: '删除用户成功'})
  })
}

// 编辑用户信息
exports.editUserInfo = (req, res) => {
  const sql = `update ms_user set ? where id=?`
  db.query(sql, [req.body, req.body.id], (err, results) => {
    if (err) return res.send({status: 1, msg: err.message})
    res.send({status:0, msg: '更新用户信息成功'})
  })
}