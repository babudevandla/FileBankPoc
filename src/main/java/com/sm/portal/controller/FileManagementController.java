package com.sm.portal.controller;

import java.io.InputStream;
import java.security.Principal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sm.portal.constants.URLCONSTANT;
import com.sm.portal.constants.WebDavServerConstant;
import com.sm.portal.digilocker.model.DigiLockerAddressBar;
import com.sm.portal.digilocker.model.DigiLockerEnum;
import com.sm.portal.digilocker.model.FileAndFolderMoveEnum;
import com.sm.portal.digilocker.model.FolderInfo;
import com.sm.portal.digilocker.model.GalleryDetails;
import com.sm.portal.digilocker.model.GallerySearchVo;
import com.sm.portal.digilocker.model.MoveFilesAndFoldersBean;
import com.sm.portal.digilocker.service.DigilockerService;
import com.sm.portal.digilocker.utils.DigiLockeUtils;
import com.sm.portal.filters.ThreadLocalInfoContainer;
import com.sm.portal.model.Users;
import com.sm.portal.service.FileManagementService;
import com.sm.portal.service.FileUploadServices;
import com.sm.portal.service.PropertyService;
import com.sm.portal.service.UserService;
import com.sm.portal.uniquekeys.UniqueKeyDaoImpl;

@RestController
@RequestMapping(URLCONSTANT.BASE_URL)
public class FileManagementController  extends CommonController{

	private static final Logger logger = LoggerFactory.getLogger(FileManagementController.class);
	
	@Autowired
	public UserService userService;
	@Autowired
	public PropertyService propertyService;
	@Autowired
	FileManagementService managementService;
	@Autowired
	FileUploadServices fileUploadServices;
	@Autowired
	DigilockerService digilockerService;
	@Autowired
	DigiLockeUtils digiLockerUtils;
	@Autowired
	UniqueKeyDaoImpl uniqueKeyDaoImpl;
	
	
	@GetMapping(value=URLCONSTANT.FILE_MANAGEMENT_CREATE_FOLDER)
	public @ResponseBody ModelAndView createFolder(@RequestParam Integer userid,@RequestParam String foldername,
			Principal principal,@RequestParam String currentFolderPath,HttpServletRequest request){
		
		
		logger.debug(" show fileManagement ...");
		HttpSession httpSession=request.getSession(true);
		ModelAndView mvc = new ModelAndView();
		
		userid =(Integer) ThreadLocalInfoContainer.INFO_CONTAINER.get().get("USER_ID");
		@SuppressWarnings("unchecked")
		List<FolderInfo> allFolderList =(List<FolderInfo>) httpSession.getAttribute("allFoldersData");
		
		FolderInfo newFolder =digilockerService.createNewFolder(userid, foldername, currentFolderPath, allFolderList, "NO");
		
		
		//List<FolderInfo>	getUpdatedFolderList=digilockerService.getDigiLockerHomeData(new Long(userid));
		List<FolderInfo>	getUpdatedFolderList=digilockerService.getAllFolders();
		httpSession.setAttribute("allFoldersData", getUpdatedFolderList);
		httpSession.setAttribute("userid", userid);
		
		mvc.addObject("digiLockActive", true);		
		if(StringUtils.isNotBlank(currentFolderPath)){
			mvc.setViewName("redirect:/sm/getfolderinfo/"+newFolder.getParentId());			
		}else{
			//mvc.setViewName("redirect:/sm/file_management/"+userid);
			mvc.setViewName("redirect:/sm/file_management");
		}
		return mvc;
	}//createFolder() closing
	
