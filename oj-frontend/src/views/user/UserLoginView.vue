<template>
  <div id="userLoginView">
    <h2 style="margin-bottom: 16px">用户登录</h2>
    <a-form
      style="max-width: 480px; margin: 0 auto"
      label-align="left"
      auto-label-width
      :model="form"
      @submit="handleSubmit"
    >
      <a-form-item field="userAccount" label="账号">
        <a-input v-model="form.userAccount" placeholder="请输入账号" />
      </a-form-item>
      <a-form-item field="userPassword" tooltip="密码不少于 8 位" label="密码">
        <a-input-password
          v-model="form.userPassword"
          placeholder="请输入密码"
        />
      </a-form-item>
      <a-form-item>
        <a-button
          type="primary"
          html-type="submit"
          style="width: 120px; margin-right: 100px"
        >
          登录
        </a-button>
        <a-button
          type="text"
          style="width: 290px; text-align: center"
          @click="handleRegister"
        >
          还没有注册账号，现在去注册！
        </a-button>
      </a-form-item>
    </a-form>
  </div>
</template>

<script setup lang="ts">
import { reactive } from "vue";
import message from "@arco-design/web-vue/es/message";
import { UserControllerService, UserLoginRequest } from "../../../generated";
import { useRouter } from "vue-router";
import { useStore } from "vuex";

/**
 * 表单信息
 */
const form = reactive({
  userAccount: "",
  userPassword: "",
});

const router = useRouter();
const store = useStore();

/**
 * 提交表单
 * @param data
 */
import { useRoute } from "vue-router";

const route = useRoute();
const handleSubmit = async () => {
  const res = await UserControllerService.userLoginUsingPost(form);
  // 登录成功，跳转到主页
  if (res.code === 0) {
    await store.dispatch("user/getLoginUser");
    const redirectPath = route.query.redirect || "/";
    router.push({ path: redirectPath as string, replace: true });
  } else {
    message.error("登陆失败，" + res.message);
  }
};
const handleRegister = () => {
  router.push({
    path: "/user/register",
    replace: false,
  });
  console.log("注册");
};
</script>
