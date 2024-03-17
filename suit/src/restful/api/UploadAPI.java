package restful.api;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import restful.annotation.isAdmin;
import restful.bean.Result;
import restful.database.EM;
import restful.entity.Clothes;
import restful.entity.User;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;

/**
 * @author YeXingyi
 * @version 1.0
 * @date 2023/12/2 11:17
 */
@Path("/upload")
public class UploadAPI {
    @Context
    HttpServletRequest request;

    /**
     * 上传图片
     * @param suitCode 套装编号
     * @return
     */
    @POST
    @Path("/uploadImage")
    @Produces("application/json;charset=UTF-8")
//    @isAdmin
    public Result uploadImage(@QueryParam("code") String suitCode) {
        System.out.println("uploadImage suitCode:"+suitCode);

        // 创建DiskFileItem工厂
        DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
        String path = "WebContent/images/clothesImg";
        // 设置缓存目录 项目目录下的images/uploadCache
        String uploadCachePath = "WebContent/images/clothesImg/uploadCache";
        File uploadCacheDir = new File(uploadCachePath);

        if (!uploadCacheDir.exists()) {
            uploadCacheDir.mkdirs();
        }

        diskFileItemFactory.setRepository(new File(uploadCachePath));
        // 设置缓冲区大小,文件体积超出缓冲区大小将保持至缓存目录然后再进行后续处理，这里设置为1M bytes
        diskFileItemFactory.setSizeThreshold(1024 * 1024); // 设定了1M的缓冲区
        // 创建文件上传解析对象
        ServletFileUpload fileUpload = new ServletFileUpload(diskFileItemFactory);
        // 按照UTF-8编码格式读取
        fileUpload.setHeaderEncoding("UTF-8");
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return new Result(-1, "服务器编码错误", null, "");
        }
        // 设置每个文件最大为5M
        fileUpload.setSizeMax(5 * 1024 * 1024);
        // 一共最多能上传10M
        fileUpload.setSizeMax(10 * 1024 * 1024);

        // 获取文件保存目录
        try {
            List<FileItem> fileItems = fileUpload.parseRequest(request);
//            System.out.println(fileItems.size());
            //调试
//            for (FileItem fileItem : fileItems){
//                System.out.println("fileItem.getName():"+fileItem.getName());
//                System.out.println("fileItem.getFieldName():"+fileItem.getFieldName());
//                System.out.println("fileItem.getContentType():"+fileItem.getContentType());
//                System.out.println("fileItem.getSize():"+fileItem.getSize());
//                System.out.println("fileItem.getString():"+fileItem.getString());
//            }
                // 解析并保存
            for (FileItem fileItem : fileItems) {
                String fileName=fileItem.getName();
//                System.out.println("fileName:" + fileName);
                if (fileName == null || fileName.trim().equals("")) {
                    return new Result(-1, "文件名为空", null, "");
                }
                // 获取文件名
                int lastBackslashIndex = fileName.lastIndexOf("\\");
                // 如果有路径，截取文件名
                if (lastBackslashIndex != -1) {
                    fileName = fileName.substring(lastBackslashIndex + 1);
                }
                // 获取文件后缀名
                String fileExtName = fileName.substring(fileName.lastIndexOf(".") + 1);
                if(!fileExtName.equals("jpg")&&!fileExtName.equals("png")&&!fileExtName.equals("jpeg")){
                    return new Result(-1, "文件格式错误", null, "");
                }
                // 获取文件大小
                long size = fileItem.getSize();
             
                
                
             // 保存文件
                String savPath = System.getProperty("user.dir") + "/suit/WebContent/images/clothesImg";
                System.out.println("==========="+savPath);
                
                File directory = new File(savPath);
                
                if (!directory.exists()) {
                    directory.mkdirs();
                }
                // 保存文件
                String savePath = directory + "\\" +fileName; // Define the save path

                //System.out.println("saveFile:" + savePath);
                File saveFile = new File(savePath);
                fileItem.write(saveFile);

                List<Clothes> result = EM.getEntityManager()
                        .createNamedQuery("Clothes.findAllByNo", Clothes.class)
                        .setParameter("clothesNo", suitCode)
                        .getResultList();
                if (result.size() == 0) {
                    return new Result(-1, "上传失败,系统未找到该套装", null, "");
                }
                Clothes clothes = result.get(0);
                clothes.setImg(fileName);
                clothes.setUpdateTime(new Date());
                clothes.setUpdateUser(((User)(request.getSession().getAttribute("user"))).getId());

                System.out.println("clothes:" + clothes);
                EM.getEntityManager().merge(clothes);
                EM.getEntityManager().getTransaction().commit();

                return new Result(0, fileName, null, "");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(-1, "服务器文件解析错误", null, "");
        }
        return new Result(-1, "未发现可供服务保存的数据", null, "");
    }
}
