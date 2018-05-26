package com.sm.portal.ebook.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sm.portal.constants.URLCONSTANT;
import com.sm.portal.controller.EDairyController;
import com.sm.portal.digilocker.model.DigiLockerEnum;
import com.sm.portal.digilocker.model.DigiLockerStatusEnum;
import com.sm.portal.digilocker.model.FilesInfo;
import com.sm.portal.digilocker.model.FolderInfo;
import com.sm.portal.digilocker.service.DigilockerService;
import com.sm.portal.digilocker.utils.DigiLockeUtils;
import com.sm.portal.ebook.enums.BookSizeEnum;
import com.sm.portal.ebook.enums.PageSizeEnum;
import com.sm.portal.ebook.model.BookSearchDto;
import com.sm.portal.ebook.model.Ebook;
import com.sm.portal.ebook.model.EbookPage;
import com.sm.portal.ebook.model.EbookPageBean;
import com.sm.portal.ebook.model.EbookPageDto;
import com.sm.portal.ebook.model.UserBooks;
import com.sm.portal.ebook.service.EbookServiceImpl;
import com.sm.portal.edairy.model.DairyPage;
import com.sm.portal.edairy.model.EdairyActionEnum;
import com.sm.portal.edairy.service.EdairyServiceImpl;
import com.sm.portal.filters.ThreadLocalInfoContainer;
import com.sm.portal.model.Users;
import com.sm.portal.service.FileUploadServices;
import com.sm.portal.service.UserService;
import com.sm.portal.uniquekeys.UniqueKeyDaoImpl;
import com.sm.portal.uniquekeys.UniqueKeyEnum;


@RestController
@RequestMapping(URLCONSTANT.BASE_URL)
public class EbookController {

	Logger logger=Logger.getLogger(EDairyController.class.getName());
	@Autowired
	FileUploadServices fileUploadServices;
	
	@Autowired
    private EbookServiceImpl ebookServiceImple;
	
	@Autowired
    private UserService userService;
	
	@Autowired
	DigilockerService digilockerService;
	
	@Autowired
	EdairyServiceImpl edairyServiceImpl;
	
	@Autowired
	DigiLockeUtils digiLockerUtils;
	
	@Autowired
	UniqueKeyDaoImpl uniqueKeyDaoImpl;
	
	@RequestMapping(value="/eBooklist", method=RequestMethod.GET)
	public ModelAndView getEbookList(@ModelAttribute("searchDto") BookSearchDto searchDto, Principal principal){
		ModelAndView mav = new ModelAndView("/ebook/ebook_home");
		Users user =userService.findUserByUserName(principal.getName());
		if(searchDto.getUserId()==null)
			searchDto.setUserId(user.getUserId());
		UserBooks userBooks = ebookServiceImple.getEbookListBySearch(searchDto);
		
		//userBooks.getBooks().stream().sorted().collect(Collectors.toList());
		mav.addObject("userBooks",userBooks);
		if(user.getUserId()!=null)mav.addObject("userId",user.getUserId());
		else mav.addObject("userId",searchDto.getUserId());
		return mav;
	}//getEbookList() closing
	
	@RequestMapping(value="/creatEbook", method=RequestMethod.GET)
	public ModelAndView creatEbook(@RequestParam Integer userId, @ModelAttribute("eBook") Ebook eBook){
		ModelAndView mav = new ModelAndView("/ebook/CreateNewBook");
		mav.addObject("userId",userId);
		mav.addObject("bookSizeEnumList", BookSizeEnum.values());
		mav.addObject("pageSizeEnumList", PageSizeEnum.values());
		return mav;
	}//getEbookList() closing
	
