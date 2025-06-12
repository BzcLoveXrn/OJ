package com.binzc.sandbox.service.Impl;


import com.binzc.sandbox.executor.CodeExecutor;
import com.binzc.sandbox.model.ExecuteCodeRequest;
import com.binzc.sandbox.model.ExecuteCodeResponse;
import com.binzc.sandbox.model.LanguageEnum;
import com.binzc.sandbox.service.SandBoxService;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
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

    @Override
    @RabbitListener(queues = "judge_task_queue",ackMode = "AUTO")
    public void receiveMessage(ExecuteCodeRequest executeCodeRequest) {
        LanguageEnum language;
        try {
            language = LanguageEnum.fromValue(executeCodeRequest.getLanguage());
        } catch (IllegalArgumentException ex) {
            throw ex;
        }
        CodeExecutor executor = executorMap.get(language);
        ExecuteCodeResponse executeCodeResponse= executor.execute(executeCodeRequest);
        executeCodeResponse.setQuestionSubmitId(executeCodeRequest.getQuestionSubmitId());
        putResult(executeCodeResponse);
    }

    @Override
    public void putResult(ExecuteCodeResponse executeCodeResponse) {
        rabbitTemplate.convertAndSend("judge_exchange","judge_result",executeCodeResponse);
    }
}