	@PostMapping(value=URLCONSTANT.FILE_MANAGEMENT_UPLOAD_FILES)
	public ModelAndView uploadFiles(@RequestParam("fileName") MultipartFile multipartList[],@RequestParam Integer userid,@RequestParam String folderPath,
			@RequestParam Integer folderId,Principal principal,
			RedirectAttributes redirectAttributes, HttpServletRequest request){
		logger.debug(" show fileManagement ...");
		boolean isUploadingAtRootFolder =false;
		userid =(Integer) ThreadLocalInfoContainer.INFO_CONTAINER.get().get("USER_ID");
		ModelAndView mvc = new ModelAndView();
		//Users user=userService.findUserByUserName(principal.getName());
		//########## below code is to upload files in filebank root folder###############
		HttpSession httpSession=request.getSession(true);
		@SuppressWarnings("unchecked")
		List<FolderInfo> allFolderList =(List<FolderInfo>) httpSession.getAttribute("allFoldersData");
		
		if(folderPath==null || folderId==null) {
			FolderInfo  newfolder=null;
			newfolder =digilockerService.getFolderInfoForRootFiles();
			if(newfolder==null)	newfolder =digilockerService.createNewFolder(userid, "home", null,allFolderList,"YES");
			folderPath =newfolder.getFolderPath();
			folderId=newfolder.getFolderId();
			isUploadingAtRootFolder=true;
		}
		//########## above code is to upload files in filebank root folder###############
		String fileUrl=null;
		for (int i=0;i<multipartList.length;i++) {	
            if (!multipartList[i].isEmpty()) {
            	fileUrl=digilockerService.uploadFiles(multipartList[i],userid,  folderPath,folderId, request );
            	if(fileUrl!=null)
            		mvc.addObject("message","file uploaded successfully!");
            }
		}
		//allFolderList=digilockerService.getDigiLockerHomeData(new Long(userid));//getting updated data from database
		allFolderList=digilockerService.getAllFolders();
		httpSession.setAttribute("allFoldersData", allFolderList);
		httpSession.setAttribute("userid", userid);
		if(isUploadingAtRootFolder) mvc.setViewName("redirect:/sm/file_management");
		else mvc.setViewName("redirect:/sm/getfolderinfo/"+folderId);
		System.out.println(user);
		return mvc;
	}//uploadFiles() closing
	
	@GetMapping(value=URLCONSTANT.FILE_MANAGEMENT_HOME)
	public ModelAndView getDigiLockerRootFolders() {
		ModelAndView mvc = new ModelAndView("/customer/file_management");
		
		List<FolderInfo>	rootFolderList=digilockerService.getRootFoldersList();
		mvc.addObject("digiLockerHomeData", rootFolderList);
		mvc.addObject("digiLockActive", true);
		mvc.addObject("WEBDAV_SERVER_URL", WebDavServerConstant.WEBDAV_SERVER_URL);
		return mvc;
	}
	
