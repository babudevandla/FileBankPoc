package com.sm.portal.digilocker.mongo.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.commons.lang3.StringUtils;
import org.bson.Document;
import org.bson.conversions.Bson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.google.gson.Gson;
import com.mongodb.client.AggregateIterable;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.FindOneAndUpdateOptions;
import com.mongodb.client.model.Projections;
import com.sm.portal.constants.CollectionsConstant;
import com.sm.portal.digilocker.model.DigiLockerEnum;
import com.sm.portal.digilocker.model.DigiLockerFileTypeEnum;
import com.sm.portal.digilocker.model.DigiLockerStatusEnum;
import com.sm.portal.digilocker.model.FilesInfo;
import com.sm.portal.digilocker.model.FolderInfo;
import com.sm.portal.digilocker.model.FolderInfoVo;
import com.sm.portal.digilocker.model.GalleryDetails;
import com.sm.portal.digilocker.model.GallerySearchVo;
import com.sm.portal.digilocker.model.MoveFilesAndFoldersBean;
import com.sm.portal.filters.ThreadLocalInfoContainer;
import com.sm.portal.mongo.MongoDBUtil;
import com.sm.portal.mongo.utils.FileBankAggregationPipeLine;




@Repository
public class DigiLockerMongoDao {

	private static final Logger logger = LoggerFactory.getLogger(DigiLockerMongoDao.class);
	
	@Autowired
	MongoDBUtil mongoDBUtil ;
	private Gson gson = new Gson();
	
	 private static final String FILE_PATTERN ="([^\\s]+(\\.(?i)(jpg|png|gif|bmp|pdf|xls))$)";
	 
	
	
	public void storeNewFolder(FolderInfo newFolderInfo, Integer folderId,Integer userId) {
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_FOLDER_LIST_COLL);
		
