package com.sm.portal.mongo.dao;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.bson.Document;
import org.bson.conversions.Bson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.FindOneAndUpdateOptions;
import com.sm.portal.constants.CollectionsConstant;
import com.sm.portal.digilocker.model.DigiLockerStatusEnum;
import com.sm.portal.ebook.enums.EbookChapterTypeEnum;
import com.sm.portal.ebook.enums.EbookStatusEnum;
import com.sm.portal.ebook.model.Ebook;
import com.sm.portal.edairy.model.DairyInfo;
import com.sm.portal.model.EDairyDto;
import com.sm.portal.model.FileManagementVO;
import com.sm.portal.model.Users;
import com.sm.portal.mongo.MongoDBUtil;

@Repository
public class EDairyMongoDao {

	private static final Logger logger = LoggerFactory.getLogger(EDairyMongoDao.class);
	
	@Autowired
	MongoDBUtil mongoDBUtil ;

	public void saveEDairyData(EDairyDto eDairyDto, Users user) {
		MongoCollection<Document>   collection =null;	
		try{
			collection = mongoDBUtil.getMongoCollection(CollectionsConstant.EDAIRY_MONGO_COLLECTION);
			logger.info(" initialized mongo with collection ::"+CollectionsConstant.EDAIRY_MONGO_COLLECTION);
			
			Document  document =new Document();
			document.put("user_id",user.getUserId());
			document.put("dairy_name",eDairyDto.getDairyname());
			document.put("created_date",eDairyDto.getDairyDate());
			document.put("content",eDairyDto.getDairy_content());
			document.put("status",eDairyDto.isStatus());
			
			Integer doc_id=generateAutoId();
			document.put("_id",doc_id);
			collection.insertOne(document);
			logger.info(" saved the data to the collection ");
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	public List<EDairyDto> getEDairyList(Integer userId) {
		MongoCollection<Document> coll = null;
		MongoCursor<Document> cursor = null;
		List<EDairyDto> list=new ArrayList<EDairyDto>();
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.EDAIRY_MONGO_COLLECTION);
		cursor = coll.find(Filters.and(Filters.eq("user_id",userId))).iterator();
		while(cursor.hasNext()){
			Document document = cursor.next();
			EDairyDto dairyDto=new EDairyDto();
			dairyDto.setDairyId(document.getInteger("_id"));		
			dairyDto.setDairyname(document.getString("dairy_name"));
			dairyDto.setDairyDate(document.getDate("created_date"));
			dairyDto.setStatus(document.getBoolean("status"));
			dairyDto.setDairy_content(document.getString("content"));
			list.add(dairyDto);
		}
		return list;
	}
	
	
	private Integer generateAutoId() {
		Integer commentId=0;
		MongoCollection<Document> coll = null;
		MongoCursor<Document> cursor = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.EDAIRY_MONGO_COLLECTION);
		cursor=coll.find().sort(new Document("_id",-1)).limit(1).iterator();;
		while(cursor.hasNext())  {
			Document document=cursor.next();
			commentId=document.getInteger("_id");
		}	
		if(commentId!=0){
			commentId=commentId+1;
		}else{
			commentId=1;
		}
		return commentId;
	}


