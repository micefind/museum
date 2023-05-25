<template>
  <el-container>
    <el-header>
      <!--logo区域-->
      <div class="logo-box" :style="{width:(collapse?'64px':'260px')}">
        <div class="logo-pic">
          <img src="../assets/logo.png" alt="">
        </div>
        <div class="logo-title" v-show="!collapse">{{system_name}}</div>
      </div>
      <!--菜单折叠按钮-->
      <div class="menu-change-box" @click="collapseChange">
        <i v-if="collapse" class="el-icon-s-fold"></i>
        <i v-else class="el-icon-s-unfold"></i>
      </div>
      <!--搜索栏-->
      <div class="search">
        <div class="search-input">
          <el-dropdown
              @command="gotoSearch"
              trigger="click"
              hide-on-click
              size="medium"
              placement="bottom-start">
            <el-input
                suffix-icon="el-icon-search"
                size="small"
                v-model="input"
                @input="handlerChange"
                placeholder="搜索菜单项"></el-input>
            <el-dropdown-menu slot="dropdown">
              <div style="width: 320px;max-height: 250px; overflow: hidden; overflow-y: auto;"
                   v-show="input && input!==''">
                <el-dropdown-item
                    v-show="resultsList[0]"
                    :command="item"
                    style="height: 50px; line-height: 50px; border-bottom: 1px solid #ebebeb; color: #777;"
                    :style="{backgroundColor:(i === 0 ? '#f5f7fa' : '#fff')}"
                    :key="i"
                    v-for="(item, i) in resultsList">{{ item.authName }}</el-dropdown-item>
                <el-dropdown-item
                    style="background-color: #f5f7fa; text-align: center; height: 50px; line-height: 50px; color: #777"
                    v-show="!resultsList[0]">无匹配结果</el-dropdown-item>
              </div>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </div>
      <!--退出登录-->
      <div class="logout-box">
        <div class="admin-pic">
          <img src="../assets/OIP.jpg" alt="">
        </div>
        <div class="logout">
          <el-dropdown @command="logout">
          <span class="el-dropdown-link text-color">
            {{user_name}}
            <i class="el-icon-caret-bottom"></i>
          </span>
            <el-dropdown-menu>
              <el-dropdown-item divided>退出登录</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </div>
    </el-header>
    <el-container>
      <el-aside :width="collapse?'64px':'260px'">
        <el-menu :default-active="active"
                 :collapse="collapse"
                 background-color="#fff"
                 text-color="#777"
                 active-text-color="#5fa4f6"
                 unique-opened
                 router
                 :collapse-transition="false">
          <template v-for="item in menuList">
            <template v-if="item.children[0]">
              <!--一级菜单-->
              <el-submenu :index="item.id+''" :key="item.id">
                <template slot="title">
                  <i :class="iconsObj[item.id]"></i>
                  <span slot="title">{{item.authName}}</span>
                </template>
                <template v-for="subItem in item.children">
                  <el-menu-item :index="subItem.path+''" :key="subItem.id" @click="savaNavStatus(subItem.path)">
                    <i class="el-icon-menu"></i>
                    <template slot="title"> {{subItem.authName}}</template>
                  </el-menu-item>
                </template>
              </el-submenu>
            </template>
            <template v-else>
              <el-menu-item :index="item.path" :key="item.id" @click="savaNavStatus(item.path)">
                <i class="el-icon-s-home"></i>
                <span slot="title">{{item.authName}}</span>
              </el-menu-item>
            </template>
          </template>
        </el-menu>
      </el-aside>
      <el-main class="content">
        <router-view></router-view>
        <el-backtop target=".content" :visibility-height=200></el-backtop>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
