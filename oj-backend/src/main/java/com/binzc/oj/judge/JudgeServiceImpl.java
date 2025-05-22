package com.binzc.oj.judge;

import cn.hutool.json.JSONUtil;
import com.binzc.oj.common.ErrorCode;
import com.binzc.oj.exception.BusinessException;
import com.binzc.oj.judge.codesandbox.CodeSandBox;
import com.binzc.oj.judge.codesandbox.CodeSandBoxFactory;
import com.binzc.oj.judge.codesandbox.model.CodeSandBoxType;
import com.binzc.oj.judge.codesandbox.model.ExecuteCodeRequest;
import com.binzc.oj.judge.codesandbox.model.ExecuteCodeResponse;
import com.binzc.oj.judge.strategy.JudgeContext;
import com.binzc.oj.model.dto.question.JudgeCase;
import com.binzc.oj.model.dto.questionsubmit.JudgeInfo;
import com.binzc.oj.model.entity.Question;
import com.binzc.oj.model.entity.QuestionSubmit;
import com.binzc.oj.model.entity.User;
import com.binzc.oj.service.QuestionService;
import com.binzc.oj.service.QuestionSubmitService;
import com.binzc.oj.service.UserService;
import com.binzc.oj.model.enums.QuestionSubmitStatusEnum;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
@Service
public class JudgeServiceImpl implements JudgeService{
    @Resource
    private QuestionSubmitService questionSubmitService;
    @Resource
    private QuestionService questionService;

    @Resource
    private UserService userService;

    @Resource
    private JudgeManager judgeManager;

    @Resource
    private CodeSandBoxFactory codeSandBoxFactory;

    @Value("${codesandbox.type:remote}")
    private String type;

    @Override
    public QuestionSubmit doJudge(long questionSubmitId) {
        //获取题目提交对象，做一些处理
        QuestionSubmit questionSubmit = questionSubmitService.getById(questionSubmitId);
        if(questionSubmit== null){
            throw new BusinessException(ErrorCode.NOT_FOUND_ERROR,"题目提交信息不存在");
        }
        //获取题目信息，做一些处理
        long questionId = questionSubmit.getQuestionId();
        Question question=questionService.getById(questionId);
        if(question== null){
            throw new BusinessException(ErrorCode.NOT_FOUND_ERROR,"题目信息不存在");
        }
        // 获取提交人信息，做一些处理
        long userId= questionSubmit.getUserId();
        User user=userService.getById(userId);
        if(user== null){
            throw new BusinessException(ErrorCode.NOT_FOUND_ERROR,"用户信息不存在");
        }
        // 避免一直提交判题
        if(!questionSubmit.getStatus().equals(QuestionSubmitStatusEnum.WAITING.getValue())){
            throw new BusinessException(ErrorCode.OPERATION_ERROR,"题目正在判题");
        }
        // 3）更改判题（题目提交）的状态为 “判题中”，防止重复执行
        QuestionSubmit questionSubmitUpdate = new QuestionSubmit();
        questionSubmitUpdate.setId(questionSubmitId);
        questionSubmitUpdate.setStatus(QuestionSubmitStatusEnum.RUNNING.getValue());
        boolean update = questionSubmitService.updateById(questionSubmitUpdate);
        if (!update) {
            throw new BusinessException(ErrorCode.SYSTEM_ERROR, "题目状态更新错误");
        }
        //根据配置文件，获得相应的沙箱
        CodeSandBoxType codeSandBoxType = CodeSandBoxType.getEnumByValue(type);
        CodeSandBox codeSandBox= codeSandBoxFactory.newCodeSandBox(codeSandBoxType);
        // 构建判题机输入用例
        String language=questionSubmit.getLanguage();
        String code=questionSubmit.getCode();
        String judgeCaseStr = question.getJudgeCase();
        List<JudgeCase> judgeCaseList = JSONUtil.toList(judgeCaseStr, JudgeCase.class);
        List<String> inputList = judgeCaseList.stream().map(JudgeCase::getInput).collect(Collectors.toList());
        ExecuteCodeRequest executeCodeRequest = ExecuteCodeRequest.builder()
                .code(code)
                .language(language)
                .inputList(inputList)
                .build();
        ExecuteCodeResponse executeCodeResponse = codeSandBox.executeCode(executeCodeRequest);
//        // 5）根据沙箱的执行结果，设置题目的判题状态和信息
//        List<String> outputList = executeCodeResponse.getOutputList();
//        JudgeContext judgeContext = new JudgeContext();
//        judgeContext.setJudgeInfo(executeCodeResponse.getJudgeInfo());
//        judgeContext.setInputList(inputList);
//        judgeContext.setOutputList(outputList);
//        judgeContext.setJudgeCaseList(judgeCaseList);
//        judgeContext.setQuestion(question);
//        judgeContext.setQuestionSubmit(questionSubmit);
//        //判题启动！
//        JudgeInfo judgeInfo = judgeManager.doJudge(judgeContext);
//        // 6）修改数据库中的判题结果
//        questionSubmitUpdate = new QuestionSubmit();
//        questionSubmitUpdate.setId(questionSubmitId);
//        questionSubmitUpdate.setStatus(QuestionSubmitStatusEnum.SUCCEED.getValue());
//        questionSubmitUpdate.setJudgeInfo(JSONUtil.toJsonStr(judgeInfo));
//        questionSubmitUpdate.setUpdateTime(Date.from(LocalDateTime.now().atZone(ZoneId.systemDefault()).toInstant()));
//        update = questionSubmitService.updateById(questionSubmitUpdate);
//        if (!update) {
//            throw new BusinessException(ErrorCode.SYSTEM_ERROR, "题目状态更新错误");
//        }
//        QuestionSubmit questionSubmitResult = questionSubmitService.getById(questionId);
//        return questionSubmitResult;
        return null;
    }
}
