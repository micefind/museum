<template>
<div>
  <!--面包屑导航-->
  <el-breadcrumb separator-class="el-icon-arrow-right">
    <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
    <el-breadcrumb-item>数据分析</el-breadcrumb-item>
    <el-breadcrumb-item>藏品数据</el-breadcrumb-item>
  </el-breadcrumb>
  <el-card>
    <div>
      <div style="color: #777;font-size: 14px">明星藏品被浏览次数</div>
      <div ref="chart" style="height: 500px;width: 100%;"></div>
    </div>
  </el-card>
</div>
</template>

<script>

import * as echarts from 'echarts'

export default {
  name: "analysis",
  data() {
    return {
      chartData: []
    }
  },
  created() {
    this.getCol()
  },
  mounted() {
    setTimeout(() => {
      const chart = echarts.init(this.$refs.chart);
      const option = {
        xAxis: {
          type: 'category',
          name:"藏品名称",  // X 坐标轴名称
          data: this.chartData.map(item => item.title),
          axisLabel: {interval:0,rotate:30}
        },
        yAxis: {
          type: 'value',
        },
        series: [{
          data: this.chartData.map(item => item.view),
          type: 'bar',
          itemStyle: {
            normal: {
              color:function(){return "#"+Math.floor(Math.random()*(256*256*256-1)).toString(16);},
            },
          },
          // 实现数字展示在柱状图
          label: {
            show: true,
            position: 'top',
            color:'#333'
          },
        }],
      };

      chart.setOption(option);
    }, 100)
  },
  methods: {
    async getCol() {
      const {data: res} = await this.$http.get('/api/getcol', {params:{cate_id: 18}})
      this.chartData = res.colList
    }
  }
}
</script>

<style scoped>

</style>