	public EDairyDto getEDairyDataById(Integer dairyId) {
		MongoCollection<Document> coll = null;
		EDairyDto dairyDto=new EDairyDto();
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.EDAIRY_MONGO_COLLECTION);
		Document document = coll.find(Filters.and(Filters.eq("_id",dairyId))).first();
		if(document!=null){
			dairyDto.setDairyId(document.getInteger("_id"));		
			dairyDto.setDairyname(document.getString("dairy_name"));
			dairyDto.setDairyDate(document.getDate("created_date"));
			dairyDto.setStatus(document.getBoolean("status"));
			dairyDto.setDairy_content(document.getString("content"));
		}
		return dairyDto;
	}


	public void updateEDairyData(EDairyDto eDairyDto, Users user) {
		MongoCollection<Document>   collection =null;	
		try{
			collection = mongoDBUtil.getMongoCollection(CollectionsConstant.EDAIRY_MONGO_COLLECTION);
			logger.info(" initialized mongo with collection ::"+CollectionsConstant.EDAIRY_MONGO_COLLECTION);
			
			Document  update =new Document();
			update.put("$set", new Document("content",eDairyDto.getDairy_content()));
			Document filter=new Document("_id",eDairyDto.getDairyId());
			collection.updateOne(filter, update);
			logger.info(" update the data to the collection ");
		}catch(Exception e){
			e.printStackTrace();
		}
	}


	public void creatEdairy(DairyInfo dairyInfo) {

			MongoCollection<Document> coll = null;
			coll = mongoDBUtil.getMongoCollection(CollectionsConstant.EDAIRY_MONGO_USER_DAIRIES);
			Bson filter=Filters.and(Filters.eq("userId",dairyInfo.getUserId()));
			Document userDairyDoc =this.getUserDairiesDocument(dairyInfo,coll);
			coll.findOneAndUpdate(filter,new Document("$set", userDairyDoc),new FindOneAndUpdateOptions().upsert(true)) ;
			this.createEdairyInMongo(dairyInfo);
	}//creatEdairy() closing

	public void createEdairyInMongo(DairyInfo dairyInfo) {
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.EDAIRY);
		Bson filter=Filters.and(Filters.eq("userId",dairyInfo.getUserId()), Filters.eq("dairyId",dairyInfo.getDairyId()));
		
		Document edairyDoc = new Document();
		edairyDoc.put("userId", dairyInfo.getUserId());
		edairyDoc.put("year", dairyInfo.getYear());
		edairyDoc.put("dairyId", dairyInfo.getDairyId());
		edairyDoc.put("dairyName", dairyInfo.getDairyName());
		edairyDoc.put("coverImage", dairyInfo.getCoverImage());
		edairyDoc.put("lastModifiedDate", dairyInfo.getLastModifiedDate());
		//edairyDoc.put("pageSize", ebook.getPageSize());
		
		List<Document> edairyPageDocs = new ArrayList<>();
		
		Document edairyPageDoc =null;
		
		int currentYear=dairyInfo.getYear();
		/*int previousYear=currentYear-1;*/
		int nextYear=currentYear+1;
		
		 Date startDate = new GregorianCalendar(currentYear, Calendar.JANUARY, 1).getTime();
		
		 Date endDate = new GregorianCalendar(nextYear, Calendar.JANUARY, 1).getTime();
		 
		 Calendar calendar = new GregorianCalendar();
		 calendar.setTime(startDate);
		     
	    Calendar endCalendar = new GregorianCalendar();
	    endCalendar.setTime(endDate);
		int i=0;
	    while (calendar.before(endCalendar)) {
	        Date date = calendar.getTime();
	        edairyPageDoc =new Document();
	        edairyPageDoc.put("date", date);
	        edairyPageDoc.put("pageNo", ++i);
	        edairyPageDoc.put("pageName", "");
	        edairyPageDoc.put("content", "");
	        edairyPageDoc.put("pageStatus", DigiLockerStatusEnum.ACTIVE.toString());
	        edairyPageDoc.put("favouriteStatus", false);
	        
	        calendar.add(Calendar.DATE, 1);
	        edairyPageDocs.add(edairyPageDoc);
	        
	    }
	    
	   // edairyPageDocs.sort((p1, p2) -> p1.getDate("date").compareTo(p2.getDate("date")));
		edairyDoc.put("pages", edairyPageDocs);
		coll.findOneAndUpdate(filter,new Document("$set", edairyDoc),new FindOneAndUpdateOptions().upsert(true)) ;
		
	}//createEbook

	private Document getUserDairiesDocument(DairyInfo dairyInfo, MongoCollection<Document> coll) {
		Document userDairyDoc=null;
		List<Document> userDairyList =null;
		if(coll!=null){
			userDairyDoc =this.getUserDairyDocumentByUserId(dairyInfo.getUserId(), coll);
			if(userDairyDoc!=null){
				userDairyList =(List<Document>) userDairyDoc.get("daires");
			}
		}
		
		if(userDairyDoc==null){//if already not available createing first
			userDairyDoc=new Document();
			userDairyDoc.put("userId", dairyInfo.getUserId());
			userDairyDoc.put("daires", userDairyList);
			coll.findOneAndUpdate(Filters.eq("userId",dairyInfo.getUserId()),new Document("$set", userDairyDoc),new FindOneAndUpdateOptions().upsert(true));//creating first and getting then
			userDairyDoc =this.getUserDairyDocumentByUserId(dairyInfo.getUserId(), coll);
			if(userDairyDoc!=null){
				userDairyList =(List<Document>) userDairyDoc.get("books");
			}
		}
		
		if(userDairyList==null)userDairyList =new ArrayList<>();
		
		Document dairyDoc = new Document();
		
		dairyDoc.put("dairyId", dairyInfo.getDairyId());
		dairyDoc.put("year", dairyInfo.getYear());
		dairyDoc.put("name", dairyInfo.getDairyName());
		dairyDoc.put("createdDate", new Date());
		dairyDoc.put("status", EbookStatusEnum.ACTIVE.toString());
		dairyDoc.put("coverPage", dairyInfo.getCoverImage());
		userDairyList.add(dairyDoc);
		userDairyDoc.put("daires", userDairyList);
		return userDairyDoc;
		
	}//getUserDairiesDocument() closing
	
	private Document getUserDairyDocumentByUserId(Integer userId, MongoCollection<Document> coll) {
		Document userDairyDoc=null;
		MongoCursor<Document> cursor = null;
		if(coll==null){
			coll = mongoDBUtil.getMongoCollection(CollectionsConstant.EDAIRY_MONGO_USER_DAIRIES);
		}//if closing
		cursor =coll.find(Filters.eq("userId",userId)).iterator();
		
		while(cursor.hasNext()){
			userDairyDoc = cursor.next();
			 break;
			}
		return userDairyDoc;
	}//getUserBookDocumentByUserId() closing
}//class closing
