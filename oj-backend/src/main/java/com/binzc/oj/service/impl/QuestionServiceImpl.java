package com.binzc.oj.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.binzc.oj.model.entity.Question;
import com.binzc.oj.service.QuestionService;
import com.binzc.oj.mapper.QuestionMapper;
import org.springframework.stereotype.Service;

/**
* @author binzc
* @description 针对表【question(题目)】的数据库操作Service实现
* @createDate 2025-05-08 13:58:41
*/
@Service
public class QuestionServiceImpl extends ServiceImpl<QuestionMapper, Question>
    implements QuestionService{

}




