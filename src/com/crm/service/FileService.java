package com.crm.service;

import org.springframework.web.multipart.MultipartFile;

public interface FileService {
	/**
	 * 上传图片
	 * @param upload
	 */
	String upLoadFile(MultipartFile  add_Img);
}
