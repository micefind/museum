const db = require('../db/index')

// 添加公告
exports.addAnnouncement = (req, res) => {
  let data = req.body
  const sql = `insert into ms_announcement set ?`
  // 获取当前时间
  let myDate = new Date()
  myDate = myDate.toLocaleDateString()
  data = {...data, date: myDate}
  db.query(sql, data, (err, results) => {
    if (err) return res.send({status: 1, msg: err.message})
    if (results.affectedRows !== 1) return res.send({ status: 1, msg: err })
    res.send({status: 0, msg: '发布公告成功'})
  })
}

// 获取公告
exports.getAnnouncement = (req, res) => {
  const query = req.query
  let sql = query.id?`select * from ms_announcement where id=?`:`select * from ms_announcement`
  db.query(sql, query.id, (err, results) => {
    if (err) return res.send({status: 1, msg: err.message})
    res.send({
      status: 0,
      announcement: results,
      total: results.length
    })
  })
}