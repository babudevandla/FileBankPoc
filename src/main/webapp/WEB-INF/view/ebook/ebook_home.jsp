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
<jsp:attribute name="title">E-Book</jsp:attribute>
<jsp:body>
	
	
	</br>
	<%-- <c:forEach items="${userBooks.books }" var="book" >
	
		<a href="${contextPath}/sm/getEbookContent?userId=${userBooks.userId}&bookId=${book.bookId}" >${book.bookTitle}</a></br>
	</c:forEach> --%>
	
	<div class="create-post">
      	<div class="row">
      		<a href="${contextPath}/sm/creatEbook?userId=${userId}"  class="btn btn-secondary" style="padding-top: 5px;">
      			<i class="fa fa-book" aria-hidden="true"></i>&nbsp; Create E-Book
      		</a>
      	</div>
      </div>
     <div class="people-nearby">
       <c:forEach items="${userBooks.books }" var="book" >
         <div class="nearby-user">
           <div class="row">
             <div class="col-md-3 col-sm-3">
             	<a href="${contextPath}/sm/getEbookContent?userId=${userBooks.userId}&bookId=${book.bookId}">
              	 <img src="${contextPath}/resources/default/images/Book_icon.png" alt="user" class="profile-photo-lg" style="border-radius:0px;"/>
               </a>
             </div>
             <div class="col-md-9 col-sm-9">
             	<h5><a href="${contextPath}/sm/getEbookContent?userId=${userBooks.userId}&bookId=${book.bookId}" class="profile-link">${book.bookTitle}</a></h5>
               <p><f:formatDate value="${book.createdDate}" type="both"/> </p>
               <c:choose>
               		<c:when test="${book.status eq 'ACTIVE'}">
               			<span class="label label-success">${book.status}</span>
               		</c:when>
               		<c:when test="${book.status eq 'HIDE'}">
               			<span class="label label-warning">${book.status}</span>
               		</c:when>
               		<c:otherwise>
               			<span class="label label-danger">${book.status}</span>
               		</c:otherwise>
               </c:choose>
             </div>
           </div>
         </div>
       </c:forEach>
       </div>
        
</jsp:body>
 </defaultTemplate:defaultDecorator>