import Vue from 'vue'
import App from './App.vue'
import router from './router'
import './plugins/element.js'
// 导入字体图标
import './assets/fonts/iconfont.css'
// 导入全局样式表
import './assets/css/global.css'
// 导入解决浏览器告警提示 mousewheel/touch 相关事件的包
import 'default-passive-events'

// 上传图片地址
// Vue.prototype.$uploadUrl = 'http://micefind.com:8090/api/upload'
Vue.prototype.$uploadUrl = 'http://127.0.0.1:8090/api/upload'

// 图片显示基准地址
// Vue.prototype.$picBaseUrl = 'http://micefind.com:8090'
Vue.prototype.$picBaseUrl = 'http://127.0.0.1:8090'

// 导入并配置 axios
import axios from 'axios'
// 请求基准地址
// axios.defaults.baseURL = 'http://micefind.com:8090'
axios.defaults.baseURL = 'http://127.0.0.1:8090'
// 为 axios 设置请求拦截器
axios.interceptors.request.use(config => {
  config.headers.Authorization = window.sessionStorage.getItem('token')
  return config
})
Vue.prototype.$http = axios

Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
