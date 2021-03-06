<template>
  <div class="app-container">
    <!-- 查询条件 -->
    <el-form :inline="true" :model="listQuery">
      <el-form-item label="名称:" prop="name">
        <el-input v-model="listQuery.name" size="small" class="filter-item" placeholder="名称" />
      </el-form-item>
      <el-form-item>
        <el-button v-waves type="primary" class="filter-item" icon="el-icon-search" size="small" @click="handleFilter">查询</el-button>
        <el-button v-for="item in btns.filter(item => item.Type==='button')" :id="item.DomId" :key="item.DomId" :type="item.Class" :icon="'el-icon-' + item.Icon" size="small" @click="handleBtnClick(item.DomId)">{{ item.Name }}</el-button>
      </el-form-item>
    </el-form>
    <el-table v-loading="listLoading" :data="list" size="mini" border fit height="520" highlight-current-row style="width: 100%;min-height:500px;">
      <el-table-column v-for="col in columns" :key="col.data" :label="col.name" :sortable="col.orderable">
        <template slot-scope="scope">{{ scope.row[col.data] }}</template>
      </el-table-column>
      <el-table-column align="center" label="是否有效" width="100">
        <template slot-scope="scope">
          <el-tag :type="scope.row.enabled ? 'success' : 'danger'">{{ scope.row.enabled ? '是' : '否' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column align="center" label="操作" width="180">
        <template slot-scope="scope">
          <el-button v-for="item in btns.filter(item => item.Type==='inline')" :id="item.DomId" :key="item.Id" :type="item.Class.replace('btn-','')" :icon="'el-icon-' + item.Icon" size="mini" @click="handleBtnClick(item.DomId, scope.row)">{{ item.Name }}</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination :current-page="listQuery.draw" :page-sizes="[10,20,30,50]" :page-size="listQuery.pageSize" :total="total" background layout="total, sizes, prev, pager, next, jumper" @size-change="handleSizeChange" @current-change="handleCurrentChange" />
    <!-- 编辑页 -->
    <el-dialog :visible.sync="dialogFormVisible" :title="editTitle">
      <el-form ref="formModel" :model="temp" :rules="rules" label-position="right" label-width="120px" style="margin-left:10px;margin-right:10px;">
        <el-form-item label="名称:" prop="name"><el-input v-model="temp.name" /></el-form-item>
        <el-form-item label="显示名称:" prop="displayName"><el-input v-model="temp.displayName" /></el-form-item>
        <el-form-item label="描述:" prop="description"><el-input v-model="temp.description" /></el-form-item>
        <el-form-item label="是否有效:" prop="enabled"><el-switch v-model="temp.enabled" /></el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取消</el-button>
        <el-button type="primary" @click="updateData">保存</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getPageList, edit, del } from '@/api/apiresource'
import waves from '@/directive/waves'

export default {
  directives: { waves },
  data() {
    return {
      total: 0,
      list: [],
      listLoading: false,
      listQuery: {
        draw: 0,
        page: 0,
        pageSize: 10,
        name: null
      },
      columns: [
        { data: 'name', name: '名称', searchable: true, orderable: true },
        { data: 'displayName', name: '显示名称', searchable: true, orderable: true },
        { data: 'description', name: '描述', searchable: true, orderable: true }
      ],
      btns: [
        { DomId: 'btnAdd', Name: '新增', Type: 'button', Class: 'primary', Icon: 'plus' },
        { DomId: 'btnEdit', Name: '编辑', Type: 'inline', Class: 'success', Icon: 'edit' },
        { DomId: 'btnDel', Name: '删除', Type: 'inline', Class: 'danger', Icon: 'delete' }
      ],
      dialogFormVisible: false,
      temp: { infoStatus: 1 },
      editTitle: '',
      rules: {
        gatewayName: [{ required: true, message: '网关名称', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.handleFilter()
  },
  methods: {
    getList() {
      this.listLoading = true
      this.list = []
      getPageList(this.listQuery).then(response => {
        this.listLoading = false
        this.list = response.result.rows || []
        this.total = response.result.total
      }).catch(() => {
        this.listLoading = false
      })
    },
    handleFilter() {
      this.listQuery.page = 0
      this.getList()
    },
    handleSizeChange(val) {
      this.listQuery.pageSize = val
      this.getList()
    },
    handleCurrentChange(val) {
      this.listQuery.page = val
      this.getList()
    },
    handleBtnClick(domid, row) {
      switch (domid) {
        case 'btnAdd':
          this.editTitle = '新增'
          this.temp = { infoStatus: 1 }
          this.dialogFormVisible = true
          this.$nextTick(() => {
            this.$refs['formModel'].clearValidate()
          })
          break
        case 'btnEdit':
          this.editTitle = '编辑'
          this.temp = Object.assign({}, row)
          this.dialogFormVisible = true
          this.$nextTick(() => {
            this.$refs['formModel'].clearValidate()
          })
          break
        case 'btnDel':
          this.handleDelete(row)
          break
      }
    },
    handleDelete(row) {
      this.$confirm('删除操作不可逆，请问是否删除?', '提示', { confirmButtonText: '确定', cancelButtonText: '取消', type: 'warning' }).then(() => {
        this.listLoading = true
        del(row.id).then(response => {
          this.listLoading = false
          if (response && response.success) {
            this.$notify({ title: '成功', message: '删除成功', type: 'success', duration: 2000 })
            this.handleFilter()
          } else {
            this.$message({ type: 'error', message: response.msg || '删除失败' })
          }
        }).catch(() => { this.listLoading = false })
      })
    },
    updateData() {
      this.$refs['formModel'].validate((valid) => {
        if (valid) {
          const tempData = Object.assign({}, this.temp)
          edit(tempData).then(response => {
            this.dialogFormVisible = false
            if (response && response.success) {
              this.handleFilter()
              this.$notify({ title: '成功', message: '更新成功', type: 'success', duration: 2000 })
            } else {
              this.$message({ type: 'error', message: response.msg || '更新失败' })
            }
          }).catch(() => { this.dialogFormVisible = false })
        }
      })
    }
  }

}
</script>
