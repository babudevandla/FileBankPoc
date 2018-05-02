package com.sm.portal.digilocker.model;

public enum DigiLockerEnum {

	LOCKER(1,"LOCKER"),
	GALLERY(2,"GALLERY"),
	EDAIRY(3,"EDAIRY"),
	EBOOK(4,"EBOOK");
	
	private int	id;
	private String status;
	private DigiLockerEnum(int id, String status)
	{
		this.id = id;
		this.status = status;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	static DigiLockerEnum[] values = values();

	public static DigiLockerEnum getStatus(int id)
	{
		for (DigiLockerEnum value : values)
		{
			if (value.getId() == id)
				return value;
		}
		return null;
	}
}
