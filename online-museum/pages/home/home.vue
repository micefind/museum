<template>
  <view>
    <!-- 使用自定义的搜索组件 -->
    <view class="search-box" @click="gotoSearch">
      <my-search></my-search>
    </view>
    <!-- 轮播图区域 -->
    <swiper :indicator-dots="true" :autoplay="true" :interval="3000" :duration="1000" :circular="true">
      <swiper-item v-for="(item, i) in swiperList" :key="i">
        <image :src="url+item.pic_src" class="swiper-img"></image>
      </swiper-item>
    </swiper>

    <!-- 分类导航区域 -->
    <view class="nav-list">
      <view class="nav-item" v-for="(item, i) in navList" :key="i" @click="gotoColList(item)">
        <image :src="item.image_src" class="nav-img"></image>
      </view>
    </view>

    <!-- 楼层区域 -->
    <view class="">
      <view class="" v-for="(item, i) in floorList" :key="i">
        <!-- 层级标题 -->
        <view>
          <uni-section :title="item.title">
            <template v-slot:decoration>
              <view class="decoration"></view>
            </template>
          </uni-section>
        </view>
        <!-- 藏品列表 -->
        <view class="col-box" v-for="(item2, i2) in item.colList" :key="i2" @click="gotoColDetail(item2)">
          <view class="img-box">
            <image class="img" :src="url+item2.col_pic"></image>
          </view>
          <view class="info-box">
            <view class="col-title">{{item2.title}}</view>
            <view class="col-origin">{{item2.origin}}</view>
            <view class="col-base">{{item2.base}}</view>
          </view>
        </view>
      </view>
    </view>

  </view>
</template>

<script>
  export default {
    data() {
      return {
        // 轮播图数据列表
        swiperList: [],
        // 分类导航列表
        navList: [{
            image_src: '../../static/1.png',
            cate_id: 8
          },
          {
            image_src: '../../static/2.png',
            cate_id: 9
          },
          {
            image_src: '../../static/3.png',
            cate_id: 13
          },
          {
            image_src: '../../static/4.png',
            cate_id: 14
          },
        ],
        // 楼层数据列表
        floorList: [{
            title: '最新发布',
            colList: [],
            query: {
              pagesize: 5,
              pagenum: 1
            }
          },
          {
            title: '明星藏品',
            colList: [],
            query: {
              cate_id: 18
            }
          }
        ],
        url: uni.$picBaseUrl
      }
    },
    onLoad() {
      this.getNewList()
      this.getStarList()
      this.getSwiperList()
    },
    methods: {
      // 获取轮播图
      async getSwiperList() {
        const {data: res} = await uni.$http.get('/api/getslideshow')
        this.swiperList = res.slideShowData
      },
      // 获取最新藏品列表
      async getNewList() {
        const {
          data: res
        } = await uni.$http.get('/api/getcol', this.floorList[0].query)
        if (res.status !== 0) return uni.$showMsg()
        for (let i = 0; i< res.colList.length; i++) {
          res.colList[i].col_pic = res.colList[i].col_pic.replace(/\\/g,"/")
        }
        setTimeout(()=> {
          this.floorList[0].colList = res.colList
        }, 100)
      },
      // 获取明星藏品列表
      async getStarList() {
        const {
          data: res
        } = await uni.$http.get('/api/getcol', this.floorList[1].query)
        if (res.status !== 0) return uni.$showMsg()
        for (let i = 0; i< res.colList.length; i++) {
          res.colList[i].col_pic = res.colList[i].col_pic.replace(/\\/g,"/")
        }
        setTimeout(()=> {
          this.floorList[1].colList = res.colList
        }, 100)
      },
      gotoColDetail(item2) {
        uni.navigateTo({
          url: '/subpkg/col_detail/col_detail?id=' + item2.id
        })
      },
      gotoSearch() {
        uni.navigateTo({
          url: '/subpkg/search/search'
        })
      },
      // 点击跳转到藏品列表页面
      gotoColList(item) {
        uni.navigateTo({
          url: '/subpkg/col_list/col_list?cate_id=' + item.cate_id
        })
      }
    }
  }
</script>

<style lang="scss">
  swiper {
    height: 330rpx;

    .swiper-item,
    .swiper-img {
      height: 100%;
      width: 100%;
    }
  }

  .nav-list {
    display: flex;
    justify-content: space-around;
    margin: 15px 0;

    .nav-img {
      width: 128rpx;
      height: 140rpx;
      border-radius: 10rpx;
      box-shadow: 0 0 10px rgba(138, 44, 45, 0.5);
    }
  }

  .decoration {
    width: 4px;
    height: 16px;
    margin-right: 4px;
    border-radius: 20%;
    background-color: #8a2c2d;
  }

  h3 {
    margin: 0;
    padding: 0;
  }

  .col-box {
    display: flex;
    padding: 10px 5px;
    border-bottom: 1px solid #f0f0f0;
    background-color: #fff;
    box-shadow: 0 0 5rpx 0 rgba(0,0,0,0.3);
    // border: 1px solid  #000;

    .img-box {
      margin-right: 10rpx;
      border-radius: 10rpx;

      .img {
        width: 200rpx;
        height: 200rpx;
        border-radius: 10rpx;
        display: block;
      }
    }

    .info-box {
      display: flex;
      flex-direction: column;
      justify-content: space-between;

      .col-title {
        // font-size: 13px;
      }
      .col-origin {
        color: #777
      }
    }
  }

  .search-box {
    // 设置定位效果为“吸顶”
    position: sticky;
    // 吸顶的“位置”
    top: 0;
    // 提高层级，防止被轮播图覆盖
    z-index: 999;
  }
</style>
