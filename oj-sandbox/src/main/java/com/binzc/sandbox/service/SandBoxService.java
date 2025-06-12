package com.binzc.sandbox.service;

import com.binzc.sandbox.model.ExecuteCodeRequest;
import com.binzc.sandbox.model.ExecuteCodeResponse;

/**
 * 沙箱服务接口
 */
public interface SandBoxService {
    /**
     * 取出消息执行代码
     * @param executeCodeRequest
     * @return
     */

    void receiveMessage(ExecuteCodeRequest executeCodeRequest);

    /**
     * 返回执行结果
     * @param executeCodeResponse
     */
    void putResult(ExecuteCodeResponse executeCodeResponse);

}
