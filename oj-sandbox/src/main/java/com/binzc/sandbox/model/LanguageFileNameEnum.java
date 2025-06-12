package com.binzc.sandbox.model;


public enum LanguageFileNameEnum {
    JAVA("java","Main.java"),
    PYTHON("python","Main.py"),
    CPP("cpp","Main.cpp");
    private final String fileName;
    private final String language;
    LanguageFileNameEnum( String language,String fileName) {
        this.fileName = fileName;
        this.language = language;
    }
    public String getFileName() {
        return fileName;
    }
    public String getLanguage() {
        return language;
    }
    public static LanguageFileNameEnum getEnumFromLanguage(String language){
        for (LanguageFileNameEnum langEnum : values()) {
            if (langEnum.language.equalsIgnoreCase(language)) {
                return langEnum;
            }
        }
        return null;
    }
}
