package restful.api;

import restful.annotation.isAdmin;
import restful.bean.Result;
import restful.database.EM;
import restful.entity.Category;
import restful.entity.ClothesDetails;
import restful.entity.User;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import java.util.Date;
import java.util.List;

/**
 * @author YeXingyi
 * @version 1.0
 * @date 2023/12/5 12:55
 */
@Path("/fitting")
public class FittingAPI {
    @Context
    private HttpServletRequest request;

    @POST
    @Path("/getAll")
    @Produces("application/json;charset=UTF-8")
    public Result getAll() {
        List<ClothesDetails> result = EM.getEntityManager()
                .createNamedQuery("ClothesDetails.findAll", ClothesDetails.class)
                .getResultList();
        return new Result(0, "查询换装记录成功", result, "");
    }

    @POST
    @Path("/getAllByUserId")
    @Produces("application/json;charset=UTF-8")
    public Result getAllByUserId() {
        User currentUser = (User) request.getSession().getAttribute("user");
        List<ClothesDetails> result = EM.getEntityManager()
                .createNamedQuery("ClothesDetails.findAllByUserId", ClothesDetails.class)
                .setParameter("userId", currentUser.getId())
                .getResultList();
        System.out.println(currentUser.getId());
        return new Result(0, "查询换装记录成功", result, "");
    }

    @POST
    @Path("/addSuit")
    @Consumes("application/json;charset=UTF-8")
    @Produces("application/json;charset=UTF-8")
    public Result addSuit(ClothesDetails clothesDetails) {
        User currentUser = (User) request.getSession().getAttribute("user");
        clothesDetails.setUserId(currentUser.getId());

        List<ClothesDetails> result = EM.getEntityManager()
                .createNamedQuery("ClothesDetails.findAllByUserId", ClothesDetails.class)
                .setParameter("userId", currentUser.getId())
                .getResultList();

        for (ClothesDetails curClothesDetails : result) {
            // 如果当前衣服的种类和新添加的衣服的种类相同
            if (curClothesDetails.getCategoryId().equals(clothesDetails.getCategoryId())) {
                //删除当前分类衣服
                EM.getEntityManager().remove(curClothesDetails);
            }
        }
        //衣服种类
        clothesDetails.setUpdateUser(currentUser.getId());
        clothesDetails.setCreateUser(currentUser.getId());
        clothesDetails.setUpdateTime(new Date());
        clothesDetails.setCreateTime(new Date());
        //添加到数据库
        EM.getEntityManager().merge(clothesDetails);
        EM.getEntityManager().getTransaction().commit();
        return new Result(0, "添加换装记录成功", clothesDetails, "");
    }

    @POST
    @Path("/deleteSuit")
    @Consumes("application/json;charset=UTF-8")
    @Produces("application/json;charset=UTF-8")
    public Result deleteSuit(ClothesDetails clothesDetails) {
        EM.getEntityManager().remove(EM.getEntityManager().merge(clothesDetails));
        EM.getEntityManager().getTransaction().commit();
        return new Result(0, "删除换装记录成功", "", "");
    }

    @POST
    @Path("/updateSuit")
    @Consumes("application/json;charset=UTF-8")
    @Produces("application/json;charset=UTF-8")
    public Result updateSuit(ClothesDetails clothesDetails) {
        clothesDetails.setUpdateUser(((User) request.getSession().getAttribute("user")).getId());
        clothesDetails.setUpdateTime(new Date());
        EM.getEntityManager().merge(clothesDetails);
        EM.getEntityManager().getTransaction().commit();
        return new Result(0, "更新换装记录成功", clothesDetails, "");
    }

    //查找分类
    @POST
    @Path("/categoryList")
    @Produces("application/json;charset=UTF-8")
    public Result categoryList() {
        List<Category> result=EM.getEntityManager()
                .createNamedQuery("Category.findAll",Category.class)
                .getResultList();
        return new Result(0, "获取分类列表信息成功", result, "");
    }
}