		Document folderDoc = new Document();
		folderDoc.put("userId", userId);
		folderDoc.put("folderId", newFolderInfo.getFolderId());
		folderDoc.put("folderName", newFolderInfo.getFolderName());
		folderDoc.put("parentId", newFolderInfo.getParentId());
		folderDoc.put("origin", newFolderInfo.getOrigin());
		folderDoc.put("folderPath", newFolderInfo.getFolderPath());
		folderDoc.put("folderNamePath", newFolderInfo.getFolderNamePath());
		folderDoc.put("folderStatus", newFolderInfo.getFolderStatus());
		folderDoc.put("isThisFolderForRootFiles", newFolderInfo.getIsThisFolderForRootFiles());
		Bson filter = Filters.and(Filters.eq("userId", userId),Filters.eq("folderId", newFolderInfo.getFolderId()));
		coll.findOneAndUpdate(filter,new Document("$set", folderDoc),new FindOneAndUpdateOptions().upsert(true)) ;
	}//storeNewFileOrFolderInfo2() closing
	
	
	public void storeNewFiles(FolderInfo newFolderInfo, Integer folderId,Integer userId) {
		
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_FILE_LIST_COLL);
		List<FilesInfo> newFileList =newFolderInfo.getFiles();
		List<Document> newFileDocList = new ArrayList();
		Document newFileDoc =null;
		for(FilesInfo file: newFileList) {
			newFileDoc =new Document();
			newFileDoc.put("userId", userId);
			newFileDoc.put("folderId", folderId);
			newFileDoc.put("fileId",file.getFileId() );
			newFileDoc.put("fileName",file.getFileName() );
			newFileDoc.put("dumy_filename",file.getDumy_filename() );
			newFileDoc.put("filePath",file.getFilePath() );
			newFileDoc.put("fileStatus", file.getFileStatus());
			newFileDoc.put("fileType", file.getFileType());
			newFileDoc.put("createddate",file.getCreateddate() );
			newFileDoc.put("statusAtGallery",file.getStatusAtGallery() );
			
			newFileDocList.add(newFileDoc);
		}//for closing
		
		coll.insertMany(newFileDocList);
	}//storeNewFiles() closing
	
	public List<FolderInfo> getRootFoldersList(Integer folderParentId) {
		List<FolderInfo> list= new ArrayList();
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_FOLDER_LIST_COLL);
		Integer userId=null;
		try{
			userId=(Integer) (ThreadLocalInfoContainer.INFO_CONTAINER.get()).get("USER_ID");
		}catch(Exception e){e.printStackTrace();}
		Bson filter =Filters.and( Filters.eq("userId", userId),  Filters.eq("parentId", folderParentId));
		MongoCursor<Document> cursor =coll.find(filter).iterator();
		Document rootFolderdoc = null;
		FolderInfo folder = null;
		while(cursor.hasNext()) {
			rootFolderdoc =cursor.next();
			folder =new FolderInfo();
			folder.setUserId(rootFolderdoc.getInteger("userId"));
			folder.setFolderId(rootFolderdoc.getInteger("folderId"));
			folder.setFolderName(rootFolderdoc.getString("folderName"));
			folder.setParentId(rootFolderdoc.getInteger("parentId"));
			folder.setOrigin(rootFolderdoc.getString("origin"));
			folder.setFolderPath(rootFolderdoc.getString("folderPath"));
			folder.setFolderNamePath(rootFolderdoc.getString("folderNamePath"));
			folder.setFolderStatus(rootFolderdoc.getString("folderStatus"));
			folder.setIsThisFolderForRootFiles(rootFolderdoc.getString("isThisFolderForRootFiles"));
			list.add(folder);
		}//while closing
		
		return list;
	}//getRootFoldersList() closings
	
	public FolderInfo getFolderInfoForRootFiles() {
		MongoCollection<Document> coll = null;
		Integer userId=null;
		try{
			userId=(Integer) (ThreadLocalInfoContainer.INFO_CONTAINER.get()).get("USER_ID");
		}catch(Exception e){e.printStackTrace();}
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_FOLDER_LIST_COLL);
		Bson filter =Filters.and( Filters.eq("userId", userId),  Filters.eq("isThisFolderForRootFiles", "YES"));
		MongoCursor<Document> cursor =coll.find(filter).iterator();
		
		Document rootFolderdoc = null;
		FolderInfo folder = null;
		while(cursor.hasNext()) {
			rootFolderdoc =cursor.next();
			folder =new FolderInfo();
			folder.setUserId(rootFolderdoc.getInteger("userId"));
			folder.setFolderId(rootFolderdoc.getInteger("folderId"));
			folder.setFolderName(rootFolderdoc.getString("folderName"));
			folder.setParentId(rootFolderdoc.getInteger("parentId"));
			folder.setOrigin(rootFolderdoc.getString("origin"));
			folder.setFolderPath(rootFolderdoc.getString("folderPath"));
			folder.setFolderNamePath(rootFolderdoc.getString("folderNamePath"));
			folder.setFolderStatus(rootFolderdoc.getString("folderStatus"));
			folder.setIsThisFolderForRootFiles(rootFolderdoc.getString("isThisFolderForRootFiles"));
		}//while closing
		
		return folder;
	}//getFolderInfoForRootFiles() closing

	public List<FolderInfo> getFolderInfo2(Long userId){
		
		List<FolderInfo> folderInfoList = new ArrayList<>();
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_FOLDER_LIST_COLL);
		
		Document lookupObject = new Document();
		lookupObject.append("from", CollectionsConstant.DIGILOCKER_FILE_LIST_COLL);
		lookupObject.append("localField", "userId");
		lookupObject.append("foreignField", "userId");
		lookupObject.append("as", "folders_files");
		
		String redActStr ="{\"$cond\":[{ \"$eq\": [ \"$folderId\", \"$folders_files.folderId\" ] }, \"$$KEEP\", \"$$PRUNE\"]}";
		System.out.println(Document.parse(redActStr));
		List<Bson> pipeline_Aggr =new ArrayList();
		pipeline_Aggr.add(new Document("$lookup", lookupObject));
		pipeline_Aggr.add(new Document("$unwind","$folders_files"));
		pipeline_Aggr.add(new Document("$redact",Document.parse(redActStr)));
		Bson projections = Projections.include("userId","folderId","folderName","folderPath","parentId","origin","folderNamePath","folderStatus","isThisFolderForRootFiles",
				"folders_files.fileId","folders_files.fileName","folders_files.folderId","folders_files.dumy_filename","folders_files.filePath","folders_files.fileStatus",
				"folders_files.fileType","folders_files.createddate","folders_files.statusAtGallery","folders_files.fileExtension");
		pipeline_Aggr.add(new Document("$project", projections));
		
		MongoCursor<Document> cursor =coll.aggregate(pipeline_Aggr).allowDiskUse(true).iterator();
		Document resDoc =null;
		Map<Integer, FolderInfo> folderMap = new HashMap<>();
		FolderInfo folder = null;
		FilesInfo file= null;
		List<FilesInfo> fileList = null;
		while(cursor.hasNext()) {
			resDoc =cursor.next();
			if(folderMap.get(resDoc.getInteger("folderId"))==null) {
				//create new folder and put in map
				folder =new FolderInfo();
				folder.setUserId(resDoc.getInteger("userId"));
				folder.setFolderId(resDoc.getInteger("folderId"));
				folder.setFolderName(resDoc.getString("folderName"));
				folder.setParentId(resDoc.getInteger("parentId"));
				folder.setOrigin(resDoc.getString("origin"));
				folder.setFolderPath(resDoc.getString("folderPath"));
				folder.setFolderNamePath(resDoc.getString("folderNamePath"));
				folder.setFolderStatus(resDoc.getString("folderStatus"));
				folder.setIsThisFolderForRootFiles(resDoc.getString("isThisFolderForRootFiles"));
				
				file =new FilesInfo();
				file.setFileId(resDoc.getInteger("folders_files.fileId"));
				file.setFileName(resDoc.getString("folders_files.fileName"));
				file.setDumy_filename(resDoc.getString("folders_files.dumy_filename"));
				file.setFilePath(resDoc.getString("folders_files.filePath"));
				file.setFileStatus(resDoc.getString("folders_files.fileStatus"));
				file.setFileType(resDoc.getString("folders_files.fileType"));
				file.setCreateddate(resDoc.getDate("folders_files.createddate"));
				file.setStatusAtGallery(resDoc.getString("folders_files.statusAtGallery"));
				file.setFileExtension(resDoc.getString("folders_files.fileExtension"));
				
				fileList =folder.getFiles();
				if(fileList==null)fileList=new ArrayList();
				fileList.add(file);
				
				folder.setFiles(fileList);;
				folderInfoList.add(folder);
				folderMap.put(folder.getFolderId(), folder);
			}else {
				folder =folderMap.get(resDoc.getInteger("folderId"));
				
				file =new FilesInfo();
				file.setFileId(resDoc.getInteger("folders_files.fileId"));
				file.setFileName(resDoc.getString("folders_files.fileName"));
				file.setDumy_filename(resDoc.getString("folders_files.dumy_filename"));
				file.setFilePath(resDoc.getString("folders_files.filePath"));
				file.setFileStatus(resDoc.getString("folders_files.fileStatus"));
				file.setFileType(resDoc.getString("folders_files.fileType"));
				file.setCreateddate(resDoc.getDate("folders_files.createddate"));
				file.setStatusAtGallery(resDoc.getString("folders_files.statusAtGallery"));
				file.setFileExtension(resDoc.getString("folders_files.fileExtension"));
				
				fileList =folder.getFiles();
				if(fileList==null)fileList=new ArrayList();
				
				fileList.add(file);				
				folder.setFiles(fileList);;
				folderInfoList.add(folder);
			}//else closing
			
			
		}//while closing
		
		return folderInfoList;
		
	}//getFolderInfo2() closing
	
	
	
	
	public List<FolderInfo> getAllFolders(){
		List<FolderInfo> folderInfoList = new ArrayList<>();
		
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_FOLDER_LIST_COLL);
		
		FolderInfo folder = null;
		
		MongoCursor<Document> cursor =coll.find().iterator();
		Document folderDoc = null;
		while(cursor.hasNext()) {
			folderDoc =cursor.next();
			folder =new FolderInfo();
			folder.setUserId(folderDoc.getInteger("userId"));
			folder.setFolderId(folderDoc.getInteger("folderId"));
			folder.setFolderName(folderDoc.getString("folderName"));
			folder.setParentId(folderDoc.getInteger("parentId"));
			folder.setOrigin(folderDoc.getString("origin"));
			folder.setFolderPath(folderDoc.getString("folderPath"));
			folder.setFolderNamePath(folderDoc.getString("folderNamePath"));
			folder.setFolderStatus(folderDoc.getString("folderStatus"));
			folder.setIsThisFolderForRootFiles(folderDoc.getString("isThisFolderForRootFiles"));
			folderInfoList.add(folder);
		}//whille closoing
		
		return folderInfoList;
		
	}//getAllFolders() closing
	
	public List<FilesInfo> getFileListOfFolder(Integer currentFolderId) {
		List<FilesInfo> fileList = new ArrayList();
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_FILE_LIST_COLL);
		Integer userId=null;
		try{
			userId=(Integer) (ThreadLocalInfoContainer.INFO_CONTAINER.get()).get("USER_ID");
		}catch(Exception e){e.printStackTrace();}
		Bson filter =Filters.and( Filters.eq("userId", userId),  Filters.eq("folderId", currentFolderId));
		MongoCursor<Document> cursor =coll.find(filter).iterator();
		Document filedoc =null;
		FilesInfo file=null;
		while(cursor.hasNext()) {
			filedoc =cursor.next();
			file =new FilesInfo();
			file.setFileId(filedoc.getInteger("fileId"));
			file.setFileName(filedoc.getString("fileName"));
			file.setDumy_filename(filedoc.getString("dumy_filename"));
			file.setFilePath(filedoc.getString("filePath"));
			file.setFileStatus(filedoc.getString("fileStatus"));
			file.setFileType(filedoc.getString("fileType"));
			file.setCreateddate(filedoc.getDate("createddate"));
			file.setStatusAtGallery(filedoc.getString("statusAtGallery"));
			file.setFileExtension(filedoc.getString("fileExtension"));
			
			fileList.add(file);
		}//while closing
		return fileList;
	}//getFileListOfFolder() closing


	
	public void moveFolderToAnothreFolder2(Integer sourceFolderId, Integer destinationFolderParentId) {
		Integer userId = (Integer) ThreadLocalInfoContainer.INFO_CONTAINER.get().get("USER_ID");
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_FOLDER_LIST_COLL);
		Bson filter = Filters.and(Filters.eq("userId", userId),Filters.eq("folderId", sourceFolderId));
		Document updatedDoc = new Document();
		updatedDoc.append("$set", new Document("parentId",destinationFolderParentId));
		coll.updateOne(filter, updatedDoc);
		
	}//moveFolderToAnothreFolder2() closing
	
    public void moveFileToAnotherFolder2(MoveFilesAndFoldersBean moveFilesAndFoldersBean) {
    	Integer userId = (Integer) ThreadLocalInfoContainer.INFO_CONTAINER.get().get("USER_ID");
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_FILE_LIST_COLL);
		//,Filters.eq("folderId", moveFilesAndFoldersBean.getSourceFolderId())
		Bson filter = Filters.and(Filters.eq("userId", userId),Filters.eq("fileId", moveFilesAndFoldersBean.getSourceFileId()) );
		Document updatedDoc = new Document();
		updatedDoc.append("$set", new Document("folderId",moveFilesAndFoldersBean.getDestinationFolderId()));
		coll.updateOne(filter, updatedDoc);
		
    }//moveFileToAnotherFolder2() closing
	
	
	public void updateFileOrFolderSatus(String deleteInfo, String action,Integer folderId,Integer fildId, Integer userId) {
		MongoCollection<Document> coll = null;
		Bson filter = null;
		Document updateFieldDoc =new Document();
		Document updateDoc =new Document();
		if(deleteInfo.equals("File")) {
			coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_FILE_LIST_COLL);
			filter = Filters.and(Filters.eq("userId", userId),Filters.eq("folderId", folderId), Filters.eq("fileId", fildId) );
			
			if(action.equals("Hide")){
				updateFieldDoc.put("fileStatus", DigiLockerStatusEnum.HIDDEN.toString());
			}else if(action.equals("Delete")){
				updateFieldDoc.put("fileStatus", DigiLockerStatusEnum.DELETED.toString());
			}
		}else {
			coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_FOLDER_LIST_COLL);
			filter = Filters.and(Filters.eq("userId", userId),Filters.eq("folderId", folderId));
			if(action.equals("Hide")){
				updateFieldDoc.put("folderStatus", DigiLockerStatusEnum.HIDDEN.toString());
			}else if(action.equals("Delete")){
				updateFieldDoc.put("folderStatus", DigiLockerStatusEnum.DELETED.toString());
			}
		}
		updateDoc.put("$set", updateFieldDoc);
		coll.updateMany(filter, updateDoc);
		
	}//updateFileOrFolderSatus() closing
	
	public void showHiddenFoldersAndFiles(Integer fid, Integer userId) {
		MongoCollection<Document> folderColl = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_FILE_LIST_COLL);
		MongoCollection<Document> fileColl = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_FILE_LIST_COLL);
		Bson filter = null;
		filter = Filters.and(Filters.eq("userId", userId),Filters.eq("folderId", fid));
		Document updateDoc_folder =new Document();
		
		updateDoc_folder.put("$set", new Document("folderStatus",DigiLockerStatusEnum.ACTIVE.toString()));
		folderColl.updateMany(filter, updateDoc_folder);
		Document updateDoc_file =new Document();
		updateDoc_file.put("$set", new Document("fileStatus",DigiLockerStatusEnum.ACTIVE.toString()));
		fileColl.updateMany(filter, updateDoc_file);
		
	}

	public List<GalleryDetails> getGallerContent(GallerySearchVo gallerySearchVo) throws ParseException {
		Integer userId =(Integer)ThreadLocalInfoContainer.INFO_CONTAINER.get().get("USER_ID");
		List<GalleryDetails> resultList =new ArrayList();
		List<FolderInfo> folderInfoList = new ArrayList<>();
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_FOLDER_LIST_COLL);
		
		Document matchFields =new Document("userId", userId);
		if(!StringUtils.isEmpty(gallerySearchVo.getFileOrigin()) && !gallerySearchVo.getFileOrigin().equals("ALL")) {
			matchFields.append("origin", gallerySearchVo.getFileOrigin());
		}
		/*Document match = new Document();
		match.append("$match",matchFields );*/
		
		String redActStr =null;
		/*if(gallerySearchVo.getFilesType()!=null && !gallerySearchVo.getFilesType().equals("ALL")) {
			if(gallerySearchVo.getFilesType().equals(DigiLockerFileTypeEnum.IMAGE.toString())) 
				redActStr ="{\"$cond\":[{ \"$eq\": [ 'IMAGE', \"$folders_files.fileType\" ] }, \"$$KEEP\", \"$$PRUNE\"]}";
			//System.out.println(Document.parse(redActStr));
		}*/
		Document lookupObject = new Document();
		lookupObject.append("from", CollectionsConstant.DIGILOCKER_FILE_LIST_COLL);
		lookupObject.append("localField", "folderId");
		lookupObject.append("foreignField", "folderId");
		lookupObject.append("as", "folders_files");
		
		
		List<Bson> pipeline_Aggr =new ArrayList();
		pipeline_Aggr.add(new Document("$match", matchFields));
		pipeline_Aggr.add(new Document("$lookup", lookupObject));
		pipeline_Aggr.add(new Document("$unwind","$folders_files"));
		//if(redActStr!=null)pipeline_Aggr.add(new Document("$redact",Document.parse(redActStr)));
		Bson projections = Projections.include("userId","folderId","folderName","folderPath","parentId","origin","folderNamePath","folderStatus","isThisFolderForRootFiles",
				"folders_files.fileId","folders_files.fileName","folders_files.folderId","folders_files.dumy_filename","folders_files.filePath","folders_files.fileStatus",
				"folders_files.fileType","folders_files.createddate","folders_files.statusAtGallery","folders_files.fileExtension");
		pipeline_Aggr.add(new Document("$project", projections));
		
		MongoCursor<Document> cursor =coll.aggregate(pipeline_Aggr).allowDiskUse(true).iterator();
		GalleryDetails galleryDetails=null;
		Document fileDoc=null;
		Document galleryDoc = null;
		while(cursor.hasNext()) {
			galleryDoc = cursor.next();
			galleryDetails = new GalleryDetails();
			galleryDetails.setFolderId(galleryDoc.getInteger("folderId"));
			galleryDetails.setFolderName(galleryDoc.getString("folderName"));
			galleryDetails.setParentId(galleryDoc.getInteger("parentId"));
			galleryDetails.setOrigin(galleryDoc.getString("origin"));
			galleryDetails.setFolderPath(galleryDoc.getString("folderPath"));
			galleryDetails.setFolderNamePath(galleryDoc.getString("folderNamePath"));
			galleryDetails.setFolderStatus(galleryDoc.getString("folderStatus"));
			
			fileDoc =(Document)galleryDoc.get("folders_files");
			galleryDetails.setFileId(fileDoc.getInteger("fileId"));
			galleryDetails.setFileName(fileDoc.getString("fileName"));
			galleryDetails.setDumy_filename(fileDoc.getString("dumy_filename"));
			galleryDetails.setFilePath(fileDoc.getString("filePath"));
			galleryDetails.setFileStatus(fileDoc.getString("fileStatus"));
			galleryDetails.setFileType(fileDoc.getString("fileType"));
			galleryDetails.setCreateddate(fileDoc.getDate("createddate"));
			galleryDetails.setStatusAtGallery(fileDoc.getString("statusAtGallery"));
			galleryDetails.setFileExtension(fileDoc.getString("fileExtension"));
			
			resultList.add(galleryDetails);
		}//while closing
		
		return resultList;
		
	}//getGallerContent() closing
	

	private GalleryDetails setDeletedFolderData(Document cur) {
		GalleryDetails details=new GalleryDetails();
		//folder details
		Document folderDoc = (Document) cur.get("foldersList");
		details.setFolderId(folderDoc.getInteger("folderId"));
		details.setFolderName(folderDoc.getString("folderName"));
		details.setFolderPath(folderDoc.getString("folderPath"));
		details.setFolderNamePath(folderDoc.getString("folderNamePath"));
		details.setFolderStatus(folderDoc.getString("folderStatus"));
		details.setOrigin(folderDoc.getString("origin"));
		details.setParentId(folderDoc.getInteger("parentId"));
		return details;
	}

	private GalleryDetails setGalleryDetailsData(Document cur) throws ParseException {
		GalleryDetails details=new GalleryDetails();
		//folder details
		Document folderDoc = (Document) cur.get("foldersList");
		details.setFolderId(folderDoc.getInteger("folderId"));
		details.setFolderName(folderDoc.getString("folderName"));
		details.setFolderPath(folderDoc.getString("folderPath"));
		details.setFolderNamePath(folderDoc.getString("folderNamePath"));
		details.setFolderStatus(folderDoc.getString("folderStatus"));
		details.setOrigin(folderDoc.getString("origin"));
		details.setParentId(folderDoc.getInteger("parentId"));
		
		Document fileDoc =(Document) folderDoc.get("files");
		// files details
		details.setFileId(fileDoc.getInteger("fileId"));
		details.setFileName(fileDoc.getString("fileName"));
		details.setDumy_filename(fileDoc.getString("dumy_filename"));
		details.setFilePath(fileDoc.getString("filePath"));
		details.setFileStatus(fileDoc.getString("fileStatus"));
		details.setFileType(fileDoc.getString("fileType"));
		SimpleDateFormat format=new SimpleDateFormat();
	//	details.setCreateddate(format.parse(fileDoc.getString("createddate")));
		details.setStatusAtGallery(fileDoc.getString("statusAtGallery"));
		details.setFileExtension(fileDoc.getString("fileExtension"));
		
		return details;
	}

	
		public FolderInfo getGalleryDetails(String origin) {
			Integer userId=(Integer) (ThreadLocalInfoContainer.INFO_CONTAINER.get()).get("USER_ID");
			FolderInfo gallerFolder = null;
			MongoCollection<Document> coll = null;
			coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_FOLDER_LIST_COLL);
			Bson filter = Filters.and(Filters.eq("userId", userId), Filters.eq("origin",origin));
			MongoCursor<Document> cursor =coll.find(filter).iterator();
			Document folderDoc = null;
			FolderInfo folder =null;
			while(cursor.hasNext()) {
				folderDoc =cursor.next();
				folder =new FolderInfo();
				folder.setUserId(folderDoc.getInteger("userId"));
				folder.setFolderId(folderDoc.getInteger("folderId"));
				folder.setFolderName(folderDoc.getString("folderName"));
				folder.setParentId(folderDoc.getInteger("parentId"));
				folder.setOrigin(folderDoc.getString("origin"));
				folder.setFolderPath(folderDoc.getString("folderPath"));
				folder.setFolderNamePath(folderDoc.getString("folderNamePath"));
				folder.setFolderStatus(folderDoc.getString("folderStatus"));
				folder.setIsThisFolderForRootFiles(folderDoc.getString("isThisFolderForRootFiles"));
				break;
			}//whille closing
			return folder;
		}//getGalleryDetails() closing
		
}//class closing
