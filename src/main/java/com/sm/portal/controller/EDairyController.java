package com.sm.portal.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.PathParam;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sm.portal.constants.URLCONSTANT;
import com.sm.portal.digilocker.model.DigiLockerEnum;
import com.sm.portal.digilocker.model.DigiLockerStatusEnum;
import com.sm.portal.digilocker.model.FilesInfo;
import com.sm.portal.digilocker.model.FolderInfo;
import com.sm.portal.digilocker.service.DigilockerService;
import com.sm.portal.digilocker.utils.DigiLockeUtils;
import com.sm.portal.ebook.enums.BookSizeEnum;
import com.sm.portal.edairy.model.DairyInfo;
import com.sm.portal.edairy.model.DairyPage;
import com.sm.portal.edairy.model.EDairyPageDto;
import com.sm.portal.edairy.model.EdairyActionEnum;
import com.sm.portal.edairy.model.EdairyYearsEnum;
import com.sm.portal.edairy.model.UserDairies;
import com.sm.portal.edairy.service.EdairyServiceImpl;
import com.sm.portal.model.EDairyDto;
import com.sm.portal.model.Users;
import com.sm.portal.service.EDairyService;
import com.sm.portal.service.FileUploadServices;
import com.sm.portal.service.UserService;
import com.sm.portal.uniquekeys.UniqueKeyDaoImpl;
import com.sm.portal.uniquekeys.UniqueKeyEnum;

@RestController
@RequestMapping(URLCONSTANT.BASE_URL)
public class EDairyController {

	Logger logger=Logger.getLogger(EDairyController.class.getName());
	
	@Autowired
    private UserService userService;
	
	@Autowired
	private EDairyService eDairyService;
	
	@Autowired
	EdairyServiceImpl edairyServiceImpl;
	
	@Autowired
	FileUploadServices fileUploadServices;
	
	@Autowired
	DigilockerService digilockerService;
	
	@Autowired
	DigiLockeUtils digiLockerUtils;
	
	@Autowired
	UniqueKeyDaoImpl uniqueKeyDaoImpl;
	
	/*@RequestMapping(value="/media", method=RequestMethod.GET)
	public byte[] getImage(@RequestParam(value = "filePath") String filePath){
		byte[] data=null;
		try {
			data = IOUtils.toByteArray(fileUploadServices.downloadFile(filePath));
		} catch (IOException e) {e.printStackTrace();}
	    return data;
	}*/
	
	@RequestMapping(value="/media", method=RequestMethod.GET)
	public byte[] getImage(@RequestParam(value = "filePath") String filePath, HttpServletResponse response){
		byte[] data=null;
		try {
			data = IOUtils.toByteArray(fileUploadServices.downloadFile(filePath));
			response.setContentType("application/pdf");
			response.setContentLength(data.length);
			response.setBufferSize(150000);
			response.getOutputStream().write(data);
		} catch (IOException e) {e.printStackTrace();}
	    return data;
	}//
	
	@RequestMapping(value="/getFileBankMedia", method=RequestMethod.GET)
	public byte[] getFileBankMedia(@RequestParam(value = "filePath") String filePath, HttpServletResponse response){
		byte[] data=null;
		try {
			data = IOUtils.toByteArray(fileUploadServices.downloadFile(filePath));
			this.getContentType(response,filePath);
			//response.setContentType("application/octet-stream");
			response.setBufferSize(150000);
			response.setContentLength(data.length);
			response.getOutputStream().write(data);
		} catch (IOException e) {e.printStackTrace();}
	    return data;
	}//
	
	
	
	private void getContentType(HttpServletResponse response, String filePath) {
		if(filePath.endsWith(".pdf"))
			response.setContentType("application/pdf");
		else if(filePath.endsWith(".mp4"))
			response.setContentType("video/mp4");
		else if(filePath.endsWith(".mp3"))
			response.setContentType("audio/mp3");
		else
			response.setContentType("image/jpg");
	}

