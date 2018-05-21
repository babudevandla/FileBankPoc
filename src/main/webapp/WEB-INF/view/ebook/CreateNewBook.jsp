<%@ page pageEncoding="ISO-8859-1"  contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@taglib prefix="defaultTemplate" tagdir="/WEB-INF/tags"%>

<%@page import="com.sm.portal.ebook.enums.BookSizeEnum"%>
<%@page import="com.sm.portal.ebook.enums.PageSizeEnum"%>
 <script src="${contextPath}/resources/default/js/jquery-3.1.1.min.js"></script>

<defaultTemplate:defaultDecorator>
<jsp:attribute name="title">E-Book</jsp:attribute>
<jsp:body>
	<h3>Create New E-Book</h3>
	<fieldset>
	<div class="row">
	<form:form action="${contextPath}/sm/creatEbook" id="createEbook"  method="POST" commandName="eBook" >
	
		<form:hidden path="userId" />
		 <div class="form-group col-xs-6">
			<label>Book Name<span style="color: red;">*</span>: </label>
			<form:input path="bookTitle" id="bookTitle" maxlength="150" class="form-control" required="required" />
		</div>
		 <div class="form-group col-xs-6">
			<label>Tag Name: </label>
			<form:input path="tagline" id="tagline" maxlength="150" class="form-control" />
		</div>
		 <div class="form-group col-xs-3">
			<label>Book Size<span style="color: red;">*</span>: </label>
			<form:select path="bookSize" id="bookSize" class="form-control" required="required">
                <c:forEach var="bookSizeVar"  items="${bookSizeEnumList}">
                   <form:option value="${bookSizeVar.bookSize}">${bookSizeVar.bookSize}</form:option>
                </c:forEach>
   			</form:select>Pages per book
           </div>
            <div class="form-group col-xs-3">
           <label>Page Size<span style="color: red;">*</span>: </label>
           <form:select path="pageSize" id="pageSize" class="form-control" required="required">
                         <c:forEach var="pageSizeVar"  items="${pageSizeEnumList}">
                          <form:option value="${pageSizeVar.pageSize}">${pageSizeVar.pageSize}</form:option>
                         </c:forEach>
           			</form:select> Lines per Page</br>
          </div> 
           <div class="form-group col-xs-2" style="top: 26px;">
            <input type="submit"  value="Create" class="btn btn-secondary"/>
           </div> 
	</form:form>
</div>	
</fieldset>	
</jsp:body>
 </defaultTemplate:defaultDecorator>