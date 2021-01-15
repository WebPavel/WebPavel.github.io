---
layout: post
title: "signature using pdfbox"
date: 2021-01-14
excerpt: "signature using pdfbox..."
tags: [pdf, signature, office]
comments: false
---

#### 签章合成

- pom.xml

```xml
<properties>
    <java.version>1.8</java.version>
    <commons-lang3.version>3.4</commons-lang3.version>
    <commons-exec.version>1.3</commons-exec.version>
    <pdfbox.version>2.0.12</pdfbox.version>
</properties>

<dependencies>

    <dependency>
        <groupId>org.apache.commons</groupId>
        <artifactId>commons-lang3</artifactId>
    </dependency>

    <dependency>
        <groupId>org.apache.commons</groupId>
        <artifactId>commons-exec</artifactId>
    </dependency>

    <dependency>
        <groupId>org.apache.pdfbox</groupId>
        <artifactId>pdfbox</artifactId>
    </dependency>
    <dependency>
        <groupId>org.apache.pdfbox</groupId>
        <artifactId>fontbox</artifactId>
    </dependency>

    <dependency>
        <groupId>org.apache.pdfbox</groupId>
        <artifactId>pdfbox-examples</artifactId>
    </dependency>

</dependencies>

<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-lang3</artifactId>
            <version>${commons-lang3.version}</version>
        </dependency>
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-exec</artifactId>
            <version>${commons-exec.version}</version>
        </dependency>

        <dependency>
            <groupId>org.apache.pdfbox</groupId>
            <artifactId>pdfbox</artifactId>
            <version>${pdfbox.version}</version>
        </dependency>
        <dependency>
            <groupId>org.apache.pdfbox</groupId>
            <artifactId>fontbox</artifactId>
            <version>${pdfbox.version}</version>
        </dependency>
        <dependency>
            <groupId>org.apache.pdfbox</groupId>
            <artifactId>pdfbox-examples</artifactId>
            <version>${pdfbox.version}</version>
        </dependency>
    </dependencies>
</dependencyManagement>

```

- 根据关键字签名类SigUtils.java

