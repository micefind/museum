<template>
  <view class="container">
    <view class="item-box" v-for="(item, i) in feedbackList" :key="i">
      <view class="title">
        {{item.timestamp}}
      </view>
      <view class="content">
        {{item.content}}
      </view>
      <view class="date">
        {{item.user_name}}
      </view>
      
    </view>
  </view>
</template>

<script>
  export default {
    data() {
      return {
        user_id: '',
        feedbackList: []
      };
    },
    onLoad() {
      this.user_id = uni.getStorageSync('user_id')
      this.getFeedback()
    },
    methods: {
      async getFeedback() {
        const {data: res} = await uni.$http.post('/api/getfeedback', {user_id: this.user_id})
        this.feedbackList = res.feedbackData
      }
    }
  }
</script>

<style lang="scss">
  .container {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
  }
  
  .item-box {
    width: 95%;
    background-color: #fff;
    border-radius: 10rpx;
    margin: 10rpx 0;
    padding: 10rpx;
  }
  
  .title {
    font-weight: 700;
  }
</style>
