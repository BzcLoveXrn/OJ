package com.binzc.oj.service.impl;

import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.binzc.oj.common.ErrorCode;
import com.binzc.oj.exception.BusinessException;
import com.binzc.oj.judge.JudgeService;
import com.binzc.oj.mapper.QuestionSubmitMapper;
import com.binzc.oj.model.dto.questionsubmit.JudgeInfo;
import com.binzc.oj.model.dto.questionsubmit.QueryParmRequest;
import com.binzc.oj.model.dto.questionsubmit.QuestionSubmitAddRequest;
import com.binzc.oj.model.entity.Question;
import com.binzc.oj.model.entity.User;
import com.binzc.oj.model.enums.QuestionSubmitLanguageEnum;
import com.binzc.oj.model.enums.QuestionSubmitStatusEnum;
import com.binzc.oj.model.vo.CodeVo;
import com.binzc.oj.model.vo.QuestionSubmitVo;
import com.binzc.oj.model.vo.SubmitRecodWithPageVo;
import com.binzc.oj.model.vo.SubmitRecordSimple;
import com.binzc.oj.service.QuestionService;
import com.binzc.oj.service.QuestionSubmitService;
import com.binzc.oj.model.entity.QuestionSubmit;

import com.binzc.oj.service.UserService;
import org.apache.ibatis.annotations.Param;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.concurrent.CompletableFuture;

/**
* @author binzc
* @description 针对表【question_submit(题目提交)】的数据库操作Service实现
* @createDate 2025-05-08 21:02:49
*/
@Service
public class QuestionSubmitServiceImpl extends ServiceImpl<QuestionSubmitMapper, QuestionSubmit>
    implements QuestionSubmitService {
    @Resource
   private UserService userService;

    @Resource
    private QuestionSubmitMapper questionSubmitMapper;

    @Resource
    private QuestionService questionService;

    @Resource
    @Lazy
    private  JudgeService judgeService;
    @Override
    public CodeVo getCode(long questionId, long userId) {
        // 查询条件
        QueryWrapper<QuestionSubmit> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("questionId", questionId)
                .eq("userId", userId).orderByDesc("updateTime")
                .last("limit 1");
        // 执行查询
        QuestionSubmit submit = this.getOne(queryWrapper);
        if(submit==null){
            throw new RuntimeException("没有找到该题目的提交记录");
        }
        CodeVo codeVo = new CodeVo();
        codeVo.setCode(submit.getCode());
        codeVo.setLanguage(submit.getLanguage());
        return codeVo;
    }

    @Override
    public QuestionSubmitVo doQuestionSubmit(QuestionSubmitAddRequest questionSubmitAddRequest, User user) {
        // 校验编程语言是否合法
        String language = questionSubmitAddRequest.getLanguage();
        QuestionSubmitLanguageEnum languageEnum = QuestionSubmitLanguageEnum.getEnumByValue(language);
        if (languageEnum == null) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "编程语言错误");
        }
        long questionId = questionSubmitAddRequest.getQuestionId();
        // 判断实体是否存在，根据类别获取实体
        Question question = questionService.getById(questionId);
        if (question == null) {
            throw new BusinessException(ErrorCode.NOT_FOUND_ERROR);
        }
        // 是否已提交题目
        long userId = user.getId();
        // 每个用户串行提交题目
        QuestionSubmit questionSubmit = new QuestionSubmit();
        questionSubmit.setUserId(userId);
        questionSubmit.setQuestionId(questionId);
        questionSubmit.setCode(questionSubmitAddRequest.getCode());
        questionSubmit.setLanguage(language);
        // 设置初始状态
        questionSubmit.setStatus(QuestionSubmitStatusEnum.WAITING.getValue());
        questionSubmit.setJudgeInfo("{}");
        boolean save = this.save(questionSubmit);
        if (!save){
            throw new BusinessException(ErrorCode.SYSTEM_ERROR, "数据插入失败");
        }
        Long questionSubmitId = questionSubmit.getId();
        // 执行判题服务
        CompletableFuture.runAsync(() -> {
            judgeService.doJudge(questionSubmitId);
        });
        QuestionSubmitVo questionSubmitVo = QuestionSubmitVo.generateVo(questionSubmit, question, user);
        return questionSubmitVo;
    }

    @Override
    public SubmitRecodWithPageVo getSubmitRecords(QueryParmRequest queryParmRequest) {
        String userName= queryParmRequest.getUserName();
        String questionTitle= queryParmRequest.getQuestionTitle();
        Integer submitStatus= queryParmRequest.getSubmitStatus();
        String language="全部语言".equals(queryParmRequest.getLanguage())?"":queryParmRequest.getLanguage();
        Integer pageNo= queryParmRequest.getPageNo();
        Integer pageSize= queryParmRequest.getPageSize();
        Integer offset = (pageNo - 1) * pageSize;
        List<SubmitRecordSimple> submitRecordSimples = questionSubmitMapper.getSubmitRecordSimpleList(userName, questionTitle, submitStatus, language, offset, pageSize);
        for(SubmitRecordSimple submitRecordSimple:submitRecordSimples){
            JudgeInfo judgeInfo = JSONUtil.toBean(submitRecordSimple.getJudgeInfo(), JudgeInfo.class);
            submitRecordSimple.setMemoryUse(judgeInfo.getMemory());
            submitRecordSimple.setTimeUse(judgeInfo.getTime());
            submitRecordSimple.setMessage(QuestionSubmitStatusEnum.getEnumByValue(submitRecordSimple.getStatus()).getText());
        }
        Long total = questionSubmitMapper.countSubmitRecordSimpleList(userName, questionTitle, submitStatus, language);
        SubmitRecodWithPageVo submitRecodWithPageVo = new SubmitRecodWithPageVo();
        submitRecodWithPageVo.setPageNo(pageNo);
        submitRecodWithPageVo.setPageSize(pageSize);
        submitRecodWithPageVo.setTotal(total);
        submitRecodWithPageVo.setSubmitRecordSimples(submitRecordSimples);
        return submitRecodWithPageVo;

    }
}




