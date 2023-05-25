<template>
<div>
  <!--面包屑导航-->
  <el-breadcrumb separator-class="el-icon-arrow-right">
    <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
    <el-breadcrumb-item>公告管理</el-breadcrumb-item>
    <el-breadcrumb-item>公告列表</el-breadcrumb-item>
  </el-breadcrumb>
  <!--公告列表区域-->
  <div v-for="(item, i) in announcementList" :key="i">
      <el-card
          @click.native="goto(item.id)"
          :style="{'margin-top': item.id === 1?'20px':'10px'}">
        <el-row>
          <h4>{{item.title}}</h4>
          <span>{{item.date}}</span>
        </el-row>
        <p v-html="item.content"></p>
      </el-card>
  </div>
</div>
</template>

<script>
export default {
  name: "announcement",
  data() {
    return {
      announcementList: []
    }
  },
  created() {
    this.getAnnouncementList()
  },
  methods: {
    async getAnnouncementList() {
      const {data: res} = await this.$http.get('/api/getannouncement')
      if (res.status !== 0) return this.$message.error('获取公告列表失败')
      this.announcementList = res.announcement
      this.announcementList.reverse()
    },
    goto(id) {
      this.$router.push({
        path: '/announcement/details',
        query: {id: id}
      })
    }
  }
}
</script>

<style lang="less" scoped>
.el-card {
  margin: 10px 0;
}

h4 {
  display: inline-block;
  margin-right: 10px;
  cursor: pointer;
}

span {
  font-size: 12px;
}

p {
  font-size: 14px;
}

</style>