```java
import org.apache.pdfbox.examples.signature.CreateVisibleSignature;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.TextPosition;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class PdfBoxSignUtils {

    public static String sign(SignatureBuildParam signatureBuildParam, PrepareSig prepareSig,
                              String signerName, String location, String reason, int page) {
        try {
            String tsaUrl = null;
            boolean externalSig = false;

            CreateVisibleSignature signing = new CreateVisibleSignature(signatureBuildParam.getKeyStore(), signatureBuildParam.getPin());

            File documentFile = prepareSig.getPdfFile();
            File signedDocumentFile = new File(documentFile.getParent(), System.currentTimeMillis() + "_signed.pdf");

            float[] coordinate = getCoordinate(documentFile, prepareSig.getKeyword(), page, prepareSig.getKwIndex());
            if (coordinate != null) {
                int x = Float.valueOf(coordinate[0]).intValue();
                int y = Float.valueOf(coordinate[1]).intValue();

                InputStream imageStream = new FileInputStream(prepareSig.getImgPath());

                signing.setVisibleSignDesigner(prepareSig.getPdfPath(), x, y, prepareSig.getZoomPercent(), imageStream, page);
                signing.setVisibleSignatureProperties(signerName, location, reason, 0, page, true);
                signing.setExternalSigning(externalSig);
                signing.signPDF(documentFile, signedDocumentFile, tsaUrl);

                imageStream.close();
            }
            return signedDocumentFile.getAbsolutePath();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void signV2(SignatureBuildParam signatureBuildParam, PrepareSig prepareSig,
                              String signerName, String location, String reason, int page) {
        if (page != -1) {
            sign(signatureBuildParam, prepareSig, signerName, location, reason, page);
        } else {
            try (PDDocument document = PDDocument.load(prepareSig.getPdfFile());) {
                String signedPdfPath = prepareSig.getPdfPath();
                int pages = document.getNumberOfPages();
                for (int i = 1; i <= pages; i++) {
                    prepareSig.setPdfPath(signedPdfPath);
                    String tmpFilePath = signedPdfPath;
                    signedPdfPath = sign(signatureBuildParam, prepareSig, signerName, location, reason, i);
                    // 删除中间文件
                    new File(tmpFilePath).delete();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static float[] getCoordinate(File documentFile, String keyword, int page, int kwIndex) {
        try (PDDocument document = PDDocument.load(documentFile);) {
            TextPositionStripper stripper = new TextPositionStripper(keyword);
            stripper.setSortByPosition(true);
            stripper.setStartPage(page);
            stripper.setEndPage(page);
            stripper.getText(document);
            List<TextPositionSequence> hits = stripper.getHits();
            TextPositionSequence hit = hits.get(kwIndex);
            TextPosition lastPosition = hit.textPositionAt(hit.length() - 1);
            hits.clear();
            return new float[]{lastPosition.getXDirAdj(), lastPosition.getYDirAdj() - 4 * lastPosition.getFontSize()};
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        /**
         * Java生成p12HTTPS证书
         * alias     要处理的条目的别名
         * keypass   密钥口令
         * keystore  密钥库名称
         * storepass 密钥库口令
         * storetype 密钥库类型
         * validity  证书有效天数
         */
        String storepass = "123456";
        String certPath = "D:/upload" + File.separator + "new_cert.cer";
        SignatureBuildParam signatureBuildParam = new SignatureBuildParam();
        signatureBuildParam.setP12Path(certPath);
        signatureBuildParam.setPassword(storepass);
        signatureBuildParam.buildP12();
        String imgPath = "D:/upload/dvLl3k8LwjNU4nA8-ff8080817032f2960170523980200005_0021711_1.png";
        String pdfPath = "D:/upload/br_EE9B31F28FB84DA6947D5AB33F88D015.pdf";
        String signerName = "TestSign";
        String reason = "sign for proxy";
        String location = "gz, China";
        String keyword = "当事人签名：";
        int kwIndex = 0;
        // page is 1-based here
//        int page = 1;
        int page = -1;
        int zoomPercent = -20;

        PrepareSig prepareSig = new PrepareSig();
        prepareSig.setPdfPath(pdfPath);
        prepareSig.setImgPath(imgPath);
        prepareSig.setKeyword(keyword);
        prepareSig.setKwIndex(kwIndex);
        prepareSig.setZoomPercent(zoomPercent);
        signV2(signatureBuildParam, prepareSig, signerName, reason, location, page);
    }
}

```

- 证书构建类SignatureBuildParam.java

```java

import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.KeyStore;
import java.util.Objects;

public class SignatureBuildParam {
    private P12GenParam param;
    private String p12Path;
    private String password;

    public P12GenParam getParam() {
        return param;
    }

    public void setParam(P12GenParam param) {
        this.param = param;
    }

    public String getP12Path() {
        return p12Path;
    }

    public void setP12Path(String p12Path) {
        this.p12Path = p12Path;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public KeyStore getKeyStore() {
        Objects.requireNonNull(p12Path);
        File ksFile = new File(p12Path);
        if (!ksFile.exists()) {
            throw new RuntimeException("due to p12 file not found, get keystore failed");
        }
        try {
            KeyStore keystore = KeyStore.getInstance("PKCS12");
            char[] pin = password.toCharArray();
            keystore.load(new FileInputStream(ksFile), pin);
            return keystore;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public char[] getPin() {
        char[] pin = password.toCharArray();
        return pin.clone();
    }

    public void buildP12() {
        File ksFile = new File(p12Path);
        if (ksFile.exists()) {
            ksFile.delete();
        }
        if (param == null) {
            param = new P12GenParam();
            param.setKeyalg(P12GenParam.ALG_RSA);
            param.setKeysize(P12GenParam.PUBKEYLENGTH_2048);
            param.setValidity("365");
        }
        param.setKeystore(p12Path);
        param.setStorepass(password);
        String cmd = param.build();
        CommandLine cl = CommandLine.parse(cmd);
        DefaultExecutor executor = new DefaultExecutor();
        executor.setExitValue(0);
        try {
            executor.execute(cl);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

```

