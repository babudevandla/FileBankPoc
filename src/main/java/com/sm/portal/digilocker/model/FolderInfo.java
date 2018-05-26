package com.sm.portal.digilocker.model;

import java.io.Serializable;
import java.util.List;

public class FolderInfo  implements Serializable{

	
	private static final long serialVersionUID = 1L;
	private Integer userId;
	public String folderName;
	 public Integer folderId;
	 public String folderPath;
	 public Integer parentId;
	 public String origin;
	 public String folderNamePath;
	 public String folderStatus;
	 private String isThisFolderForRootFiles;
	 public List<FilesInfo> files;
	 public List<FolderInfo> childFolders;
	 
	public String getfName() {
		return folderName;
	}
	public void setfName(String fName) {
		this.folderName = fName;
	}
	public Integer getfId() {
		return folderId;
	}
	public void setfId(Integer fId) {
		this.folderId = fId;
	}
	public String getFolderPath() {
		return folderPath;
	}
	public void setFolderPath(String folderPath) {
		this.folderPath = folderPath;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public List<FilesInfo> getLocalFilesInfo() {
		return files;
	}
	public void setLocalFilesInfo(List<FilesInfo> localFilesInfo) {
		this.files = localFilesInfo;
	}
	public List<FolderInfo> getChildFolders() {
		return childFolders;
	}
	public void setChildFolders(List<FolderInfo> childFolders) {
		this.childFolders = childFolders;
	}
	public String getFolderNamePath() {
		return folderNamePath;
	}
	public void setFolderNamePath(String folderNamePath) {
		this.folderNamePath = folderNamePath;
	}
	public String getFolderStatus() {
		return folderStatus;
	}
	public void setFolderStatus(String folderStatus) {
		this.folderStatus = folderStatus;
	}
	public String getFolderName() {
		return folderName;
	}
	public void setFolderName(String folderName) {
		this.folderName = folderName;
	}
	public Integer getFolderId() {
		return folderId;
	}
	public void setFolderId(Integer folderId) {
		this.folderId = folderId;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public List<FilesInfo> getFiles() {
		return files;
	}
	public void setFiles(List<FilesInfo> files) {
		this.files = files;
	}
	public String getIsThisFolderForRootFiles() {
		return isThisFolderForRootFiles;
	}
	public void setIsThisFolderForRootFiles(String isThisFolderForRootFiles) {
		this.isThisFolderForRootFiles = isThisFolderForRootFiles;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	
	 
	 
}
