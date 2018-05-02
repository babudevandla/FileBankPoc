package com.sm.portal.digilocker.mongo.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

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
import com.sm.portal.constants.CollectionsConstant;
import com.sm.portal.digilocker.model.DigiLockerEnum;
import com.sm.portal.digilocker.model.DigiLockerStatusEnum;
import com.sm.portal.digilocker.model.FilesInfo;
import com.sm.portal.digilocker.model.FolderInfo;
import com.sm.portal.digilocker.model.FolderInfoVo;
import com.sm.portal.digilocker.model.GalleryDetails;
import com.sm.portal.filters.ThreadLocalInfoContainer;
import com.sm.portal.mongo.MongoDBUtil;




@Repository
public class DigiLockerMongoDao {

	private static final Logger logger = LoggerFactory.getLogger(DigiLockerMongoDao.class);
	
	@Autowired
	MongoDBUtil mongoDBUtil ;
	private Gson gson = new Gson();
	
	 private static final String FILE_PATTERN ="([^\\s]+(\\.(?i)(jpg|png|gif|bmp|pdf|xls))$)";
	 
	@SuppressWarnings("unchecked")
	public List<FolderInfo> getFolderInfo(Long userId){
		
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_MONGO_COLLETION);
		Document folderResultDoc = null;
		folderResultDoc =coll.find(Filters.and(Filters.eq("userId",userId),Filters.eq("foldersList.folderStatus",DigiLockerStatusEnum.ACTIVE.toString()))).first();
		//folderResultDoc =coll.find(Filters.and(Filters.eq("userId",userId))).first();
		//Document fileDoc = coll.find(Filters.and(Filters.eq("userId",userId),Filters.eq("parentId",userId))).first();
		List<FolderInfo> folderInfoList = new ArrayList<>();
		if(folderResultDoc!=null){			
			List<Document> foldersList=(List<Document>) folderResultDoc.get("foldersList");	
			
			
			FolderInfo folderInfo=null;
			
			List<FilesInfo> filesInfoList = null;
			FilesInfo filesInfo =null;
			
			List<Document> filesDocs=null;
			
			for(Document folderDoc:foldersList){
				
				folderInfo =new FolderInfo();
				folderInfo.setOrigin(folderDoc.getString("origin"));
				folderInfo.setfId(folderDoc.getInteger("folderId"));
				folderInfo.setfName(folderDoc.getString("folderName"));
				folderInfo.setParentId(folderDoc.getInteger("parentId"));
				folderInfo.setFolderPath(folderDoc.getString("folderPath"));
				folderInfo.setFolderNamePath(folderDoc.getString("folderNamePath"));
				folderInfo.setFolderStatus(folderDoc.getString("folderStatus"));
				filesDocs = (List<Document>) folderDoc.get("files");
				if(filesDocs!=null){
					filesInfoList = new ArrayList<>();
					for(Document fileDocument:filesDocs){
						if(fileDocument.getString("fileStatus").equals(DigiLockerStatusEnum.ACTIVE.toString())){
							filesInfo =new FilesInfo();
							filesInfo.setFileName(fileDocument.getString("fileName"));
							filesInfo.setDumy_filename(fileDocument.getString("dumy_filename"));
							filesInfo.setFilePath(fileDocument.getString("filePath"));
							filesInfo.setFileId(fileDocument.getInteger("fileId"));
							filesInfo.setFileStatus(fileDocument.getString("fileStatus"));
							//filesInfo.setCreateddate(fileDocument.getDate("createddate"));
							//filesInfo.setUpdateddate(fileDocument.getDate("updateddate"));
							filesInfo.setFileType(fileDocument.getString("fileType"));
							filesInfo.setStatusAtGallery(fileDocument.getString("statusAtGallery"));
							filesInfo.setFileExtension(fileDocument.getString("fileExtension"));
							/*if(filesInfo.getFileName().endsWith(".jpg") || filesInfo.getFileName().endsWith(".png") || 
									filesInfo.getFileName().endsWith(".jpeg") ||  filesInfo.getFileName().endsWith(".gif")){
								filesInfo.setFileType("img");
							}else if(filesInfo.getFileName().endsWith(".pdf") ){
								filesInfo.setFileType("pdf");
							}else if(filesInfo.getFileName().endsWith(".xls")|| filesInfo.getFileName().endsWith(".xlsx")){
								filesInfo.setFileType("xls");
							}else if(filesInfo.getFileName().endsWith(".txt") ){
								filesInfo.setFileType("txt");
							}else if(filesInfo.getFileName().endsWith(".doc") || filesInfo.getFileName().endsWith(".docx") ){
								filesInfo.setFileType("doc");
							}*/
							filesInfoList.add(filesInfo);
						}
					}//inner for closing
				}//if closing
				
				folderInfo.setLocalFilesInfo(filesInfoList);
				if(folderInfo.getFolderStatus().equals(DigiLockerStatusEnum.ACTIVE.toString()))
					folderInfoList.add(folderInfo);
			}//for closing
		}
		return folderInfoList;
	}//getDigiLockerHomeData() closing

	public void storeFilesInGallery(FolderInfo newFolderInfo, Integer userId){
		
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_MONGO_COLLETION);
		Bson filter = Filters.eq("userId", userId);
		
		FindIterable<Document> folderInfoVos=coll.find(filter);
		if(null != folderInfoVos){
			for (Document cur :  folderInfoVos ) {
				
				boolean isFolderAlreadyExists =false;
				FolderInfoVo folderInfoVo = gson.fromJson(cur.toJson(), FolderInfoVo.class);
				List<FolderInfo> folderInfoList=folderInfoVo.getFoldersList();
				for(FolderInfo folderInfo :folderInfoList){
					if(folderInfo.getOrigin().equals(DigiLockerEnum.GALLERY.toString())){
						List<FilesInfo>  fileList=folderInfo.getLocalFilesInfo();
						if(fileList!=null){
							fileList.add(newFolderInfo.getLocalFilesInfo().get(0));
						}else{
							fileList = new ArrayList<>();
							if(newFolderInfo.getLocalFilesInfo().size()> 0)
								fileList.add(newFolderInfo.getLocalFilesInfo().get(0));
							folderInfo.setLocalFilesInfo(fileList);
						}
						isFolderAlreadyExists=true;
						break;
					}//if closing
				}//for closing
				
				if(!isFolderAlreadyExists){
					newFolderInfo.setLocalFilesInfo(new ArrayList<>());
					folderInfoList.add(newFolderInfo);
				}//if closing
				String folderInfoVoJson = gson.toJson(folderInfoVo);
				Document folderInfoVoJsonDoc = Document.parse(folderInfoVoJson);
				coll.findOneAndUpdate(filter,new Document("$set", folderInfoVoJsonDoc),new FindOneAndUpdateOptions().upsert(true)) ;
				
			}//outer for closing
		}
		
	}//storeFilesInGallery() closing
	
	public void storeNewFileOrFolderInfo(FolderInfo newFolderInfo, Integer folderId,Integer userId) {
		
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_MONGO_COLLETION);
		Bson filter = Filters.eq("userId", userId);
		
		FindIterable<Document> folderInfoVos=coll.find(filter);
		int count=0;
		for(Document cur : folderInfoVos){
			count++;
			break;
		}
		if(count==0){
			Document userDigilockerDocument = new Document();
			userDigilockerDocument.put("userId", userId);
			userDigilockerDocument.put("foldersList", new ArrayList<Document>());
			coll.insertOne(userDigilockerDocument);
			folderInfoVos=coll.find(filter);
		}
		
		if(null != folderInfoVos){
			for (Document cur :  folderInfoVos ) {
				boolean isFolderAlreadyExists =false;
				FolderInfoVo folderInfoVo = gson.fromJson(cur.toJson(), FolderInfoVo.class);
				List<FolderInfo> folderInfoList=folderInfoVo.getFoldersList();
				for(FolderInfo folderInfo :folderInfoList){
					if(folderInfo.getfId()==folderId.intValue()){
						List<FilesInfo>  fileList=folderInfo.getLocalFilesInfo();
						if(fileList!=null){
							fileList.add(newFolderInfo.getLocalFilesInfo().get(0));
						}else{
							fileList = new ArrayList<>();
							if(newFolderInfo.getLocalFilesInfo().size()> 0)
								fileList.add(newFolderInfo.getLocalFilesInfo().get(0));
							folderInfo.setLocalFilesInfo(fileList);
						}
						isFolderAlreadyExists=true;
					}
				}//for closing
				
				if(!isFolderAlreadyExists){
					newFolderInfo.setLocalFilesInfo(new ArrayList<>());
					folderInfoList.add(newFolderInfo);
				}//if closing
				String folderInfoVoJson = gson.toJson(folderInfoVo);
				Document folderInfoVoJsonDoc = Document.parse(folderInfoVoJson);
				coll.findOneAndUpdate(filter,new Document("$set", folderInfoVoJsonDoc),new FindOneAndUpdateOptions().upsert(true)) ;
				
			}//outer for closing
		}
	}//storeFileInfoInDB() closing
	public void updateFileOrFolderSatus(String deleteInfo, String action,Integer folderId,Integer fildId, Integer userId) {
		
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_MONGO_COLLETION);
		Bson filter = Filters.eq("userId", userId);
		
		FindIterable<Document> folderInfoVos=coll.find(filter);
		if(null != folderInfoVos){
			for (Document cur :  folderInfoVos ) {
				FolderInfoVo folderInfoVo = gson.fromJson(cur.toJson(), FolderInfoVo.class);
				List<FolderInfo> folderInfoList=folderInfoVo.getFoldersList();
				for(FolderInfo folderInfo :folderInfoList){
					if(folderInfo.getfId()==folderId.intValue()){
						if(deleteInfo.equals("File")){
							List<FilesInfo>  fileList=folderInfo.getLocalFilesInfo();
							List<FilesInfo> updatableFileInfoList=fileList.stream().filter(folder->folder.fileId == fildId.intValue()).collect(Collectors.toList());
							if(updatableFileInfoList!=null && updatableFileInfoList.size()>0){
								FilesInfo updatableFile=updatableFileInfoList.get(0);
								if(action.equals("Hide")){
									updatableFile.setFileStatus(DigiLockerStatusEnum.HIDDEN.toString());
								}else if(action.equals("Delete")){
									updatableFile.setFileStatus(DigiLockerStatusEnum.DELETED.toString());
								}//else closing
							}//if closing
						}else{
							if(action.equals("Hide")){
								folderInfo.setFolderStatus(DigiLockerStatusEnum.HIDDEN.toString());
							}else if(action.equals("Delete")){
								folderInfo.setFolderStatus(DigiLockerStatusEnum.DELETED.toString());
							}
						}//else cloisng
						
					}//if closing
				}//for closing
				String folderInfoVoJson = gson.toJson(folderInfoVo);
				Document folderInfoVoJsonDoc = Document.parse(folderInfoVoJson);
				coll.findOneAndUpdate(filter,new Document("$set", folderInfoVoJsonDoc),new FindOneAndUpdateOptions().upsert(true)) ;
				
			}//outer for closing
		}
	}//storeFileInfoInDB() closing

	public void showHiddenFoldersAndFiles(Integer fid, Integer userId) {
		
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_MONGO_COLLETION);
		Bson filter = Filters.eq("userId", userId);
		
		FindIterable<Document> folderInfoVos=coll.find(filter);
		if(null != folderInfoVos){
			for (Document cur :  folderInfoVos ) {
				FolderInfoVo folderInfoVo = gson.fromJson(cur.toJson(), FolderInfoVo.class);
				List<FolderInfo> folderInfoList=folderInfoVo.getFoldersList();
				for(FolderInfo folderInfo :folderInfoList){
					if(folderInfo.getfId()==fid.intValue() || folderInfo.getParentId()==fid.intValue()){
						if(!folderInfo.getFolderStatus().equals(DigiLockerStatusEnum.DELETED.toString())){
							folderInfo.setFolderStatus(DigiLockerStatusEnum.ACTIVE.toString());
							List<FilesInfo>  fileList=folderInfo.getLocalFilesInfo();
							if(fileList!=null && fileList.size()>0){
								for(FilesInfo filesInfo:fileList){
									if(!filesInfo.getFileStatus().equals(DigiLockerStatusEnum.DELETED.toString()))
										filesInfo.setFileStatus(DigiLockerStatusEnum.ACTIVE.toString());
								}//for closing
								
							}//if closing
						}
						//break;
					}//if closing
					
					
					String folderInfoVoJson = gson.toJson(folderInfoVo);
					Document folderInfoVoJsonDoc = Document.parse(folderInfoVoJson);
					coll.findOneAndUpdate(filter,new Document("$set", folderInfoVoJsonDoc),new FindOneAndUpdateOptions().upsert(true)) ;
				}//for closing
			}//for closing
		}//if closing
	}//showHiddenFoldersAndFiles() closing

	public void storeFolderInfo(List<FolderInfo> folderlist, Integer userId) {
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_MONGO_COLLETION);
		
		Document mainDocu=new Document();
		mainDocu.append("userId", userId);
		
		List<Document> foldersList=new ArrayList<Document>();
		for(FolderInfo newFolder:folderlist){
			Document folderDoc1=new Document();
			folderDoc1.append("folderName", newFolder.getFolderName());
			folderDoc1.append("folderId", newFolder.getfId());
			folderDoc1.append("folderPath", newFolder.getFolderPath());
			folderDoc1.append("parentId", newFolder.getParentId());
			folderDoc1.append("folderNamePath", newFolder.getFolderNamePath());
			folderDoc1.append("folderStatus", newFolder.getFolderStatus());
			folderDoc1.append("origin", newFolder.getOrigin());
			folderDoc1.append("files", new ArrayList<>());
			
			foldersList.add(folderDoc1);
		}
		
		mainDocu.append("foldersList", foldersList);
		
		coll.insertOne(mainDocu);
		logger.info(" saved the data to the collection ");
	}

	/*public FolderInfo getGallerContent(Integer userId, String filesType) {
		FolderInfo gallerInfo = new FolderInfo();
		List<FilesInfo> galleryFiles = new ArrayList<>();
		
		List<FilesInfo> filesList = null;
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_MONGO_COLLETION);
		Bson filter = Filters.eq("userId", userId);
		
		FindIterable<Document> folderInfoVos=coll.find(filter);
		if(null != folderInfoVos){
			for (Document cur :  folderInfoVos ) {
				FolderInfoVo folderInfoVo = gson.fromJson(cur.toJson(), FolderInfoVo.class);
				List<FolderInfo> folderInfoList=folderInfoVo.getFoldersList();
				for(FolderInfo folderInfo :folderInfoList){
					filesList =folderInfo.getFiles();
					if(filesList!=null && filesList.size()>0){
						for(FilesInfo file:filesList){
							if(filesType!=null){//checking that files are getting based on type or not
								if(filesType.equals(file.getFileType()))galleryFiles.add(file);//getting file list based on type
							}else{
								galleryFiles.add(file);//getting all type(audio, video, documents and images) of files 
							}//else closing
						}//inner for closing
					}//if closing
				}//inner for closing
			}//outer for closing
		}//if closing
		gallerInfo.setFiles(galleryFiles);
		return gallerInfo;
	}//getGallerContent() closing
*/
	
	
	public List<GalleryDetails> getGallerContent(Integer userId, String filesType, String fileStatus) throws ParseException {
		List<GalleryDetails> gallerInfo = new ArrayList<GalleryDetails>();
		AggregateIterable<Document> folderInfoVos=null;
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_MONGO_COLLETION);
		
		Document match = new Document();
		match.append("$match", new Document("userId", userId));
		Document unwind1 = new Document();
		unwind1.append("$unwind", "$foldersList");
		Document unwind2 = new Document();
		unwind2.append("$unwind", "$foldersList.files");
		Document match2 = new Document();
		Document sort = new Document();
		sort.append("$sort", new Document("foldersList.files.createddate",-1));
		
		if(filesType!=null && !filesType.equals("ALL")){
			Document matchFilter=new Document("foldersList.folderStatus", "ACTIVE");
			matchFilter.append("foldersList.files.fileType", filesType);
			match2.append("$match", matchFilter);
			folderInfoVos=coll.aggregate(Arrays.asList(match,unwind1,unwind2,match2,sort));
		}else if(fileStatus!=null && !fileStatus.equals("DELETED")){
			Document matchFilter=new Document("foldersList.folderStatus",  "ACTIVE");
			matchFilter.append("foldersList.files.fileStatus", fileStatus);
			match2.append("$match", matchFilter);
			folderInfoVos=coll.aggregate(Arrays.asList(match,unwind1,unwind2,match2,sort));
		}else if((filesType!=null && filesType.equals("ALL"))&& (fileStatus==null)){
			match2.append("$match", new Document("foldersList.folderStatus", "ACTIVE"));
			folderInfoVos=coll.aggregate(Arrays.asList(match,unwind1,unwind2,match2,sort));
		}
		if(null != folderInfoVos){
			for (Document cur :  folderInfoVos ) {
				GalleryDetails details=setGalleryDetailsData(cur);
				gallerInfo.add(details);
			}//for closing
			
		}//if closing
		//fetching deleted folders
		if(fileStatus!=null && fileStatus.equals("DELETED")){
			fetchingDeletedFolder(gallerInfo,fileStatus,userId);
		}
		return gallerInfo;
	}//getGallerContent() closing
	
	private List<GalleryDetails> fetchingDeletedFolder(List<GalleryDetails> gallerInfo, String folderStatus, Integer userId) {
		
		AggregateIterable<Document> folderInfoVos=null;
		
		MongoCollection<Document> coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_MONGO_COLLETION);
		Document match = new Document();
		match.append("$match", new Document("userId", userId));
		Document unwind1 = new Document();
		unwind1.append("$unwind", "$foldersList");
		Document matchFilter=new Document();
		matchFilter.append("$match", new Document("foldersList.folderStatus", folderStatus));
		
		folderInfoVos=coll.aggregate(Arrays.asList(match,unwind1,matchFilter));
		if(null != folderInfoVos){
			for (Document cur :  folderInfoVos ) {
				GalleryDetails details=setDeletedFolderData(cur);
				gallerInfo.add(details);
			}//for closing
		}//if closing
		return gallerInfo;
	}

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

	//public FolderInfo getGalleryDetails(Integer userId) {
		public FolderInfo getGalleryDetails(String origin) {

		Integer userId=(Integer) (ThreadLocalInfoContainer.INFO_CONTAINER.get()).get("USER_ID");
		FolderInfo gallerFolder = null;
		MongoCollection<Document> coll = null;
		coll = mongoDBUtil.getMongoCollection(CollectionsConstant.DIGILOCKER_MONGO_COLLETION);
		Bson filter = Filters.and(Filters.eq("userId", userId), Filters.elemMatch("foldersList", new Document("origin",origin)));
		FindIterable<Document> folderInfoVos=coll.find(filter);
		if(null != folderInfoVos){
			for (Document cur :  folderInfoVos ) {
				FolderInfoVo folderInfoVo = gson.fromJson(cur.toJson(), FolderInfoVo.class);
				List<FolderInfo> folderInfoList=folderInfoVo.getFoldersList();
				for(FolderInfo folderInfo :folderInfoList){
					//if(folderInfo.getOrigin().equals(DigiLockerEnum.GALLERY.toString())){
					if(folderInfo.getOrigin().equals(origin)){
						gallerFolder=folderInfo;
						break;
					}
				}//inner for closing
			}//outer for closing
		}//if closing
		
		return gallerFolder;
	}//getGalleryDetails() closing
	
}//class closing
