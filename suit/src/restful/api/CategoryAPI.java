package restful.api;



import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;

import restful.annotation.isAdmin;
import restful.bean.Result;
import restful.database.EM;
import restful.entity.Category;
import restful.entity.User;


@Path("/category")
public class CategoryAPI {
	
	@Context
	private HttpServletRequest request;
	 //增加分类
	@POST
	@isAdmin
    @Path("/addCategory")
    @Consumes("application/json;charset=UTF-8")
    @Produces("application/json;charset=UTF-8")
    public Result addCategory(Category category) {
		if(category.getCategoryNo().equals("")||category.getCategoryAlias().equals("")) {
			return new Result(1,"分类信息不为空","","");
		}

		 List<Category> result=EM.getEntityManager()
        		.createNamedQuery("Category.findAllByNo",Category.class)
        		.setParameter("categoryNo",category.getCategoryNo()).getResultList();
		 if(result.size()!=0) {
			 return new Result(1,"该分类已存在","","");
		 }
		 
		category.setCreateTime(new Date());
		User user=(User)request.getSession().getAttribute("user");
		category.setCreateUser(user.getId());

		category.setUpdateTime(new Date());
		category.setUpdateUser(user.getId());
		
		EM.getEntityManager().merge(category);
		EM.getEntityManager().getTransaction().commit();
		
        return new Result(0, "添加分类成功", category, "");
    }
	
	//删除分类
	
	@POST
	@isAdmin
    @Path("/deleteCategory")
    @Consumes("application/json;charset=UTF-8")
    @Produces("application/json;charset=UTF-8")
    public Result deleteCategory(Category category) {

		EM.getEntityManager().remove(EM.getEntityManager().merge(category));  
    	EM.getEntityManager().getTransaction().commit();
		
        return new Result(0, "删除分类成功", category, "");
    }
	  
	
	//查找分类
	@POST
	@isAdmin
    @Path("/categoryList")
    @Produces("application/json;charset=UTF-8")
    public Result categoryList() {
		 List<Category> result=EM.getEntityManager()
	        		.createNamedQuery("Category.findAll",Category.class)
	        		.getResultList();
	        return new Result(0, "获取分类列表信息成功", result, "");
    }
	    
	//修改分类
	 @POST
	 @isAdmin
	 @Path("/updateCategory")
	 @Consumes("application/json;charset=UTF-8")
	 @Produces("application/json;charset=UTF-8")
	 public Result updateCurCategory(Category category) {
		 if(category.getCategoryNo().equals("")||category.getCategoryAlias().equals("")) {
				return new Result(1,"分类信息不为空","","");
			}
		 List<Category> result=EM.getEntityManager()
	        		.createNamedQuery("Category.findAllByNo",Category.class)
	        		.setParameter("categoryNo",category.getCategoryNo()).getResultList();
		 
		 if(result.size()>0&&result.get(0).getId()!=category.getId()) {
			 System.out.println(category.getCategoryNo().toString()+"重复了==============");
			 return new Result(1,"该分类名称已存在","","");
		 }

	     category.setUpdateUser(((User) request.getSession().getAttribute("user")).getId());
	     category.setUpdateTime(new Date());

		 category=EM.getEntityManager().merge(category);

		 EM.getEntityManager().getTransaction().commit();
		 return new Result(0, "修改成功", category, "");

	    }
}