	//@GetMapping(value=URLCONSTANT.FILE_MANAGEMENT_HOME)
	public ModelAndView getDigiLockerHomeData(@RequestParam(name="userId",required=false)  Integer userId,@RequestParam(name="message",required=false) String message,
			Principal principal,HttpServletRequest request){
		logger.debug(" show fileManagement ...");
		if(userId==null){
			try{
				userId=(Integer) (ThreadLocalInfoContainer.INFO_CONTAINER.get()).get("USER_ID");
			}catch(Exception e){e.printStackTrace();}
		}
		ModelAndView mvc = new ModelAndView("/customer/file_management");
		//Integer UId=(Integer) ThreadLocalInfoContainer.INFO_CONTAINER.get().get("USER_ID");
		try{
			//Users user=userService.getUserById(userId);
			List<FolderInfo>	allFolderList=digilockerService.getDigiLockerHomeData(new Long(userId));
			
			HttpSession httpSession=request.getSession(true);
			httpSession.setAttribute("allFoldersData", allFolderList);
			httpSession.setAttribute("userid", userId);
			List<FolderInfo>	rootFolderList=digilockerService.getRootFoldersList(allFolderList);
			mvc.addObject("digiLockerHomeData", rootFolderList);
			List<FolderInfo> galleryData=rootFolderList.stream().filter(folder -> folder.origin.equals("GALLERY")).collect(Collectors.toList());
			mvc.addObject("galleryData", galleryData);
			System.out.println(user);
			mvc.addObject("WEBDAV_SERVER_URL", WebDavServerConstant.WEBDAV_SERVER_URL);
		}catch(Exception e){
			e.printStackTrace();
		}
		//mvc.addObject("currentFolderPath", "home");
		mvc.addObject("digiLockActive", true);
		return mvc;
	}//closing getDigiLockerHomeData() 
	

	
	@GetMapping(value="/getfolderinfo/{fid}")
	public ModelAndView getFolderInfo(@PathVariable Integer fid,Principal principal,HttpServletRequest request){
		logger.debug(" show fileManagement ...");
		
		ModelAndView mvc = new ModelAndView("/customer/file_management");
		HttpSession httpSession=request.getSession(true);
		@SuppressWarnings("unchecked")
		List<FolderInfo> allFolderList =(List<FolderInfo>) httpSession.getAttribute("allFoldersData");
		FolderInfo	folderInfo =null;
		FolderInfo	currentFolderInfo =null;
		try{
			if(allFolderList==null || allFolderList.size()==0) {
				allFolderList =digilockerService.getAllFolders();
				httpSession.setAttribute("allFoldersData", allFolderList);
			}
			currentFolderInfo=digilockerService.getFolderInfo(allFolderList,fid);
			folderInfo =digilockerService.getFolderInfo(fid);
			folderInfo.setFolderId(currentFolderInfo.getFolderId());
			folderInfo.setFolderPath(currentFolderInfo.getFolderPath());
			List<DigiLockerAddressBar> addressBar = this.getAddressBar(folderInfo, allFolderList);
			mvc.addObject("folderInfo", folderInfo);
			mvc.addObject("currentFolderPath", folderInfo.getFolderPath());
			mvc.addObject("isInternalFolder", "Yes");
			mvc.addObject("addressBar",addressBar);
			
			
			//fileUploadServices.createFolderName(folderInfo.getFolderPath());
			mvc.addObject("digiLockActive", true);
			mvc.addObject("WEBDAV_SERVER_URL", WebDavServerConstant.WEBDAV_SERVER_URL);
			//System.out.println(user);			
		}catch(Exception e){e.printStackTrace();}
		
		return mvc;
	}//closing getDigiLockerHomeData() 
	
	@GetMapping(value="/moveFilesAndFolders")
	public ModelAndView moveFilesAndFolders(@ModelAttribute MoveFilesAndFoldersBean moveFilesAndFoldersBean,HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView("/customer/movefileandfolders");
		Integer userId =(Integer) (ThreadLocalInfoContainer.INFO_CONTAINER.get()).get("USER_ID");
		try{
			//Users user=userService.getUserById(userId);
			//List<FolderInfo>	allFolderList=digilockerService.getDigiLockerHomeData(new Long(userId));
			List<FolderInfo>	allFolderList=digilockerService.getAllFolders();
			HttpSession httpSession=request.getSession(true);
			httpSession.setAttribute("allFoldersData", allFolderList);
			httpSession.setAttribute("userid", userId);
			//List<FolderInfo>	rootFolderList=digilockerService.getRootFoldersList(allFolderList);
			List<FolderInfo>	rootFolderList=digilockerService.getRootFoldersList();
			if(moveFilesAndFoldersBean.getMoveType().toString().equals(FileAndFolderMoveEnum.FOLDER_MOVE.toString())){
				for(FolderInfo folder:rootFolderList) {
					if(folder.getFolderId().intValue()==moveFilesAndFoldersBean.getSourceFolderId().intValue()) {
						folder.setFolderStatus("DISABLED");
						break;//since only folder should be disabled as per the fundamental logic
					}//if closing
				}//for closing
			}//if closing
			mav.addObject("digiLockerHomeData", rootFolderList);
			List<FolderInfo> galleryData=rootFolderList.stream().filter(folder -> folder.origin.equals("GALLERY")).collect(Collectors.toList());
			mav.addObject("galleryData", galleryData);
			System.out.println(user);
			mav.addObject("WEBDAV_SERVER_URL", WebDavServerConstant.WEBDAV_SERVER_URL);
		}catch(Exception e){
			e.printStackTrace();
		}
		//mvc.addObject("currentFolderPath", "home");
		mav.addObject("digiLockActive", true);
		mav.addObject("moveFilesAndFoldersBean",moveFilesAndFoldersBean);
		
		return mav;
	}//moveFilesAndFolders() closing
	
