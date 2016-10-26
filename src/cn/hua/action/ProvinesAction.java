package cn.hua.action;

import java.util.List;

import com.opensymphony.xwork2.ActionSupport;

import cn.hua.model.Area;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;

public class ProvinesAction extends ActionSupport{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String result="";
	private Service service;
	private int id=0;
	public void setId(int id) {
		this.id = id;
	}
	public void setService(Service service) {
		this.service = service;
	}
	public String getResult() {
		return result;
	}
	public String execute(){
		List<Area> list = service.getAreas(id);
		for(Area area : list){
			System.out.println(area.getName());
			this.result += "id,"+area.getId()+","+"name,"+area.getName()+",";
		}
		if(!result.equals("")){
			this.result = Conversion.stringToJsonGroupTwo(result.substring(0,result.length()-1));
		}else{
			this.result =  Conversion.stringToJson("message,false");
		}
		return "success";
	}
}
