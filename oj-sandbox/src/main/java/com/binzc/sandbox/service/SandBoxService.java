package com.binzc.sandbox.service;

import com.binzc.sandbox.model.ExecuteCodeRequest;
import com.binzc.sandbox.model.ExecuteCodeResponse;
import com.rabbitmq.client.Channel;
import org.springframework.amqp.core.Message;

/**
 * 沙箱服务接口
 */
public interface SandBoxService {
    /**
     * 取出消息执行代码
     * @param executeCodeRequest
     * @return
     */

    void receiveMessage(ExecuteCodeRequest executeCodeRequest, Channel channel, Message message);

    /**
     * 返回执行结果
     * @param executeCodeResponse
     */
    void putResult(ExecuteCodeResponse executeCodeResponse);

}
