package com.binzc.sandbox.service.Impl;


import com.binzc.sandbox.executor.CodeExecutor;
import com.binzc.sandbox.model.ExecuteCodeRequest;
import com.binzc.sandbox.model.ExecuteCodeResponse;
import com.binzc.sandbox.model.LanguageEnum;
import com.binzc.sandbox.service.SandBoxService;
import com.rabbitmq.client.Channel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Slf4j
public class SandBoxServiceImpl implements SandBoxService {
    private final Map<LanguageEnum, CodeExecutor> executorMap;

    @Autowired
    private RabbitTemplate rabbitTemplate;



    @Autowired
    public SandBoxServiceImpl(List<CodeExecutor> executors) {
        this.executorMap = executors.stream()
                .collect(Collectors.toMap(
                        CodeExecutor::language,
                        e -> e,
                        (e1, e2) -> {
                            throw new IllegalStateException("Duplicate executor for language: " + e1.language());
                        }
                ));
    }

    @RabbitListener(queues = "judge_task_queue", ackMode = "MANUAL")
    public void receiveMessage(ExecuteCodeRequest executeCodeRequest, Channel channel, Message message) {
        long deliveryTag = message.getMessageProperties().getDeliveryTag();
        ExecuteCodeResponse executeCodeResponse=null;
        try {
            LanguageEnum language = LanguageEnum.fromValue(executeCodeRequest.getLanguage());
            CodeExecutor executor = executorMap.get(language);

            // 这一步你之前失败了（下载镜像失败）
            executeCodeResponse = executor.execute(executeCodeRequest);

            executeCodeResponse.setQuestionSubmitId(executeCodeRequest.getQuestionSubmitId());
            putResult(executeCodeResponse);

            // ✅ 成功处理，手动 ACK
            channel.basicAck(deliveryTag, false);

        } catch (Exception e) {
            log.error("execute code error!!!!!",e.getMessage());
            executeCodeResponse=new ExecuteCodeResponse();
            executeCodeResponse.setQuestionSubmitId(executeCodeRequest.getQuestionSubmitId());
            executeCodeResponse.setStatus(0x3f3f3f3f);
            try {
                // ❗关键：失败后选择丢弃（false）或重试（true）
                channel.basicNack(deliveryTag, false, false); // false 表示不再重试（推荐，防死循环）
            } catch (IOException ioException) {
                log.error("丢弃失败!!!!!");
            }
        }finally {
            putResult(executeCodeResponse);
        }
    }
    @Override
    public void putResult(ExecuteCodeResponse executeCodeResponse) {
        rabbitTemplate.convertAndSend("judge_exchange","judge_result",executeCodeResponse);
    }

}
