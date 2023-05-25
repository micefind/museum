<template>
  <view class="container">
    <img :src="url+item.col_pic" mode="aspectFill" class="image"></img>
    <view class="info">
      <view class="title">{{item.title}}</view>
      <view class="source">{{item.origin}}</view>
      <view class="base">{{item.base}}</view>
      <view class="desc">{{item.describe}}</view>
    </view>
    <!-- 底部按钮 -->
    <view class="museum-detail__footer">
      <!-- 按钮区域 -->
      <view class="museum-detail__buttons">
        <button class="museum-detail__button museum-detail__button--collection"
          @click="toggleCollection">{{ collectionStatus }}</button>
        <button class="museum-detail__button museum-detail__button--feedback" @click="showFeedback">反馈</button>
      </view>
      <!-- 提交区域 -->
      <view v-if="showFeedbackForm" class="museum-detail__feedback-form">
        <textarea class="museum-detail__feedback-input" v-model="feedback" placeholder="请输入"></textarea>
        <button class="museum-detail__feedback-submit" @click="submitFeedback">提交</button>
      </view>
    </view>
  </view>
</template>

<script>
  import {
    mapMutations
  } from 'vuex'
  import { mapState } from 'vuex'


  export default {
    data() {
      return {
        isCollected: '',
        showFeedbackForm: false,
        feedback: "",
        url: uni.$picBaseUrl,
        // 查询参数对象
        query: {
          col_id: ''
        },
        item: {
          id: '',
          col_pic: '',
          origin: '',
          title: '',
          describe: '',
          base: '',
          cate_id: '',
          cate_name: '',
          view: null
        },
        collectionIds: [],
      }
    },
    onLoad(options) {
      this.collectionIds = JSON.parse(uni.getStorageSync('col_id') || '[]')
      // console.log(options);
      // 获取页面参数
      this.query.col_id = options.id || ''
      // console.log(this.query.col_id);
      this.getColDetail()
      
    },
    computed: {
      collectionStatus() {
        return this.isCollected ? "已收藏" : "收藏";
      }
    },
    onshow() {
      if (this.collectionIds.indexOf(this.item.id) === -1) this.isCollected = false
      else this.isCollected = true
    },
    destroyed() {
      // 销毁阶段藏品被浏览次数 view +1
      this.item.view = parseInt(this.item.view) + 1
      // console.log(this.item.view);
      uni.$http.post('/api/addview', {view: this.item.view, id: this.item.id})
    },
    methods: {
      ...mapMutations(['addCollectionId', 'removeCollectionId', 'saveCollectionIds']),
      async getColDetail() {
        const {
          data: res
        } = await uni.$http.get('/api/getcol', this.query)
        // console.log(res);
        res.colList[0].col_pic = res.colList[0].col_pic.replace(/\\/g,"/")
        this.item = res.colList[0]
        // console.log(this.item);
      },
      // 收藏
      toggleCollection() {
        this.isCollected = !this.isCollected;
        if (this.isCollected) {
          this.addCollectionId(this.item.id)
        }
        else {
          this.removeCollectionId(this.item.id)
        }
      },
      showFeedback() {
        this.showFeedbackForm = true;
      },
      async submitFeedback() {
        // 实现提交反馈的逻辑
        let data = {
          user_id: uni.getStorageSync('user_id'),
          user_name: uni.getStorageSync('user_name'),
          content: this.feedback
        }
        const {data:res} = await uni.$http.post('/api/addfeedback', data)
        if (res.status !== 0) return uni.showToast({
          title: "提交失败",
          icon: "error",
          duration: 1000
        });
        this.showFeedbackForm = false;
        uni.showToast({
          title: "反馈已提交",
          icon: "success",
          duration: 1000
        });
      }
    }
  }
</script>

<style scoped>
  .container {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .image {
    width: 100%;
  }

  .info {
    width: 95%;
    margin-top: 20rpx;
    margin-bottom: 120rpx;
  }

  .source {
    font-size: 28rpx;
    color: #999;
  }


  .base {
    font-size: 28rpx;
    color: #333;
  }

  .title {
    font-size: 36rpx;
    margin-top: 10rpx;
  }

  .desc {
    /* text-align-last: justify; */
    font-size: 32rpx;
    margin: 20rpx 0;
    line-height: 48rpx;
  }


  .museum-detail__footer {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    padding: 10rpx;
    background-color: #f7f7fa;
    border-top: 1px solid #ccc;
  }

  .museum-detail__buttons {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .museum-detail__button {
    border: none;
    border-radius: 10rpx;
    font-size: 28rpx;
    color: #fff;
    cursor: pointer;
  }

  .museum-detail__button--collection {
    background-color: #ff6633;
  }

  .museum-detail__button--feedback {
    background-color: #8a2c2d;
  }

  .museum-detail__feedback-form {
    margin-top: 20rpx;
    padding: 20rpx 10rpx 0 10rpx;
    background-color: #fff;
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
  }

  .museum-detail__feedback-input {
    box-sizing: border-box;
    width: 100%;
    height: 200rpx;
    border-radius: 10rpx;
    border: 1rpx solid #ccc;
    padding: 10rpx;
    font-size: 28rpx;
    margin-bottom: 10rpx;
    background-color: #f5f5f5;
  }

  .museum-detail__feedback-submit {
    border: none;
    font-size: 28rpx;
    padding: 10rpx 20rpx;
    color: #333;
    background-color: #fff;
    cursor: pointer;
  }
</style>
