<template>
  <a-button @click="handleClick">测试接口</a-button>
  {{ data }}
</template>

<script lang="ts" setup>
import { ref } from "vue";
const formRef = ref({
  code: "dhohdohoda",
  language: "java",
  questionId: 2,
});
const data = ref("");
import { QuestionSubmitControllerService } from "../../generated";
const handleClick = async () => {
  const res = await QuestionSubmitControllerService.doQuestionSubmitUsingPost(
    formRef.value
  );
  if (res.code == 0) {
    data.value = res.data;
  }
};
</script>
