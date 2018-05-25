package com.sm.portal.edairy.model;

import java.util.Date;

public class DairyPage {

	private int pageNo;
	private String pageName;
	private Date date;
	private String content;
	private String pageStatus;
	private boolean favouriteStatus;
	
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public String getPageName() {
		return pageName;
	}
	public void setPageName(String pageName) {
		this.pageName = pageName;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPageStatus() {
		return pageStatus;
	}
	public void setPageStatus(String pageStatus) {
		this.pageStatus = pageStatus;
	}
	public boolean isFavouriteStatus() {
		return favouriteStatus;
	}
	public void setFavouriteStatus(boolean favouriteStatus) {
		this.favouriteStatus = favouriteStatus;
	}
	
	
	
}
