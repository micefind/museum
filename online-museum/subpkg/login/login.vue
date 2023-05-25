<template>
  <view>
    <view class="login-box" v-if="!show">
      <form>
        <view class="input-box">
          <view class="text">
            用户名
          </view>
          <input type="text" class="input" v-model="loginInfo.username" focus>
        </view>
        <view class="input-box">
          <view class="text">密码：</view>
          <input class="input" v-model="loginInfo.password" password type="password">
        </view>
        <view class="btn">
          <button style="background-color: #fff;color: #333;" @click="login">登录</button>
        </view>
      </form>
      <view class="goto" @click="gotoRegister">没有账号？去注册</view>
    </view>
    <view v-else class="login-box">
      <form>
        <view class="input-box">
          <view class="text">用户名：</view>
          <input class="input" v-model="registerInfo.username" focus>
        </view>
        <view class="input-box">
          <view class="text">密码：</view>
          <input class="input" v-model="registerInfo.password" password type="password">
        </view>
        <view class="btn">
          <button style="background-color: #fff;color: #333;" @click="register">注册</button>
        </view>
      </form>
      <view class="goto" @click="gotoLogin">返回</view>
    </view>
  </view>
</template>

<script>
  export default {
    data() {
      return {
        show: false,
        loginInfo: {
          username: '',
          password: ''
        },
        registerInfo: {
          username: '',
          password: '',
        }
      };
    },
    methods: {
      gotoRegister() {
        this.show = true
      },
      gotoLogin() {
        this.show = false
      },
      async login() {
        const {data: res} = await uni.$http.post('/api/public/user/login', this.loginInfo)
        if (res.status !== 0) return uni.showToast({title: res.message,icon: "error",duration: 1000})
        uni.setStorageSync('token', res.token)
        uni.setStorageSync('user_name', this.loginInfo.username)
        uni.setStorageSync('user_id', res.user_id)
        uni.showToast({title: res.message,icon: "success",duration: 1000})
        setTimeout(() => {
          uni.switchTab({
            url: '/pages/my/my'
          })
        },1000)
      },
      async register() {
        await uni.$http.post('/api/public/user/register', this.registerInfo)
        // console.log(res);
        this.loginInfo.username = this.registerInfo.username
        this.show = false
        this.registerInfo.username = ''
        this.registerInfo.password = ''
      }
    }
  }
</script>

<style lang="scss">
.login-box {
  // background-color: #977;
  padding: 10px;
  margin: 10px;
}
.input-box {
  display: flex;
  // background-color: #fff;
  align-items: center;
  margin: 0 0 10px 0;
}
.text {
  width: 25%;
  color: #777;
  font-size: 32rpx
}
.input {
  // background-color: #fff;
  border-bottom: 1px solid #333;
  padding: 10rpx;
  margin-bottom: 10rpx;
  width: 75%;
}
.btn {
  // background-color: #987;
  padding: 10px;
}
.goto {
  margin-top: 20rpx;
}
</style>
