package com.sm.portal.filebank.bean;

public class FileBankCloudBean {

	private Integer id;
	private String content;
	private Integer pageNo;
	private String actionType;
	private String filePaths[];
	private String filesType;
	private String fileStatus;
	private String fileOrigin;
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getPageNo() {
		return pageNo;
	}
	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}
	public String getActionType() {
		return actionType;
	}
	public void setActionType(String actionType) {
		this.actionType = actionType;
	}
	public String[] getFilePaths() {
		return filePaths;
	}
	public void setFilePaths(String[] filePaths) {
		this.filePaths = filePaths;
	}
	public String getFilesType() {
		return filesType;
	}
	public void setFilesType(String filesType) {
		this.filesType = filesType;
	}
	public String getFileStatus() {
		return fileStatus;
	}
	public void setFileStatus(String fileStatus) {
		this.fileStatus = fileStatus;
	}
	public String getFileOrigin() {
		return fileOrigin;
	}
	public void setFileOrigin(String fileOrigin) {
		this.fileOrigin = fileOrigin;
	}
	
}
