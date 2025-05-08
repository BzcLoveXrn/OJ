package com.binzc.oj.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.binzc.oj.model.entity.Post;
import com.binzc.oj.service.PostService;
import com.binzc.oj.mapper.PostMapper;
import org.springframework.stereotype.Service;

/**
* @author binzc
* @description 针对表【post(帖子)】的数据库操作Service实现
* @createDate 2025-05-08 13:58:41
*/
@Service
public class PostServiceImpl extends ServiceImpl<PostMapper, Post>
    implements PostService{

}




