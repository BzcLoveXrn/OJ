package com.binzc.oj.judge.codesandbox.impl;

import com.binzc.oj.common.BaseResponse;
import com.binzc.oj.common.ErrorCode;
import com.binzc.oj.exception.BusinessException;
import com.binzc.oj.judge.codesandbox.CodeSandBox;
import com.binzc.oj.judge.codesandbox.model.CodeSandBoxType;
import com.binzc.oj.judge.codesandbox.model.ExecuteCodeRequest;
import com.binzc.oj.judge.codesandbox.model.ExecuteCodeResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
@Component
public class RemoteCodeSandBox implements CodeSandBox {
    @Value("${codesandbox.url:http://localhost:8122/executeCode}")
    private String url;

    @Autowired
    private RestTemplate restTemplate;

    @Override
    public ExecuteCodeResponse executeCode(ExecuteCodeRequest executeCodeRequest) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<ExecuteCodeRequest> entity = new HttpEntity<>(executeCodeRequest, headers);

        try {
            ResponseEntity<BaseResponse<ExecuteCodeResponse>> response = restTemplate.exchange(
                    url, HttpMethod.POST, entity,
                    new ParameterizedTypeReference<BaseResponse<ExecuteCodeResponse>>() {}
            );
            BaseResponse<ExecuteCodeResponse> baseResponse = response.getBody();
            System.out.println(baseResponse);
            if (baseResponse.getCode()==0){
                return baseResponse.getData();
            }else {
                throw new BusinessException(ErrorCode.SYSTEM_ERROR,"远程调用失败");
            }
            // ... 原代码
        } catch (Exception e) {
            System.err.println("远程调用异常: " + e.getMessage());
            e.printStackTrace(); // 打印详细堆栈
            throw new BusinessException(ErrorCode.SYSTEM_ERROR, "远程调用失败");
        }


    }

    @Override
    public CodeSandBoxType getCodeSandBoxType() {
        return CodeSandBoxType.REMOTE;
    }
}
