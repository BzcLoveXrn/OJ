package com.binzc.oj.judge.codesandbox.impl;

import com.binzc.oj.judge.codesandbox.CodeSandBox;
import com.binzc.oj.judge.codesandbox.model.ExecuteCodeRequest;
import com.binzc.oj.judge.codesandbox.model.ExecuteCodeResponse;

public class ThirdPartyCodeSandBox implements CodeSandBox {
    @Override
    public ExecuteCodeResponse executeCode(ExecuteCodeRequest executeCodeRequest) {
        System.out.println("ThirdPartyCodeSandBox executeCode");
        return null;
    }
}