	@RequestMapping(value="/uploadCoverimg", method=RequestMethod.POST)
	public ModelAndView uploadCoverimg(@ModelAttribute Ebook eBook,BindingResult result, HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		//FolderInfo gallery =digilockerService.getGalleryDetails(eBook.getUserId());
		FolderInfo gallery =digilockerService.getGalleryDetails(DigiLockerEnum.EBOOK.toString());
		if(gallery==null){
			gallery =digilockerService.checkAndCreateGalleryFolder(DigiLockerEnum.EBOOK.toString());
		}
		ebookServiceImple.updateBookCoverImg(eBook,gallery);
		mav.setViewName("redirect:/sm/eBooklist?userId="+eBook.getUserId());
		return mav;
	}//getEbookList() closing
	
	@RequestMapping(value="/creatEbook", method=RequestMethod.POST)
	public ModelAndView creatEbookSubmit(@ModelAttribute Ebook eBook,BindingResult result, HttpServletRequest request,Principal principal){
		ModelAndView mav = new ModelAndView();
		Users user =userService.findUserByUserName(principal.getName());
		int	fileUniqueKey=uniqueKeyDaoImpl.getUniqueKey(eBook.getUserId(), UniqueKeyEnum.BOOK_ID.toString(), 1);
		eBook.setBookId(fileUniqueKey);
		eBook.setCreatedBy(user.getFirstname()+" "+user.getLastname());
		ebookServiceImple.createUserBook(eBook);
		mav.setViewName("redirect:/sm/eBooklist?userId="+eBook.getUserId());
		return mav;
	}//getEbookList() closing
	
	@RequestMapping(value="/getEbookContent", method=RequestMethod.GET)
	public ModelAndView getEbookContent(@RequestParam Integer userId, @RequestParam Integer bookId,
			@RequestParam(required=false) Integer  defaultPageNo){
		ModelAndView mav = new ModelAndView("/ebook/ebook_content");
		Gson gson = new Gson();
		
		Ebook ebook =ebookServiceImple.getEbookContent(userId, bookId);
		if(defaultPageNo!=null){
			for(EbookPage ep:ebook.getEbookPages()){
				if(ep.getPageNo()==defaultPageNo.intValue()){
					ebook.setDefaultPage(ep);
					break;
				}//if closing
			}//for closing
		}
		mav.addObject("pagelist", gson.toJson(ebook.getEbookPages()));
		mav.addObject("eBook", ebook);
		mav.addObject("defaultPageNo", defaultPageNo);
		return mav;
	}//getEbookContent() closing
	
	
	@RequestMapping(value="/editEbookContent", method=RequestMethod.GET)
	public ModelAndView editEbookContent(@RequestParam Integer userId, 
										 @RequestParam Integer bookId,
										 @RequestParam Integer defaultPageNo){
		ModelAndView mav = new ModelAndView("/ebook/edit_content");
		Gson gson = new Gson();
		
		Ebook ebook =ebookServiceImple.getEbookContent(userId, bookId);
		for(EbookPage ep:ebook.getEbookPages()){
			if(ep.getPageNo()==defaultPageNo.intValue()){
				ebook.setDefaultPage(ep);
				break;
			}//if closing
		}//for closing
		mav.addObject("pagelist", gson.toJson(ebook.getEbookPages()));
		mav.addObject("eBook", ebook);
		return mav;
	}//getEbookContent() closing
	
