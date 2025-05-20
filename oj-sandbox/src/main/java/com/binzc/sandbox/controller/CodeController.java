package com.binzc.sandbox.controller;

import com.github.dockerjava.api.DockerClient;
import com.github.dockerjava.api.model.Version;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CodeController {
    @Autowired
    private DockerClient dockerClient;
    @GetMapping("/health")
    public String health() {
        Version exec = dockerClient.versionCmd().exec();
        return exec.toString();
    }

}
