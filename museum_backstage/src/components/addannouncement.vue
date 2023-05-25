<template>
<div>
  <!--面包屑导航-->
  <el-breadcrumb separator-class="el-icon-arrow-right">
    <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
    <el-breadcrumb-item>公告管理</el-breadcrumb-item>
    <el-breadcrumb-item>发布公告</el-breadcrumb-item>
  </el-breadcrumb>
  <el-card>
    <el-alert title="发布公告" type="info" center show-icon :closable="false"></el-alert>
    <!--表单区域-->
    <el-form :model="announcementInfo" :rules="rules" ref="ruleForm" label-width="80px">
      <el-form-item label="标题" prop="title">
        <el-input v-model="announcementInfo.title"></el-input>
      </el-form-item>
      <el-form-item label="公告内容" prop="content">
        <div>
          <quill-editor v-model="announcementInfo.content" :options="editorOption"></quill-editor>
        </div>

        <!--<el-input v-model="announcementInfo.content" type="textarea" :rows="14"></el-input>-->
      </el-form-item>
      <el-form-item class="btn">
        <el-button type="primary" @click="addAnnouncement">提交</el-button>
        <el-button @click="resetForm">重置</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</div>
</template>

<script>
import Vue from 'vue';
import VueQuillEditor from 'vue-quill-editor';
// 导入所需样式
import 'quill/dist/quill.core.css';
import 'quill/dist/quill.snow.css';
import 'quill/dist/quill.bubble.css';
Vue.use(VueQuillEditor)

export default {
  name: "addannouncement",
  data() {
    return {
      editorOption: {
        placeholder: '请输入公告内容'
      },
      announcementInfo: {
        title: '',
        content: ''
      },
      rules: {
        title: [
          { required: true, message: '标题不能为空', trigger: 'blur' },
          { min: 1, max: 50, message: '长度在 1 到 50 个字符', trigger: 'blur' }
        ],
        content: [
          { required: true, message: '内容不能为空', trigger: 'blur' },
        ]
      }
    }
  },
  methods: {
    // 添加公告
    addAnnouncement() {
      this.$refs.ruleForm.validate( async valid => {
        if (!valid) return
        const {data: res} = await this.$http.post('/api/addannouncement', this.announcementInfo)
        if (res.status !== 0) return this.$message.error('发布公告失败')
        this.$message.success('添加公告成功')
      })
    },
    // 重置表单
    resetForm() {
      this.$refs.ruleForm.resetFields()
    }
  }
}
</script>

<style lang="less" scoped>
.el-form {
  width: 80%;
  padding: 20px 20px;
}

.btn {
  display: flex;
  justify-content: end;
}
</style>
