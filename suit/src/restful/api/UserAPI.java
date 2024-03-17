package restful.api;

import restful.annotation.isAdmin;
import restful.bean.Result;
import restful.database.EM;
import restful.entity.RegisterUser;
import restful.entity.User;
import restful.utils.Md5Util;

import java.util.Date;
import java.util.List;

import javax.persistence.NonUniqueResultException;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;

/**
 * @author YeXingyi
 * @version 1.0
 * @date 2023/11/26 10:45
 */

@Path("/user")
public class UserAPI {
	@Context
	private HttpServletRequest request;

	String regex = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";


	@POST
	@Path("/login")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result login(User user)
	{
//        User curUser = new User();
//
//        curUser.setUsername(user.getUsername());
//        curUser.setPassword(user.getPassword());
//        curUser.setSex(1);
//        curUser.setAdmin(false);
//        curUser.setModel("mheadA");
//        curUser.setNickname("游客");
//        System.out.println(user.getUsername());
		
		List<User> result =  EM.getEntityManager()
				.createNamedQuery("User.findAllByName", User.class)
				.setParameter("username",user.getUsername())
				.getResultList();
		if(result.size()==0)
			return new Result(1, "该用户不存在", "", "");
		
		if(Md5Util.checkPassword(user.getPassword(), result.get(0).getPassword())) {
			request.getSession().setAttribute("user",result.get(0));
			return new Result(0, "登录成功", result.get(0), "");

		}else {
			return new Result(1, "密码错误", "", "");
		}

	}

	@POST
	@Path("/register")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result register(RegisterUser Ruser) {

		if(!Ruser.getPassword().matches(regex)||Ruser.getUsername()==null||Ruser.getSex()==null||Ruser.getNickname()==null) {
			return new Result(1, "数据不合法", " ", "");
		}

		User user=new User();
		user.setUsername(Ruser.getUsername());
		user.setNickname(Ruser.getNickname());
		String password = Md5Util.getMD5String(Ruser.getPassword());
		user.setPassword( password );
		user.setSex(Ruser.getSex());
		user.setModel(Ruser.getModel());
		user.setCreateUser(user.getId());
		user.setUpdateUser(Ruser.getId());

		List<User> result =  EM.getEntityManager()
				.createNamedQuery("User.findAllByName", User.class)
				.setParameter("username",Ruser.getUsername())
				.getResultList();
		if(result.size()>0)
			return new Result(1, "该用户已存在，请重新注册", "", "");

        EM.getEntityManager().merge(user);
		EM.getEntityManager().getTransaction().commit();
		return new Result(0, "注册成功", "", "");

	}


	//获取本人用户信息
	@POST
	@Path("/curUser")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result curUser() {
		return new Result(0, "获取当前用户信息成功", (User) request.getSession().getAttribute("user"), "");
	}



	@POST
	@Path("/updateCurUser")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result updateCurUser(RegisterUser Ruser) {

		//数据合法性检验
		if(Ruser.getSex()==null||Ruser.getNickname()==null||Ruser.getModel()==null) {
			return new Result(1, "数据不合法", " ", "");
		}
//		System.out.println("updateCurUser:"+Ruser);
		//从数据库中拉取该用户信息
		User user=EM.getEntityManager()
				.createNamedQuery("User.findAllByName",User.class)
				.setParameter("username",Ruser.getUsername()).getSingleResult();

		//更新信息
//		System.out.println(Ruser.getPassword());
		if(!Ruser.getPassword().equals("")) {
//			System.out.println("进入判断");
			if(!Ruser.getPassword().matches(regex)||Ruser.getSex()==null||Ruser.getNickname()==null||Ruser.getPassword()!=Ruser.getPasswordAgain()) {
//				System.out.println("进入数据不合法");
				new Result(1, "数据不合法", " ", "");
			}
			
//				System.out.println("进入修改密码");
				String password = Md5Util.getMD5String(Ruser.getPassword());
				user.setPassword( password );
				
			
		}

		user.setNickname(Ruser.getNickname());
		user.setAdmin(Ruser.getAdmin());
		user.setSex(Ruser.getSex());
		user.setModel(Ruser.getModel());
		//user.setCreateUser(user.getId());
//    	user.setUpdateUser((long) 1);
		user.setUpdateUser(((User) request.getSession().getAttribute("user")).getId());
		user.setUpdateTime(new Date());

		user=EM.getEntityManager().merge(user);

		EM.getEntityManager().getTransaction().commit();
		System.out.print(user.toString());
		return new Result(0, "修改成功", user, "");

	}


	@POST
	@isAdmin
	@Path("/userList")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result getUserList() {
		List<User> result=EM.getEntityManager()
				.createNamedQuery("User.findAll",User.class)
				.getResultList();
		return new Result(0, "获取用户列表信息成功", result, "");
	}


	@POST
	@Path("/logout")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result logout() {
		request.getSession().removeAttribute("user");
		return new Result(0, "登出成功", "", "");
	}


	@POST
	@Path("/delete")
	@Consumes("application/json;charset=UTF-8")
	@Produces("application/json;charset=UTF-8")
	public Result Delete(User user) {


		EM.getEntityManager().remove(EM.getEntityManager().merge(user));
		EM.getEntityManager().getTransaction().commit();
		return new Result(0, "删除成功", "", "");
	}




}
