package com.binzc.oj.judge.strategy;

import com.binzc.oj.model.dto.questionsubmit.JudgeInfo;

public interface JudgeStrategy {
    /**
     * 执行判题
     * @param judgeContext
     * @return
     */
    JudgeInfo doJudge(JudgeContext judgeContext);

}
