package cn.hua.utils;

import java.io.EOFException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import cn.hua.model.Log;

public class Logging {
	private static Properties properties = new Properties();
	static{
		try {
			properties.load(Logging.class.getClassLoader().getResourceAsStream("path.properties"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static void save(String type,Log log){
		String path = properties.getProperty("logging");
		if(path==null){
			path="D:/DATA/SKJS/log";
		}
		File dir = new File(path+"/"+type);
		if(!dir.exists()){
			dir.mkdirs();
		}
		try {
			boolean bool=false;
			File file = new File(dir,log.getUserID());
			if(file.exists()){
				bool=true;
			}
			FileOutputStream out = new FileOutputStream(file,true);
			ObjectOutputStream oos = new ObjectOutputStream(out);
			if(bool){	//如果文件存在，则向文件追加，去除头4个字节
				long pos = out.getChannel().position()-4;
				out.getChannel().truncate(pos);
			}
			oos.writeObject(log);
			oos.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static List<Log> read(String type,String userID){
		String path = properties.getProperty("logging");
		ObjectInputStream ois=null;
		List<Log> list=null;
		if(path==null){return null;}
		try {
			File file = new File(path+"/"+type,userID);
			if(!file.exists())return null;
			FileInputStream in = new FileInputStream(file);
			ois = new ObjectInputStream(in);
			while(in.available()>0){//判断是否有效,循环读取
				if(list==null){
					list = new ArrayList<Log>();
				}
				try{
					list.add((Log)ois.readObject());
				}catch(EOFException  e){
					e.printStackTrace();
					break;
				}
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			System.out.println("日志读取完成");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			if(ois!=null)
				try {
					ois.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
		return list;
	}
}
