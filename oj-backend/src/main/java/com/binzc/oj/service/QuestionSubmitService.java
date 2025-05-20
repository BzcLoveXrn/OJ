package com.binzc.oj.service;

import com.binzc.oj.model.dto.questionsubmit.QuestionSubmitAddRequest;
import com.binzc.oj.model.entity.QuestionSubmit;
import com.baomidou.mybatisplus.extension.service.IService;
import com.binzc.oj.model.entity.User;
import com.binzc.oj.model.vo.CodeVo;
import com.binzc.oj.model.vo.QuestionSubmitVo;

import javax.servlet.http.HttpServletRequest;

/**
* @author binzc
* @description 针对表【question_submit(题目提交)】的数据库操作Service
* @createDate 2025-05-08 21:02:49
*/
public interface QuestionSubmitService extends IService<QuestionSubmit> {
    /**
     * 获取用户最新提交代码
     * @param questionId
     *
     * @param userId
     * @return
     */
    CodeVo getCode(long questionId, long userId);

    /**
     *
     * @param questionSubmitAddRequest
     * @param user
     * @return
     */
    QuestionSubmitVo doQuestionSubmit(QuestionSubmitAddRequest questionSubmitAddRequest, User user);

}
