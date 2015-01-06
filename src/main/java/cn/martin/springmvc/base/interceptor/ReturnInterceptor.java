package cn.martin.springmvc.base.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 将Controller返回模板路径指定到当前模块的ftl路径下
 * 
 * @author martin
 * 
 */
public class ReturnInterceptor extends HandlerInterceptorAdapter {

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);

		if (handler.getClass().isAssignableFrom(HandlerMethod.class)) {
			HandlerMethod handlerMethod = (HandlerMethod) handler;
			DefaultReturn defaultReturn1 = handlerMethod.getMethodAnnotation(DefaultReturn.class);
			DefaultReturn defaultReturn2 = handlerMethod.getBean().getClass().getAnnotation(DefaultReturn.class);

			if ((defaultReturn1 == null || defaultReturn1.value() == false)
					&& (defaultReturn2 == null || defaultReturn2.value() == false)) {
				String viewName = modelAndView.getViewName();
				if (null != viewName) {
					String path = handlerMethod.getBean().getClass().getPackage().getName().replace('.', '/')
							+ "/../ftl/" + modelAndView.getViewName();
					System.out.println(path);
					modelAndView.setViewName(path);
				}
			}

		}

	}

}
