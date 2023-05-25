<template>
  <div class="login-container">
    <div class="login-box">
      <!--头像标志区域-->
      <div class="avatar-box">
        <img src="../assets/logo.png" alt="">
      </div>
      <!--登录表单区域-->
      <el-form
          ref="loginFormRef"
          :rules="loginFormRules"
          :model="loginForm"
          label-width="0px"
          class="login-form">
        <!--用户名-->
        <el-form-item prop="username">
          <el-input
              v-model="loginForm.username"
              prefix-icon="iconfont icon-user">
          </el-input>
        </el-form-item>
        <!--密码-->
        <el-form-item prop="password">
          <el-input
              type="password"
              v-model="loginForm.password"
              prefix-icon="iconfont icon-3702mima">
          </el-input>
        </el-form-item>
        <!--登录按钮-->
        <el-form-item class="btn">
          <el-button type="primary" @click="login">登录</el-button>
          <el-button type="info" @click="resetLoginForm">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="file-box">
      <el-link :underline="false" href="https://beian.miit.gov.cn/#/Integrated/index">渝 ICP 备 2022007989 号 - 1</el-link>
    </div>
  </div>
</template>

<script>
export default {
  name: "login",
  data() {
    return {
      // 登录表单数据
      loginForm: {
        username: 'admin',
        password: '123456'
      },
      // 登录表单验证规则对象
      loginFormRules: {
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
          { min: 3, max: 9, message: '长度在 3 到 9 个字符', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
          { min: 6, max: 15, message: '长度在 6 到 15 个字符', trigger: 'blur' }
        ]
      }
    }
  },
  methods: {
    // 点击重置按钮重置登录表单
    resetLoginForm() {
      this.$refs.loginFormRef.resetFields()
    },
    // 点击登录按钮
    login() {
      this.$refs.loginFormRef.validate(async valid => {
        if(!valid) return
        const { data: res } = await this.$http.post('/api/public/login', this.loginForm)
        if (res.status !== 0) return this.$message.error('登录失败')
        window.sessionStorage.setItem('token', res.token)
        await this.$router.push('/home')
      })
    }
  }
}
</script>

<style lang="less" scoped>
.login-container {
  background-color: #f5f6fa;
  height: 100%;
}

.login-box {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 450px;
  height: 300px;
  background-color: #fff;
  border-radius: 5px;
  box-shadow: 0 1px 5px rgba(55, 122, 255, 0.3);

  .avatar-box {
    width: 130px;
    height: 130px;
    position: absolute;
    left: 50%;
    transform: translate(-50%, -50%);
    border-radius: 50%;
    padding: 10px;
    border: 1px solid #eee;
    background-color: #fff;
    //box-shadow: 0 0 10px #ddd;
    box-shadow: 0 0 10px rgba(55, 122, 255, 0.3);

    img {
      width: 100%;
      height: 100%;
      border-radius: 50%;
      background-color: #996;
    }
  }

  .login-form {
    position: absolute;
    bottom: 0;
    width: 100%;
    box-sizing: border-box;
    padding: 20px;

    .btn {
      display: flex;
      justify-content: flex-end;
    }
  }
}

.file-box {
  position: absolute;
  left: 10px;
  bottom: 10px;
  foot-size: 12px;
  color: #999;
}


</style>
