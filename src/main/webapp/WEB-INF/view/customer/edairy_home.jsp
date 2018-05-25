<%@ page pageEncoding="ISO-8859-1"  contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@taglib prefix="defaultTemplate" tagdir="/WEB-INF/tags"%>
<%@ page import="com.sm.portal.edairy.model.EdairyActionEnum" %>
 <script src="${contextPath}/resources/default/js/jquery-3.1.1.min.js"></script>

<defaultTemplate:defaultDecorator>
<jsp:attribute name="title">E-Diary</jsp:attribute>
<jsp:body>
	<%-- <a href="${contextPath}/sm/getDairyInfo/${userId}/${dairyId}?actionBy=${EdairyActionEnum.TODAYS_PAGE}" class="btn btn-primary">Go to today's page</a>
	<a href="${contextPath}/sm/getDairyInfo/${userId}/${dairyId}?actionBy=${EdairyActionEnum.LAST_UPDATD_DATE}" class="btn btn-primary">Go to last updated page</a>
	<a href="${contextPath}/sm/getDairyInfo/${userId}/${dairyId}?actionBy=${EdairyActionEnum.SELECTED_DATE}" class="btn btn-primary">Select date to open page</a></br></br> --%>
	<a href="${contextPath}/sm/getFavourateDairyInfo/${userId}/${dairyId}?actionBy=${EdairyActionEnum.FAVORITE_PAGE}&favourate=true" class="btn btn-primary">
		<i class="fa fa-heart" aria-hidden="true"></i> Select favorite Pages
	</a>
	<a href="${contextPath}/sm/getDairyInfo/${userId}/${dairyId}?actionBy=${EdairyActionEnum.TITLE_PAGE}" class="btn btn-primary">
		Open all pages
	</a>
	<%-- <a href="${contextPath}/sm/getDairyInfo/${userDairies.userId}/${dairy.dairyId}" >${dairy.name}</a> --%>
    
</jsp:body>
 </defaultTemplate:defaultDecorator>