package restful.utils;
import org.apache.commons.codec.binary.Base64;

import java.security.MessageDigest;

public class MD5BU {
    /**
     * 密码加密处理（MD5）
     * @param src 原密码
     * @return 加密后的内容
     */
    public static String md5(String src){
        try{//采用MD5处理
            MessageDigest md =
                    MessageDigest.getInstance("MD5");
            byte[] output = md.digest(
                    src.getBytes());//加密处理
            //将加密结果output利用Base64转成字符串输出
            String ret =
                    Base64.encodeBase64String(output);
            return ret;
        }catch(Exception e){
            return "";
        }
    }
}