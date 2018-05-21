package com.sm.portal.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sm.portal.constants.Email;
import com.sm.portal.constants.MESSAGECONSTANT;
import com.sm.portal.constants.SMSGateway;
import com.sm.portal.constants.URLCONSTANT;
import com.sm.portal.ebook.model.BookSearchDto;
import com.sm.portal.ebook.model.UserBooks;
import com.sm.portal.ebook.service.EbookServiceImpl;
import com.sm.portal.edairy.model.UserDairies;
import com.sm.portal.edairy.service.EdairyServiceImpl;
import com.sm.portal.model.Users;
import com.sm.portal.model.UsersDto;
import com.sm.portal.service.FileUploadServices;
import com.sm.portal.service.UserService;

@Controller
public class FrontendController extends CommonController{

	private static final Logger logger = LoggerFactory.getLogger(FrontendController.class);
	
	@Autowired
	public UserService userService;
	
	@Autowired
	FileUploadServices fileUploadServices;
	
	@Autowired
    private EbookServiceImpl ebookServiceImple;
	
	@Autowired
	EdairyServiceImpl edairyServiceImpl;
	
	@PostMapping(value=URLCONSTANT.LOGIN_PAGE)
	public ModelAndView loginSubmit(@ModelAttribute UsersDto usersDto , final RedirectAttributes redirectAttributes){
		if(logger.isTraceEnabled())logger.info("FrontOendCntroller --- loginSubmit --start");
		ModelAndView model=new ModelAndView("common/login");
		boolean flag=false;
		if(StringUtils.isNotEmpty(usersDto.getMobile_no()) && StringUtils.isNotEmpty(usersDto.getPassword())){
			Users userInfo=userService.getUserByUsernamePassword(usersDto);
			if(userInfo!=null){
				if(userInfo.isDynamic_status()){
					redirectAttributes.addFlashAttribute("user",userInfo);
					model.setViewName("redirect:/sm/dashboard");
				}else{
					model.addObject("userId",userInfo.getUserId());
					model.setViewName("redirect:/dynamic-access-code");
				
				}
			}else{
				flag=true;
				model.setViewName("common/login");
				model.addObject("message", MESSAGECONSTANT.LOGIN_FAILURE);
				model.addObject("flag", flag);
			}
		}else{
			flag=true;
			model.setViewName("common/login");
			model.addObject("message", MESSAGECONSTANT.LOGIN_EMPTY_FAILURE);
			model.addObject("flag", flag);
		}
		if(logger.isTraceEnabled())logger.info("FrontOendCntroller --- loginSubmit --end");
		return model;
	}
	
