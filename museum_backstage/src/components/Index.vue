<template>
  <div>
    <!--面包屑导航-->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item>首页</el-breadcrumb-item>
      <el-breadcrumb-item>信息总览</el-breadcrumb-item>
    </el-breadcrumb>
    <!--4盒子 头部区域-->
    <div class="index-head-box">
      <div class="head-item"  v-for="(item, i) in headTitleList" :key="i">
        <div class="title">{{item}}</div>
        <div v-if="i === 0" >
          <div v-if="overviewData.collectionData&&overviewData.collectionData.length>0" class="item1">
            <div v-for="(item,i) in overviewData.collectionData" :key="i" class="item1-i" :class="styleList[i % 4]">
              <span>{{item.title}}</span>
              <span>{{item.origin}}</span>
            </div>
          </div>
          <div v-else style="padding: 10%">
            <el-skeleton :rows="4" animated />
          </div>
        </div>
        <div v-if="i === 1">
          <div v-if="overviewData.slideShowData&&overviewData.slideShowData.length>0" class="item2">
            <el-carousel height="200px" indicator-position="none">
              <el-carousel-item v-for="(item,i) in overviewData.slideShowData" :key="i">
                <img :src="picBaseUrl+item.pic_src" alt="">
              </el-carousel-item>
            </el-carousel>
          </div>
          <div v-else style="padding: 10%">
            <el-skeleton :rows="4" animated />
          </div>
        </div>
        <div v-if="i === 2">
          <div v-if="overviewData.collectionData&&overviewData.collectionData.length>0" class="item2">
            <el-carousel height="200px" indicator-position="none">
              <el-carousel-item v-for="(item,i) in overviewData.collectionData" :key="i">
                <img :src="picBaseUrl+item.col_pic" alt="">
              </el-carousel-item>
            </el-carousel>
          </div>
          <div v-else style="padding: 10%">
            <el-skeleton :rows="4" animated />
          </div>
        </div>
        <div v-if="i === 3" class="item3">
          <div v-if="overviewData.feedbackData&&overviewData.feedbackData.length>0">
            <div class="item3-text">
              <p v-html="overviewData.announcementData[0].content"></p>
            </div>
            <div class="item3-date">{{overviewData.announcementData[0].date}}</div>
          </div>
          <div v-else style="padding: 8%">
            <el-skeleton :rows="4" animated />
          </div>
        </div>
      </div>
    </div>
    <!--表格与柱形图区域-->
    <div class="index-content-box">
      <div class="index-content-box-left">
        <div class="title">用户反馈信息</div>
        <div class="table-box" v-if="overviewData.feedbackData&&overviewData.feedbackData.length>0">
          <el-table
              :data="overviewData.feedbackData"
              height="270"
              border
              stripe>
            <el-table-column label="用户名" prop="user_name"></el-table-column>
            <el-table-column label="反馈内容" prop="content"></el-table-column>
            <el-table-column label="提交时间" prop="timestamp"></el-table-column>
          </el-table>
        </div>
      </div>
      <div class="index-content-box-right">
        <div class="title">藏品浏览次数</div>
        <div class="column-title-box">
          <span class="column-title" @click="showChartOne" :class="showChart1===true?'column-title-active':'column-title'">陶器</span>
          <span class="column-title" @click="showChartTwo" :class="showChart2===true?'column-title-active':'column-title'">青铜器</span>
          <span class="column-title" @click="showChartThree" :class="showChart3===true?'column-title-active':'column-title'">书法</span>
          <span class="column-title" @click="showChartFour" :class="showChart4===true?'column-title-active':'column-title'">绘画</span>
        </div>
        <div class="column-box">
          <div ref="chart1" v-show="showChart1" style="height: 270px">1</div>
          <div ref="chart2" v-show="showChart2" style="height: 270px">2</div>
          <div ref="chart3" v-show="showChart3" style="height: 270px">3</div>
          <div ref="chart4" v-show="showChart4" style="height: 270px">4</div>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
import * as echarts from "echarts";

