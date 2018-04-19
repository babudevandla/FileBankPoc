package com.sm.portal.ebook.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.portal.ebook.model.Ebook;
import com.sm.portal.ebook.model.EbookPage;
import com.sm.portal.ebook.model.EbookPageBean;
import com.sm.portal.ebook.model.EbookPageDto;
import com.sm.portal.ebook.model.UserBooks;
import com.sm.portal.ebook.mongo.dao.EbookMongoDao;
import com.sm.portal.service.FileUploadServices;

@Service
public class EbookServiceImpl implements EbookService{

	@Autowired
	public EbookMongoDao ebookMongoDao;
	
	@Autowired
	FileUploadServices fileUploadServices;
	
	@Override
	public UserBooks getEbookList(Integer userId) {

		UserBooks userBooks = ebookMongoDao.getEbookList(userId);
		return userBooks;
	}

	@Override
	public void createUserBook(Ebook ebook) {

		ebookMongoDao.createUserBook(ebook);
	}
	@Override
	public void creatChapter(EbookPageBean ebookPageBean) {

		ebookMongoDao.creatChapter(ebookPageBean);
	}
	@Override
	public void updateChapter(EbookPageBean ebookPageBean) {

		ebookMongoDao.updateChapter(ebookPageBean);
	}
	@Override
	public void updateEbookPage(EbookPageBean ebookPageBean) {

		ebookMongoDao.updateEbookPage(ebookPageBean);
	}
	@Override
	public void updateEbookDetails(Ebook ebook) {

		ebookMongoDao.updateEbookDetails(ebook);
	}

	@Override
	public Ebook getEbookContent(Integer userId, Integer bookId) {

		Ebook ebook=ebookMongoDao.getEbookContent(userId,bookId );
		EbookPage ep=ebook.getEbookPages().get(0);
		ebook.setDefaultPage(ep);
		return ebook;
	}//getEbookContent() closing
	@Override
	public void saveEbookPageContent(EbookPageDto eBookPageDto) {

		ebookMongoDao.saveEbookPageContent(eBookPageDto);
		
	}//saveEbookPageContent() closing

	public void createNewChapter(Integer bookId, Integer pageNo, String chapterName, Integer userId) {
		ebookMongoDao.createNewChapter(bookId,pageNo,chapterName ,userId);	
	}

	public void updateChapter(Integer bookId, Integer pageNo, String chapterName, String existingName, Integer userId) {

		ebookMongoDao.updateChapter(bookId,pageNo,chapterName,existingName ,userId);
	}

	public void updateBookCoverImg(Ebook eBook) {
		String fileURL=null;
		 if (!eBook.getCoverImg().isEmpty()) {
			 fileURL =fileUploadServices.uploadWebDavServer(eBook.getCoverImg());
		 }
		 eBook.setCoverImage(fileURL);
		 ebookMongoDao.updateBookCoverImg(eBook);
	}
	
	
	
}//class closing
