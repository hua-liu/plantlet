/*package cn.hua.action;

import java.util.List;

import cn.hua.model.GoodsKind;
import cn.hua.service.Service;

import com.opensymphony.xwork2.ActionSupport;

public class SearchOfKindAction extends ActionSupport{
	*//**
	 * 
	 *//*
	private static final long serialVersionUID = 1L;
	private int id;
	private String result;
	private Service service;
	public void setService(Service service) {
		this.service = service;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getResult() {
		return result;
	}
	public String execute(){
		result = "[";
		if(id!=0){
			List<GoodsKind> list= service.getGoodsKindChilds(id);
			if(list!=null){
				for(GoodsKind kind : list){
					result += "{'id':'"+kind.getId()+"','name':'"+kind.getName()+"'},";
				}
				result = result.substring(0, result.length()-1)+"]";
			}
		}
		return SUCCESS;
	}
}
*/