package com.sm.portal.digilocker.model;

import java.io.Serializable;
import java.util.Date;

public class FilesInfo implements Serializable {

	 private static final long serialVersionUID = 1L;
	 public Integer fileId;
	 private Integer folderId;
	 public String fileName;
	 private String dumy_filename;
	 public String filePath;
	 public String fileStatus;
	 private String fileType;
	 private Date createddate;
	 private Date updateddate;
	 private String statusAtGallery;
	 private Boolean favoritePage;
	 private String fileExtension;
	 
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileStatus() {
		return fileStatus;
	}
	public void setFileStatus(String fileStatus) {
		this.fileStatus = fileStatus;
	}
	public Integer getFileId() {
		return fileId;
	}
	public void setFileId(Integer fileId) {
		this.fileId = fileId;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public Date getCreateddate() {
		return createddate;
	}
	public void setCreateddate(Date createddate) {
		this.createddate = createddate;
	}
	public Date getUpdateddate() {
		return updateddate;
	}
	public void setUpdateddate(Date updateddate) {
		this.updateddate = updateddate;
	}
	public String getDumy_filename() {
		return dumy_filename;
	}
	public void setDumy_filename(String dumy_filename) {
		this.dumy_filename = dumy_filename;
	}
	public String getStatusAtGallery() {
		return statusAtGallery;
	}
	public void setStatusAtGallery(String statusAtGallery) {
		this.statusAtGallery = statusAtGallery;
	}
	public Boolean getFavoritePage() {
		return favoritePage;
	}
	public void setFavoritePage(Boolean favoritePage) {
		this.favoritePage = favoritePage;
	}
	public String getFileExtension() {
		return fileExtension;
	}
	public void setFileExtension(String fileExtension) {
		this.fileExtension = fileExtension;
	}
	public Integer getFolderId() {
		return folderId;
	}
	public void setFolderId(Integer folderId) {
		this.folderId = folderId;
	}
	
}