package restful.interceptor;

import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.core.Context;

import org.jboss.resteasy.core.Headers;
import org.jboss.resteasy.core.ResourceMethodInvoker;
import org.jboss.resteasy.core.ServerResponse;
import org.jboss.resteasy.spi.HttpRequest;
import org.jboss.resteasy.spi.interception.PreProcessInterceptor;

import restful.annotation.isAdmin;
import restful.bean.Result;
import restful.entity.User;

@SuppressWarnings("deprecation")
public class Interceptor4PreProcess implements PreProcessInterceptor {

	@Context
	HttpServletRequest request;

	@Context
	HttpServletResponse response;


	@Override
	public ServerResponse preProcess(HttpRequest httpRequest, ResourceMethodInvoker resourceMethodInvoker) {

//		System.out.println("进入拦截器");
		Method method = resourceMethodInvoker.getMethod();

		//		//是否登录
//		if(method.isAnnotationPresent(isLogin.class)){
//			if(request.getSession().getAttribute("user")==null) {
//				System.out.printf("我没登录哇哇哇");
//				Result result=new Result(-20,"未登录","","");
//				ServerResponse response=new ServerResponse();
//				response.setEntity(result);
//				response.setStatus(200);
//				return response;
//			}
//
//		}

		// 是否是管理员
		if (method.isAnnotationPresent(isAdmin.class)) {
			User user = (User) request.getSession().getAttribute("user");
			if (user == null || !user.getIsAdmin()) {
				System.out.println("我没权限哇哇哇");
				Result result = new Result(-20, "需要管理员权限", "", "");
				try {
					return new ServerResponse(result, 200, new Headers<>());
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		return null;
	}
}