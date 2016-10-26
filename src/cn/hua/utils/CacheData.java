package cn.hua.utils;

import cn.hua.model.User;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CacheData{
	//缓存规则：用户名：当前时间：用户名+密码+当前时间+851860021
	public static void addCookie(HttpServletResponse httpServletResponse, User user) {
		long date = System.currentTimeMillis();
		String name = checkType(user);
		String data = name+":"+date+":"+Encryption.encryption(name+user.getSafe().getLoginPassword()+date);
		Cookie cookie = new Cookie("skjsAutoData",data);
		cookie.setMaxAge(60*60*24*15);
		cookie.setPath("/skjs");
		httpServletResponse.addCookie(cookie);
	}
	public static String[] getCookie(HttpServletRequest httpServletRequest,String key){
		Cookie[] cookies = httpServletRequest.getCookies();
		if(cookies!=null)
		for(Cookie cookie : cookies){
			if(key.equals(cookie.getName())){
				String value = cookie.getValue();
				System.out.println(value);
				if(value!=null){
					String[] val = value.split(":"); 
					if(val.length==3){
						long date = Long.parseLong(val[1]);
						if(date>System.currentTimeMillis()-60*60*24*15*1000){
							return val;
						}
					}
				}
			}
		}
		return null;
	}
	public static void removeCookie(HttpServletResponse httpServletResponse, String key){
		Cookie cookie = new Cookie(key,null);
		cookie.setMaxAge(0);
		cookie.setPath("/skjs");
		System.out.println("remove");
		httpServletResponse.addCookie(cookie);
	}
	public static String checkType(User user){
		if(user.getUsername()!=null){
			return user.getUsername();
		}else if(user.getPhone()!=null){
			return user.getPhone();
		}else
			return user.getEmail();
	}
}