	@GetMapping(value=URLCONSTANT.DASHBOARD)
	public ModelAndView dashboard(Principal principal){
		ModelAndView model=new ModelAndView();
		try {
			Users user=userService.findUserByUserName(principal.getName());
			model.addObject("user",user);
			model.setViewName("customer/dashboard");
			BookSearchDto searchDto=new BookSearchDto();
			searchDto.setUserId(user.getUserId());
			UserBooks userBooks = ebookServiceImple.getEbookListBySearch(searchDto);
			UserDairies  userDairies=edairyServiceImpl.gerUserDairies(user.getUserId());
			
			model.addObject("booksSize",userBooks.getBooks().size());
			model.addObject("dairysSize",userDairies.getDairyList().size());
			//create userid folder under webdav
			fileUploadServices.createDefaultUserIdFolder(user.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	@GetMapping(value=URLCONSTANT.SIGNUP_PAGE)
	public ModelAndView signup(@RequestParam(value="message",required=false) String message){
		if(logger.isTraceEnabled())logger.info("FrontendCntroller --- signup --start");
		System.out.println("singup");
		ModelAndView model=new ModelAndView("common/signup");
		model.addObject("message",message);
		
		return model;
	}
	
	@PostMapping(value=URLCONSTANT.SIGNUP_PAGE)
	public ModelAndView signupProcess(@ModelAttribute UsersDto users,HttpServletRequest request){
		if(logger.isTraceEnabled())
			logger.info("FrontendCntroller --- signupProcess --start");
		
		ModelAndView model=new ModelAndView("common/signup");
		boolean flag=false;
		if(users!=null){
			System.out.println(users.getFirstname()+"::::"+users.getMobile_no());
			String dynamicCode=getDynamicCode(); 
			users.setDynamic_access_code(dynamicCode);
			String final_url=SMSAuthetications(users);
			boolean smsStatus=SMSGateway.SendDynamicAccessCode(final_url);
			Integer userId= userService.saveUser(users,request);
			if(userId!=null){
				userService.updateDynamicCode(dynamicCode,users);
				if(smsStatus){
					Email email=new Email();
					email.setMailto(users.getEmail());
					emailSender.sendUserRegisterConformation(users,email, velocityEngine, request);
					model.setViewName("common/dynamic-access-code");
					model.addObject("message", MESSAGECONSTANT.ACCOUNT_CREATE_SUCCESS);
					model.addObject("userId",userId);
					model.addObject("flag",flag);
					
					return model;
				}else{
					flag=true;
					model.setViewName("common/signup");
					model.addObject("message", MESSAGECONSTANT.GENERATED_DAC_FAILURE);
					model.addObject("flag",flag);
					return model;
				}
				//create userid folder under webdav
				//fileUploadServices.createDefaultUserIdFolder(user.getUserId());
			}else{
				flag=true;
				model.setViewName("common/signup");
				model.addObject("message", MESSAGECONSTANT.ACCOUNT_CREATE_FAILURE);
				model.addObject("flag",flag);
				return model;
			}
		}
		return model;
		
	}
	@GetMapping(value=URLCONSTANT.DYNAMIC_ACCESS_CODE)
	public ModelAndView dynamicAccessCode(@RequestParam Integer userId){
		if(logger.isTraceEnabled())
			logger.info("FrontendCntroller --- dynamicAccessCode --start");
		ModelAndView model=new ModelAndView();
		boolean flag=false;
		if(userId!=null){
			model.setViewName("common/dynamic-access-code");
			model.addObject("userId",userId);
		}else{
			flag=true;
			model.setViewName("common/login");
			model.addObject("message", MESSAGECONSTANT.LOGIN_EMPTY_USER_FAILURE);
			model.addObject("flag", flag);
		}
		return model;
	}
	
	
	@GetMapping(value=URLCONSTANT.RE_GENARATE)
	public ModelAndView reGenerateDAC(@PathVariable Integer userId){
		if(logger.isTraceEnabled())
			logger.info("FrontendCntroller --- reGenerateDAC --start");
		
		ModelAndView model=new ModelAndView("common/signup");
		UsersDto users=new UsersDto();
		Users user=null;
		boolean flag=false;
		if(userId!=null){
			user=userService.getUserById(userId);
			String dynamicCode=getDynamicCode();
			users.setFirstname(user.getFirstname());
			users.setLastname(user.getLastname());
			users.setMobile_no(user.getMobile_no());
			users.setDynamic_access_code(dynamicCode);
			String final_url=SMSAuthetications(users);
			
			userService.updateDynamicCode(dynamicCode,users);
			boolean smsStatus=SMSGateway.SendDynamicAccessCode(final_url);
			if(smsStatus){
				model.setViewName("common/dynamic-access-code");
				model.addObject("message", MESSAGECONSTANT.GENERATED_DAC_SUCCESS);
				model.addObject("userId",userId);
				model.addObject("flag",flag);
				return model;
			}else{
				flag=true;
				model.setViewName("common/signup");
				model.addObject("message", MESSAGECONSTANT.GENERATED_DAC_FAILURE);
				model.addObject("flag",flag);
				return model;
			}
		}
		return model;
	}
	
	@GetMapping(value=URLCONSTANT.SUBMIT_DAC)
	public ModelAndView submitDAC(@ModelAttribute UsersDto userDto){
		if(logger.isTraceEnabled())
			logger.info("FrontendCntroller --- submitDAC --start");
		
		ModelAndView model=new ModelAndView();
		Users user=null;
		boolean flag=false;
		if(StringUtils.isNotBlank(userDto.getDynamic_access_code()) && userDto.getUserId()!=null){
			user=userService.checkDynamicAccessCode(userDto);
			if(user!=null){
				userService.updateUserInfo(userDto);
				model.setViewName("redirect:/login");
				model.addObject("message",MESSAGECONSTANT.ACCOUNT_CREATE_SUCCESS);
				model.addObject("user",user);
			}else{
				flag=true;
				model.setViewName("common/dynamic-access-code");
				model.addObject("message", MESSAGECONSTANT.DAC_CHECK_FAIL);
				model.addObject("userId",userDto.getUserId());
				model.addObject("flag",flag);
			}
		}else{
			flag=true;
			model.setViewName("common/dynamic-access-code");
			model.addObject("message", MESSAGECONSTANT.DAC_NOT_ENTER);
			model.addObject("userId",userDto.getUserId());
			model.addObject("flag",flag);
		}
		if(logger.isTraceEnabled())
			logger.info("FrontendCntroller --- submitDAC --end");
		
		return model;
	}
	
	
	
}
