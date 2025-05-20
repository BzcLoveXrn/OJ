package com.binzc.oj.judge.codesandbox;

import com.binzc.oj.judge.codesandbox.impl.ExampleCodeSandBox;
import com.binzc.oj.judge.codesandbox.impl.RemoteCodeSandBox;
import com.binzc.oj.judge.codesandbox.impl.ThirdPartyCodeSandBox;
import com.binzc.oj.judge.codesandbox.model.CodeSandBoxType;

public class CodeSandBoxFactory {
    public static CodeSandBox newCodeSandBox(CodeSandBoxType codeSandBoxType) {
        CodeSandBox codeSandBox = null;
        switch (codeSandBoxType){
            case REMOTE:
                codeSandBox = new RemoteCodeSandBox();
                break;
            case EXAMPLE:
                codeSandBox = new ExampleCodeSandBox();
                break;
            case THIRDPARTY:
                codeSandBox = new ThirdPartyCodeSandBox();
                break;
            default:
                codeSandBox=new ExampleCodeSandBox();
        }
        return codeSandBox;
    }
}
