import { RouteRecordRaw } from "vue-router";
import HomeView from "../views/HomeView.vue";
import HideView from "@/components/HideView.vue";
import AdminView from "@/components/Admin.vue";
import ACCESS_ENUM from "@/access/accessEnum";
import NoAuthView from "@/components/NoAuthView.vue";
import CallerComponent from "@/components/CallerComponent.vue";
import UserLoginView from "@/views/user/UserLoginView.vue";
import UserRegisterView from "@/views/user/UserRegisterView.vue";
import UserLayout from "@/layouts/UserLayout.vue";
import AboutView from "../views/AboutView.vue";
import TestView from "@/views/TestView.vue";
import QuestionAddView from "@/views/question/QuestionAdd.vue";
import QuestionListView from "@/views/question/QuestionList.vue";
import QuestionDetailView from "@/views/question/QuestionDetail.vue";

export const routes: Array<RouteRecordRaw> = [
  {
    path: "/user",
    name: "用户",
    component: UserLayout,
    children: [
      {
        path: "/user/login",
        name: "用户登录",
        component: UserLoginView,
      },
      {
        path: "/user/register",
        name: "用户注册",
        component: UserRegisterView,
      },
    ],
    meta: {
      hideInMenu: true,
    },
  },
  {
    path: "/question/list",
    name: "浏览题目",
    component: QuestionListView,
  },
  {
    path: "/hide",
    name: "隐藏界面",
    component: HideView,
    meta: {
      hideInMenu: true,
    },
  },
  {
    path: "/noAuth",
    name: "无权限界面",
    component: NoAuthView,
    meta: {
      hideInMenu: true,
    },
  },
  {
    path: "/admin",
    name: "管理员界面",
    component: AdminView,
    meta: {
      access: ACCESS_ENUM.ADMIN,
    },
  },
  {
    path: "/about",
    name: "关于我的",
    component: AboutView,
  },
  {
    path: "/test",
    name: "测试",
    component: TestView,
  },
  {
    path: "/question/add",
    name: "添加题目",
    component: QuestionAddView,
  },
  {
    path: "/question/:id",
    props: true,
    name: "questionDetail",
    component: QuestionDetailView,
    meta: {
      hideInMenu: true,
    },
  },
];