export default {
  name: "Index2",
  data() {
    return {
      picBaseUrl: this.$picBaseUrl,
      headTitleList: ['藏品一览','首页轮播图','明星藏品图','公告栏(最新公告信息)'],
      // 头部盒子1内部样式列表
      styleList: ["item1-red",'item1-blue','item1-yellow','item1-pink'],
      // 控制柱形图显示与隐藏
      showChart1: true,
      showChart2: true,
      showChart3: true,
      showChart4: true,
      chart1: null,
      chart2: null,
      chart3: null,
      chart4: null,
      // 折线图数据 假数据
      chartData: [],
      // 柱形图数据
      yData1: [],
      xData1: [],
      xData2: [],
      yData2: [],
      xData3: [],
      yData3: [],
      xData4: [],
      yData4: [],
      // 首屏加载初始数据
      overviewData: {
        collectionData: [],
        feedbackData: [],
        slideShowData: [],
        announcementData: [],
      },
    }
  },
  created() {
    this.getOverview()
    this.getDrawingColList()
    this.getPotteryColList()
    this.getHandwritingColList()
    this.getBronzeColList()
  },
  updated() {

  },
  mounted() {
    this.chart1 = echarts.init(this.$refs.chart1)
    this.chart2 = echarts.init(this.$refs.chart2)
    this.chart3 = echarts.init(this.$refs.chart3)
    this.chart4 = echarts.init(this.$refs.chart4)
    // 默认不显示图表234
    this.showChart2= false
    this.showChart3= false
    this.showChart4= false
  },
  methods: {
    // 获取首屏加载初始数据
    getOverview() {
      this.$http.get('/api/getoverviews').then( res => {
        this.overviewData = res.data
      })
    },
    async getPotteryColList() {
      const {data: res} = await this.$http.get('/api/getcol', {params:{cate_id: 8}})
      res.colList.forEach(item => {
        this.xData1.push(item.title)
        this.yData1.push(item.view)
      })
      this.renderChart1()
    },
    async getBronzeColList() {
      const {data: res} = await this.$http.get('/api/getcol', {params:{cate_id: 9}})
      res.colList.forEach(item => {
        this.xData2.push(item.title)
        this.yData2.push(item.view)
      })
      this.renderChart2()
    },
    async getHandwritingColList() {
      const {data: res} = await this.$http.get('/api/getcol', {params:{cate_id: 13}})
      res.colList.forEach(item => {
        this.xData3.push(item.title)
        this.yData3.push(item.view)
      })
      this.renderChart3()
    },
    async getDrawingColList() {
      const {data: res} = await this.$http.get('/api/getcol', {params:{cate_id: 14}})
      res.colList.forEach(item => {
        this.xData4.push(item.title)
        this.yData4.push(item.view)
      })
      this.renderChart4()
    },
    // 控制柱形图显示与隐藏
    showChartOne() {
      this.showChart1 = true
      this.showChart2 = false
      this.showChart3 = false
      this.showChart4 = false
    },
    showChartTwo() {
      this.showChart1 = false
      this.showChart2 = true
      this.showChart3 = false
      this.showChart4 = false
    },
    showChartThree() {
      this.showChart1 = false
      this.showChart2 = false
      this.showChart3 = true
      this.showChart4 = false
    },
    showChartFour() {
      this.showChart1 = false
      this.showChart2 = false
      this.showChart3 = false
      this.showChart4 = true
    },
    // 柱形图数据配置
    renderChart1() {
      const options = {
        title: {
          text: '',
        },
        xAxis: {
          type: 'category',
          data: this.xData1,
          // axisLabel: {interval:0,rotate:30},
          // x轴文字换行显示
          axisLabel: {
            interval: 0,
            formatter:function(value)
            {
              let ret = "";//拼接加\n返回的类目项
              let maxLength = 4;//每项显示文字个数
              let valLength = value.length;//X轴类目项的文字个数
              let rowN = Math.ceil(valLength / maxLength); //类目项需要换行的行数
              if (rowN > 1)//如果类目项的文字大于4,
              {
                for (let i = 0; i < rowN; i++) {
                  let temp = "";//每次截取的字符串
                  let start = i * maxLength;//开始截取的位置
                  let end = start + maxLength;//结束截取的位置
                  temp = value.substring(start, end) + "\n";
                  ret += temp; //凭借最终的字符串
                }
                return ret;
              }
              else {
                return value;
              }
            }
          }
        },
        yAxis: {
          type: 'value',
        },
        series: [
          {
            name: 'Data 1',
            type: 'bar',
            data: this.yData1,
          },
        ],
        dataZoom:[
          {
            startValue: 0, // 用绝对值的方式定义了窗口数据默认展示的数据开始范围
            endValue: 6, // 用绝对值的方式定义了窗口数据默认展示的数据终止范围
            filterMode: 'filter',
            realtime:true, //拖动滚动条时是否动态的更新图表数据
            height:15,//滚动条高度
          },
          {
            type: "inside",  // 支持内部鼠标滚动平移
            zoomOnMouseWheel: true,  // 关闭滚轮缩放
          }
        ]
      }
      this.chart1.setOption(options)
    },
    renderChart2() {
      const options = {
        title: {
          text: '',
        },
        xAxis: {
          type: 'category',
          data: this.xData2,
          // axisLabel: {interval:0,rotate:30},
          // x轴文字换行显示
          axisLabel: {
            interval: 0,
            formatter:function(value)
            {
              let ret = "";//拼接加\n返回的类目项
              let maxLength = 4;//每项显示文字个数
              let valLength = value.length;//X轴类目项的文字个数
              let rowN = Math.ceil(valLength / maxLength); //类目项需要换行的行数
              if (rowN > 1)//如果类目项的文字大于4,
              {
                for (let i = 0; i < rowN; i++) {
                  let temp = "";//每次截取的字符串
                  let start = i * maxLength;//开始截取的位置
                  let end = start + maxLength;//结束截取的位置
                  temp = value.substring(start, end) + "\n";
                  ret += temp; //凭借最终的字符串
                }
                return ret;
              }
              else {
                return value;
              }
            }
          }
        },
        yAxis: {
          type: 'value',
        },
        series: [
          {
            name: 'Data 2',
            type: 'bar',
            data: this.yData2,
          }
        ],
        dataZoom:{
          realtime:true, //拖动滚动条时是否动态的更新图表数据
          height:15,//滚动条高度
          start:0,//滚动条开始位置（共100等份）
          end:100//结束位置（共100等份）
        }
      }
      this.chart2.setOption(options)
    },
    renderChart3() {
      const options = {
        title: {
          text: '',
        },
        xAxis: {
          type: 'category',
          data: this.xData3,
          // axisLabel: {interval:0,rotate:30},
          // x轴文字换行显示
          axisLabel: {
            interval: 0,
            formatter:function(value)
            {
              let ret = "";//拼接加\n返回的类目项
              let maxLength = 4;//每项显示文字个数
              let valLength = value.length;//X轴类目项的文字个数
              let rowN = Math.ceil(valLength / maxLength); //类目项需要换行的行数
              if (rowN > 1)//如果类目项的文字大于4,
              {
                for (let i = 0; i < rowN; i++) {
                  let temp = "";//每次截取的字符串
                  let start = i * maxLength;//开始截取的位置
                  let end = start + maxLength;//结束截取的位置
                  temp = value.substring(start, end) + "\n";
                  ret += temp; //凭借最终的字符串
                }
                return ret;
              }
              else {
                return value;
              }
            }
          }
        },
        yAxis: {
          type: 'value',
        },
        series: [
          {
            name: 'Data 1',
            type: 'bar',
            data: this.yData3,
          }
        ],
        dataZoom:{
          realtime:true, //拖动滚动条时是否动态的更新图表数据
          height:15,//滚动条高度
          start:0,//滚动条开始位置（共100等份）
          end:100//结束位置（共100等份）
        }
      }
      this.chart3.setOption(options)
    },
    renderChart4() {
      const options = {
        title: {
          text: '',
        },
        xAxis: {
          type: 'category',
          data: this.xData4,
          // axisLabel: {interval:0,rotate:30},
          // x轴文字换行显示
          axisLabel: {
            interval: 0,
            formatter:function(value)
            {
              let ret = "";//拼接加\n返回的类目项
              let maxLength = 4;//每项显示文字个数
              let valLength = value.length;//X轴类目项的文字个数
              let rowN = Math.ceil(valLength / maxLength); //类目项需要换行的行数
              if (rowN > 1)//如果类目项的文字大于4,
              {
                for (let i = 0; i < rowN; i++) {
                  let temp = "";//每次截取的字符串
                  let start = i * maxLength;//开始截取的位置
                  let end = start + maxLength;//结束截取的位置
                  temp = value.substring(start, end) + "\n";
                  ret += temp; //凭借最终的字符串
                }
                return ret;
              }
              else {
                return value;
              }
            }
          }
        },
        yAxis: {
          type: 'value',
        },
        series: [
          {
            name: 'Data 1',
            type: 'bar',
            data: this.yData4,
          }
        ],
        dataZoom:{
          realtime:true, //拖动滚动条时是否动态的更新图表数据
          height:15,//滚动条高度
          start:0,//滚动条开始位置（共100等份）
          end:100//结束位置（共100等份）
        }
      }
      this.chart4.setOption(options)
    },
  }
}
</script>

