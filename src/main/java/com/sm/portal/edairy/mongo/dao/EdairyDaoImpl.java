package com.sm.portal.edairy.mongo.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.bson.Document;
import org.bson.conversions.Bson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.google.gson.Gson;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.FindOneAndUpdateOptions;
import com.sm.portal.constants.CollectionsConstant;
import com.sm.portal.digilocker.model.FilesInfo;
import com.sm.portal.digilocker.model.FolderInfo;
import com.sm.portal.digilocker.model.FolderInfoVo;
import com.sm.portal.edairy.model.Dairy;
import com.sm.portal.edairy.model.DairyInfo;
import com.sm.portal.edairy.model.DairyPage;
import com.sm.portal.edairy.model.UserDairies;
import com.sm.portal.model.EDairyDto;
import com.sm.portal.mongo.MongoDBUtil;

@Repository
public class EdairyDaoImpl implements EdairyDao{

	@Autowired
	private MongoDBUtil mongoDBUtil ;
	private Gson gson = new Gson();
	@SuppressWarnings("unchecked")
	@Override
	public UserDairies gerUserDairies(int userId) {
		UserDairies userDairies =null;
		
		MongoCollection<Document> coll = null;
		MongoCursor<Document> cursor = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.EDAIRY_MONGO_USER_DAIRIES);
		cursor = coll.find(Filters.and(Filters.eq("userId",userId))).iterator();
		List<Document> dairyDocList =null;
		List<Dairy> dairyList=new ArrayList<>();
		Dairy dairy =null;
		
		while(cursor.hasNext()){
			Document document = cursor.next();
			userDairies=new UserDairies();
			userDairies.setUserId(document.getInteger("userId"));

			dairyDocList=(List<Document>) document.get("daires");
			for(Document dairyDoc:dairyDocList){
				dairy =new Dairy();
				dairy.setDairyId(dairyDoc.getInteger("dairyId"));
				dairy.setName(dairyDoc.getString("name"));
				dairy.setCreatedDate(dairyDoc.getDate("createdDate"));
				dairy.setStatus(dairyDoc.getString("status"));
				dairyList.add(dairy);
			}
			userDairies.setDairyList(dairyList);
			
		}
		return userDairies;
		
	}//gerUserDairies() closing

	@SuppressWarnings({ "unchecked", "null" })
	@Override
	public DairyInfo getDairyInfo(int userId, int dairyId) {

		DairyInfo dairyInfo =null;
		MongoCollection<Document> coll = null;
		MongoCursor<Document> cursor = null;
		
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.EDAIRY);
		cursor = coll.find(Filters.and(Filters.eq("userId",userId), Filters.eq("dairyId",dairyId))).iterator();
		List<Document> pagesDocList =null;
		List<DairyPage> pageList=new ArrayList<>();
		DairyPage page =null;
		
		while(cursor.hasNext()){
			Document document = cursor.next();
			dairyInfo=new DairyInfo();
			dairyInfo.setUserId(document.getInteger("userId"));
			dairyInfo.setDairyId(document.getInteger("dairyId"));
			dairyInfo.setDairyName(document.getString("dairyName"));
			dairyInfo.setCoverImage(document.getString("coverImage"));
			dairyInfo.setLastModifiedDate(document.getDate("lastModifiedDate"));
			
			pagesDocList =(List<Document>) document.get("pages");
			
			for(Document pageDoc : pagesDocList){
				page =new DairyPage();
				page.setPageNo(pageDoc.getInteger("pageNo"));
				page.setPageName(pageDoc.getString("pageName"));
				page.setDate(pageDoc.getDate("date"));
				page.setContent(pageDoc.getString("content"));
				page.setPageStatus(pageDoc.getString("pageStatus"));
				pageList.add(page);
				
			}//for closing
			dairyInfo.setPages(pageList);
		}//while closing
		return dairyInfo;
	}//getDairyInfo() closing

	@Override
	public DairyInfo editPageContent(int userId, int dairyId, DairyPage page) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean  savePageContent(int userId, int dairyId, DairyPage dairyPage) {

		boolean isPageUpdated=false;
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.EDAIRY);
		//cursor = coll.find(Filters.and(Filters.eq("userId",userId), Filters.eq("dairyId",dairyId))).iterator();
		DairyInfo dairyInfoVo =this.getDairyInfo(userId, dairyId);
		Bson filter=Filters.and(Filters.eq("userId",userId), Filters.eq("dairyId",dairyId));
		Date lastModifiedDate = new Date();
		dairyInfoVo.setLastModifiedDate(lastModifiedDate);
		/*FindIterable<Document> DairyInfoVos=coll.find(filter);
		if(null != DairyInfoVos){
			for (Document cur :  DairyInfoVos ) {
				DairyInfo dairyInfoVo = gson.fromJson(cur.toJson(), DairyInfo.class);*/
				List<DairyPage> pagesList=dairyInfoVo.getPages();
				for(DairyPage page: pagesList){
					if(page.getPageNo()==dairyPage.getPageNo()){
						page.setContent(dairyPage.getContent());
						isPageUpdated=true;
						break;
					}
					
				}//for closing
				Document dairyInfoVoDoc =this.getEdairyDocument(dairyInfoVo);
				/*String dairyInfoVoJson = gson.toJson(dairyInfoVo);
				Document dairyInfoVoJsonDoc = Document.parse(dairyInfoVoJson);*/
				coll.findOneAndUpdate(filter,new Document("$set", dairyInfoVoDoc),new FindOneAndUpdateOptions().upsert(true)) ;
				
			//}//outer for closing
		//}
		return isPageUpdated;
	}//savePageContent() closing

	private Document getEdairyDocument(DairyInfo dairyInfoVo) {
		Document dairyInfoVoDoc =new Document();
		Document pageDoc = null;
		List<Document> pageDocList = new ArrayList<>();
		
		dairyInfoVoDoc.put("userId", dairyInfoVo.getUserId());
		dairyInfoVoDoc.put("dairyId",dairyInfoVo.getDairyId());
		dairyInfoVoDoc.put("dairyName", dairyInfoVo.getDairyName());
		dairyInfoVoDoc.put("coverImage", dairyInfoVo.getCoverImage());
		dairyInfoVoDoc.put("lastModifiedDate", dairyInfoVo.getLastModifiedDate());
		List<DairyPage> pageVoList = dairyInfoVo.getPages();
		if(pageVoList!=null && pageVoList.size()>0){
			for(DairyPage page:pageVoList){
				pageDoc =new Document();
				pageDoc.put("pageNo", page.getPageNo());
				pageDoc.put("pageName", page.getPageName());
				pageDoc.put("content", page.getContent());
				pageDoc.put("pageStatus", page.getPageStatus());
				pageDocList.add(pageDoc);
			}//for closing
		}//if closing
		dairyInfoVoDoc.put("pages", pageDocList);
		return dairyInfoVoDoc;
	}//getEdairyDocument() closing
	
	
	
	
}//class closing
