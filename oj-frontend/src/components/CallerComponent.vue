<template>
  <a-button @click="handleClick">Open Login Modal</a-button>
</template>

<script>
import { h } from "vue";
import { Modal, Button, Input } from "@arco-design/web-vue";

const LoginModalContent = {
  setup() {
    const handleLogin = () => {
      // 这里可以添加登录逻辑，例如发送请求到后端进行验证
      console.log("Login button clicked");
    };

    return () =>
      h("div", { class: "login-modal-content" }, [
        h("div", { class: "mb-4" }, [
          h("label", { for: "username" }, "Username"),
          h(Input, { id: "username", placeholder: "Enter your username" }),
        ]),
        h("div", { class: "mb-4" }, [
          h("label", { for: "password" }, "Password"),
          h(Input, {
            id: "password",
            type: "password",
            placeholder: "Enter your password",
          }),
        ]),
        h(Button, { onClick: handleLogin }, "Login"),
      ]);
  },
};

export default {
  setup() {
    const handleClick = () => {
      Modal.info({
        title: "Login",
        content: () => h(LoginModalContent),
      });
    };

    return {
      handleClick,
    };
  },
};
</script>

<style scoped>
.login-modal-content {
  display: flex;
  flex-direction: column;
  padding: 20px;
}

.login-modal-content label {
  display: block;
  margin-bottom: 4px;
}

.login-modal-content input {
  width: 100%;
  padding: 8px;
  margin-bottom: 16px;
  border: 1px solid #ccc;
  border-radius: 4px;
}
</style>
