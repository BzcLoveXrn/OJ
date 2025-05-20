<template>
  <a-row class="grid-demo" style="margin-bottom: 16px; height: 80vh">
    <a-col :span="12" style="height: 100%">
      <a-tabs default-active-key="question">
        <a-tab-pane key="question" title="题目">
          <a-card v-if="question" :title="question.title">
            <a-descriptions title="判题条件" :column="{ xs: 1, md: 2, lg: 3 }">
              <a-descriptions-item label="时间限制">
                {{ question.judgeConfig?.timeLimit ?? 0 }}
              </a-descriptions-item>
              <a-descriptions-item label="内存限制">
                {{ question.judgeConfig?.memoryLimit ?? 0 }}
              </a-descriptions-item>
              <a-descriptions-item label="堆栈限制">
                {{ question.judgeConfig?.stackLimit ?? 0 }}
              </a-descriptions-item>
            </a-descriptions>
            <MdViewer
              :value="
                question.content || 'dsdkjsgdksabdksafbkasvksbvfkfdsbafsk'
              "
            />
            <template #extra>
              <a-space wrap>
                <a-tag
                  v-for="(tag, index) of question.tags"
                  :key="index"
                  color="green"
                  >{{ tag }}
                </a-tag>
              </a-space>
            </template>
          </a-card>
        </a-tab-pane>
        <a-tab-pane key="comment" title="评论" disabled> 评论区</a-tab-pane>
        <a-tab-pane key="answer" title="答案"> 暂时无法查看答案</a-tab-pane>
      </a-tabs>
    </a-col>
    <a-col :span="12" style="height: 100%">
      <div style="height: auto">
        编程语言<a-select
          v-model="form.language"
          style="width: auto; margin-bottom: 16px; margin-left: 6px"
          placeholder="Select"
          :trigger-props="{ autoFitPopupMinWidth: true }"
        >
          <a-option value="java">JAVA</a-option>
          <a-option value="cpp">C++</a-option>
          <a-option value="python">Python</a-option>
        </a-select>
      </div>
      <div style="height: 90%; display: flex; flex-direction: column">
        <CodeEditor
          style="flex: 1"
          :language="form.language"
          :code-value="form.code"
          :code-change="codeChange"
        />
      </div>
      <div
        style="
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-top: 16px;
        "
      >
        <div style="min-width: 100px">
          <template v-if="isNotLoggedIn">
            提交代码需要
            <a-button type="text" @click="goLogin" size="small"
              >去登录</a-button
            >
          </template>
        </div>

        <a-button type="primary" :disabled="isNotLoggedIn" @click="submitCode"
          >提交</a-button
        >
      </div>
    </a-col>
  </a-row>
</template>

<script lang="ts" setup>
import CodeEditor from "@/components/CodeEditor.vue";
import MdViewer from "@/components/MdViewer.vue";
import {
  QuestionControllerService,
  QuestionSubmitControllerService,
} from "../../../generated";
import message from "@arco-design/web-vue/es/message";
import { onMounted, withDefaults, defineProps, ref, computed } from "vue";
import ACCESS_ENUM from "@/access/accessEnum";
import { useRouter, useRoute } from "vue-router";
import { useStore } from "vuex";
/**
 * @description: 问题详情
 * 以上是初始化
 */
interface Props {
  id: string;
}
const form = ref<{
  code: string;
  language: string;
}>({
  code: `public class Main {
    public static void main(String[] args) {
        System.out.println("Hello World!");
    }
}`,
  language: "java",
});
const submitCode = async () => {
  const res = await QuestionSubmitControllerService.doQuestionSubmitUsingPost({
    code: form.value.code,
    language: form.value.language,
    questionId: Number(props.id),
  });
  if (res.code === 0) {
    message.success("提交成功");
  } else {
    message.error(res.message);
  }
};

const props = withDefaults(defineProps<Props>(), {
  id: () => "",
});
const question = ref<any>({});
let cnt = 0;
onMounted(async () => {
  const id = props.id;
  const res = await QuestionControllerService.getQuestionByIdUsingGet(id);
  if (res.code === 0) {
    question.value = res.data;
  } else {
    message.error("加载失败，" + res.message);
  }
  const res2 = await QuestionSubmitControllerService.getCodeUsingGet(id);
  if (res2.code === 0) {
    form.value.code = res2.data.code;
    form.value.language = res2.data.language;
  } else {
    message.error("加载失败，" + res2.message);
  }
});
/**
 * @description: 是否未登录
 * 以及根据登录状态获取数据
 */
const isNotLoggedIn = computed(() => {
  const role = store.state.user.loginUser?.userRole;
  return role === ACCESS_ENUM.NOT_LOGIN || role === undefined;
});
const router = useRouter();
const route = useRoute();
const goLogin = () => {
  // 当前页面完整路径
  const currentPath = route.fullPath;
  router.push({ path: "/user/login", query: { redirect: currentPath } });
};
const codeChange = (newValue) => {
  form.value.code = newValue;
};
const store = useStore();
</script>
