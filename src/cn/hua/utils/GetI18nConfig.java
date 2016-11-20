package cn.hua.utils;

import com.opensymphony.xwork2.ActionContext;

import java.io.IOException;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
public class GetI18nConfig extends Thread{
	private static String result;
	private Map<String,Object> session;
	private ActionContext actionContext;
	private static Properties properties = new Properties();
	public GetI18nConfig(ActionContext actionContext){
		this.actionContext = actionContext;this.session = actionContext.getSession();
	}
	public void run(){
		Locale sessionI18n = (Locale) session.get("WW_TRANS_I18N_LOCALE");
		if(sessionI18n==null){
			sessionI18n = actionContext.getLocale();
		}
		session.put("i18nConfig",getI18n(sessionI18n));
	}
	public static String getI18n(Locale locale){
		try {
			result="{";
			properties.load(GetI18nConfig.class.getClassLoader().getResourceAsStream("i18n_js_"+locale.toString()+".properties"));
			int i=0;
			for(Entry<Object, Object>  entry : properties.entrySet()){
				i++;
				result = result + "'"+entry.getKey().toString()+"':'"+entry.getValue().toString()+"',";
			}
			System.out.println(i);
		return result  = result.substring(0,result.length()-1)+"}";
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
