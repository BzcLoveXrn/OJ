package com.binzc.oj.judge;

import com.binzc.oj.judge.model.ExecuteCodeRequest;
import com.binzc.oj.judge.model.ExecuteCodeResponse;
import com.binzc.oj.model.entity.Question;
import com.binzc.oj.model.entity.QuestionSubmit;

public interface JudgeService {
    /**
     *  提交到消息队列去
     *
     * @param questioSubmitId
     * @retur
     */
    void submitJudge(long questioSubmitId);

    /**
     *  收取结果
     */
     void getJudgeResult(ExecuteCodeResponse executeCodeResponse);


}
