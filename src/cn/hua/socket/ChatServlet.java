package cn.hua.socket;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Map.Entry;
import java.util.UUID;

import javax.websocket.CloseReason;
import javax.websocket.CloseReason.CloseCode;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

import cn.hua.utils.Conversion;
import cn.hua.utils.MessageOperation;
/*
 * 状态：5，表示没有客服需等待
 * 	   1，有客服，正在呼叫客服，等待
 * 	   2，消息发送成功回复
 * 	   4,文件发送中止
 * 	   10,正在消息
 * 	   0，聊天中断
 * 	   6,有等待用户
 * 	   8,接收图片
 * 	   3,发送记录信息
 * 	   
 */
@ServerEndpoint("/chatServer.server")
public class ChatServlet {
	private static Properties properties = new Properties();
	//存储在线客服
	private static final Map<String,Session> onlineServer = new HashMap<String,Session>();
	//存储等待用户
	private static final Map<String,Session> consultUser = new HashMap<String,Session>();
	//存储一对一关系
	private static Map<String,String> oneToOneChat= new HashMap<String,String>();
	static{
		try {
			properties.load(MessageOperation.class.getClassLoader().getResourceAsStream("path.properties"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@OnOpen
	public void onOpen(Session session){
		Map<String,List<String>> parameters = session.getRequestParameterMap();
		if(parameters==null||parameters!=null&&parameters.size()<=0){
			close(session,false);	//如果没带用户名等信息过来则不建立通信
			return;
		}
		List<String> userTypes = parameters.get("userType");	//获取属性
		List<String> userInfors = parameters.get("user");		//获取属性
		if((userTypes!=null&&userTypes.size()<1)||(userInfors==null||userInfors!=null&&userInfors.size()<1)){
			close(session,false);	//如果没带用户名等信息过来则不建立通信
			return;
		}
		if(userTypes!=null&&"system".equals(userTypes.get(0))){//判定为客服
			onlineServer.put(parameters.get("user").get(0),session);	//存入在线客服
			String waitUser = getConsultUser();
			if(waitUser!=null){//获取到 一个等待用户
				//建立一对一关系
				oneToOneChat.put(parameters.get("user").get(0),waitUser);
				//获取等待用户离线信息
				Map<String,String> map = getOfflineMessage(waitUser);
				//向客服发送等待用户的信息
				sendSystemMessage(session,Conversion.stringToJson("state,1,user,"+waitUser+",message,用户"+waitUser+"有问题咨询，请尽快回复！"));
				//向客服发送等待用户发送的信息条数
				sendSystemMessage(session,Conversion.stringToJson("state,6,user,"+waitUser+",num,"+(map==null?1:map.size()+1)));
				//向用户发送已找到客服
				sendSystemMessage(consultUser.get(waitUser),Conversion.stringToJson("state,1,user,"+parameters.get("user").get(0)+",message,亲爱的用户您好，客服   "+parameters.get("user").get(0)+" 即将为您提供服务，请等待一会..."));
				//发送离线信息
				sendMapMessage(session, map,waitUser);
			}
		}else{//判断为用户
			if("".equals(userInfors.get(0))){//用户没有获取用户带过来的用户名等信息，则关系连接
				close(session,false);
				return;
			}
			//向用户集合里存储当前用户
			consultUser.put(parameters.get("user").get(0), session);
			//发送欢迎词
			sendMessage(session,"欢迎来到小苗基地，正在分配客服为您服务....",new Date(),5);
			//获取空间客服
			String leisureServer = getLeisureServer();
			if(leisureServer==null){//判断没有空闲客服，向 用户发送说明信息
				sendMessage(session,"当前客服繁忙，可能无法及时回复您的信息，请等待一会...",new Date(),5);
			}else{
				//有空闲客服，建立一对一关系
				oneToOneChat.put(leisureServer, parameters.get("user").get(0));
				//向用户发送说明信息
				sendSystemMessage(session,Conversion.stringToJson("state,1,user,"+leisureServer+",message,正在通知客服   "+leisureServer+" 请等待一会..."));
				//向客服发送用户消息
				sendSystemMessage(onlineServer.get(leisureServer),Conversion.stringToJson("state,6,user,"+parameters.get("user").get(0)+",num,"+1));
				sendSystemMessage(onlineServer.get(leisureServer),Conversion.stringToJson("state,1,user,"+parameters.get("user").get(0)+",message,用户"+parameters.get("user").get(0)+"需要您的帮助，请尽快回复...."));
			}
		}
	}
	 /**  
     * 收到客户端消息时触发  
     * @param relationId  
     * @param userCode  
     * @param message  
     * @return  
    */  
	@OnMessage
	public String onMessage(Session session,String message){
		if(judgeType(session)){//判定为客服信息
			if(message.startsWith("record:")){
				getRecordMessage(true,session,oneToOneChat.get(getUser(session)), Integer.parseInt(message.substring(message.lastIndexOf("record:")+"record:".length(),message.lastIndexOf("make:"))),message.endsWith("make:+")?true:false);
			}else{
				sendMessage(consultUser.get(oneToOneChat.get(getUser(session))),message,new Date(),10);
				//保存为记录信息
				createRecordMessage(oneToOneChat.get(getUser(session)),getUser(session), message, System.currentTimeMillis(),1);//保存消息记录
			}
		}else{
			if(message.startsWith("record:")){
				getRecordMessage(false,session,getServerKey((getUser(session))), Integer.parseInt(message.substring(message.lastIndexOf("record:")+"record:".length(),message.lastIndexOf("make:"))),message.endsWith("make:+")?true:false);
			}else{
				//获取客服名
				String serverKey = getServerKey(getUser(session));
				if(serverKey==null){
					//保存为离线消息
					createMessage(getUser(session), message, System.currentTimeMillis());
				}else{
					//发送消息
					sendMessage(onlineServer.get(serverKey),message,new Date(),10);
					//保存为记录信息
					createRecordMessage(getUser(session), serverKey, message, System.currentTimeMillis(),0);//保存消息记录
				}
			}
		}
		//返回消息发送状态
         return  Conversion.stringToJson("state,2");  
	}
	 /**  
     * 异常时触发  
     * @param relationId  
     * @param userCode  
     * @param session  
    */  
    @OnError  
     public void onError(Throwable throwable,Session session) {  
    	userTypeToUser(session);
    	try {
			session.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }  
  
    /**  
     * 关闭连接时触发  
     * @param relationId  
     * @param userCode  
     * @param session  
    */  
    @OnClose  
     public void onClose(Session session) {  
    	//等待关闭
    	userTypeToUser(session);
    } 
    public void close(Session session,boolean bool){
    	try {
    		if(bool){	//正常调用关闭
    			session.close();
    		}{
			session.close(new CloseReason(new CloseCode(){
				@Override
				public int getCode() {	//没用户信息调用，则说明不能建立通信
					return 8;
				}}, "没有阁下的信息，不能与阁下建立通信!"));
    		}
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
    public void userTypeToUser(Session session){
    	//获取参数
    	Map<String,List<String>> parameters = session.getRequestParameterMap();
		if(parameters==null||parameters!=null&&parameters.size()<=0){
			close(session,false);
			return;
		}
		List<String> userTypes = parameters.get("userType");
		List<String> userInfors = parameters.get("user");
		if((userTypes!=null&&userTypes.size()<1)||(userInfors==null||userInfors!=null&&userInfors.size()<1)){
			close(session,false);
			return;
		}
		if(userTypes!=null&&"system".equals(userTypes.get(0))){//判定为系统用户关闭连接
			//移除在线客服
			onlineServer.remove(userInfors.get(0));
			//移除一对一之前获取用户名为了给用户提示
			String consult = oneToOneChat.get(userInfors.get(0));
			//列队一对一关系
			oneToOneChat.remove(userInfors.get(0));
			//获取空闲客服
			String leisureServer = getLeisureServer();
			if(leisureServer==null){
				sendMessage(consultUser.get(consult), "客服"+userInfors.get(0)+"已离线，暂时没有空闲客服，请稍等一下",new Date(), 0);
			}else{
				//有空闲客服，建立一对一关系
				oneToOneChat.put(leisureServer, parameters.get("user").get(0));
				sendMessage(consultUser.get(consult), "客服"+userInfors.get(0)+"已离线，客服  "+leisureServer+" 将继续为您服务，请稍等...",new Date(), 0);
				//向客服发送用户消息
				sendSystemMessage(onlineServer.get(leisureServer),Conversion.stringToJson("state,6,user,"+parameters.get("user").get(0)+",num,"+1));
				sendSystemMessage(onlineServer.get(leisureServer),Conversion.stringToJson("state,1,user,"+parameters.get("user").get(0)+",message,用户"+parameters.get("user").get(0)+"需要您的帮助，请尽快回复...."));
			}
		}else{//判定为用户关闭连接
			consultUser.remove(userInfors.get(0));
			String serverKey = getServerKey(userInfors.get(0));
			if(serverKey!=null){
				sendMessage(onlineServer.get(serverKey), "用户"+userInfors.get(0)+"已经取消会话",new Date(), 0);
				oneToOneChat.remove(getServerKey(userInfors.get(0)));
				String waitUser = getConsultUser();
				if(waitUser!=null){//获取到 一个等待用户
					//建立一对一关系
					oneToOneChat.put(serverKey,waitUser);
					//获取等待用户离线信息
					Map<String,String> map = getOfflineMessage(waitUser);
					//向客服发送等待用户的信息
					sendSystemMessage(onlineServer.get(serverKey),Conversion.stringToJson("state,1,user,"+waitUser+",message,用户"+waitUser+"有问题咨询，请尽快回复！"));
					//向客服发送等待用户发送的信息条数
					sendSystemMessage(onlineServer.get(serverKey),Conversion.stringToJson("state,6,user,"+waitUser+",num,"+(map==null?1:map.size()+1)));
					//向用户发送已找到客服
					sendSystemMessage(consultUser.get(waitUser),Conversion.stringToJson("state,1,user,"+parameters.get("user").get(0)+",message,亲爱的用户您好，客服"+parameters.get("user").get(0)+"即将为您提供服务，请等待一会..."));
					//发送离线信息
					sendMapMessage(onlineServer.get(serverKey), map,waitUser);
				}
			}
		}
		close(session,true);
    }
    //获取一位等待用户
    public String getConsultUser(){
    	for(String key: consultUser.keySet()){
    		if(!oneToOneChat.containsValue(key)){
    			return key;
    		}
    	}
    	return null;
    }
    //获取一位在线客服 
    public String getLeisureServer(){
    	for(String key: onlineServer.keySet()){
    		if(!oneToOneChat.containsKey(key)){
    			return key;
    		}
    	}
    	return null;
    }
    //发送系统消息
  public void sendSystemMessage(Session session,String message){
	  if(session==null)return;
    	final RemoteEndpoint.Basic basic = session.getBasicRemote();
    	try {
			basic.sendText(message);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
  //发送带时间，带状态消息
    public void sendMessage(Session session,String message,Date time,int state){
    	if(session==null)return;
    	final RemoteEndpoint.Basic basic = session.getBasicRemote();
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    	try {
			basic.sendText(Conversion.stringToJson("state,"+state+",time,"+sdf.format(time)+",message,"+message));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    //判断用户类型
    public boolean judgeType(Session session){
    	Map<String,List<String>> parameters = session.getRequestParameterMap();
    	List<String> userTypes = parameters.get("userType");
    	if(userTypes!=null&&"system".equals(userTypes.get(0)))
			return true;
		else
			return false;
    }
    //获取当前请求的用户名
    public String getUser(Session session){
    	Map<String,List<String>> parameters = session.getRequestParameterMap();
		return parameters.get("user").get(0);
    }
    //通过用户名获取一对一的客服名
    public String getServerKey(String value){
    	for(Entry<String,String> entry :oneToOneChat.entrySet()){
    		if(entry.getValue().equals(value)){
    			return entry.getKey();
    		}
    	}
    	return null;
    }
    //获取离线的用户信息
    public Map<String,String> getOfflineMessage(String user){
    	SAXReader reader = new SAXReader();
    	Map<String,String> messages = null;
    	Document doc;
		try {
			//读取文件
			doc = reader.read(properties.getProperty("message")+"/offline.xml");
			//获取user节点
			Element my = (Element) doc.getRootElement().selectSingleNode(user);
			if(my==null)return null;
			List<Element> list = my.selectNodes("message");
			for(Element e : list){
				if(messages==null)messages = new LinkedHashMap<String,String>();
				messages.put(e.attributeValue("time"), e.getText());
			}
			doc.getRootElement().remove(my);//读取离线信息之后删除
			saveXml(doc, "offline.xml");	//保存
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return messages;
    }
    //获取客服的离线消息
    public Map<String,String> getServerOfflineMessage(String server,String user){
    	SAXReader reader = new SAXReader();
    	Map<String,String> messages = null;
    	Document doc;
		try {
			doc = reader.read(properties.getProperty("message")+"/serverOffline.xml");
			Element my = (Element)doc.getRootElement().selectSingleNode(user);
			if(my==null)return null;
			Element se = (Element) my.selectSingleNode(server);
			if(se==null)return null;
			List<Element> list = se.selectNodes("message");
			for(Element e: list){
				if(messages==null)messages = new LinkedHashMap<String,String>();
				messages.put(e.attributeValue("time"), e.getText());
			}
			my.remove(se);
			saveXml(doc, "serverOffline.xml");
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return messages;
    }
    //获取记录消息 
    int page=0;
    int currentIndex=0;
    public void getRecordMessage(boolean isSystem,Session myself,String user,int page,boolean make){
    	/*if(this.page >= page){
    		this.page=page;
    		bool = true;
    	}*/
    	int i=20;
    	SAXReader reader = new SAXReader();
    	Document doc;
		try {
			doc = reader.read(properties.getProperty("message")+"/record.xml");
			Element my = (Element)doc.getRootElement().selectSingleNode(isSystem?user:getUser(myself));
			if(my==null)return;
			my = (Element) my.selectSingleNode(isSystem?getUser(myself):user);
			if(my==null)return;
			List<Element> list = my.selectNodes("message");
			Basic basic = myself.getBasicRemote();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			if(make&&currentIndex<list.size()){
				this.page++;
			}else if(!make&&list!=null&&list.size()>0&&currentIndex>=0){
				this.page--;
				currentIndex -=40;
				if(currentIndex<0)currentIndex=0;
			}else{
				return;
			}
			for(;currentIndex<list.size();currentIndex++){
				if(--i<=0){
					break;
				}
				Element e = list.get(currentIndex);
				basic.sendText(Conversion.stringToJson("state,"+3+",time,"+sdf.format(new Date(Long.parseLong(e.attributeValue("time"))))+",message,"+e.getText()+",isSystem,"+(isSystem?e.attributeValue("isSystem").equals("1")?'0':'1':e.attributeValue("isSystem"))+",page,"+this.page));
				//sendMessage(myself, e.getText(),), 3);
			}
			/*for(Element e: list){
				if(messages==null)messages = new HashMap<String,String>();
				messages.put(e.attributeValue("time"), e.getText());
			}*/
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NumberFormatException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
    }
    //保存离线消息
    public void createMessage(String user,String message,Long time){
    	SAXReader reader = new SAXReader();
    	Document doc;
		try {
			doc = reader.read(properties.getProperty("message")+"/offline.xml");
			Element root = doc.getRootElement();
			Element node = (Element) root.selectSingleNode("//"+user);
			if(node==null){
				Element newNode = root.addElement(user).addElement("message");
				newNode.addAttribute("time", time.toString());
				newNode.setText(message);
			}else{
				
				Element mes = node.addElement("message");
				mes.addAttribute("time", time.toString());
				mes.setText(message);
			}
			saveXml(doc,"offline.xml");
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    //保存客服离线消息
    public void createServerOfflineMessage(String server,String user,String message,Long time){
    	SAXReader reader = new SAXReader();
    	Document doc;
		try {
			doc = reader.read(properties.getProperty("message")+"/serverOffline.xml");
			Element root = doc.getRootElement();
			Element my = (Element) root.selectSingleNode(user);
			if(my==null){
				Element newNode = root.addElement(user).addElement(server);
				newNode = newNode.addElement("message");
				newNode.addAttribute("time", time.toString());
				newNode.setText(message);
			}else{
				Element he = (Element) my.selectSingleNode(user);
				if(he==null){
					Element newNode = my.addElement(user);
					newNode = newNode.addElement("message");
					newNode.addAttribute("time", time.toString());
					newNode.setText(message);
				}else{
					Element newNode = he.addElement("message");
					newNode.addAttribute("time", time.toString());
					newNode.setText(message);
				}
			}
			saveXml(doc,"serverOffline.xml");
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    //保存记录消息
    public void createRecordMessage(String myself,String user,String message,Long time,int isSystem){
    	SAXReader reader = new SAXReader();
    	Document doc;
		try {
			doc = reader.read(properties.getProperty("message")+"/record.xml");
			Element root = doc.getRootElement();
			Element my = (Element) root.selectSingleNode(myself);
			if(my==null){
				Element newNode = root.addElement(myself).addElement(user);
				newNode = newNode.addElement("message");
				newNode.addAttribute("isSystem", isSystem+"");
				newNode.addAttribute("time", time.toString());
				newNode.setText(message);
			}else{
				Element he = (Element) my.selectSingleNode(user);
				if(he==null){
					Element newNode = my.addElement(user);
					newNode = newNode.addElement("message");
					newNode.addAttribute("isSystem", isSystem+"");
					newNode.addAttribute("time", time.toString());
					newNode.setText(message);
				}else{
					Element newNode = he.addElement("message");
					newNode.addAttribute("isSystem", isSystem+"");
					newNode.addAttribute("time", time.toString());
					newNode.setText(message);
				}
			}
			saveXml(doc,"record.xml");
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    //保存文件
    public void saveXml(Document doc,String file){
		 OutputFormat outputFormat = OutputFormat.createPrettyPrint();  
	     outputFormat.setLineSeparator("\r\n");//这是为了换行操作  
		try {
			 Writer writer = new FileWriter(properties.getProperty("message")+file);
			XMLWriter output = new XMLWriter(writer,outputFormat);  
			output.write(doc);
			output.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
    }
    //发送集合消息
    public void sendMapMessage(Session session,Map<String,String> map,String he){
    	if(map==null||session==null)return;
    	for(Entry<String,String> entry : map.entrySet()){
    		sendMessage(session, entry.getValue(), new Date(Long.parseLong(entry.getKey())), 10);
    		createRecordMessage(he, getUser(session), entry.getValue(), Long.parseLong(entry.getKey()),0);//保存消息记录
    	}
    }
    //发送聊天记录
    public void sendRecordMessage(Session session,Map<String,String> map){
    	if(map==null||session==null)return;
    	for(Entry<String,String> entry : map.entrySet()){
    		sendMessage(session, entry.getValue(), new Date(Long.parseLong(entry.getKey())), 3);
    	}
    }
    //保存聊天图片
    public void savePicture(byte[] picture,boolean bool){
    	File file = new File(properties.getProperty("chatPicture"),UUID.randomUUID().toString());
    	try {
			FileOutputStream out = new FileOutputStream(file);
			out.write(picture);
			out.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    public String getDir(String path,String filename){
    	File file = new File(path);
    	if(file.exists()){
    		file.mkdirs();
    	}
    	return path+"/"+filename;
    }
}
