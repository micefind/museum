<template>
<div>
  <!--面包屑导航-->
  <el-breadcrumb separator-class="el-icon-arrow-right">
    <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
    <el-breadcrumb-item>藏品管理</el-breadcrumb-item>
    <el-breadcrumb-item>藏品列表</el-breadcrumb-item>
  </el-breadcrumb>
  <!--藏品列表区域-->
  <el-card>
    <!--用户表格区域-->
    <el-table
        border
        :data="colList"
        stripe>
      <el-table-column type="index"></el-table-column>
      <el-table-column label="藏品" align="center">
          <template v-slot:default="scope">
            <!--<img :src="baseUrl+scope.row.col_pic" alt="" class="col-pic">-->
            <el-image
                :preview-src-list="[baseUrl+scope.row.col_pic]"
                :src="baseUrl+scope.row.col_pic"
                class="col-pic">
            </el-image>
          </template>
      </el-table-column>
      <el-table-column prop="title" label="名称" :formatter="stateFormat"></el-table-column>
      <el-table-column prop="origin" label="来源"></el-table-column>
      <el-table-column prop="cate_id" label="分类"></el-table-column>
      <el-table-column prop="base" label="基本信息" :formatter="stateFormat"></el-table-column>
      <el-table-column prop="describe" label="描述" :formatter="stateFormat"></el-table-column>
      <el-table-column label="操作">
        <template v-slot:default="scope">
          <el-tooltip effect="dark" content="编辑" placement="top" :enterable="false">
            <el-button type="primary" icon="el-icon-edit" size="mini"
                       @click="showEditDialog(scope.row.id,scope.row.title,scope.row.base,scope.row.origin,scope.row.describe)"></el-button>
          </el-tooltip>
          <el-tooltip effect="dark" content="删除" placement="top" :enterable="false">
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="deleteCol(scope.row.id)"></el-button>
          </el-tooltip>
        </template>
      </el-table-column>
    </el-table>
    <!--分页区域-->
    <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="queryInfo.pagenum"
        :page-sizes="[5, 10, 15, 20]"
        :page-size="queryInfo.pagesize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total">
    </el-pagination>
  </el-card>
  <!--编辑藏品信息对话框-->
  <el-dialog
      @close="editDialogClose"
      title="编辑藏品信息"
      :visible.sync="editDialogVisible"
      width="50%">
    <el-form :model="updateColInfo" ref="editInfoRef" label-width="70px">
      <el-form-item label="藏品名称">
        <el-input v-model="updateColInfo.title"></el-input>
      </el-form-item>
      <el-form-item label="来源">
        <el-input v-model="updateColInfo.origin" ></el-input>
      </el-form-item>
      <el-form-item label="基本信息">
        <el-input v-model="updateColInfo.base"></el-input>
      </el-form-item>
      <el-form-item label="描述">
        <el-input v-model="updateColInfo.describe"></el-input>
      </el-form-item>

    </el-form>
    <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="editColInfo">确 定</el-button>
      </span>
  </el-dialog>


</div>
</template>

<script>
export default {
  name: "collection",
  data() {
    return {
      // 获取藏品信息参数
      queryInfo: {
        query: '',
        pagenum: 1,
        pagesize: 5
      },
      // 藏品列表
      colList: [],
      // 藏品总数
      total: 0,
      // 图片显示基准地址
      baseUrl: this.$picBaseUrl,
      editDialogVisible: false,
      updateColInfo: {
        id: null,
        title: '',
        origin: '',
        base: '',
        describe: ''
      }
    }
  },
  created() {
    this.getColList()
  },
  methods: {
    async getColList() {
      const {data: res} = await this.$http.get('/api/getcol', {params: this.queryInfo})
      if (res.status !== 0) return this.$message.error('获取藏品信息失败')
      this.colList = res.colList
      this.total = res.total
    },
    // 格式化表格消息内容
    stateFormat(row, column, cellValue) {
      // console.log(row , column , cellValue)
      if (!cellValue) return "";
      if (cellValue.length > 20) {
        //最长固定显示4个字符
        return cellValue.slice(0, 20) + "...";
      }
      return cellValue;
    },
    // 监听分页 pageSize 变化
    handleSizeChange(newSize) {
      this.queryInfo.pagesize = newSize
      this.getColList()
    },
    // 监听分页 pageNum 变化
    handleCurrentChange(newPage) {
      this.queryInfo.pagenum = newPage
      this.getColList()
    },
    // 监听添加用户对话框关闭
    editDialogClose() {
      // 重置表单数据
      this.$refs.editInfoRef.resetFields()
    },
    // 删除藏品
    async deleteCol(id) {
      const confirmResult = await this.$confirm('此操作将永久删除该藏品, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).catch(err => err)
      if (confirmResult !== 'confirm') return this.$message.info('已取消删除')
      const {data: res} = await this.$http.delete('/api/delcol', {params: {id: id}})
      if (res.status !== 0) return this.$message.error('删除藏品失败')
      this.$message.success('删除藏品成功')
      await this.getColList()
    },
    // 显示编辑藏品信息对话框
    showEditDialog(id, title, base, origin, describe) {
      this.updateColInfo.id = id
      this.updateColInfo.title = title
      this.updateColInfo.base = base
      this.updateColInfo.origin = origin
      this.updateColInfo.describe = describe
      this.editDialogVisible = true
    },
    // 更新藏品信息
    async editColInfo() {
      await this.$http.post('/api/updatecolinfo', this.updateColInfo)
      this.editDialogVisible = false
      await this.getColList()
      this.$message.success('更新藏品信息成功')
    }
  }
}
</script>

<style lang="less" scoped>

.col-pic {
  width: 50px;
  height: 50px;
  border-radius: 5px;
}

</style>