	@RequestMapping(value="/e_dairy_list", method=RequestMethod.GET)
	public ModelAndView eDairyLists(Principal principal){
		logger.debug(" show user profile ...");
		ModelAndView mvc = new ModelAndView("/customer/e-dairy");
		Users user =userService.findUserByUserName(principal.getName());
		
		List<EDairyDto>  dairyList=eDairyService.getEDairyList(user.getUserId());
		mvc.addObject("user", user);
		mvc.addObject("dairyList", dairyList);
		mvc.addObject("diaryActive", true);
		return mvc;
	}
	
	
	@RequestMapping(value="/create_edairy", method=RequestMethod.GET)
	public ModelAndView createNewEDairy(@ModelAttribute("dairyInfo") DairyInfo dairyInfo, Principal principal){
		logger.debug(" show user profile ...");
		Users user =userService.findUserByUserName(principal.getName());
		ModelAndView mvc = new ModelAndView("/customer/create_edairy");
		dairyInfo.setYear(2018);
		mvc.addObject("dairyInfo",dairyInfo);
		mvc.addObject("diaryActive", true);
		mvc.addObject("edairyYearsEnum", EdairyYearsEnum.values());
		mvc.addObject("userId",user.getUserId());
		return mvc;
	}
	
	@RequestMapping(value="/submit_edairy", method=RequestMethod.POST)
	public ModelAndView saveNewEDairy(@ModelAttribute("dairyInfo") DairyInfo dairyInfo, Principal principal){
		logger.debug(" show saveNewEDairy ...");
		ModelAndView mvc = new ModelAndView();
		Users user =userService.findUserByUserName(principal.getName());
		mvc.addObject("user", user);
		eDairyService.saveEDairyData(dairyInfo);
		mvc.setViewName("redirect:/sm/getUserDairiesList");
		
		//mvc.addObject("edairyDto",eDairyDto);
		return mvc;
	}


	@RequestMapping(value="/edit_edairy/{dairyId}", method=RequestMethod.GET)
	public ModelAndView editEDairy(@PathVariable("dairyId") Integer dairyId, Principal principal){
		logger.debug(" show edit edairy ...");
		ModelAndView mvc = new ModelAndView("/customer/edit_edairy");
		EDairyDto eDairyDto=eDairyService.getEDairyDataById(dairyId);
		mvc.addObject("edairyDto",eDairyDto);
		mvc.addObject("diaryActive", true);
		return mvc;
	}
	
	@RequestMapping(value="/edit_edairy", method=RequestMethod.POST)
	public ModelAndView saveEditEDairy(@ModelAttribute("edairyDto") EDairyDto eDairyDto, Principal principal){
		logger.debug(" show saveNewEDairy ...");
		ModelAndView mvc = new ModelAndView();
		Users user =userService.findUserByUserName(principal.getName());
		mvc.addObject("user", user);
		eDairyService.updateEDairyData(eDairyDto,user);
		mvc.setViewName("redirect:/sm/e_dairy_list");
		
		mvc.addObject("edairyDto",eDairyDto);
		return mvc;
	}
	
