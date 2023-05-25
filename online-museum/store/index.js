import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
  state: {
    // 存储收藏藏品的id
    collectionIds: []
  },
  mutations: {
    // 添加一个收藏藏品的id
    addCollectionId(state, id) {
      // console.log('添加收藏藏品的id成功');
      state.collectionIds = JSON.parse(uni.getStorageSync('col_id') || '[]')
      // state.collectionIds.push(id)
      // console.log(state.collectionIds);
      const set = new Set(state.collectionIds)
      set.delete(id)
      set.add(id)
      state.collectionIds = Array.from(set)
      // 调用 uni.setStorageSync(key, value) 将搜索历史记录持久化存储到本地
      uni.setStorageSync('col_id', JSON.stringify(state.collectionIds))
    },
    // 移除一个收藏藏品的id
    removeCollectionId(state, id) {
      state.collectionIds = JSON.parse(uni.getStorageSync('col_id') || '[]')
      const index = state.collectionIds.indexOf(id)
      if (index !== -1) {
        // console.log('移除收藏藏品的id成功');
        state.collectionIds.splice(index, 1)
      }
      uni.setStorageSync('col_id', JSON.stringify(state.collectionIds))
    },
  },
  getters: {
    // 获取收藏藏品的id列表
    collectionIds(state) {
      return state.collectionIds
    }
  }
})

export default store
