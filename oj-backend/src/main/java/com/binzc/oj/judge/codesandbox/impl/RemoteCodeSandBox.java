package com.binzc.oj.judge.codesandbox.impl;

import com.binzc.oj.judge.codesandbox.CodeSandBox;
import com.binzc.oj.judge.codesandbox.model.ExecuteCodeRequest;
import com.binzc.oj.judge.codesandbox.model.ExecuteCodeResponse;

public class RemoteCodeSandBox implements CodeSandBox {

    @Override
    public ExecuteCodeResponse executeCode(ExecuteCodeRequest executeCodeRequest) {
        System.out.println("这是RemoteCodeSandBox在执行代码");
        return null;
    }
}