- 签名控制类PrepareSig.java

```java

import java.io.File;

public class PrepareSig {
    private String pdfPath;
    private String imgPath;
    private String keyword;
    private int kwIndex;
    private int zoomPercent;

    public String getPdfPath() {
        return pdfPath;
    }

    public void setPdfPath(String pdfPath) {
        this.pdfPath = pdfPath;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public int getKwIndex() {
        return kwIndex;
    }

    public void setKwIndex(int kwIndex) {
        this.kwIndex = kwIndex;
    }

    public int getZoomPercent() {
        return zoomPercent;
    }

    public void setZoomPercent(int zoomPercent) {
        this.zoomPercent = zoomPercent;
    }

    public File getPdfFile() {
        File documentFile = new File(pdfPath);
        if (!documentFile.exists()) {
            throw new RuntimeException("not found file");
        }
        return documentFile;
    }
}

```

- 生成证书参数类P12GenParam.java

```java

import org.apache.commons.lang3.StringUtils;

public class P12GenParam {
    private String alias = "mykey";
    private String keypass;
    private String storepass;
    private String keyalg = "DSA";
    private String keysize = "1024";
    private String validity = "90";
    private String keystore = ".keystore";
    private DName dname = new DName();

    /**
     * RSA算法
     */
    public static final String ALG_RSA = "RSA";

    /**
     * 公钥长度为1024
     */
    public static final String PUBKEYLENGTH_1024 = "1024";
    /**
     * 公钥长度为2048
     */
    public static final String PUBKEYLENGTH_2048 = "2048";

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public String getKeypass() {
        return keypass;
    }

    public void setKeypass(String keypass) {
        this.keypass = keypass;
    }

    public String getStorepass() {
        return storepass;
    }

    public void setStorepass(String storepass) {
        this.storepass = storepass;
    }

    public String getKeyalg() {
        return keyalg;
    }

    public void setKeyalg(String keyalg) {
        this.keyalg = keyalg;
    }

    public String getKeysize() {
        return keysize;
    }

    public void setKeysize(String keysize) {
        this.keysize = keysize;
    }

    public String getValidity() {
        return validity;
    }

    public void setValidity(String validity) {
        this.validity = validity;
    }

    public String getKeystore() {
        return keystore;
    }

    public void setKeystore(String keystore) {
        this.keystore = keystore;
    }

    public DName getDname() {
        return dname;
    }

    public void setDname(DName dname) {
        this.dname = dname;
    }

    public String build() {
        String cmd = "keytool -genkey -storetype PKCS12";
        StringBuilder builder = new StringBuilder(cmd);
        if (StringUtils.isNotEmpty(alias)) {
            builder.append(" -alias ");
            builder.append(alias);
        }

        if (StringUtils.isNotEmpty(keyalg)) {
            builder.append(" -keyalg ");
            builder.append(keyalg);
        }

        if (StringUtils.isNotEmpty(keysize)) {
            builder.append(" -keysize ");
            builder.append(keysize);
        }

        if (StringUtils.isNotEmpty(validity)) {
            builder.append(" -validity ");
            builder.append(validity);
        }

        if (StringUtils.isNotEmpty(keystore)) {
            builder.append(" -keystore ");
            builder.append(keystore);
        }

        builder.append(" -dname ");
        builder.append(dname);

        builder.append(" -storepass ");
        builder.append(storepass);
        return builder.toString();
    }

    /**
     * CN=(名字与姓氏), OU=(组织单位名称), O=(组织名称), L=(城市或区域名称), ST=(州或省份名称), C=(单位的两字母国家代码)
     */
    public static class DName {
        private String cn;
        private String ou;
        private String o;
        private String l;
        private String st;
        private String c;

        public String getCn() {
            return cn;
        }

        public void setCn(String cn) {
            this.cn = cn;
        }

        public String getOu() {
            return ou;
        }

        public void setOu(String ou) {
            this.ou = ou;
        }

        public String getO() {
            return o;
        }

        public void setO(String o) {
            this.o = o;
        }

        public String getL() {
            return l;
        }

        public void setL(String l) {
            this.l = l;
        }

        public String getSt() {
            return st;
        }

        public void setSt(String st) {
            this.st = st;
        }

        public String getC() {
            return c;
        }

        public void setC(String c) {
            this.c = c;
        }

        @Override
        public String toString() {
            // 'CN=, OU=, O=, L=, ST=, C='
            return build();
        }

        public String build() {
            StringBuilder builder = new StringBuilder("'");
            builder.append("CN=");
            if (StringUtils.isNotEmpty(cn)) {
                builder.append(cn);
            }
            builder.append(", OU=");
            if (StringUtils.isNotEmpty(ou)) {
                builder.append(ou);
            }
            builder.append(", O=");
            if (StringUtils.isNotEmpty(o)) {
                builder.append(o);
            }
            builder.append(", L=");
            if (StringUtils.isNotEmpty(l)) {
                builder.append(l);
            }
            builder.append(", ST=");
            if (StringUtils.isNotEmpty(st)) {
                builder.append(st);
            }
            builder.append(", C=");
            if (StringUtils.isNotEmpty(c)) {
                builder.append(c);
            }
            builder.append("'");
            return builder.toString();
        }
    }
}

```

