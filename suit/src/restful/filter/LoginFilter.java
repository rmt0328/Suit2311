package restful.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import restful.entity.User;

/**
 * @author YeXingyi
 * @version 1.0
 * @date 2023/12/4 12:48
 */
public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;

        String requestURI = req.getRequestURI();
        User user = (User) req.getSession().getAttribute("user" );
//        System.out.println("user:" + user);
        if (user != null) {
//            System.out.println("LoginFilter:已登录");
            chain.doFilter(request, response);
        }
        else if(requestURI.endsWith("login.jsp") || requestURI.endsWith("register.jsp")
                || requestURI.endsWith("login") || requestURI.endsWith("register") || requestURI.endsWith(".png")
                || requestURI.endsWith(".jpg") || requestURI.endsWith(".js") || requestURI.endsWith(".css") ) {
//            System.out.println("LoginFilter:未登录"+requestURI+"允许访问");
            chain.doFilter(request, response);
        } else {
            //若未登录，转至错误页面
//            System.out.println("LoginFilter:未登录"+requestURI+"禁止访问");
            ((HttpServletResponse) response).sendRedirect("/suit/jsp/login.jsp");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void destroy() {

    }


}
