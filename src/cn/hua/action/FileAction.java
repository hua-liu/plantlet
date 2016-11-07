package cn.hua.action;

import cn.hua.model.BreviaryPicture;
import cn.hua.model.Explain;
import cn.hua.model.Goods;
import cn.hua.model.GoodsPicture;
import cn.hua.service.Service;
import cn.hua.utils.Conversion;
import cn.hua.utils.FileOperation;
import com.opensymphony.xwork2.ActionSupport;

import java.io.*;
import java.util.UUID;

public class FileAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private File file;
	private String fileFileName;
	private String fileContentType;
	private String message;
	private Service service;
	private String id;
	private ByteArrayInputStream inputStream;
	private File[] htmlfile;
	private String[] htmlfileFileName;
	private String[] htmlfileContentType;
	private int isBreviary;
	private String sourcePicId;
	public void setSourcePicId(String sourcePicId) {
		this.sourcePicId = sourcePicId;
	}

	public void setIsBreviary(int isBreviary) {
		this.isBreviary = isBreviary;
	}

	public File[] getHtmlfile() {
		return htmlfile;
	}

	public void setHtmlfile(File[] htmlfile) {
		this.htmlfile = htmlfile;
	}

	public String[] getHtmlfileFileName() {
		return htmlfileFileName;
	}

	public void setHtmlfileFileName(String[] htmlfileFileName) {
		this.htmlfileFileName = htmlfileFileName;
	}

	public String[] getHtmlfileContentType() {
		return htmlfileContentType;
	}

	public void setHtmlfileContentType(String[] htmlfileContentType) {
		this.htmlfileContentType = htmlfileContentType;
	}

	public ByteArrayInputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(ByteArrayInputStream inputStream) {
		this.inputStream = inputStream;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setService(Service service) {
		this.service = service;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public String downloadImg() {

		return SUCCESS;
	}
	//上传聊天时的图片
	public String uploadChatPic(){
		String path = "";
		try {
			String[] fileSuffix = new String[] { ".jpg", ".gif", ".png" };
			boolean isPass = false;
			for (String fileSuffixName : fileSuffix) {
				if (fileFileName.endsWith(fileSuffixName)) {
					isPass = true;
					break;
				}
			}
			if (!isPass) {
				message = Conversion.stringToJson("message,false,cause,上传非法格式文件");
				return SUCCESS;
			}
			String uuid = UUID.randomUUID().toString();
			FileInputStream inputStream = new FileInputStream(file);
			path = "D:/DATA/SKJS/message/picture/" + uuid;
			FileOutputStream outputStream = new FileOutputStream(path);
			byte[] buf = new byte[1024];
			int length = 0;
			while ((length = inputStream.read(buf)) != -1) {
				outputStream.write(buf, 0, length);
			}
			inputStream.close();
			// outputStream.flush();
			outputStream.close();
			this.message = Conversion.stringToJson("message,true,id,"+uuid);
		} catch (Exception e) {
			e.printStackTrace();
			new FileOperation(path).start(); // 启用线程删除文件
			message = Conversion.stringToJson("message,false,cause,文件系统出错");
			return SUCCESS;
		}
		
		return SUCCESS;
	}
	//下载聊天时的图片
	public String downloadChatPic() {
		try {
			if (id != null) {
				String path = "D:/DATA/SKJS/message/picture/"+id;
				ByteArrayOutputStream bos = new ByteArrayOutputStream();
				InputStream input = new BufferedInputStream(
						new FileInputStream(path));
				byte[] bt = new byte[1024];
				while (input.read(bt) > 0) {
					bos.write(bt);
				}
				this.inputStream = new ByteArrayInputStream(bos.toByteArray());
				bos.close();
				input.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "download";
	}

	// 上传
	public String upload() throws Exception {
		if (id == null) {
			message = Conversion.stringToJson("cause,没有获取到商品基本信息");
			return SUCCESS;
		}
		Goods goods = service.findGoodsById(id);
		if (goods == null) {
			message = Conversion.stringToJson("cause,没有获取到商品基本信息");
			return SUCCESS;
		}
		String path = "";
		try {
			String[] fileSuffix = new String[] { ".jpg", ".gif", ".png" };
			boolean isPass = false;
			for (String fileSuffixName : fileSuffix) {
				if (fileFileName.endsWith(fileSuffixName)) {
					isPass = true;
					break;
				}
			}
			if (!isPass) {
				message = Conversion.stringToJson("cause,上传非法格式文件");
				return SUCCESS;
			}
			FileInputStream inputStream = new FileInputStream(file);
			path = getDir("D:/DATA/SKJS/photo", null) + "/" + UUID.randomUUID();
			FileOutputStream outputStream = new FileOutputStream(path);
			byte[] buf = new byte[1024];
			int length = 0;
			while ((length = inputStream.read(buf)) != -1) {
				outputStream.write(buf, 0, length);
			}
			inputStream.close();
			// outputStream.flush();
			outputStream.close();
		} catch (Exception e) {
			e.printStackTrace();
			message = Conversion.stringToJson("cause,文件系统出错");
			return SUCCESS;
		}
		try {
			if (isBreviary == 1) {
				String breviaryPictureId = null;
				if (goods.getBreviaryPicture() != null) {
					breviaryPictureId = goods.getBreviaryPicture().getId();
					new FileOperation(goods.getBreviaryPicture().getPath())
							.start(); // 启用线程删除文件
					/*
					 * service.deleteGoodsPicture(goods.getGoodsId(),
					 * goods.getBreviaryPicture().getId());
					 */
				}
				goods.setBreviaryPicture(new BreviaryPicture(null,path));
				service.updateGoods(goods);
				if(breviaryPictureId!=null){
					service.deleteGoodsBreviaryPicture(breviaryPictureId);
				}
				this.message = Conversion.stringToJson("message,true,id,"
						+ goods.getBreviaryPicture().getId());
			} else {
				if (sourcePicId != null) {
					GoodsPicture goodsPic = service
							.getGoodsPicture(sourcePicId);
					if (goodsPic != null) {
						service.deleteGoodsPicture(goods.getGoodsId(),
								goodsPic.getId());
						new FileOperation(goodsPic.getPath())
								.start();
					}
				}
				GoodsPicture goodsPicture = new GoodsPicture(path, goods);
				service.SaveGoodsPicture(goodsPicture);
				this.message = Conversion.stringToJson("message,true,id,"
						+ goodsPicture.getId());
			}
		} catch (Exception e) {
			e.printStackTrace();
			new FileOperation(path).start(); // 启用线程删除文件
			message = Conversion.stringToJson("cause,服务器异常");
			return SUCCESS;

		}
		return SUCCESS;
	}

	public String download() {
		try {
			if (id != null) {
				String path = "";
				if (isBreviary == 1) {
					BreviaryPicture breviaryPicture = service
							.getGoodsBreviaryPicture(id);
					if (breviaryPicture != null) {
						path = breviaryPicture.getPath();
					}
				} else {
					GoodsPicture goodsPicture = service.getGoodsPicture(id);
					if (goodsPicture != null) {
						path = goodsPicture.getPath();
					}
				}
				ByteArrayOutputStream bos = new ByteArrayOutputStream();
				InputStream input = new BufferedInputStream(
						new FileInputStream(path));
				byte[] bt = new byte[1024];
				while (input.read(bt) > 0) {
					bos.write(bt);
				}
				this.inputStream = new ByteArrayInputStream(bos.toByteArray());
				bos.close();
				input.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "download";
	}

	// 上传多个文件
	public String uploadHtml() {
		if (id == null) {
			message = Conversion.stringToJson("cause,没有获取到商品基本信息");
			return SUCCESS;
		}
		Goods goods = service.findGoodsById(id);
		if (goods == null) {
			message = Conversion.stringToJson("cause,没有获取到商品基本信息");
			return SUCCESS;
		}
		if (htmlfile != null) {
			String[] fileSuffix = new String[] { ".jpg", ".gif", ".png",
					".css",".html" };
			for (String htmlfileName : htmlfileFileName) {
				boolean isPass = false;
				for (String fileSuffixName : fileSuffix) {
					if (htmlfileName.endsWith(fileSuffixName)) {
						isPass = true;
						break;
					}
				}
				if (!isPass) {
					message = Conversion.stringToJson("cause,上传非法格式文件");
					return SUCCESS;
				}
			}
			// 如果没有目录建立目录
			String filePath = getDir("D:/DATA/SKJS/html", "uuid") + "/";
			try {
				InputStream inputStream = null;
				OutputStream outputStream = null;
				for (int i = 0; i < htmlfile.length; i++) {
					inputStream = new FileInputStream(htmlfile[i]);
					outputStream = new FileOutputStream(filePath
							+ htmlfileFileName[i]);
					byte buffer[] = new byte[1024];
					int count = 0;
					while ((count = inputStream.read(buffer)) > 0) {
						outputStream.write(buffer, 0, count);
					}
					outputStream.flush();
					if (outputStream != null)
						outputStream.close();
					if (inputStream != null)
						inputStream.close();
				}
				// 此处htmlfile是服务器映射的地址
				filePath = filePath.replace("D:/DATA/SKJS/html", "htmlfile")
						+ "index.html";
				Explain explain = new Explain(filePath);
				service.saveGoodsExplain(explain);
				goods.setExplain(explain);
				service.updateGoods(goods);
				this.message = Conversion.stringToJson("message,true,path,"
						+ filePath + ",id," + explain.getId());
			} catch (Exception e) {
				e.printStackTrace();
				new FileOperation(filePath).start(); // 启用线程删除文件
				this.message = Conversion.stringToJson("cause,服务器异常");
			}
		}
		return SUCCESS;
	}

	public String getDir(String path, String uuid) {
		Long currentTime = System.currentTimeMillis();
		int hashcode = currentTime.hashCode();
		int dir1 = hashcode & 0xf;
		int dir2 = (hashcode >> 4) & 0xf;
		String finalPath;
		if (uuid != null)
			finalPath = path + "/" + dir1 + "/" + dir2 + "/"
					+ UUID.randomUUID();
		else
			finalPath = path + "/" + dir1 + "/" + dir2;
		File file = new File(finalPath);
		if (!file.exists()) {
			file.mkdirs();
		}
		return finalPath;
	}
}
