package cn.hua.utils;

import java.io.File;

public class FileOperation extends Thread{
	private String path;
	public FileOperation(String path){
		this.path= path;
	}
	
	@Override
	public void run(){
		if(path.equals(""))return;
		deleteFile(path,"noCheck");
		path = path.substring(0,path.lastIndexOf("/"));
		deleteFile(path,"check");
		path = path.substring(0,path.lastIndexOf("/"));
		deleteFile(path,"check");
	}
	public void deleteFile(String path,String type){
		File file = new File(path);
		if(file.exists()){
			if(file.isDirectory()){
				if(type.equals("check")){
					if(file.listFiles().length>0){
						return;
					}
				}else if(file.listFiles().length>0){
					for(File f : file.listFiles()){
						f.delete();
					}
				}
			}
			file.delete();
		}
	}
}