	@GetMapping(value="/getfolderinfowhilemoving")
	public ModelAndView getfolderinfowhilemoving(@ModelAttribute MoveFilesAndFoldersBean moveFilesAndFoldersBean,HttpServletRequest request){
		logger.debug(" show fileManagement ...");
		
		ModelAndView mvc = new ModelAndView("/customer/movefileandfolders");
		HttpSession httpSession=request.getSession(true);
		@SuppressWarnings("unchecked")
		List<FolderInfo> allFolderList =(List<FolderInfo>) httpSession.getAttribute("allFoldersData");
		try{
						
			if(moveFilesAndFoldersBean.getDestinationFolderId()==null || moveFilesAndFoldersBean.getDestinationFolderId().intValue()<0) {
				moveFilesAndFoldersBean.setDestinationFolderParentId(0);
				//List<FolderInfo>	rootFolderList=digilockerService.getRootFoldersList(allFolderList);
				List<FolderInfo>	rootFolderList=digilockerService.getRootFoldersList();
				mvc.addObject("digiLockerHomeData", rootFolderList);
			}else {
			FolderInfo	folderInfo=digilockerService.getFolderInfo(allFolderList,moveFilesAndFoldersBean.getDestinationFolderId());
			
			if(moveFilesAndFoldersBean.getMoveType().toString().equals(FileAndFolderMoveEnum.FOLDER_MOVE.toString())){
				List<FolderInfo> childFolders = folderInfo.getChildFolders();
				for(FolderInfo folder:childFolders) {
					if(folder.getFolderId().intValue()==moveFilesAndFoldersBean.getSourceFolderId().intValue()) {
						folder.setFolderStatus("DISABLED");
						break;//since only folder should be disabled as per the fundamental logic
					}//if closing
				}//for closing
			}//if closing
			List<DigiLockerAddressBar> addressBar = this.getAddressBar(folderInfo, allFolderList);
			mvc.addObject("folderInfo", folderInfo);
			mvc.addObject("currentFolderPath", folderInfo.getFolderPath());
			mvc.addObject("isInternalFolder", "Yes");
			mvc.addObject("addressBar",addressBar);
			}
			//fileUploadServices.createFolderName(folderInfo.getFolderPath());
			mvc.addObject("digiLockActive", true);
			mvc.addObject("WEBDAV_SERVER_URL", WebDavServerConstant.WEBDAV_SERVER_URL);
			//System.out.println(user);			
		}catch(Exception e){e.printStackTrace();}
		mvc.addObject("moveFilesAndFoldersBean",moveFilesAndFoldersBean);
		return mvc;
	}//closing getDigiLockerHomeData() 
	
