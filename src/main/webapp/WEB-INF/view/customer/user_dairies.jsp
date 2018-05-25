<%@ page pageEncoding="ISO-8859-1"  contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@taglib prefix="defaultTemplate" tagdir="/WEB-INF/tags"%>

<defaultTemplate:defaultDecorator>
<jsp:attribute name="title">E-Diary</jsp:attribute>
<jsp:body>

 <div class="create-post">
   <div class="row">
   	<div class="col-md-3 col-sm-3">
         <div class="form-group">
           	<a href="${contextPath}/sm/create_edairy" class="btn btn-primary pull-right">
           		 <i class="fa fa-calendar" aria-hidden="true"></i> &nbsp;Create New E-Diary 
           	</a>
         </div>
         </div>
       </div>
   	</div>
   <%--  <table id="example" class="table  table-bordered" cellspacing="0" style="width: 100%">
        <tbody>
        <c:forEach items="${userDairies.dairyList}" var="dairy" varStatus="status">
            <tr>            
            	<td>
            		<a href="${contextPath}/sm/getUserDairyCoverPage/${userDairies.userId}/${dairy.dairyId}" > 
            			<i class="fa fa-calendar" aria-hidden="true"></i> ${dairy.name}
            		</a>  
            	</td>              
            </tr>
          </c:forEach>  
       </tbody>
    </table>   --%>
     <div class="people-nearby">
       <c:forEach items="${userDairies.dairyList}" var="dairy" varStatus="status">
         <div class="nearby-user">
           <div class="row">
             <div class="col-md-3 col-sm-3">
              <%-- <a href="${contextPath}/sm/getUserDairyCoverPage/${userDairies.userId}/${dairy.dairyId}"> --%>
              <a href="${contextPath}/sm/getDairyInfo/${userDairies.userId}/${dairy.dairyId}?actionBy=${EdairyActionEnum.VIEW_PAGE}">
             	 <img src="${contextPath}/resources/default/images/diary_icon.png" alt="user" class="profile-photo-lg" style="border-radius:0px;"/>
              </a> 
             </div>
             <div class="col-md-5 col-sm-5">
             	<h5><a href="${contextPath}/sm/getDairyInfo/${userDairies.userId}/${dairy.dairyId}?actionBy=${EdairyActionEnum.VIEW_PAGE}" class="profile-link">${dairy.name}</a></h5>
               <p><f:formatDate value="${dairy.createdDate}" type="both"/> </p>
               <c:choose>
               		<c:when test="${dairy.status eq 'ACTIVE'}">
               			<span class="label label-success">${dairy.status}</span>
               		</c:when>
               		<c:when test="${dairy.status eq 'HIDE'}">
               			<span class="label label-warning">${dairy.status}</span>
               		</c:when>
               		<c:otherwise>
               			<span class="label label-danger">${dairy.status}</span>
               		</c:otherwise>
               </c:choose>
             </div>
             <div class="col-md-3 col-sm-3">
             		<a href="${contextPath}/sm/getFavourateDairyInfo/${userDairies.userId}/${dairy.dairyId}?actionBy=${EdairyActionEnum.FAVORITE_PAGE}&favourate=true" class="btn btn-primary">
						<i class="fa fa-heart" aria-hidden="true"></i> Select favorite Pages
					</a>
             </div>
           </div>
         </div>
       </c:forEach>
       </div>
</jsp:body>
 </defaultTemplate:defaultDecorator>