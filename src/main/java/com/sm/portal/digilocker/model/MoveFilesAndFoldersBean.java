package com.sm.portal.digilocker.model;

public class MoveFilesAndFoldersBean {

	private Integer sourceFolderId;
	private Integer sourceFileId;
	private Integer destinationFolderId;
	private  FileAndFolderMoveEnum moveType;
	private Integer destinationFolderParentId;
	
	
	public Integer getSourceFolderId() {
		return sourceFolderId;
	}
	public void setSourceFolderId(Integer sourceFolderId) {
		this.sourceFolderId = sourceFolderId;
	}
	public Integer getSourceFileId() {
		return sourceFileId;
	}
	public void setSourceFileId(Integer sourceFileId) {
		this.sourceFileId = sourceFileId;
	}
	public Integer getDestinationFolderId() {
		return destinationFolderId;
	}
	public void setDestinationFolderId(Integer destinationFolderId) {
		this.destinationFolderId = destinationFolderId;
	}
	public FileAndFolderMoveEnum getMoveType() {
		return moveType;
	}
	public void setMoveType(FileAndFolderMoveEnum moveType) {
		this.moveType = moveType;
	}
	public Integer getDestinationFolderParentId() {
		return destinationFolderParentId;
	}
	public void setDestinationFolderParentId(Integer destinationFolderParentId) {
		this.destinationFolderParentId = destinationFolderParentId;
	}
	
	
}//class closing
