package cn.hua.action;

import cn.hua.service.Service;
import com.opensymphony.xwork2.ActionSupport;

public class CheckIsExistAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private String type;
	private String value;
	private String id;
	private String result;
	private Service service;

	public void setId(String id) {
		this.id = id;
	}

	public void setService(Service service) {
		this.service = service;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void setValue(String value) {
		this.value = value;
	}
	/**
	 * 检查是否存在
	 */
	public String execute() {
		if (type != null &&!type.trim().equals("")&& value != null&&!value.trim().equals("")) {
			boolean bool = service.UserIsExist(type, value,id);
			this.result = "{'message':"+bool+"}";
			/*Map<String, Object> map = new HashMap<String, Object>();
			map.put("message", bool);
			ObjectMapper mapper = new ObjectMapper();
			try {
				this.result = mapper.writeValueAsString(map);
			} catch (JsonProcessingException e) {
				this.result = null;
			}*/
		}

		return "success";
	}
}