#### 技术难点 -- 关键字定位和解决方案

- 拦截类TextPositionStripper.java

```java
package cn.com.ava.sign.util.signature;

import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.pdfbox.text.TextPosition;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class TextPositionStripper extends PDFTextStripper {
    private final String searchTerm;
    private final List<TextPositionSequence> hits = new ArrayList<>();

    /**
     * Instantiate a new PDFTextStripper object.
     *
     * @throws IOException If there is an error loading the properties.
     */
    public TextPositionStripper(String searchTerm) throws IOException {
        super();
        this.searchTerm = searchTerm;
    }

    @Override
    protected void writeString(String text, List<TextPosition> textPositions) throws IOException {
        TextPositionSequence word = new TextPositionSequence(textPositions);
        String string = word.toString();

        int fromIndex = 0;
        int index;
        while ((index = string.indexOf(searchTerm, fromIndex)) > -1) {
            hits.add(word.subSequence(index, index + searchTerm.length()));
            fromIndex = index + 1;
        }

        super.writeString(text, textPositions);
    }

    public List<TextPositionSequence> getHits() {
        return hits;
    }
}

```

- 辅助类TextPositionSequence.java

```java
package cn.com.ava.sign.util.signature;

import org.apache.pdfbox.text.TextPosition;

import java.util.List;

public class TextPositionSequence implements CharSequence {

    public TextPositionSequence(List<TextPosition> textPositions) {
        this.textPositions = textPositions;
        this.start = 0;
        this.end = textPositions.size();
    }

    public TextPositionSequence(List<TextPosition> textPositions, int start, int end) {
        this.textPositions = textPositions;
        this.start = start;
        this.end = end;
    }

    @Override
    public int length() {
        return end - start;
    }

    @Override
    public char charAt(int index) {
        TextPosition textPosition = textPositionAt(index);
        String text = textPosition.getUnicode();
        return text.charAt(0);
    }

    @Override
    public TextPositionSequence subSequence(int start, int end) {
        return new TextPositionSequence(textPositions, this.start + start, this.start + end);
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder(length());
        for (int i = 0; i < length(); i++) {
            builder.append(charAt(i));
        }
        return builder.toString();
    }

    public float getX() {
        return textPositions.get(start).getXDirAdj();
    }

    public float getY() {
        return textPositions.get(start).getYDirAdj();
    }

    public TextPosition textPositionAt(int index) {
        return textPositions.get(start + index);
    }

    private final List<TextPosition> textPositions;
    private final int start;
    private final int end;
}

```

#### 特性
1. 支持单页多关键字签名
2. 支持多页多关键字签名
3. 支持多种格式图片签名

#### 参考链接

1. https://stackoverflow.com/questions/35937774/how-to-search-some-specific-string-or-a-word-and-there-coordinates-from-a-pdf-do
2. https://svn.apache.org/viewvc/pdfbox/trunk/examples/src/main/java/org/apache/pdfbox/examples/signature/