import ACCESS_ENUM from "@/access/accessEnum";
import { UserControllerService } from "../../generated";
import { StoreOptions } from "vuex";
const state: any = () => ({
  loginUser: {
    userName: "未登录",
  },
});

// actions
const actions = {
  async getLoginUser({ commit }: any, payload: any) {
    // 从远程请求获取登录信息
    const res = await UserControllerService.helloUsingGet();
    console.log("获取登录信息", res);
  },
};

const mutations = {
  updateUser(state: any, payload: any) {
    state.loginUser = payload;
  },
};

// getters
const getters = {};

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
  modules: {},
} as StoreOptions<any>;
