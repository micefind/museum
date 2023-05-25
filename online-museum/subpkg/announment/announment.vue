<template>
  <view class="container">
    <view class="item-box" v-for="(item, i) in basedata" :key="i">
      <view class="title">
        {{item.title}}
      </view>
      <view class="content">
        <rich-text :nodes="item.content">
          <!-- {{item.content}} -->
        </rich-text>
      </view>
      <view class="date">
        {{item.date}}
      </view>
    </view>
  </view>
</template>

<script>
  export default {
    data() {
      return {
        basedata: []
      };
    },
    onLoad() {
      this.getBaseData()
    },
    methods: {
      async getBaseData() {
        const {data: res} = await uni.$http.get('/api/getannounment')
        this.basedata = res.announmentList
        // console.log(this.basedata);
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
    font-size: 16px;
    font-weight: 700;
  }
  

</style>