<style scoped>
.index-head-box {
  box-sizing: border-box;
  width: 100%;
  height: 250px;
  /*background-color: #889;*/
  padding: 5px;
  display: flex;
  margin-top: 15px;
}

.head-item {
  box-sizing: border-box;
  width: 25%;
  height: 100%;
  background-color: #fff;
  display: flex;
  flex-direction: column;
  margin: 0 5px;
  border-radius: 5px;
  overflow: hidden;
  box-shadow: 0 1px 5px rgba(55, 122, 255, 0.3);
}

.item1 {
  box-sizing: border-box;
  margin-right: 5px;
  padding: 3px 0 3px 5px;
  background-color: #fff;
  overflow: hidden;
  display: flex;
  flex-wrap: wrap;
  overflow-y: scroll;
  height: 200px;
  border-bottom: 5px solid #fff;
}
.item1-i {
  background-color: #ccc;
  height: 60px;
  border-radius: 5px;
  /*overflow-y: auto;*/
  margin: 3px;
  padding: 5px;
  /*border: 1px solid #ccc;*/
  display: flex;
  width: calc(50% - 10px);
  flex-direction: column;
  justify-content: center;
  align-items: center;
  box-sizing: border-box;
  box-shadow: 0 0 2px rgba(0, 150, 255, 0.5);
  /*文字不换行*/
  white-space: nowrap;
  overflow: hidden;
  text-overflow:ellipsis;
  font-size: 12px;
}
.item2 {
  box-sizing: border-box;
  width: 100%;
  height: 200px;
  background-color: #fff;
  /*margin: 0 auto;*/
  overflow: hidden;
  text-align: center;
  padding: 0 10px;
}

