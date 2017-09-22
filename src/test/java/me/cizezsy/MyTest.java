package me.cizezsy;

import org.junit.Assert;
import org.junit.Test;

import java.io.*;

public class MyTest {

    @Test
    public void testLoad() throws IOException {
        File file = new File("C:\\Users\\Administrator\\Desktop\\VectorPinball.rar");
        if(!file.exists()) {
            throw new FileNotFoundException();
        }
        BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
        ByteArrayOutputStream byteOs = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int length;
        try {
            while((length = bis.read(buffer)) != -1) {
                byteOs.write(buffer, 0, length);
            }
        } finally {
            bis.close();
        }
        Assert.assertEquals(byteOs.toByteArray().length , file.length());
    }

}
