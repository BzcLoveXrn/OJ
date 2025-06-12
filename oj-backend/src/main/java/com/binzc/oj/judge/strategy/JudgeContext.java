package com.binzc.oj.judge.strategy;


import com.binzc.oj.judge.model.ExecuteMessage;
import com.binzc.oj.model.dto.question.JudgeConfig;
import lombok.Data;

import java.util.List;

/**
 * 上下文（用于定义在策略中传递的参数）
 */
@Data
public class JudgeContext {
    /**
     * 预期要求
     */
    private  JudgeConfig judgeConfig;
    /**
     * 程序输出结果
     */
    List<ExecuteMessage>executeMessages;

    /**
     * 预期输出
     */
    private List<String> outputList;

    /**
     * 语言
     */
    private String Language;

}
