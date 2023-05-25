const express = require('express')
const router = express.Router()

// 导入路由处理模块
const adminHandler = require('../router_handler/admin')

// 管理员登录
router.post('/public/login', adminHandler.login)


module.exports = router