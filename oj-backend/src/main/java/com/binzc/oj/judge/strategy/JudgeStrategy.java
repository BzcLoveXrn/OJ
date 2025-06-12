package com.binzc.oj.judge.strategy;

import com.binzc.oj.judge.model.JudgeResult;

public interface JudgeStrategy {
    /**
     * 执行判题
     * @param judgeContext
     * @return
     */
    JudgeResult doJudge(JudgeContext judgeContext);

}
