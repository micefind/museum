// #ifndef VUE3
import Vue from 'vue'
import App from './App'
import store from './store/index.js'


import { $http } from '@escook/request-miniprogram'

uni.$http = $http
// 配置请求根路径
$http.baseUrl = 'http://127.0.0.1:8090'
// $http.baseUrl = 'http://micefind.com:8090'

// 图片显示根路径
uni.$picBaseUrl = 'http://127.0.0.1:8090'
// uni.$picBaseUrl = 'http://micefind.com:8090'

// 请求开始之前
$http.beforeRequest = function (options) {
  uni.showLoading({
    title: '数据加载中...',
  })
}

// 请求完成之后
$http.afterRequest = function () {
  uni.hideLoading()
}

// 自定义弹框
uni.$showMsg = function(title = '请求数据失败！', duration = 1500) {
  uni.showToast({
    title,
    duration,
    icon: "none"
  })
}

Vue.config.productionTip = false

App.mpType = 'app'

const app = new Vue({
    ...App,
    store
})
app.$mount()
// #endif

// #ifdef VUE3
import { createSSRApp } from 'vue'
import App from './App.vue'
export function createApp() {
  const app = createSSRApp(App)
  return {
    app,
  }
}
// #endif