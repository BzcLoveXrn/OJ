package com.binzc.oj.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.binzc.oj.model.entity.User;
import com.binzc.oj.service.UserService;
import com.binzc.oj.mapper.UserMapper;
import org.springframework.stereotype.Service;

/**
* @author binzc
* @description 针对表【user(用户)】的数据库操作Service实现
* @createDate 2025-05-08 13:58:41
*/
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User>
    implements UserService{

}




