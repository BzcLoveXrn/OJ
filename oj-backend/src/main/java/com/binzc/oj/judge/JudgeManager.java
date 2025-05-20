package com.binzc.oj.judge;


import com.binzc.oj.judge.strategy.DefaultJudgeStrategy;
import com.binzc.oj.judge.strategy.JavaLanguageJudgeStrategy;
import com.binzc.oj.judge.strategy.JudgeContext;
import com.binzc.oj.judge.strategy.JudgeStrategy;
import com.binzc.oj.model.dto.questionsubmit.JudgeInfo;
import com.binzc.oj.model.entity.QuestionSubmit;
import org.springframework.stereotype.Service;

/**
 * 判题管理（简化调用）
 */
@Service
public class JudgeManager {

    /**
     * 执行判题
     *
     * @param judgeContext
     * @return
     */
    JudgeInfo doJudge(JudgeContext judgeContext) {
        QuestionSubmit questionSubmit = judgeContext.getQuestionSubmit();
        String language = questionSubmit.getLanguage();
        JudgeStrategy judgeStrategy = new DefaultJudgeStrategy();
        if ("java".equals(language)) {
            judgeStrategy = new JavaLanguageJudgeStrategy();
        }
        return judgeStrategy.doJudge(judgeContext);
    }

}