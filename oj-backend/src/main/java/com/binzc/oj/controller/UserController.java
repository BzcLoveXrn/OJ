package com.binzc.oj.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
@Slf4j
public class UserController {
    /**
     * 测试接口
     * @Author binzc
     *
     * @return
     */
    @GetMapping ("/hello")
    public String hello() {
        return "hello";
    }
}
