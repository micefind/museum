<template>
<div>
  <!--面包屑导航-->
  <el-breadcrumb separator-class="el-icon-arrow-right">
    <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
    <el-breadcrumb-item>藏品管理</el-breadcrumb-item>
    <el-breadcrumb-item>添加藏品</el-breadcrumb-item>
  </el-breadcrumb>
  <!--表单区域-->
  <el-card>
    <el-alert title="添加藏品信息" type="info" center show-icon :closable="false"></el-alert>
    <el-form
        label-width="80px"
        :model="colInfo"
        :rules="rules"
        ref="ruleForm">
      <el-form-item label="藏品名称" prop="title">
        <el-input v-model="colInfo.title"></el-input>
      </el-form-item>
      <el-form-item label="藏品来源" prop="origin">
        <el-input v-model="colInfo.origin"></el-input>
      </el-form-item>
      <el-form-item label="藏品分类" prop="origin">
        <el-select v-model="colInfo.cate_id" placeholder="请选择">
          <el-option
              v-for="item in cateList"
              :key="item.id"
              :label="item.catename"
              :value="item.id">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="基本信息" prop="base">
        <el-input v-model="colInfo.base"></el-input>
      </el-form-item>
      <el-form-item label="图片" prop="col_pic">
        <el-upload
            name="col_pic"
            :headers="headerObj"
            :action="uploadUrl"
            :on-preview="handlePreview"
            :on-remove="handleRemove"
            :on-success="uploadSuccess"
            list-type="picture">
          <el-button size="small" type="primary">点击上传</el-button>
        </el-upload>
      </el-form-item>
      <el-form-item label="藏品描述" prop="describe">
        <el-input v-model="colInfo.describe" type="textarea" :rows="5"></el-input>
      </el-form-item>
      <el-form-item class="btn">
        <el-button type="primary" @click="addCol">提交</el-button>
        <el-button @click="resetForm">重置</el-button>
      </el-form-item>
    </el-form>
  </el-card>
  <!--图片预览区域-->
  <el-dialog
      title="图片预览"
      :visible.sync="dialogVisible"
      width="50%">
    <img :src="baseUrl+previewPath" alt="" style="width: 100%;">
  </el-dialog>
</div>
</template>

<script>
export default {
  name: "addcol",
  data() {
    return {
      // 藏品分类
      cateList: [],
      // 藏品信息
      colInfo: {
        title: '',
        origin: '',
        cate_id: null,
        col_pic: '',
        base: '',
        describe: ''
      },
      // 添加藏品表单验证规则
      rules: {
        title: [
          { required: true, message: '请输入藏品名称', trigger: 'blur' },
          { min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur' }
        ],
        origin: [
          { required: true, message: '请输入藏品来源', trigger: 'blur' },
          { min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur' }
        ],
        cate: [
          { required: true, message: '请输入藏品来源', trigger: 'blur' },
          { min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur' }
        ],
        base: [
          { required: true, message: '请输入藏品基本信息', trigger: 'blur' },
          { min: 1, max: 30, message: '长度在 1 到 30 个字符', trigger: 'blur' }
        ],
        col_pic: [
          { required: true, message: '图片不能为空'},
        ],
        describe: [
          { required: true, message: '请输入藏品描述', trigger: 'blur' },
          { min: 1, max: 800, message: '长度在 1 到 800 个字符', trigger: 'blur' }
        ]
      },
      // 上传图片地址
      uploadUrl: this.$uploadUrl,
      // 上传图片请求头 token
      headerObj: {Authorization: window.sessionStorage.getItem('token')},
      // 预览图片地址
      previewPath: '',
      // 控制图片预览显示隐藏
      dialogVisible: false,
      // 图片基准地址
      baseUrl: 'http://127.0.0.1'
    }
  },
  created() {
    this.getCate()
  },
  methods: {
    // 图片预览效果
    handlePreview(file) {
      this.previewPath = file.response.picUrl
      this.dialogVisible = true
    },
    // 图片移除操作
    handleRemove() {
      // 暂未处理
    },
    // 图片上传成功时的钩子
    uploadSuccess(response) {
      this.colInfo.col_pic = response.picUrl
    },
    // 获取分类名称
    async getCate() {
      const {data: res} = await this.$http.get('/api/getcate')
      if (res.status !== 0) return this.$message.error('获取分类列表失败')
      this.cateList = res.cateList
    },
    // 添加藏品
    addCol() {
      this.$refs.ruleForm.validate( async valid => {
        if (!valid) return
        const {data: res} = await this.$http.post('/api/addcol', this.colInfo)
        if (res.status !== 0) return this.$message.error('添加失败，已存在同名藏品')
        this.$message.success('添加藏品成功')
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
