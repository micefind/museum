const express = require('express')
const router = express.Router()

const userHandler = require('../router_handler/user')

// 用户注册
router.post('/public/user/register', userHandler.register)

// 用户登录
router.post('/public/user/login', userHandler.login)

// 获取所有用户数据
router.get('/user/getdata', userHandler.getUserInfo)

// 删除用户
router.delete('/deluser', userHandler.deleteUser)

// 编辑用户信息
router.post('/editUserInfo', userHandler.editUserInfo)


module.exports = router