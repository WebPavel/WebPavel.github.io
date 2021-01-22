---
layout: post
title: "file utility"
date: 2021-01-22
excerpt: "file utility..."
tags: [file path]
comments: false
---

##### 获取绝对路径等工具类

```java

import org.apache.commons.codec.binary.Hex;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.env.Environment;
import org.springframework.util.Assert;
import org.springframework.util.FileCopyUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class FileUtils {

    public static String sha1(String filePath) {
        Assert.notNull(filePath, "file path must not be null");
        File file = new File(filePath);
        if (!file.exists() || !file.isFile()) {
            throw new RuntimeException("file[" + filePath + "] not exist");
        }
        try (InputStream in = new FileInputStream(file)) {
            MessageDigest sha1 = MessageDigest.getInstance("SHA-1");
            sha1.reset();
            byte[] buffer = new byte[8192];
            int len;
            while ((len = in.read(buffer)) != -1) {
                sha1.update(buffer, 0, len);
            }
            byte[] digest = sha1.digest();
            return Hex.encodeHexString(digest);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String getRealPath(HttpServletRequest request, String path) {
        return request.getServletContext().getRealPath(path);
    }

    public static String getAbsoluteUploadPath(String path) {
        Environment environment = SpringBeanUtils.getBean(Environment.class);
        String uploadRoot = environment.getRequiredProperty("application.upload.root");
        File file = new File(uploadRoot, path.replace("/", File.separator));
        return file.getAbsolutePath();
    }

    public static String getFileExtension(String filename) {
        Assert.isTrue(StringUtils.isNotEmpty(filename), "file name isn't valid");
        int index = filename.lastIndexOf(".");
        if (index != -1) {
            return filename.substring(index);
        }
        return null;
    }

    public static String renameToChecksum(String srcPath, String destDir) {
        Assert.notNull(srcPath, "源文件路径为空");
        String checksum = FileUtils.sha1(srcPath);
        String srcFileExtension = getFileExtension(srcPath);
        String destFilename = checksum + srcFileExtension;
        if (destDir == null) {
            destDir = new File(srcPath).getParent();
        }
        File destFile = new File(destDir, destFilename);
        // 存在则重命名
        if (destFile.exists()) {
            destFilename = String.valueOf(System.currentTimeMillis()) + destFilename;
        }
        try {
            FileCopyUtils.copy(new File(srcPath), new File(destDir, destFilename));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return destFilename;
    }
}

```

##### 获取实例工具类

```java

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class SpringBeanUtils implements ApplicationContextAware {
    private static ApplicationContext applicationContext;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        SpringBeanUtils.applicationContext = applicationContext;
    }

    public static Object getBean(String beanName) {
        return applicationContext.getBean(beanName);
    }

    public static <T> T getBean(Class<T> beanClass) {
        return applicationContext.getBean(beanClass);
    }
}

```

##### 验证是否合法文件

```java

public static String[] allowedUploadExtension(String uploadExtension) {
    if (StringUtils.isNotEmpty(uploadExtension)) {
        return uploadExtension.split(StringUtils.escapeRegExpString(","));
    }
    return null;
}

public static boolean isAllowedUploadExtension(String filename) {
    Assert.notNull(filename, "file name must not be null");
    String fileExtension = FileUtils.getFileExtension(filename);
    String[] allowedUploadExtension = allowedUploadExtension();
    if (allowedUploadExtension != null) {
        if (fileExtension != null) {
            for (String ext : allowedUploadExtension) {
                if (fileExtension.equalsIgnoreCase(ext)) {
                    return true;
                }
            }
        }
        return false;
    }
    return true;
}
```

