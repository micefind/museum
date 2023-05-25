<template>
  <div>
    <!--面包屑导航-->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>用户管理</el-breadcrumb-item>
      <el-breadcrumb-item>用户列表</el-breadcrumb-item>
    </el-breadcrumb>
    <!--卡片视图区域-->
    <el-card>
      <!--搜索和用户添加区域-->
      <el-row :gutter="20">
        <el-col :span="8">
          <el-input placeholder="请输入内容" v-model="queryInfo.query">
            <el-button slot="append" icon="el-icon-search" @click="getUserList"></el-button>
          </el-input>
        </el-col>
        <el-col :span="4">
          <el-button type="primary" @click="dialogVisible = true">添加用户</el-button>
        </el-col>
      </el-row>
      <!--用户表格区域-->
      <el-table
          border
          :data="userList"
          stripe>
        <el-table-column type="index"></el-table-column>
        <el-table-column prop="username" label="用户名"></el-table-column>
        <el-table-column prop="nickname" label="昵称"></el-table-column>
        <el-table-column prop="mobile" label="电话"></el-table-column>
        <el-table-column label="状态">
          <template v-slot:default="scope">
            <el-switch v-model="scope.row.state"></el-switch>
          </template>
        </el-table-column>
        <el-table-column prop="date" label="注册时间"></el-table-column>
        <el-table-column label="操作">
          <template v-slot:default="scope">
            <el-tooltip effect="dark" content="编辑" placement="top" :enterable="false">
              <el-button type="primary" icon="el-icon-edit" size="mini"
                         @click="updateUser(scope.row.id,scope.row.username,scope.row.nickname,scope.row.mobile,scope.row.state)"></el-button>
            </el-tooltip>
            <el-tooltip effect="dark" content="删除" placement="top" :enterable="false">
              <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteUser(scope.row.id)"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>
      <!--分页区域-->
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="queryInfo.pagenum"
          :page-sizes="[1, 2, 5, 10]"
          :page-size="queryInfo.pagesize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </el-card>
    <!--添加用户对话框-->
    <el-dialog
        @close="addDialogClose"
        title="添加用户"
        :visible.sync="dialogVisible"
        width="50%">
      <el-form :model="userInfo" :rules="userInfoRules" ref="userInfoRef" label-width="70px">
        <el-form-item label="用户名" prop="username">
          <el-input v-model="userInfo.username"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="userInfo.password" type="password"></el-input>
        </el-form-item>
        <el-form-item label="昵称" prop="nickname">
          <el-input v-model="userInfo.nickname" ></el-input>
        </el-form-item>
        <el-form-item label="手机" prop="mobile">
          <el-input v-model="userInfo.mobile"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="addUser">确 定</el-button>
      </span>
    </el-dialog>
    <!--编辑用户信息对话框-->
    <el-dialog
        @close="editDialogClose"
        title="编辑用户信息"
        :visible.sync="editDialogVisible"
        width="50%">
      <el-form :model="updateUserInfo" ref="editUserInfoRef" label-width="70px">
        <el-form-item label="用户名">
          <el-input v-model="updateUserInfo.username" disabled></el-input>
        </el-form-item>
        <el-form-item label="昵称">
          <el-input v-model="updateUserInfo.nickname" ></el-input>
        </el-form-item>
        <el-form-item label="手机">
          <el-input v-model="updateUserInfo.mobile"></el-input>
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="updateUserInfo.state">
            <el-radio :label="1">异常</el-radio>
            <el-radio :label="0">正常</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editUser">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
export default {
  name: "user",
  data() {
    return {
      // 用户列表
      userList: [],
      // 获取用户列表查询参数
      queryInfo: {
        query: '',
        pagenum: 1,
        pagesize: 5,
      },
      // 用户数据总条数
      total: 0,
      // 控制添加用户对话框显示和隐藏
      dialogVisible: false,
      // 控制添加用户对话框显示和隐藏
      editDialogVisible: false,
      // 用户信息
      userInfo: {
        username: '',
        password: '',
        nickname: '',
        mobile: ''
      },
      updateUserInfo: {
        id: null,
        username: '',
        nickname: '',
        mobile: '',
        state: ''
      },
      // 添加用户表单验证规则对象
      userInfoRules: {
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
          { min: 3, max: 9, message: '长度在 3 到 9 个字符', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
          { min: 6, max: 15, message: '长度在 6 到 15 个字符', trigger: 'blur' }
        ],
        nickname: [
          { required: false, message: '请输入昵称', trigger: 'blur' },
          { min: 1, max: 7, message: '长度在 1 到 7 个字符', trigger: 'blur' }
        ],
        mobile: [
          { required: false, message: '请输入手机号', trigger: 'blur' },
          { min: 11, max: 11, message: '请输入11位的手机号', trigger: 'blur' }
        ],
      },
    }
  },
  created() {
    this.getUserList()
  },
  methods: {
    // 获取用户列表
    async getUserList() {
      const {data: res} = await this.$http.get('/api/user/getdata', {params: this.queryInfo})
      if (res.status !== 0) return this.$message.error('获取用户列表失败')
      this.userList = res.userList
      this.total = res.total
    },
    // 监听分页 pageSize 变化
    handleSizeChange(newSize) {
      this.queryInfo.pagesize = newSize
      this.getUserList()
    },
    // 监听分页 pageNum 变化
    handleCurrentChange(newPage) {
      this.queryInfo.pagenum = newPage
      this.getUserList()
    },
    // 监听添加用户对话框关闭
    addDialogClose() {
      // 重置表单数据
      this.$refs.userInfoRef.resetFields()
    },
    // 监听添加用户对话框关闭
    editDialogClose() {
      // 重置表单数据
      this.$refs.editUserInfoRef.resetFields()
    },
    // 添加用户
    addUser() {
      this.$refs.userInfoRef.validate(async valid => {
        if (!valid) return
        const {data: res} = await this.$http.post('/api/public/user/register', this.userInfo)
        if (res.status !== 0) return this.$message.error(res.message)
        this.$message.success('添加用户成功')
        this.dialogVisible = false
        await this.getUserList()
      })
    },
    // 删除用户
    async deleteUser(id) {
      const confirmResult = await this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).catch(err => err)
      if (confirmResult !== 'confirm') return this.$message.info('已取消删除')
      const {data: res} = await this.$http.delete('/api/deluser', {params: {id: id}})
      if (res.status !== 0) return this.$message.error('删除用户失败')
      this.$message.success('删除用户成功')
      await this.getUserList()
    },
    // 显示添加用户对话框
    updateUser(id, username, nickname, mobile, state) {
      this.updateUserInfo.id = id
      this.updateUserInfo.username = username
      this.updateUserInfo.nickname = nickname
      this.updateUserInfo.mobile = mobile
      this.updateUserInfo.state = state===false?1:0
      this.editDialogVisible = true
    },
    async editUser() {
      await this.$http.post('/api/editUserInfo', this.updateUserInfo)
      this.editDialogVisible = false
      await this.getUserList()
      this.$message.success('更新用户信息成功')
    }
  }
}
</script>

<style lang="less" scoped>




</style>
