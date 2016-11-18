package cn.hua.utils;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

import cn.hua.model.Message;

public class MessageOperation {
	private static Properties properties = new Properties();
	static{
		try {
			properties.load(MessageOperation.class.getClassLoader().getResourceAsStream("path.properties"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void sendFirstMessage(Message message){
		save(message);
	}
	//获取消息
    public static List<Message> read(String receiveID){
    	String path = properties.getProperty("myMessage");
		if(path==null){
			path="D:/DATA/SKJS/myMessage";
		}
		File file = new File(path+"/"+receiveID+".xml");
		if(!file.exists()){
			return null;
		}
    	SAXReader reader = new SAXReader();
    	List<Message> messages = null;
    	Document doc;
		try {
			doc = reader.read(file);
			if(doc==null)return null;
			List<Element> list = doc.getRootElement().elements("message");
			for(Element e: list){
				if(messages==null)messages=new ArrayList<Message>();
				Message message = new Message();
				message.setId(e.elementText("id"));
				message.setIsNew(Integer.parseInt(e.attributeValue("isNew")));
				message.setSendDate(new Date(Long.parseLong(e.elementText("send-date"))));
				message.setReceiveID(e.elementText("receive-id"));
				message.setSendID(e.elementText("send-id"));
				message.setSendName(e.elementText("send-name"));
				message.setContent(e.elementText("content"));
				messages.add(message);
			}
			if(messages!=null)
			Collections.sort(messages);
			return messages;
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
    }
	//保存消息
    public static boolean save(Message message){
    	String path = properties.getProperty("myMessage");
		if(path==null){
			path="D:/DATA/SKJS/myMessage";
		}
		File dir = new File(path);
		if(!dir.exists()){
			dir.mkdirs();
		}
    	SAXReader reader = new SAXReader();
    	Document doc = null;
    	Element root=null;
    	File file = new File(path+"/"+message.getReceiveID()+".xml");
    	if(!file.exists()){
    		doc = DocumentHelper.createDocument();
    		root = doc.addElement("messages");
    	}
    	if(doc==null){
    		try {
				doc = reader.read(file);
			} catch (DocumentException e) {
				return false;
			}
    	}
    	if(root==null)
		root = doc.getRootElement();
    	try{
			Element mes = root.addElement("message").addAttribute("isNew", "1");
			mes.addElement("id").setText(message.getId());
			mes.addElement("send-date").setText(System.currentTimeMillis()+"");
			mes.addElement("receive-id").setText(message.getReceiveID());
			mes.addElement("send-id").setText(message.getSendID());
			mes.addElement("send-name").setText(message.getSendName());
			mes.addElement("content").setText(message.getContent());
    	}catch(Exception e){
    		e.printStackTrace();
    	}
		return saveXml(doc,file);
    }
	//保存文件
    public static boolean saveXml(Document doc,File file){
		 OutputFormat outputFormat = OutputFormat.createPrettyPrint();  
	     outputFormat.setLineSeparator("\r\n");//这是为了换行操作  
		try {
			Writer writer = new FileWriter(file);
			XMLWriter output = new XMLWriter(writer,outputFormat);  
			output.write(doc);
			output.close();
			return true;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
    }
    //已读设置
	public static void readed(String receiveID,String[] ids) {
		String path = properties.getProperty("myMessage");
		if(path==null){
			path="D:/DATA/SKJS/myMessage";
		}
		File file = new File(path+"/"+receiveID+".xml");
		if(!file.exists()){
			return;
		}
		int signNum=0;//计算标记数量
    	SAXReader reader = new SAXReader();
    	Document doc;
		try {
			doc = reader.read(file);
			if(doc==null)return;
			List<Element> list = doc.getRootElement().elements("message");
			for(Element e: list){
				for(String id : ids){
					if(id.equals(e.elementText("id"))){
						e.remove(e.attribute("isNew"));
						e.addAttribute("isNew", "0");
						signNum++;
						break;
					}
				}
				if(signNum>=ids.length){
					break;
				}
			}
			saveXml(doc, file);
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static boolean delete(String receiveID, String[] ids) {
		String path = properties.getProperty("myMessage");
		if(path==null){
			path="D:/DATA/SKJS/myMessage";
		}
		File file = new File(path+"/"+receiveID+".xml");
		if(!file.exists()){
			return false;
		}
		int deleteNum=0;//计算删除数量
    	SAXReader reader = new SAXReader();
    	Document doc;
		try {
			doc = reader.read(file);
			if(doc==null)return false;
			List<Element> list = doc.getRootElement().elements("message");
			for(Element e: list){
				for(String id:ids){
					if(id.equals(e.elementText("id"))){
						doc.getRootElement().remove(e);
						deleteNum++;
						break;
					}
				}
				if(deleteNum>=ids.length){
					break;
				}
			}
			if(saveXml(doc, file))
			return true;
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	public static boolean readNew(String id) {
		String path = properties.getProperty("myMessage");
		if(path==null){
			path="D:/DATA/SKJS/myMessage";
		}
		File file = new File(path+"/"+id+".xml");
		if(!file.exists()){
			return false;
		}
    	SAXReader reader = new SAXReader();
    	Document doc;
		try {
			doc = reader.read(file);
			if(doc==null)return false;
			List<Element> list = doc.getRootElement().elements("message");
			for(Element e: list){
				if("1".equals(e.attributeValue("isNew"))){
					return true;
				}
			}
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
}
