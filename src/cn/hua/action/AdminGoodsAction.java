package cn.hua.action;

import cn.hua.annotation.Jurisdiction;
import cn.hua.formBean.Paging;
import cn.hua.model.Goods;
import cn.hua.model.GoodsKind;
import cn.hua.model.User;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.SessionAware;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class AdminGoodsAction extends ActionSupport implements ServletRequestAware,
		SessionAware,ModelDriven<Goods>{
	private static final long serialVersionUID = 1L;
	private HttpServletRequest httpServletRequest;
	private Map<String, Object> session;
	private Service service;
	private String id;
	private Goods goods;
	private String result;
	public String getResult() {
		return result;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setGoods(Goods goods) {
		this.goods = goods;
	}
	public void setService(Service service) {
		this.service = service;
	}
	/**
	 * 所有请求之后都会转向到这个Action，这个Action处理页面所需要的分页搜索等数据
	 */
	@Jurisdiction("BackgroundLogin")
	public String add() {
		User user = (User) session.get("user");
		if (user == null) {
				return INPUT;
		}
		Paging paging = new Paging();
		paging.setClassify(2);
		paging.setPutawayGoods(1);
		ActionContext.getContext().getValueStack().push(paging);
		session.put("paging",paging);
		//第一次访问时就重新new一个
		/*Paging paging = (Paging) session.get("paging");
		if(paging==null){
			paging = new Paging();
		}*/
		//获取所有分类
	/*	List<Classify> classifys = service.getClassifys();
		for(int i=0;i<classifys.size();i++){
			classifys.get(i).setName(getText(classifys.get(i).getName()));
		}*/
		/*httpServletRequest.setAttribute("kind", classifys);*/
		//获取所类下的状态
		/*List<State> states = service.getStates();
		for(int i=0;i<states.size();i++){
			states.get(i).setName(getText(states.get(i).getName()));
		}
		states.add(0, new State(getText("all")));
		httpServletRequest.setAttribute("state", states);
		states = new ArrayList<State>();
		states.add(new State(1,getText("normal")));
		states.add(new State(2,getText("inactive")));
		states.add(new State(3,getText("locked")));
		httpServletRequest.setAttribute("userAllState", states);
		Map<Integer,String> MaintenanceMenu = new HashMap<Integer,String>();//权限管理下的功能
		MaintenanceMenu.put(1,getText("userMaintenance"));
		MaintenanceMenu.put(2,getText("roleMaintenance"));
		MaintenanceMenu.put(3,getText("jurisdictionMaintenance"));
		httpServletRequest.setAttribute("MaintenanceMenu", MaintenanceMenu);*/
		//商品管理
		/*Map<Integer,String> goodsMade = new HashMap<Integer,String>();//权限管理下的功能
		goodsMade.put(1,getText("addGoods"));
		goodsMade.put(2,getText("selectGoods"));
		httpServletRequest.setAttribute("goodsMade", goodsMade);*/
		/*
		httpServletRequest.setAttribute("goodsKind", goodsKinds);
		//获取分类下的角色
		List<Role> roles = service.getRoles();
		for(int i=0;i<roles.size();i++){
			roles.get(i).setName(getText(roles.get(i).getName()));
		}
		roles.add(0,new Role("0",getText("all")));
		httpServletRequest.setAttribute("role", roles);
		//获取当前用户的所有权限，对于js判断
		httpServletRequest.setAttribute("permissions", service.getPermissions(user.getRole()));
		//获取分页数据
		if(!(paging.getClassify()==2&&paging.getPutawayGoods()==1))
		httpServletRequest.setAttribute("list", service.getPagingData(paging,user.getId()));*/
		//获取i18n配置
		//商品管理
		List<GoodsKind> goodsKinds = service.getGoodsKindRoot();
		goodsKinds.add(0,new GoodsKind(0, "----点击选择商品分类----"));
		httpServletRequest.setAttribute("goodsKind", goodsKinds);
		/*ActionContext.getContext().getValueStack().push(paging);
		if(paging.getClassify()==4){//当分类为权限管理
			if(paging.getFunction()==1){	//当功能为用户维护时获取所有角色，为用户添加角色，更改用户时需要
					roles = service.getAllRoles();
					for(int i=0;i<roles.size();i++){
						roles.get(i).setName(getText(roles.get(i).getName()));
					}
					session.put("allRoles", roles);
			}
			if(paging.getFunction()==2)	//当功能为角色维护时获取所有权限，添加角色，更新角色时需要
				session.put("allPermissions", service.getPermissions());
		} */
		/*if(paging.getClassify()==1)return "UserAdmin";	//如果分类为用户管理时，返回到用户页面
		else if(paging.getClassify()==4) return "PermissionAdmin";//如果分类为权限管理时，返回到权限页面
		else if(paging.getClassify()==2) return "GoodsAdmin";*/
		return SUCCESS;
	}
	public String manage(){
		User user = (User) session.get("user");
		if (user == null) {
				return INPUT;
		}
		Paging paging = (Paging) session.get("paging");
		if(paging==null){
			paging = new Paging();
		}
		paging.setClassify(2);	
		httpServletRequest.setAttribute("list",service.getPagingData(paging, user.getId()));
		ActionContext.getContext().getValueStack().push(paging);
		session.put("paging", paging);
		return SUCCESS;
	}
	public String putawayOrSoldout(){
		if(goods==null){
			this.result = Conversion.stringToJson("message,false,cause,没有获取到商品信息");
			return SUCCESS;
		}
		goods.setShelfTime(new Date());
		try{
			service.updateGoods(goods);
			this.result = Conversion.stringToJson("message,true");
		}catch(Exception e){
			this.result = Conversion.stringToJson("message,false,cause,服务器异常，请稍候再试");
		}
		return SUCCESS;
	}
	public String updateUi(){
		if(goods!=null){
			ActionContext.getContext().getValueStack().push(goods);
			return "updateGoodsUiSuccess";
		}
		return "updateGoodsUiError";
	}
	@Override
	public void setServletRequest(HttpServletRequest arg0) {
		this.httpServletRequest = arg0;
		// TODO Auto-generated method stub

	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	@Override
	public Goods getModel() {
		if(id!=null){
			goods = service.findGoodsById(id);
			if(goods==null){
				System.out.println("没有获取到商品");
				goods = new Goods();
			}
		}else{
			goods = new Goods();
		}
		return goods;
	}
}
