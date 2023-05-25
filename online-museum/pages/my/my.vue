<template>
  <view class="container">
    <view  v-if="token" style="width: 100%;">
      <view class="info-group">
        <view class="avatar">
          <image class="avatar-icon" src="../../static/OIP.jpg"></image>
          <view class="avatar-name">{{user_name}}</view>
        </view>
      </view>
      <view class="details">
        <view class="details-item" @click="gotoAnnounment">
          <uni-icons type="sound" size="20"></uni-icons>
          <view class="details-info">公告信息</view>
          </view>
        <view class="details-item" @click="gotoFeedback">
          <uni-icons type="paperplane" size="20"></uni-icons>
          <view class="details-info">我的反馈</view>
          </view>
        <view class="logout">
          <button @click="logout">退出登录</button>
        </view>
      </view>
    </view>
    <view v-if="!token">
      <view class="logo">
        <image class="logo-icon" src="../../static/logo.png"></image>
        <view class="logo-text">线上博物馆</view>
      </view>
      <view class="btn-group">
        <button class="btn" @click="wxLogin" style="background-color: #19ad17;">
          <image src="../../static/weixin.png" mode="" class="weixin-logo"></image>
          <view class="btn-text">微信一键登录</view>
        </button>
        <view @click="goToLogin">
          <view style="color: #777;">账号密码登录</view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
  export default {
    data() {
      return {
        token: "", 
        user_name: '',
      };
    },
    onLoad() {
      this.token = uni.getStorageSync('token')
      // console.log(this.token);
      this.user_name = uni.getStorageSync('user_name')
    },
    onShow() {
      this.token = uni.getStorageSync('token')
      this.user_name = uni.getStorageSync('user_name')
    },
    methods: {
      wxLogin() {
        // TODO: 调用微信登录接口实现微信一键登录
        console.log("微信一键登录");
      },
      goToLogin() {
        uni.navigateTo({
          url: '/subpkg/login/login'
        })
        // TODO: 跳转到注册/登录页面
        console.log("跳转到注册/登录页面");
      },
      goToSettings() {
        // TODO: 跳转到设置页面
        console.log("跳转到设置页面");
      },
      logout() {
        // TODO: 清空token并跳转到未登录状态下的页面
        uni.setStorageSync('token', '')
        uni.navigateTo({
          url: '/subpkg/login/login'
        })
      },
      gotoAnnounment() {
        uni.navigateTo({
          url: '/subpkg/announment/announment'
        })
      },
      gotoFeedback() {
        uni.navigateTo({
          url: '/subpkg/feedback/feedback'
        })
      }
    },
  };
</script>

<style>
  .container {
    background-color: #000;
    width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding-top: 200rpx;
    background-color: #f7f7f7;
  }

  .logo {
    display: flex;
    align-items: center;
    margin-bottom: 50px;
  }

  .logo-icon {
    width: 60px;
    height: 60px;
    margin-right: 10px;
    border-radius: 50%;
    box-shadow: 0px 1px 5px #c9c9c9;
  }

  .logo-text {
    font-size: 24px;
    font-weight: bold;
    color: #777;
  }

  .btn-group {
    display: flex;
    width: 100%;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }

  .btn {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    background-color: #fff;
    border-radius: 30px;
    margin-bottom: 20px;
    box-shadow: 0px 0px 1px #c9c9c9;
  }
  
  .weixin-logo {
    width: 20px;
    height: 20px;
    margin: 0 10rpx;
  }

  .btn-text {
    font-size: 16px;
    color: #fff;
  }

  .info-group {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .avatar {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-bottom: 30px;
  }

  .avatar-icon {
    width: 80px;
    height: 80px;
    margin-bottom: 10px;
    border-radius: 50%;
    box-shadow: 0px 1px 5px #c9c9c9;
  }

  .avatar-name {
    font-size: 20px;
    color: #333;
  }

  .info-group .btn-group {
    margin-top: 30px;
  }
  
  .details {
    box-sizing: border-box;
    /* background-color: #090; */
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
  }
  
  .details-item {
    display: flex;
    /* justify-content: center; */
    align-items: center;
    background-color: #fff;
    height: 100rpx;
    line-height: 100rpx;
    width: 100%;
    padding: 0 0 0 60rpx;
    border-bottom: 1px solid #999;
  }
  
  .logout {
    margin-top: 20px;
  }
  
  .details-info {
    margin: 0 20rpx;
  }
  
</style>
