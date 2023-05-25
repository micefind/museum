// 导入数据库操作模块
const db = require('../db/index')
// 导入生成 token 的包
const jwt = require('jsonwebtoken')
// 导入全局配置文件
const config = require('../config')

// 管理员登录
exports.login = (req, res) => {
  const userinfo = req.body
  const sql = `select * from ms_admin where username=?`
  db.query(sql, userinfo.username, (err, results) => {
    if (err) return res.send({status: 1, message: res.message})
    if (results.length !== 1) return res.send({status: 1, message: '用户名不存在'})
    if (userinfo.password !== results[0].password) return res.send({status: 1, message: '密码错误'})
    const user = { ...results[0], password: '' }
    // 对用户信息加密 生成 token 字符串
    const tokenStr = jwt.sign(user, config.jwtSecretKey, {expiresIn: config.expiresIn})
    res.send({
      status: 0,
      message: '登录成功',
      token: 'Bearer ' + tokenStr
    })
  })
}