package com.binzc.sandbox.utils;


import cn.hutool.core.io.FileUtil;
import com.binzc.sandbox.model.LanguageFileNameEnum;
import lombok.extern.slf4j.Slf4j;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.util.UUID;
@Slf4j
public class FileUtils {
    public static final String GLOBAL_CODE_DIR="temp";
    public static String saveFile(String code,String language){
        String userDir = System.getProperty("user.dir");
        String globalCodePathName = userDir + File.separator + GLOBAL_CODE_DIR;
        // 判断全局代码目录是否存在，没有则新建
        if (!FileUtil.exist(globalCodePathName)) {
            FileUtil.mkdir(globalCodePathName);
        }
        // 把用户的代码隔离存放
        String userCodeParentPath = globalCodePathName + File.separator +language+File.separator+  UUID.randomUUID();
        String fileName= LanguageFileNameEnum.getEnumFromLanguage(language).getFileName();
        String userCodePath = userCodeParentPath + File.separator + fileName;
        File userCodeFile = FileUtil.writeString(code, userCodePath, StandardCharsets.UTF_8);
        log.info("用户代码文件路径:{}",userCodeParentPath);
        return userCodeParentPath;
    }

    public static boolean deleteFile(String path){
        return FileUtil.del(path);
    }
}
