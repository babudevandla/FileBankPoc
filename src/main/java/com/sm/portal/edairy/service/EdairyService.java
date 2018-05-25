package com.sm.portal.edairy.service;

import com.sm.portal.edairy.model.DairyInfo;
import com.sm.portal.edairy.model.DairyPage;
import com.sm.portal.edairy.model.UserDairies;

public interface EdairyService {

	public UserDairies gerUserDairies(int userId);
	public  DairyInfo getDairyInfo(int userId, int dairyId, String actionBy, Integer defaultPageNo);
	public DairyInfo editPageContent(int userId, int dairyId, DairyPage dairyPage);
	public boolean savePageContent(int userId, int dairyId, DairyPage dairyPage);
}