	@RequestMapping(value = "/uploadMultipleFile", method = RequestMethod.POST)
	public @ResponseBody String uploadMultipleFileHandler(@RequestParam("pagecontent") String pagecontent, 
			 @RequestParam("files") MultipartFile files[]) {

		try {
            String filePath="c:/temp/kk/";
            StringBuffer result=new StringBuffer();
            byte[] bytes=null;
            result.append("Uploading of File(s) ");

            for (int i=0;i<files.length;i++) {	
                if (!files[i].isEmpty()) {
                    bytes = files[i].getBytes();
                    BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(new File(filePath+files[i].getOriginalFilename())));
                    stream.write(bytes);
                    stream.close();

                   result.append(files[i].getOriginalFilename() + " Ok. ") ;
                }
                else
                    result.append( files[i].getOriginalFilename() + " Failed. ");

        }
            return result.toString();

        } catch (Exception e) {
            return "Error Occured while uploading files." + " => " + e.getMessage();
        }

	} 
	
	@RequestMapping(value = "/storeFilesInGallery", method = RequestMethod.POST)
	public ModelAndView  storeFilesInGallery(@RequestParam("userId") Integer userId,
			 @RequestParam("dairyId") Integer dairyId,
			 @RequestParam("pageNo") Integer pageNo,
			 @RequestParam("pagecontent") String pagecontent,
			 @RequestParam("files") MultipartFile multipartList[],
			 HttpServletRequest request) {
		//FolderInfo gallery =digilockerService.getGalleryDetails(userId);
		FolderInfo gallery =digilockerService.getGalleryDetails(DigiLockerEnum.EDAIRY.toString());
		if(gallery==null){
			gallery =digilockerService.checkAndCreateGalleryFolder(DigiLockerEnum.EDAIRY.toString());
		}
		
		String fileURL=null;
		List<String> fileUrlList=new ArrayList<>();
		List<FilesInfo> newFileList = new ArrayList<>();
		FilesInfo filesInfo = null;
		int	fileUniqueKey=uniqueKeyDaoImpl.getUniqueKey(userId, UniqueKeyEnum.FILES_ID.toString(), multipartList.length);
		for (int i=0;i<multipartList.length;i++) {	
            if (!multipartList[i].isEmpty()) {
            	fileURL =fileUploadServices.uploadWebDavServer(multipartList[i], gallery.getFolderPath(),request);
            	if(fileURL!=null){
	            	fileUrlList.add(fileURL);
	            	filesInfo =new FilesInfo();
	            	String fileName = multipartList[i].getOriginalFilename();
	        		//String filePath = multipartList[i]+fileName.replaceAll(" ", "_");
	            	filesInfo.setFileId(++fileUniqueKey);
	            	filesInfo.setFileName(fileName);
	            	filesInfo.setDumy_filename(fileName.replaceAll(" ", "_"));
	            	//String filePath = gallery.getFolderPath()+fileName.replaceAll(" ", "_");
	            	filesInfo.setFilePath(gallery.getFolderPath()+fileName.replaceAll(" ", "_"));
	            	filesInfo.setFileStatus(DigiLockerStatusEnum.ACTIVE.toString());
	            	filesInfo.setCreateddate(new Date());
	            	filesInfo.setStatusAtGallery(DigiLockerStatusEnum.ACTIVE.toString());
	            	filesInfo.setFileType(digiLockerUtils.getFileType(multipartList[i]));
	            	newFileList.add(filesInfo);
            	}//if closing
            }//if closing
		}//for closing
		if(fileUrlList.size()>0){
			gallery.setLocalFilesInfo(newFileList);
			digilockerService.storeNewFileOrFolderInfo(gallery, gallery.getFolderId(), userId);
			
			String updatedPageContent =edairyServiceImpl.getContentAfterFileUpload(pagecontent, fileUrlList);
			DairyPage page=new DairyPage();
			page.setPageNo(pageNo);
			page.setContent(updatedPageContent);
			boolean result=edairyServiceImpl.savePageContent(userId, dairyId, page);
		}
		ModelAndView mvc= new ModelAndView();
		EdairyActionEnum.EDIT_PAGE.toString();
		mvc.setViewName("redirect:/sm/getDairyInfo/"+userId+"/"+dairyId+"?actionBy="+EdairyActionEnum.EDIT_PAGE.toString()+"&defaultPageNo="+pageNo+"&edit="+"YES");
		
		return mvc;
	}//storeFilesInGallery() closing
	@RequestMapping(value="/getUserDairiesList", method=RequestMethod.GET)
	public ModelAndView getUserDairiesList(Principal principal){
		logger.debug(" show user profile ...");
		ModelAndView mvc = new ModelAndView("/customer/user_dairies");
		Users user =this.getUserInfo(principal);
		
		UserDairies  userDairies=edairyServiceImpl.gerUserDairies(user.getUserId());
		mvc.addObject("user", user);
		mvc.addObject("userDairies", userDairies);
		mvc.addObject("diaryActive", true);
		return mvc;
	}//getUserDairiesList() closing
	
	@RequestMapping(value="/getUserDairyCoverPage/{userId}/{dairyId}", method=RequestMethod.GET)
	public ModelAndView getUserDairyCoverPage(Principal principal, @PathVariable("userId") Integer userId,
			@PathVariable("dairyId") Integer dairyId){
		logger.debug("getUserDairyCoverPage");
		
		ModelAndView mvc = new ModelAndView("/customer/edairy_home");
		mvc.addObject("userId", userId);
		mvc.addObject("dairyId", dairyId);
		mvc.addObject("diaryActive", true);
		return mvc;
	}//getUserDairiesList() closing
	
	@RequestMapping(value="/getDairyInfo/{userId}/{dairyId}", method=RequestMethod.GET)
	public ModelAndView getDairyInfo(Principal principal, 
						@PathVariable("userId") Integer userId,
						@PathVariable("dairyId") Integer dairyId,
						@RequestParam String actionBy,
						@RequestParam(name="defaultPageNo", required=false) int defaultPageNo,
						@RequestParam(name="edit", required=false) String goToEditPage){
		logger.debug(" show user profile ...");
		
		Gson gson = new Gson();
		ModelAndView mvc = null;
		if(goToEditPage!=null && goToEditPage.equals("YES")){
			mvc =new ModelAndView("/customer/edit_edairy");
		}else{
			mvc =new ModelAndView("/customer/dairy_content");
		}
		
		DairyInfo  dairyInfo=edairyServiceImpl.getDairyInfo(userId, dairyId,actionBy,defaultPageNo);
		
		//mvc.addObject("showPageNo", 1);
		mvc.addObject("userId", userId);
		mvc.addObject("dairyId", dairyId);
		mvc.addObject("dairyInfo", dairyInfo);
		mvc.addObject("pages", dairyInfo.getPages());
		mvc.addObject("pagelist", gson.toJson(dairyInfo.getPages()));
		mvc.addObject("diaryActive", true);
		return mvc;
	}//getUserDairiesList() closing
	
	
	@RequestMapping(value="/editPageContent/{userId}/{dairyId}", method=RequestMethod.GET)
	public ModelAndView editPageContent(Principal principal, @PathVariable("userId") Integer userId,
			@PathVariable("dairyId") Integer dairyId, @RequestParam Integer pageNo,
			@RequestParam String  content){
		DairyPage page =new DairyPage();
		page.setPageNo(pageNo);
		page.setContent(content);
		logger.debug(" show user profile ...");
		ModelAndView mvc = new ModelAndView("/customer/edit_edairy");
		DairyInfo  dairyInfo=edairyServiceImpl.editPageContent(userId, dairyId, page);
		//DairyInfo  dairyInfo=new DairyInfo();
		List<DairyPage> pages = new ArrayList<DairyPage>();
		pages.add(page);
		dairyInfo.setPages(pages);
		mvc.addObject("showPageNo", page.getPageNo());
		mvc.addObject("userId", userId);
		mvc.addObject("dairyId", dairyId);
		mvc.addObject("dairyInfo", dairyInfo);
		mvc.addObject("page",page);
		mvc.addObject("diaryActive", true);
		return mvc;
	}//getUserDairiesList() closing
	
	
	@RequestMapping(value="/savePageContent", method=RequestMethod.POST)
	public ModelAndView savePageContent(@ModelAttribute("eDairyPageDto") EDairyPageDto eDairyPageDto){
		logger.debug(" show user profile ...");
		ModelAndView mvc = new ModelAndView("/customer/dairy_content");
		DairyInfo  dairyInfo = null;
		DairyPage page= new DairyPage();
		page.setPageNo(eDairyPageDto.getPageNo());
		page.setContent(eDairyPageDto.getContent());
		
		boolean result=edairyServiceImpl.savePageContent(eDairyPageDto.getUserId(), eDairyPageDto.getDairyId(), page);
		dairyInfo =edairyServiceImpl.getDairyInfo(eDairyPageDto.getUserId(), eDairyPageDto.getDairyId(), EdairyActionEnum.VIEW_PAGE.toString(), page.getPageNo());
		//DairyPage defaultPage =new DairyPage();
		//defaultPage =
		mvc.addObject("showPageNo", eDairyPageDto.getPageNo());
		mvc.addObject("userId", eDairyPageDto.getUserId());
		mvc.addObject("dairyId", eDairyPageDto.getDairyId());
		mvc.addObject("dairyInfo", dairyInfo);
		mvc.setViewName("redirect:/sm/getDairyInfo/"+eDairyPageDto.getUserId()+"/"+eDairyPageDto.getDairyId()+"?actionBy=&defaultPageNo="+eDairyPageDto.getPageNo());
		return mvc;
	}//getUserDairiesList() closing
	private Users getUserInfo(Principal principal){
		return userService.findUserByUserName(principal.getName());
	}//getUserInfo() closoing
	
}
