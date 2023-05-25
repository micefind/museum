const express = require('express')
const router = express.Router()

// 导入解析 formdata 格式数据的包
const multer = require('multer')

// 创建 multer 对象，但直接保存图片，文件大小不变
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads')
    //文件保存路径
  },
  filename: function (req, file, cb) {
    file.filename = 'col_pic' + '-' + Date.now() + '.jpg'
    cb(null, file.filename)
    //存储文件名
  }
})
const upload = multer({ storage: storage })

// 导入路由处理模块
const collectionHandler = require('../router_handler/collection')

// 添加分类
router.post('/addcate', collectionHandler.addcate)
// 添加藏品
router.post('/addcol', upload.single('col_pic'), collectionHandler.addCollection)
// 获取藏品信息
router.get('/getcol', collectionHandler.getCol)
// 获取分类名
router.get('/getcate', collectionHandler.getCate)
// 上传图片
router.post('/upload', upload.single('col_pic'), collectionHandler.upload)
// 删除藏品
router.delete('/delcol', collectionHandler.deleteCol)
// 编辑藏品信息
router.post('/updatecolinfo', collectionHandler.updateColInfo)
// 增加藏品被浏览次数
router.post('/addview', collectionHandler.addView)
// 声明：为缩短开发时间，以下是项目所需其他接口
// 添加小程序首页轮播图数据
router.post('/addslideShow', collectionHandler.addSlideShow)
// 添加用户反馈信息
router.post('/addfeedback', collectionHandler.addUserFeedback)
// 获取后台首页数据
router.get('/getoverviews', collectionHandler.getOverviews)
// 获取轮播图
router.get('/getslideshow', collectionHandler.getSlideShow)
// 获取公告信息
router.get('/getannounment', collectionHandler.getAnnounment)
// 获取反馈信息
router.post('/getfeedback', collectionHandler.getFeedback)


module.exports = router