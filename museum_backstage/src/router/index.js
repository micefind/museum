import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from "@/components/login";
import Home from "@/components/home";
import User from "@/components/user";
import Collection from "@/components/collection";
import Addcol from "@/components/addcol";
import Announcement from "@/components/announcement";
import Addannouncement from "@/components/addannouncement";
import Analysis from "@/components/analysis";
import Annoudetails from "@/components/annoudetails";
import NotFound from "@/components/NotFound";
import Index from "@/components/Index";

Vue.use(VueRouter)

const routes = [
  { path: '*', name: 'NotFound', component: NotFound },
  { path: '/', redirect: '/index' },
  { path: '/login', component: Login },
  { path: '/home', component: Home, redirect: '/index', children: [
      { path: '/user', component: User },
      { path: '/index', component: Index },
      { path: '/collection', component: Collection },
      { path: '/collection/add', component: Addcol },
      { path: '/announcement', component: Announcement },
      { path: '/announcement/add', component: Addannouncement },
      { path: '/data-analysis', component: Analysis },
      { path: '/announcement/details', component: Annoudetails },
    ] },
]

const router = new VueRouter({
  routes
})

// 挂载路由导航守卫
router.beforeEach((to, from, next) => {
  if (to.path === '/login') next()
  const tokenStr = window.sessionStorage.getItem('token')
  if (!tokenStr) return next('/login')
  next()
})

export default router
