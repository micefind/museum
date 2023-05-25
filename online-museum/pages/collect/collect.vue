<template>
  <view>
    <view class="col-box" v-for="(item, i) in colList" :key="i" @click="gotoColDetail(item)">
      <view class="img-box">
        <!-- <image class="img" :src="url+item.col_pic"></image> -->
        <image :src="url+item.col_pic" class="img"></image>
      </view>
      <view class="info-box">
        <view class="col-title">{{item.title}}</view>
        <view class="col-origin">{{item.origin}}</view>
        <view class="col-base">{{item.base}}</view>
      </view>
    </view>
  </view>
</template>

<script>
  import {
    mapState
  } from 'vuex'

  export default {
    data() {
      return {
        url: uni.$picBaseUrl,
        colIds: [],
        colList: [],
      }
    },
    onLoad() {
      this.colIds = JSON.parse(uni.getStorageSync('col_id') || '[]')
      this.getColList()
      // console.log(this.collectionIds);
    },
    onShow() {
      this.colIds = JSON.parse(uni.getStorageSync('col_id') || '[]')
    },
    computed: {
      ...mapState(['collectionIds'])
    },
    methods: {
      gotoColDetail(item) {
        // console.log(item);
        uni.navigateTo({
          url: '/subpkg/col_detail/col_detail?id=' + item.id
        })
      },
      async getColList() {
        // console.log(this.colIds);
        for (let i = 0; i < this.colIds.length; i++) {
          const {data: res} = await uni.$http.get('/api/getcol', {col_id: this.colIds[i]})
          res.colList[0].col_pic = res.colList[0].col_pic.replace(/\\/g,"/")
          // console.log(res);
          this.colList.push(res.colList[0])
          // console.log(this.colList)
        }
      }
    }
  }
</script>

<style lang="scss">
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
</style>