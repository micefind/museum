<template>
<div>
  <!--面包屑导航-->
  <el-breadcrumb separator-class="el-icon-arrow-right">
    <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
    <el-breadcrumb-item>公告管理</el-breadcrumb-item>
    <el-breadcrumb-item :to="{ path: '/announcement' }">公告列表</el-breadcrumb-item>
    <el-breadcrumb-item>公告详情</el-breadcrumb-item>
  </el-breadcrumb>
  <el-card>
    <el-row>
      <h4>{{annouInfo[0].title}}</h4>
      <span>{{annouInfo[0].date}}</span>
    </el-row>
    <p v-html="annouInfo[0].content"></p>
  </el-card>
</div>
</template>

<script>
export default {
  name: "annoudetails",
  data() {
    return {
      // 页面参数
      query: {},
      // 公告信息
      annouInfo: []
    }
  },
  created() {
    // 获取页面参数
    this.query = this.$route.query
    this.getAnnouDetails()
  },
  methods: {
    // 根据页面参数获取公告详情
    async getAnnouDetails() {
      const {data: res} = await this.$http.get('/api/getannouncement', {params: this.query})
      if (res.status !== 0) return this.$message.error('获取公告详情失败')
      this.annouInfo = res.announcement
    }
  }
}
</script>

<style lang="less" scoped>
h4 {
  display: inline-block;
  margin-right: 10px;
}

span {
  font-size: 12px;
}

p {
  font-size: 14px;
}
</style>
