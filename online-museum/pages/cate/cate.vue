<template>
  <view>
    <my-search @click="gotoSearch"></my-search>
    <view class="scroll-view-container">
      <!-- 左侧分类 -->
      <scroll-view scroll-y="true" class="left-scroll-view" :style="{height: windowHeight + 'px'}">
        <block v-for="(item, i) in cateList" :key="i">
          <view :class="['left-scroll-view-item', item.id === active ? 'active' : '']" @click="activeChanged(item)">
            {{item.catename}}
          </view>
        </block>
      </scroll-view>
      <!-- 右侧列表 -->
      <scroll-view scroll-y="true" class="right-scroll-view" :style="{height: windowHeight + 'px'}"
        :scroll-top="scrollTop">
        <view class="cate-lv3-item" v-for="(item2, i2) in colList" :key="i2" @click="gotoColDetail(item2)">
          <!-- 图片 -->
          <img :src="url+item2.col_pic"></img>
          <!-- 文本 -->
          <text>{{item2.title}}</text>
        </view>
      </scroll-view>
    </view>
  </view>
</template>

<script>
  export default {
    data() {
      return {
        url: uni.$picBaseUrl,
        // 窗口可用高度
        windowHeight: 0,
        // 分类数据列表
        cateList: [],
        // 藏品列表
        colList: [],
        // 激活项
        active: 4,
        // 滚动条
        scrollTop: 0
      }
    },
    onLoad() {
      const sysInfo = uni.getSystemInfoSync()
      this.windowHeight = sysInfo.windowHeight - 50
      this.getCateList()
      this.getColList(4)
    },
    methods: {
      async getCateList() {
        // 发起请求
        const {
          data: res
        } = await uni.$http.get('/api/getcate')
        // 判断是否获取失败
        if (res.status !== 0) return uni.$showMsg()
        // 转存数据
        this.cateList = res.cateList
        // console.log(this.cateList);
      },
      async getColList(id) {
        const {
          data: res
        } = await uni.$http.get('/api/getcol', {
          cate_id: id
        })
        for (let i = 0; i< res.colList.length; i++) {
          res.colList[i].col_pic = res.colList[i].col_pic.replace(/\\/g,"/")
        }
        setTimeout(()=> {
          this.colList = res.colList
        }, 100)
        // console.log(this.colList);
      },
      activeChanged(item) {
        // console.log(item.id);
        this.active = item.id
        // 为二级分类列表重新赋值
        this.getColList(item.id)
      },
      gotoColDetail(item2) {
        uni.navigateTo({
          url: '/subpkg/col_detail/col_detail?id=' + item2.id
        })
      },
      // 点击搜索框跳转
      gotoSearch() {
        uni.navigateTo({
          url: '/subpkg/search/search'
        })
      }

    }
  }
</script>

<style lang="scss">
  .scroll-view-container {
    display: flex;

    .left-scroll-view {
      height: 300px;
      width: 120px;

      .left-scroll-view-item {
        line-height: 60px;
        background-color: #f7f7f7;
        text-align: center;
        font-size: 12px;

        // 激活項樣式
        &.active {
          background-color: #ffffff;
          position: relative;

          // 激活項左側變現
          &::before {
            content: " ";
            display: block;
            width: 3px;
            height: 30px;
            background-color: #8a2c2d;
            position: absolute;
            top: 50%;
            left: 0;
            transform: translateY(-50%);
          }
        }

      }
    }

    .right-scroll-view {
      box-sizing: border-box;
    }

    .cate-lv3-item {
      box-sizing: border-box;
      display: inline-block;
      width: calc(50% - 20rpx);
      margin: 10rpx;
      padding: 10rpx;
      font-size: 12px;
      border-radius: 20rpx;
      background-color: #ffffff;
      overflow: hidden;

      img {
        width: 100%;
      }
    }
  }
</style>
