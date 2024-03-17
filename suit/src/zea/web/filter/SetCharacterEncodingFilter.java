package zea.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


//@WebFilter("/*")
public class SetCharacterEncodingFilter implements Filter{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		request.setCharacterEncoding("UTF-8");
		chain.doFilter(request,response);      
		
	}
    /*public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        req.setCharacterEncoding("UTF-8");
        String urls[] = {"/jsp/login.jsp","/jsp/register.jsp","/login/log","/login/register", "/images/","user/login","user/register"};
        StringBuffer url = req.getRequestURL();
        for (String u:urls){
            if ((url+"").contains(u)){
                chain.doFilter(servletRequest, servletResponse);
                return;
            }
        }
        HttpSession session = req.getSession();
        Object user = session.getAttribute("user");
        if (user != null){
            //req.setAttribute("isLog",0);
            chain.doFilter(servletRequest, servletResponse);
        }
        else {
            //req.setAttribute("isLog",1);
            req.getRequestDispatcher("/jsp/login.jsp").forward(req,servletResponse);
        }
    }*/

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}
}
