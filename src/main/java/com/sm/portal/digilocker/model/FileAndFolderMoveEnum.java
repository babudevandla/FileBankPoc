package com.sm.portal.digilocker.model;


public enum FileAndFolderMoveEnum {

	FILE_MOVE(1, "FILE_MOVE"),
	FOLDER_MOVE(2,"FOLDER_MOVE");
	
	private int	fileMoveId;
	private String fileMoveName;
	private FileAndFolderMoveEnum(int fileMoveId, String fileMoveName)
	{
		this.fileMoveId = fileMoveId;
		this.fileMoveName = fileMoveName;
	}
	
	
	static FileAndFolderMoveEnum[] values = values();
	
	public int getFileMoveId() {
		return fileMoveId;
	}
	public void setFileMoveId(int fileMoveId) {
		this.fileMoveId = fileMoveId;
	}
	public String getFileMoveName() {
		return fileMoveName;
	}
	public void setFileMoveName(String fileMoveName) {
		this.fileMoveName = fileMoveName;
	}
	public static FileAndFolderMoveEnum getBookSizes(int fileMoveId)
	{
		for (FileAndFolderMoveEnum value : values)
		{
			if (value.getFileMoveId() == fileMoveId)
				return value;
		}
		return null;
	}	
}
