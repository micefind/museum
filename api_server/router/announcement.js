const express = require('express')
const router = express.Router()

const announcementHandler = require('../router_handler/announcement')

// 添加公告
router.post('/addannouncement', announcementHandler.addAnnouncement)
// 获取公告
router.get('/getannouncement', announcementHandler.getAnnouncement)



module.exports = router