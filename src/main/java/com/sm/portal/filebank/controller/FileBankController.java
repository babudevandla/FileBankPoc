package com.sm.portal.filebank.controller;

import java.security.Principal;
import java.text.ParseException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sm.portal.constants.URLCONSTANT;
import com.sm.portal.digilocker.model.GalleryDetails;
import com.sm.portal.digilocker.service.DigilockerService;
import com.sm.portal.ebook.model.EbookPageDto;
import com.sm.portal.ebook.service.EbookServiceImpl;
import com.sm.portal.edairy.model.DairyPage;
import com.sm.portal.edairy.model.EdairyActionEnum;
import com.sm.portal.edairy.service.EdairyServiceImpl;
import com.sm.portal.filebank.bean.FileBankCloudBean;
import com.sm.portal.filters.ThreadLocalInfoContainer;

@RestController
@RequestMapping(URLCONSTANT.BASE_URL)
public class FileBankController {

	private static final Logger logger = LoggerFactory.getLogger(FileBankController.class);
	
	@Autowired
	DigilockerService digilockerService;
	
	@Autowired
	EdairyServiceImpl edairyServiceImpl;
	
	@Autowired
    private EbookServiceImpl ebookServiceImple;
	
	@GetMapping(value="/getFileBankList")
	public ModelAndView getFileBankList(@RequestParam(name="userid", required=false) Integer userid,Principal principal,
			@RequestParam(name="filesType", required=false) String filesType,@RequestParam(name="fileStatus", required=false) String fileStatus,
			@RequestParam(name="fileOrigin", required=false) String fileOrigin
			,HttpServletRequest request){
		if (logger.isInfoEnabled())
			logger.info("FileBankController ::: getFileBankList ::: Start ");
		ModelAndView mvc = new ModelAndView("/filebank/filebank_list");
		if(userid==null){
			try{
				userid=(Integer) (ThreadLocalInfoContainer.INFO_CONTAINER.get()).get("USER_ID");
			}catch(Exception e){e.printStackTrace();}
		}
		try {
			if(filesType==null)
				filesType="ALL";
			List<GalleryDetails> gallerylist = digilockerService.getGallerContent(userid, filesType,fileStatus);
			if(fileOrigin!=null)
				gallerylist=gallerylist.stream().filter( g -> fileOrigin.equals(g.getOrigin())).collect(Collectors.toList());
			
			mvc.addObject("galleryContent", gallerylist);
			mvc.addObject("fileType", filesType);

			boolean allCls=false;
			boolean imgCls=false;
			boolean audCls=false;
			boolean vedCls=false;
			boolean docCls=false;
			
			boolean recyleCls=false;
			if(filesType.equals("ALL") && fileStatus==null)
				allCls=true;
			else if(filesType.equals("IMAGE"))
				imgCls=true;
			else if(filesType.equals("AUDIO"))
				audCls=true;
			else if(filesType.equals("VIDEO"))
				vedCls=true;
			else if(filesType.equals("DOCUMENT"))
				docCls=true;
			
			if(fileStatus!=null && fileStatus.equals("DELETED"))
				recyleCls=true;
			
			
			mvc.addObject("allCls", allCls);
			mvc.addObject("imgCls", imgCls);
			mvc.addObject("audCls", audCls);
			mvc.addObject("vedCls", vedCls);
			mvc.addObject("docCls", docCls);
			mvc.addObject("recyleCls", recyleCls);
			
			mvc.addObject("userid", userid);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		mvc.addObject("digiLockActive", true);
		
		if (logger.isInfoEnabled())
			logger.info("FileBankController ::: getFileBankList ::: End ");
		return mvc;
	}//getGallerContent() closing
	
	@PostMapping(value="/uploadFileBankFilesInCloud")
	public ModelAndView uploadFileBankCloudFiles(@ModelAttribute("bankCloudBean") FileBankCloudBean bankCloudBean,Principal principal,
			RedirectAttributes redirectAttributes, HttpServletRequest request){
		/**
		 * id(dairy/ebook id), content, pageNo, filePaths[], actionType="EBOOK/EDAIRY(enum)"
		 * 
		 */
		logger.debug(" show fileManagement ...");
		Integer userId =(Integer) (ThreadLocalInfoContainer.INFO_CONTAINER.get()).get("USER_ID");
		List<String> fileUrlList =edairyServiceImpl.getAbsoluteUrls(Arrays.asList(bankCloudBean.getFilePaths()));
		ModelAndView mvc= new ModelAndView();
		String updatedPageContent=null;
		if(fileUrlList.size()>0){
			updatedPageContent =edairyServiceImpl.getContentAfterFileUpload(bankCloudBean.getContent(), fileUrlList);			
		}else{
			updatedPageContent=bankCloudBean.getContent();
		}
		if("EDAIRY".equalsIgnoreCase(bankCloudBean.getActionType())) {//actiontype
			DairyPage page=new DairyPage();
			page.setPageNo(bankCloudBean.getPageNo());
			page.setContent(updatedPageContent);
			boolean result=edairyServiceImpl.savePageContent(userId, bankCloudBean.getId(), page);
			mvc.setViewName("redirect:/sm/getDairyInfo/"+userId+"/"+bankCloudBean.getId()+"?actionBy="+EdairyActionEnum.EDIT_PAGE.toString()+"&defaultPageNo="+bankCloudBean.getPageNo()+"&edit="+"YES");
			
		}else if("EBOOK".equalsIgnoreCase(bankCloudBean.getActionType())){
			EbookPageDto ebookPageDto =new EbookPageDto();
			ebookPageDto.setUserId(userId);
			ebookPageDto.setBookId(bankCloudBean.getId());
			ebookPageDto.setContent(updatedPageContent);
			ebookPageDto.setPageNo(bankCloudBean.getPageNo());
			
			ebookServiceImple.saveEbookPageContent(ebookPageDto);
			mvc.setViewName("redirect:/sm/editEbookContent?userId="+userId+"&bookId="+bankCloudBean.getId()+"&defaultPageNo="+bankCloudBean.getPageNo());
		}else if("GALLERY".equalsIgnoreCase(bankCloudBean.getActionType())){
			
		}
		return mvc;
		
	}//uploadFiles() closing
	
}
