package com.sm.portal.edairy.service;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.portal.constants.WebDavServerConstant;
import com.sm.portal.edairy.model.DairyInfo;
import com.sm.portal.edairy.model.DairyPage;
import com.sm.portal.edairy.model.EdairyActionEnum;
import com.sm.portal.edairy.model.UserDairies;
import com.sm.portal.edairy.mongo.dao.EdairyDao;


@Service
public class EdairyServiceImpl implements EdairyService{

	@Autowired
	private EdairyDao edairyDaoImpl;
	
	@Override
	public UserDairies gerUserDairies(int userId) {
		return edairyDaoImpl.gerUserDairies(userId);
	}

	@Override
	public DairyInfo getDairyInfo(int userId, int dairyId, String actionBy, Integer defaultPageNo) {
		DairyInfo dairyInfo =edairyDaoImpl.getDairyInfo(userId, dairyId);
		List<DairyPage> pagesList =null;
		DairyPage defaultPage = null;
		if(dairyInfo!=null)pagesList =dairyInfo.getPages();
		if(defaultPageNo!=null){
			if(pagesList !=null && actionBy!=null){
				if(actionBy.equals(EdairyActionEnum.TODAYS_PAGE.toString())){
					defaultPage =pagesList.stream().filter(p->p.getDate().equals(new Date())).findFirst().orElse(new DairyPage());
				}else if(actionBy.equals(EdairyActionEnum.LAST_UPDATD_DATE.toString())){
					defaultPage =pagesList.stream().filter(p->p.getDate().equals(dairyInfo.getLastModifiedDate())).findFirst().orElse(new DairyPage());
				}else if(actionBy.equals(EdairyActionEnum.SELECTED_DATE.toString())){
					defaultPage =pagesList.stream().filter(p->p.getPageNo()==defaultPageNo).findFirst().orElse(new DairyPage());
				}else if(actionBy.equals(EdairyActionEnum.FAVORITE_PAGE.toString())){
					defaultPage =pagesList.stream().filter(p->p.getPageNo()==defaultPageNo).findFirst().orElse(new DairyPage());
				}else if(actionBy.equals(EdairyActionEnum.TITLE_PAGE.toString())){
					defaultPage =pagesList.stream().filter(p->p.getPageNo()==defaultPageNo).findFirst().orElse(new DairyPage());
				}else if(actionBy.equals(EdairyActionEnum.EDIT_PAGE.toString())){
					defaultPage =pagesList.stream().filter(p->p.getPageNo()==defaultPageNo).findFirst().orElse(new DairyPage());
				}else if(actionBy.equals(EdairyActionEnum.VIEW_PAGE.toString())){
					defaultPage =pagesList.stream().filter(p->p.getPageNo()==defaultPageNo).findFirst().orElse(new DairyPage());
				}else{
					defaultPage =pagesList.stream().filter(p->p.getPageNo()==defaultPageNo).findFirst().orElse(new DairyPage());
				}
				dairyInfo.setDefaultPage(defaultPage);
			}//if closing
		}
		return dairyInfo;
	}//getDairyInfo() closing

	@Override
	public DairyInfo editPageContent(int userId, int dairyId, DairyPage dairyPage) {
		return edairyDaoImpl.editPageContent(userId, dairyId, dairyPage);
	}

	@Override
	public boolean savePageContent(int userId, int dairyId, DairyPage dairyPage) {

		boolean result =edairyDaoImpl.savePageContent(userId, dairyId, dairyPage);
		return result;
		//if(result)
			//return edairyDaoImpl.editPageContent(userId, dairyId, dairyPage);
	}

	public String getContentAfterFileUpload(String pagecontent, List<String> fileUrlList) {
		String updatedImageString =null;
		List<String> updatedImageList =new ArrayList<String>();
		if(pagecontent!=null && fileUrlList.size()>0 ){
			for(int i=0;i<fileUrlList.size();i++){
			 updatedImageString =this.getUpdatedUrlWithHtmlTag( fileUrlList.get(i));
			 updatedImageList.add(updatedImageString);
			}
			System.out.println(updatedImageList.toString());
			String updatedPageContent = pagecontent+updatedImageList;
			return updatedPageContent;
			
		}else{
			return pagecontent;
		}
		
	}//getContentAfterFileUpload() closing

	private String getUpdatedUrlWithHtmlTag(String raw_url) {
		String updatedUrlWithHtmlTag=null;
		
		if(raw_url.endsWith(".jpg") || raw_url.endsWith(".jpeg") || raw_url.endsWith(".png"))
			updatedUrlWithHtmlTag= MessageFormat.format(WebDavServerConstant.HTML_IMAGE_TAG,raw_url);
		else if(raw_url.endsWith(".mp4"))
			updatedUrlWithHtmlTag= MessageFormat.format(WebDavServerConstant.HTML_VIDEO_TAG,raw_url);
		else if(raw_url.endsWith(".mp3"))
			updatedUrlWithHtmlTag= MessageFormat.format(WebDavServerConstant.HTML_AUDIO_TAG,raw_url);
		return updatedUrlWithHtmlTag;
	}

	public List<String> getAbsoluteUrls(List<String> fileUrlList) {
		List<String> updatedList  =null;
		if(fileUrlList!=null && fileUrlList.size()>0){
			updatedList =new ArrayList();
			for(String url: fileUrlList) {
				url =WebDavServerConstant.WEBDAV_SERVER_URL+url;
				updatedList.add(url);
			}//for closing
		}//if closing
		return updatedList;
	}//getAbsoluteUrls() closing

	public void updateFavouritePage(Integer dairyId, Integer pageNo, boolean favourate, Integer userId) {
		edairyDaoImpl.updateFavouritePage(dairyId,pageNo,favourate,userId);
	}

	public DairyInfo getFavourateDairyInfo(Integer userId, Integer dairyId, boolean favourate, Integer defaultPageNo) {
		return edairyDaoImpl.getFavourateDairyInfo(userId,dairyId,favourate,defaultPageNo);
	}
}//class closing
