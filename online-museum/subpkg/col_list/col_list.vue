<template>
  <view class="waterfall-container">
    <view v-if="!cangpinList[0]">暂无此相关藏品</view>
    <view v-else class="waterfall-item" v-for="(item, index) in cangpinList" :key="index" @click="gotoColDetail(item)">
      <img class="waterfall-img" :src="url+item.col_pic" mode="aspectFill"></img>
      <view class="waterfall-title">{{item.title}}</view>
      <view class="waterfall-desc">{{item.origin}}</view>
    </view>
  </view>
</template>

<script>
  export default {
    data() {
      return {
        queryInfo: {
          query: '',
          cate_id: ''
        },
        url: uni.$picBaseUrl,
        cangpinList: [],
        columnCount: 2,
        columnHeight: [0, 0],
      };
    },
    mounted() {
      this.getImageWidth();
    },
    onLoad(options) {
      this.queryInfo.query = options.query
      this.queryInfo.cate_id = options.cate_id
      this.getCollectionList()
    },
    methods: {
      // 获取藏品列表
      async getCollectionList() {
        // console.log(this.queryInfo);
        const {
          data: res
        } = await uni.$http.get('/api/getcol', this.queryInfo)
        for (let i = 0; i< res.colList.length; i++) {
          res.colList[i].col_pic = res.colList[i].col_pic.replace(/\\/g,"/")
        }
        setTimeout(()=> {
          this.cangpinList = res.colList
        }, 100)
        // console.log(this.cangpinList);
      },
      getImageWidth() {
        for (let i = 0; i < this.cangpinList.length; i++) {
          const img = new Image();
          img.src = this.cangpinList[i].imgUrl;
          img.onload = () => {
            const h = img.height * (this.$refs.waterfall.clientWidth / (this.columnCount * img.width));
            const minIndex = this.columnHeight.indexOf(Math.min(...this.columnHeight));
            this.cangpinList[i].height = h;
            this.columnHeight[minIndex] += h;
          };
        }
      },
      gotoColDetail(item) {
        // console.log(item);
        uni.navigateTo({
          url: '/subpkg/col_detail/col_detail?id=' + item.id
        })
      },
    },
  };
</script>

<style scoped>
  .waterfall-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    margin-top: 10rpx;
  }

  .waterfall-item {
    /* margin-bottom: 16px; */
    width: calc(50% - 20rpx);
    background-color: #fff;
    border-radius: 10rpx;
    overflow: hidden;
    /* background-color: #996; */
    padding: 10rpx;
    box-sizing: border-box;
    margin: 10rpx;
  }

  .waterfall-img {
    width: 100%;
    border-radius: 10rpx;
  }

  .waterfall-title {
    /* padding: 8px; */
    font-size: 14px;
    /* font-weight: bold; */
  }

  .waterfall-desc {
    /* padding: 8px; */
    font-size: 12px;
    color: #666;
  }
</style>
