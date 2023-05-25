<template>
  <div class="main-box">
    <div class="not-found-box">
      <div class="title">404</div>
      <div class="text">您访问的页面不存在！</div>
      <div>
        <el-button @click="goHome" type="primary">返回首页</el-button>
        <el-button @click="goBack" type="primary">返回上一页</el-button>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name:"NotFound",
  methods: {
    goBack() {
      this.$router.go(-1);
    },
    goHome() {
      this.$router.push({ path: "/" });
    }
  }
}
</script>

<style scoped>
.main-box {
  height: 100%;
  width: 100%;
  /*background-color: #993;*/
  position: relative;
}
.not-found-box {
  /*background-color: #145;*/
  width: 400px;
  height: 400px;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}
.title {
  font-size: 80px;
}
.text {
  font-size: 20px;
  margin-bottom: 20px;
}
</style>