	@GetMapping(value="/moveFileOrFolderSubmit")
	public ModelAndView moveFileOrFolderSubmit(@ModelAttribute MoveFilesAndFoldersBean moveFilesAndFoldersBean,HttpServletRequest request) {
		
		if(moveFilesAndFoldersBean.getMoveType().toString().equals(FileAndFolderMoveEnum.FOLDER_MOVE.toString())) {
			digilockerService.moveFolderToAnothreFolder(moveFilesAndFoldersBean.getSourceFolderId(), moveFilesAndFoldersBean.getDestinationFolderId());
		}else if(moveFilesAndFoldersBean.getMoveType().toString().equals(FileAndFolderMoveEnum.FILE_MOVE.toString())) {
			digilockerService.moveFileToAnotherFolder(moveFilesAndFoldersBean);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/sm/getUpdatedFodlerInfo?currentFolderId="+moveFilesAndFoldersBean.getDestinationFolderId());	
		return mav;
		
	}//moveFileOrFolderSubmit() closing
	
	@GetMapping(value="getUpdatedFodlerInfo")
	public ModelAndView getUpdatedFolderInfo(HttpServletRequest request,@RequestParam(name="currentFolderId",required=false) Integer currentFolderId) {
		
		ModelAndView mvc = new ModelAndView("/customer/file_management");
		Integer userId = (Integer)ThreadLocalInfoContainer.INFO_CONTAINER.get().get("USER_ID");
		//List<FolderInfo>	allFolderList=digilockerService.getDigiLockerHomeData(new Long(userId));
		List<FolderInfo>	allFolderList=digilockerService.getAllFolders();
		HttpSession httpSession=request.getSession(true);
		httpSession.setAttribute("allFoldersData", allFolderList);
		httpSession.setAttribute("userid", userId);
		
		FolderInfo	folderInfo=digilockerService.getFolderInfo(allFolderList,currentFolderId);
		List<DigiLockerAddressBar> addressBar = this.getAddressBar(folderInfo, allFolderList);
		mvc.addObject("folderInfo", folderInfo);
		mvc.addObject("currentFolderPath", folderInfo.getFolderPath());
		mvc.addObject("isInternalFolder", "Yes");
		mvc.addObject("addressBar",addressBar);
		
		
		//fileUploadServices.createFolderName(folderInfo.getFolderPath());
		mvc.addObject("digiLockActive", true);
		mvc.addObject("WEBDAV_SERVER_URL", WebDavServerConstant.WEBDAV_SERVER_URL);
		
		return mvc;
	}//getUpdatedFolderInfo() closing
	
	
	@GetMapping(value="/downloadFile/{fid}")
	public void downloadFile(@PathVariable Integer fid,@RequestParam String filePath,Principal principal,HttpServletRequest request
			,HttpServletResponse response){
		
			String fileName =filePath.substring(filePath.lastIndexOf("/"));
		try{
			InputStream	inputStream=fileUploadServices.downloadFile(filePath);
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
			
			FileCopyUtils.copy(inputStream, response.getOutputStream());
		}catch(Exception e){e.printStackTrace();}
		
		//return mvc;
	}//closing getDigiLockerHomeData() 
	
	private List<DigiLockerAddressBar> getAddressBar(FolderInfo folderInfo, List<FolderInfo> allFolderList) {
		String currentFolderPath = folderInfo.getFolderPath();
		List<DigiLockerAddressBar> addressBar=new ArrayList<>();
		String[] folderIdArray=currentFolderPath.split("/");
		DigiLockerAddressBar addBar = null;
		for(String folderId:folderIdArray){
			for(FolderInfo folder:allFolderList){
				if(!folderId.equals("") &&new Long(""+folder.getfId()).intValue()==Long.parseLong(folderId)){
					addBar = new DigiLockerAddressBar();
					addBar.setFolderId(new Integer(folderId));
					addBar.setFolderName(folder.getfName());
					addressBar.add(addBar);
					break;
				}//if closing
			}//for closing
		}//for closing
		
		
		return addressBar;
	}//getAddressBar() closing
	
//http://localhost:8092/SM_Portal/sm/deletefile?folderId=10004&userid=101&action=Delete&fileId=506
	@GetMapping(value=URLCONSTANT.DIGILOCKER_DELETE_OR_HIDE_FILE)
	public ModelAndView deleteOrHideFile(@RequestParam Integer folderId,@RequestParam Integer parentId,@RequestParam String deleteInfo,@RequestParam(required=false) Integer fileId,@RequestParam Integer userid, @RequestParam String action,
			Principal principal,RedirectAttributes redirectAttributes, HttpServletRequest request){
		logger.debug(" delete file or folders ...");
		ModelAndView mvc = new ModelAndView();
		if(deleteInfo.equals("File"))folderId=parentId;
		try {
			digilockerService.updateFileOrFolderSatus(deleteInfo,action,folderId, fileId,userid);
			mvc.addObject("message","file deleted successfully!");
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.reseteFolderInfoInSession(request, userid);
		mvc.setViewName("redirect:/sm/getfolderinfo/"+parentId);
		mvc.addObject("digiLockActive", true);
		return mvc;
	}//deleteFile() closing
	
	
	private void reseteFolderInfoInSession(HttpServletRequest request, Integer userid) {

		List<FolderInfo>	allFolderList=digilockerService.getDigiLockerHomeData(new Long(userid));
		
		HttpSession httpSession=request.getSession(true);
		httpSession.setAttribute("allFoldersData", allFolderList);
		httpSession.setAttribute("userid", userid);
	}//reseteFolderInfoInSession() closing



	//http://localhost:8092/SM_Portal/sm/deletefolder?folderId=10004&userid=101&action=Delete
	@GetMapping(value=URLCONSTANT.DIGILOCKER_DELETE_OR_HIDE_FOLDER)
	public ModelAndView deleteOrHideFolder(@RequestParam Integer folderId,@RequestParam Integer userid,@RequestParam(name="filePath",required=false) String filePath, 
			@RequestParam String action,Principal principal,RedirectAttributes redirectAttributes, HttpServletRequest request){
		logger.debug(" delete file or folders ...");
		ModelAndView mvc = new ModelAndView();
		//SMPropertites propertites = propertyService.getSmPropertyByKey(PropertyConstant.UPLOAD_USER_FILE_PATH);
		Users user=userService.findUserByUserName(principal.getName());
		boolean deleteStatus;
		try {
			//deleteStatus = fileUploadServices.deleteFileOrFolder(filePath);
			//if(deleteStatus){
				digilockerService.updateFileOrFolderSatus("Folder",action,folderId, null,userid);
				mvc.addObject("message","file deleted successfully!");
			//}
		} catch (Exception e) {
			e.printStackTrace();
		}
		this.reseteFolderInfoInSession(request, userid);
		mvc.addObject("digiLockActive", true);
		mvc.setViewName("redirect:/sm/getfolderinfo/"+folderId);
		
		return mvc;
	}//deleteFile() closing

	//http://localhost:8092/SM_Portal/sm/showHiddenFoldersAndFiles/10000?userid=101
	@GetMapping(value="/showHiddenFoldersAndFiles/{fid}")
	public ModelAndView showHiddenFoldersAndFiles(@PathVariable Integer fid,@RequestParam Integer userid,Principal principal,HttpServletRequest request){
		logger.debug(" show fileManagement ...");
		
		ModelAndView mvc = new ModelAndView();
		
		try{
						
			digilockerService.showHiddenFoldersAndFiles(fid, userid);
			mvc.addObject("isInternalFolder", "Yes");
			//System.out.println(user);			
		}catch(Exception e){e.printStackTrace();}
		
		this.reseteFolderInfoInSession(request, userid);
		mvc.setViewName("redirect:/sm/getfolderinfo/"+fid);
		return mvc;
	}//closing getDigiLockerHomeData() 
	
	@GetMapping(value="/openGallery/{fid}")
	public ModelAndView openGallery(@PathVariable Integer fid,@RequestParam Integer userid,Principal principal,HttpServletRequest request){
		ModelAndView mvc = new ModelAndView("/customer/gallery_content");
		
		try {
			//List<GalleryDetails> gallerylist = digilockerService.getGallerContent(userid, null,null);
			GallerySearchVo gallerySearchVo =new GallerySearchVo();
			gallerySearchVo.setUserid(userid);
			List<GalleryDetails> gallerylist = digilockerService.getGallerContent(gallerySearchVo);
			mvc.addObject("galleryContent", gallerylist);
			mvc.addObject("fileType", "ALL");
			mvc.addObject("fid", fid);
			mvc.addObject("userid", userid);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		mvc.addObject("digiLockActive", true);
		return mvc;
	}//openGallery() closing
	
	
	@GetMapping(value="/getGallerContent")
	public ModelAndView getGallerContent(@ModelAttribute(name="gallerySearchVo") GallerySearchVo gallerySearchVo,Principal principal,HttpServletRequest request){
		ModelAndView mvc = new ModelAndView("/customer/gallery_content");
		 Integer userid=null;
			try{
				userid=(Integer) (ThreadLocalInfoContainer.INFO_CONTAINER.get()).get("USER_ID");
			}catch(Exception e){e.printStackTrace();}
		
		try {
			if(gallerySearchVo.getFilesType()==null)
				gallerySearchVo.setFilesType("ALL");
			
			List<GalleryDetails> gallerylist = digilockerService.getGallerContent(gallerySearchVo);
			if(StringUtils.isNotBlank(gallerySearchVo.getFilesType())&& !gallerySearchVo.getFilesType().equals("ALL"))
				gallerylist=gallerylist.stream().filter( g -> gallerySearchVo.getFilesType().equals(g.getFileType())).collect(Collectors.toList());
			
			mvc.addObject("galleryContent", gallerylist);
			mvc.addObject("fileType", gallerySearchVo.getFilesType());

			boolean allCls=false;
			boolean imgCls=false;
			boolean audCls=false;
			boolean vedCls=false;
			boolean docCls=false;
			boolean recyleCls=false;
			if(StringUtils.isNotBlank(gallerySearchVo.getFilesType())){
				if(gallerySearchVo.getFilesType().equals("ALL") && gallerySearchVo.getFileStatus()==null)
					allCls=true;
				else if(gallerySearchVo.getFilesType().equals("IMAGE"))
					imgCls=true;
				else if(gallerySearchVo.getFilesType().equals("AUDIO"))
					audCls=true;
				else if(gallerySearchVo.getFilesType().equals("VIDEO"))
					vedCls=true;
				else if(gallerySearchVo.getFilesType().equals("DOCUMENT"))
					docCls=true;
			}
			if(StringUtils.isNotBlank(gallerySearchVo.getFileStatus()) && gallerySearchVo.getFileStatus().equals("DELETED"))
				recyleCls=true;
			
			if(gallerySearchVo.getFileOrigin()==null)
				gallerySearchVo.setFileOrigin("ALL");
			
			mvc.addObject("allCls", allCls);
			mvc.addObject("imgCls", imgCls);
			mvc.addObject("audCls", audCls);
			mvc.addObject("vedCls", vedCls);
			mvc.addObject("docCls", docCls);
			mvc.addObject("recyleCls", recyleCls);
			mvc.addObject("fileOrigin", gallerySearchVo.getFileOrigin());
			mvc.addObject("userid", userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(gallerySearchVo.getFileOrigin()==null)mvc.addObject("fileOrigin", DigiLockerEnum.LOCKER.toString());
		mvc.addObject("digiLockActive", true);
		mvc.addObject("fileOriginList", DigiLockerEnum.values());
		return mvc;
	}//getGallerContent() closing
	
	



	@RequestMapping(value = "/storeFilesFromGallery", method = RequestMethod.POST)
	public ModelAndView  storeFilesInGalleryFromDigiLocker(@RequestParam("userId") Integer userId,
			 @RequestParam("folderId") Integer folderId,
			 @RequestParam("files") MultipartFile multipartList[],
			 HttpServletRequest request) {
	
		digilockerService.storeFilesInGalleryFromDigiLocker(userId,folderId,  multipartList, request);
		
		ModelAndView mvc= new ModelAndView();
		mvc.setViewName("redirect:/sm/getGallerContent?userid="+userId);
		
		return mvc;
	}//storeFilesInGalleryFromEbook() closing
	
}//class closing