export default {
  name: "Home",
  data() {
    return {
      // 搜索栏
      input: '',
      // 搜索结果
      results: [],
      resultsList: [],
      // 显示搜索列表
      showSearchList:false,
      logo_img: '../assets/logo.png',
      system_name: '线上博物馆',
      active: '/index',
      collapse: false,
      user_name: 'admin',
      iconsObj: {
        '1': 'el-icon-user-solid',
        '2': 'el-icon-s-claim',
        '3': 'el-icon-s-comment',
        '4': 'el-icon-data-analysis'
      },
      // 菜单数据
      menuList: [
        {
          id: 0,
          authName: '首页',
          path: '/index',
          children: []
        },
        {
          id: 1,
          authName: '用户管理',
          children: [
            {
              id: 11,
              authName: '用户列表',
              path: '/user',
              children: []
            }
          ]
        },
        {
          id: 2,
          authName: '藏品管理',
          children: [
            {
              id: 21,
              authName: '藏品列表',
              path: '/collection',
              children: []
            },
            {
              id: 22,
              authName: '添加藏品',
              path: '/collection/add',
              children: []
            }
          ]
        },
        {
          id: 3,
          authName: '公告管理',
          children: [
            {
              id: 31,
              authName: '公告列表',
              path: '/announcement',
              children: []
            },
            {
              id: 32,
              authName: '发布公告',
              path: '/announcement/add',
              children: []
            }
          ]
        },
        {
          id: 4,
          authName: '数据分析',
          children: [
            {
              id: 41,
              authName: '藏品数据',
              path: '/data-analysis',
              children: []
            },
          ]
        },
      ],
    }
  },
  created() {
    this.getHashUrl()
    if (window.sessionStorage.getItem('activePath') !== null && window.sessionStorage.getItem('activePath') !== 'null') {
      this.active = window.sessionStorage.getItem('activePath')
    }
  },
  mounted() {
    this.getHashUrl()
    // 窗口宽度小于 1250px 侧边栏折叠
    if (document.body.clientWidth < 1250) {
      this.collapseChange();
    }
  },
  updated() {
    setTimeout(() => {
      this.getHashUrl()
      if (window.sessionStorage.getItem('activePath') !== null && window.sessionStorage.getItem('activePath') !== 'null') {
        this.active = window.sessionStorage.getItem('activePath')
      }
    },50)
    this.getMenuItems()
  },
  methods: {
    // 获取 href 属性中在井号“#”后面的分段并保存本地
    getHashUrl() {
      let hashStr = window.location.hash.slice(1)
      const results = Array.from(new Set(this.results)) // 数组去重
      // 判断所有菜单项中 path 是否匹配当前 href
      results.forEach(item => {
        if (item.path === hashStr) return window.sessionStorage.setItem('activePath', hashStr)
      })
    },
    // 监听搜索输入框内容变化
    handlerChange() {
      this.showSearchList = true
      if (this.input === '' || this.input === null) {
        this.results = []
      } else {
        this.getMenuItems()
      }
      const results = Array.from(new Set(this.results)) // 数组去重
      this.resultsList = results.filter(result => result.authName.includes(this.input))
    },
    // 获取所有的菜单项
    getMenuItems() {
      this.menuList.forEach(item => {
        if (item.children.length === 0) {
          this.results.push(item)
        } else {
          item.children.forEach(item2 => {
            if (item2.children.length === 0) {
              this.results.push(item2)
            } else {
              item2.children.forEach(item3 => {
                this.results.push(item3)
              })
            }
          })
        }
      })
    },
    // 点击搜索列表项，跳转到页面
    gotoSearch(item) {
      if (!item) return this.input = ''
      else if (item.path === this.active) return this.$router.go(0)
      else this.$router.push(item.path)
      this.input = ''
      this.resultsList = ''
    },
    // 折叠菜单
    collapseChange() {
      this.collapse = !this.collapse
    },
    // 退出登录
    logout() {
      this.$router.push('/login')
      window.sessionStorage.clear()
    },
    // 保存菜单项激活状态
    savaNavStatus(activePath) {
      window.sessionStorage.setItem('activePath', activePath)
      this.active = activePath
    },
  }
}
</script>

<style scoped lang="less">
.el-container {
  height: 100%;
  width: 100%;
}

.el-header {
  background-color: #fff;
  display: flex;
  align-items: center;
  padding: 0;
  border: none;
  margin: 0;
  position: relative;
  height: 60px;
  overflow: hidden;
  box-shadow: 0 1px 5px rgba(55, 122, 255, 0.3);

  .logo-box {
    //background-color: #098;
    background-image: linear-gradient(to right, #0659ff,#3f80ff); // 渐变色
    display: flex;
    align-items: center;
    height: 100%;
    overflow: hidden;
    transition: all .38s;

    .logo-pic {
      //background-color: #911;
      height: 100%;
      width: 64px;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 7px;
      box-sizing: border-box;

      img {
        height: 50px;
        width: 50px;
        border-radius: 5px;
      }
    }

    .logo-title {
      //background-color: #789;
      display: flex;
      align-items: center;
      height: 100%;
      width: 196px;
      padding: 0 10px;
      color: #fff;
      font-size: 20px;
      word-break:keep-all; //文字不换行
    }
  }

  .menu-change-box {
    //background-color: #876;
    height: 100%;
    width: 64px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #239;

    .el-icon-s-fold,
    .el-icon-s-unfold {
      font-size: 18px;
      color: #fff;
      background-color: #3a7dff;
    }
  }

  .logout-box {
    //background-color: #911;
    position: absolute;
    right: 50px;
    top: 0;
    display: flex;
    align-items: center;
    height: 100%;

    .admin-pic {
      //background-color: #911;
      height: 100%;
      width: 64px;
      display: flex;
      align-items: center;
      justify-content: center;

      img {
        height: 50px;
        width: 50px;
        border-radius: 50%;
      }
    }

    .logout {
      margin: 0 5px;
      cursor: pointer;

      .text-color {
        color: #3b7dff;
      }
    }

  }

}

.el-aside {
  background-color: #fff;
  box-shadow: 0 1px 5px rgba(55, 122, 255, 0.3);
  z-index: 999;
  transition: all .38s;

  .el-menu {
    border-right: none;

    .el-menu-item.is-active,
    .el-menu-item:hover
    {
      background-color: #e7f3ff!important;
    }

  }
}

.el-aside::-webkit-scrollbar {
  display: none;
}

.el-main {
  background-color: #f0f0f0;
  border-bottom: 20px solid #f0f0f0;
}




</style>
