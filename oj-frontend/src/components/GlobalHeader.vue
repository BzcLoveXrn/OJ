<template>
  <a-row
    id="globalHeader"
    style="margin-bottom: 16px"
    align="center"
    :wrap="false"
  >
    <a-col flex="auto">
      <div class="menu-demo">
        <a-menu
          mode="horizontal"
          :selected-keys="selectedKeys"
          @menu-item-click="doClick"
        >
          <a-menu-item
            key="0"
            :style="{ padding: 0, marginRight: '38px' }"
            disabled
          >
            <div class="titlebar">
              <img class="logo" src="../assets/logo.png" alt="" />
              <div class="title">力扣</div>
            </div>
          </a-menu-item>

          <a-menu-item v-for="item in visibleRoutes" :key="item.path">
            {{ item.name }}
          </a-menu-item>
        </a-menu>
      </div>
    </a-col>
    <a-col flex="100px" @click="changeName">
      <div>用户名：{{ $store.state.user.loginUser.userName }}</div>
    </a-col>
  </a-row>
</template>

<style scoped>
.titlebar {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  width: 100%;
}
.logo {
  height: 48px;
}
.title {
  height: 48px;
  color: black;
  margin-left: 16px;
}
</style>
<script setup>
import router from "@/router";
import { computed } from "vue";
import { routes } from "@/router/routes";
import checkAccess from "@/access/checkAccess";
const store = useStore();
const loginUser = computed(() => store.state.user.loginUser);
const visibleRoutes = computed(() => {
  return routes.filter((item, index) => {
    if (item.meta?.hideInMenu) {
      return false;
    }
    if (!checkAccess(loginUser.value, item.meta?.access)) {
      return false;
    }
    return true;
  });
});
import { useRouter } from "vue-router";
import { ref } from "vue";
import { useStore } from "vuex";
import ACCESS_ENUM from "@/access/accessEnum";
const routerInstance = useRouter();
const selectedKeys = ref(["/"]);
routerInstance.afterEach((to) => {
  selectedKeys.value = [to.path];
});
const doClick = (key) => {
  routerInstance.push({
    path: key,
  });
};
const changeName = () => {
  store.dispatch("user/updateLoginUserName", {
    userName: "宾子成",
    userRole: ACCESS_ENUM.USER,
  });
  store.dispatch("user/updateShowLoginModel", true);
};
</script>