.item2 img {
  box-sizing: border-box;
  height: 90%;
  /*margin: 10px 10px;*/
  margin: 10px auto;
  /*border-radius: 5px;*/
}

.item3 {
  box-sizing: border-box;
  padding: 10px;
}
.item3-text {
  font-size: 14px;
  color: #333;
}
.item3-date {
  font-size: 12px;
  color: #777;
  line-height: 24px;
}

/*盒子1：内部元素循环添加样式*/
.item1-red {
  background-color: #dff0d8;
  color: #3c763d;
}
.item1-blue {
  background-color: #d9edf7;
  color: #31708f;
}
.item1-yellow {
  background-color: #fcf8e3;
  color: #8a6d38;
}
.item1-pink {
  background-color: #f2dede;
  color: #a94442;
}

.title {
  height: 40px;
  line-height: 40px;
  text-align: center;
  overflow: hidden;
  background-color: #fff;
  white-space: nowrap;
  text-overflow: ellipsis;
  font-size: 14px;
  color: #444;
}

/*表格与折线图区域*/
.index-content-box {
  box-sizing: border-box;
  width: 100%;
  height: 400px;
  /*background-color: #999;*/
  margin: 15px 0 50px 0;
  padding: 10px;
  display: flex;
  /*box-shadow: 0 1px 5px rgba(55, 122, 255, 0.3);*/
}

.index-content-box-left {
  box-shadow: 0 1px 5px rgba(55, 122, 255, 0.3);
  width: 50%;
  height: 100%;
  background-color: #fff;
  border-bottom-left-radius: 5px;
  border-top-left-radius: 5px;
  overflow: hidden;
}
.table-box {
  border-right: 1px solid #eff0f2;
  padding: 0 10px;
  height: 300px;
  overflow: hidden;
  /*overflow-y: scroll;*/
}

.index-content-box-right {
  border-bottom-right-radius: 5px;
  border-top-right-radius: 5px;
  box-shadow: 0 1px 5px rgba(55, 122, 255, 0.3);
  width: 50%;
  height: 100%;
  background-color: #fff;
  overflow: hidden;
}

.column-title-box {
  margin: 5px 0 0 20px;
  /*border-left: 1px solid #999999;*/
}

.column-box {
  /*border-left: 1px solid #999999;*/
  height: 270px;
  width: 500px;
  overflow: hidden;
  background-color: #fff;
  margin: 0 auto;
}

.column-title {
  display: inline-block;
  border: 1px solid #97a8be;
  cursor: pointer;
  background-color: #ecf5ff;
  color: #777;
  padding: 3px;
  margin-top: 2px;
  border-radius: 3px;
  margin-right: 5px;
  font-size: 14px;
}

.column-title:hover {
  background-color: rgba(58, 125, 255, 0.77);
  color: #fff;
}
.column-title-active {
  background-color: rgba(58, 125, 255, 0.77);
  color: #fff;
}

</style>