	@RequestMapping(value="/saveEbookPageContent", method=RequestMethod.POST)
	public ModelAndView saveEbookPageContent(@ModelAttribute("eBookPageDto") EbookPageDto eBookPageDto){
		ModelAndView mav = new ModelAndView("/ebook/edit_content");
		/*eBookPageDto.setUserId(1);
		eBookPageDto.setBookId(60002);
		eBookPageDto.setContent("content update-2");
		eBookPageDto.setPageNo(2);*/
		ebookServiceImple.saveEbookPageContent(eBookPageDto);
		
		
		mav.setViewName("redirect:/sm/getEbookContent?userId="+eBookPageDto.getUserId()+"&bookId="+eBookPageDto.getBookId()+"&defaultPageNo="+eBookPageDto.getPageNo());
		return mav;
	}//saveEbookPageContent() closing
	
	
	@RequestMapping(value = "/storeFilesInGalleryFromEbook", method = RequestMethod.POST)
	public ModelAndView  storeFilesInGalleryFromEbook(@RequestParam("userId") Integer userId,
			 @RequestParam("bookId") Integer bookId,
			 @RequestParam("pageNo") Integer pageNo,
			 @RequestParam("bookPagecontent") String pagecontent,
			 @RequestParam("files") MultipartFile multipartList[],
			 HttpServletRequest request) {
		//FolderInfo gallery =digilockerService.getGalleryDetails(userId);
		FolderInfo gallery =digilockerService.getGalleryDetails(DigiLockerEnum.EBOOK.toString());
		if(gallery==null){
			gallery =digilockerService.checkAndCreateGalleryFolder(DigiLockerEnum.EBOOK.toString());
		}
		
		String fileURL=null;
		List<String> fileUrlList=new ArrayList<>();
		List<FilesInfo> newFileList = new ArrayList<>();
		FilesInfo filesInfo = null;
		DigiLockeUtils digiLockerUtils = new DigiLockeUtils();
		for (int i=0;i<multipartList.length;i++) {	
            if (!multipartList[i].isEmpty()) {
            	fileURL =fileUploadServices.uploadWebDavServer(multipartList[i], gallery.getFolderPath(),request);
            	if(fileURL!=null){
	            	fileUrlList.add(fileURL);
	            	filesInfo =new FilesInfo();
	            	String fileName = multipartList[i].getOriginalFilename();
	        		//String filePath = multipartList[i]+fileName.replaceAll(" ", "_");
	            	filesInfo.setFileId(digiLockerUtils.gerUniqueKey(request));
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
			digilockerService.storeFilesInGallery(gallery, gallery.getFolderId(), userId);
			
			String updatedPageContent =edairyServiceImpl.getContentAfterFileUpload(pagecontent, fileUrlList);
			/*EbookPage page=new EbookPage();
			page.setPageNo(pageNo);
			page.setContent(updatedPageContent);*/
			
			EbookPageDto ebookPageDto =new EbookPageDto();
			ebookPageDto.setUserId(userId);
			ebookPageDto.setBookId(bookId);
			ebookPageDto.setContent(updatedPageContent);
			ebookPageDto.setPageNo(pageNo);
			
			ebookServiceImple.saveEbookPageContent(ebookPageDto);
		}
		ModelAndView mvc= new ModelAndView();
		EdairyActionEnum.EDIT_PAGE.toString();
		mvc.setViewName("redirect:/sm/editEbookContent?userId="+userId+"&bookId="+bookId+"&defaultPageNo="+pageNo);
		
		return mvc;
	}//storeFilesInGalleryFromEbook() closing
	
	@RequestMapping(value = "/storeCloudFilesInEbookPageContent", method = RequestMethod.POST)
	public ModelAndView storeCloudFilesInEbookPageContent(@ModelAttribute EbookPage ebookPage, @RequestParam("bookId") Integer bookId, @RequestParam("fileList") List<String> fileUrlList) {
		
		fileUrlList =edairyServiceImpl.getAbsoluteUrls(fileUrlList);
		Integer userId =(Integer) (ThreadLocalInfoContainer.INFO_CONTAINER.get()).get("USER_ID");
		if(fileUrlList.size()>0){
						
			String updatedPageContent =edairyServiceImpl.getContentAfterFileUpload(ebookPage.getContent(), fileUrlList);
			EbookPageDto ebookPageDto =new EbookPageDto();
			ebookPageDto.setUserId(userId);
			ebookPageDto.setBookId(bookId);
			ebookPageDto.setContent(updatedPageContent);
			ebookPageDto.setPageNo(ebookPage.getPageNo());
			
			ebookServiceImple.saveEbookPageContent(ebookPageDto);
		}
		ModelAndView mvc= new ModelAndView();
		EdairyActionEnum.EDIT_PAGE.toString();
		mvc.setViewName("redirect:/sm/editEbookContent?userId="+userId+"&bookId="+bookId+"&defaultPageNo="+ebookPage.getPageNo());
		return mvc;
	}//storeCloudFilesInEbookPageContent() closing
	
	
	
	
	@RequestMapping(value="/updateEbookDetails", method=RequestMethod.POST)
	public ModelAndView updateEbookDetails(@ModelAttribute Ebook ebook){
		ModelAndView mav = new ModelAndView();
		ebookServiceImple.updateEbookDetails(ebook);
		return mav;
	}//getEbookList() closing
	

	
	
	@RequestMapping(value="/creatChapter", method=RequestMethod.POST)
	public ModelAndView creatChapter(@ModelAttribute EbookPageBean ebookPageBean){
		ModelAndView mav = new ModelAndView();
		ebookServiceImple.creatChapter(ebookPageBean);
		return mav;
		
	}//creatChapter() closing
	
	@RequestMapping(value="/updateChapter", method=RequestMethod.POST)
	public ModelAndView updateChapter(@ModelAttribute EbookPageBean ebookPageBean){
		ModelAndView mav = new ModelAndView();
		ebookServiceImple.updateChapter(ebookPageBean);
		return mav;
		
	}//creatChapter() closing
	
	@RequestMapping(value="/updateEbookPage", method=RequestMethod.POST)
	public ModelAndView updateEbookPage(@ModelAttribute EbookPageBean ebookPageBean){
		ModelAndView mav = new ModelAndView();
		ebookServiceImple.updateEbookPage(ebookPageBean);
		return mav;
		
	}//creatChapter() closing
	
	@RequestMapping(value="/getUniqueValue", method=RequestMethod.GET)
	public Integer getUniqueValue(@RequestParam(name="userId", required=false) Integer userId,
			@RequestParam(name="uniqueKeyProperty", required=false) String uniqueKeyProperty){
		Integer uniqueKey=null;
		if(userId==null && uniqueKeyProperty==null)
			 uniqueKey=uniqueKeyDaoImpl.getUniqueKey(1, UniqueKeyEnum.DAIRY_ID.toString(), 1);
		else if(userId==null)
			uniqueKey=uniqueKeyDaoImpl.getUniqueKey(1, uniqueKeyProperty, 1);
		else
			uniqueKey=uniqueKeyDaoImpl.getUniqueKey(userId, UniqueKeyEnum.DAIRY_ID.toString(), 1);
		return uniqueKey;
	}//getUniqueValue() closing
	
	@RequestMapping(value="/createNewChapter")
	public ModelAndView createNewChapter(@RequestParam Integer bookId,@RequestParam Integer userId,
			@RequestParam Integer pageNo,
			@RequestParam String newChapterName,
			@RequestParam String existingName){
		if(userId==null){
			userId=(Integer) (ThreadLocalInfoContainer.INFO_CONTAINER.get()).get("USER_ID");
		}
		ModelAndView mav =new ModelAndView();
		ebookServiceImple.createNewChapter(bookId,pageNo, newChapterName,userId);
		mav.setViewName("redirect:/sm/editEbookContent?userId="+userId+"&bookId="+bookId+"&defaultPageNo="+pageNo);
		return mav;
		
	}//createNewChapter() closing
	@RequestMapping(value="/updateChapter")
	public ModelAndView updateChapter(@RequestParam Integer bookId,@RequestParam Integer userId,
			@RequestParam Integer pageNo,
			@RequestParam String newChapterName,
			@RequestParam String existingName){
		if(userId==null){
			userId=(Integer) (ThreadLocalInfoContainer.INFO_CONTAINER.get()).get("USER_ID");
		}
		ebookServiceImple.updateChapter(bookId,pageNo, newChapterName,existingName,userId);
		
		ModelAndView mav =new ModelAndView();	
		mav.setViewName("redirect:/sm/editEbookContent?userId="+userId+"&bookId="+bookId+"&defaultPageNo="+pageNo);
		return mav;
		
	}//createNewChapter() closing
	
	
}//class closing
