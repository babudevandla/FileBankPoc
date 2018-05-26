package com.sm.portal.digilocker.service;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.sm.portal.digilocker.model.FilesInfo;
import com.sm.portal.digilocker.model.FolderInfo;
import com.sm.portal.digilocker.model.GalleryDetails;
import com.sm.portal.digilocker.model.GallerySearchVo;
import com.sm.portal.digilocker.model.MoveFilesAndFoldersBean;
import com.sm.portal.ebook.model.Ebook;

public interface DigilockerService {

	public List<FolderInfo> getDigiLockerHomeData(Long userId);

	public List<FolderInfo> getRootFoldersList(List<FolderInfo> allFolderList);

	public FolderInfo getFolderInfo(List<FolderInfo> allFolderList,Integer fid);

	public void storeNewFileOrFolderInfo(FolderInfo FolderInfo, Integer folderId, Integer userid);
	public void storeNewFolderInfo(FolderInfo FolderInfo, Integer folderId, Integer userid);

	public void updateFileOrFolderSatus(String deleteInfo, String action, Integer folderId, Integer fileId, Integer userId);

	public void showHiddenFoldersAndFiles(Integer fid, Integer userid);
	public FolderInfo getGalleryDetails(String origin);

	public FolderInfo createNewFolder(Integer userid, String foldername, String currentFolderPath,
			List<FolderInfo> allFolderList, String isThisFolderForRootFiles);

	public String uploadFiles(MultipartFile multipart, Integer userid, String folderPath, Integer folderId, HttpServletRequest request);

	public void storeFilesInGalleryFromDigiLocker(Integer userId, Integer folderId, MultipartFile[] multipartList, HttpServletRequest request);

	public FolderInfo checkAndCreateGalleryFolder(String origin);

	public void storeFilesInFileBank(MultipartFile multipart, String folderPath, Integer folderId);
	
	public void moveFolderToAnothreFolder(Integer sourceFolderId, Integer destinationFolderParentId);

	public void moveFileToAnotherFolder(MoveFilesAndFoldersBean moveFilesAndFoldersBean);

	public List<FolderInfo> getRootFoldersList();

	public List<FolderInfo> getChildFolders(int parentFolderId);

	public FolderInfo getFolderInfo(Integer fid);


	List<FolderInfo> getAllFolders();

	public FolderInfo getFolderInfoForRootFiles();

	void storeFilesInGallery(FolderInfo newFolderInfo, Integer folderId, Integer userId);

	public List<GalleryDetails> getGallerContent(GallerySearchVo gallerySearchVo) throws ParseException;


}
