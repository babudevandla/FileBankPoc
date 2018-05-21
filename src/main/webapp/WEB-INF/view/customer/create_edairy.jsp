<%@ page pageEncoding="ISO-8859-1"  contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@taglib prefix="defaultTemplate" tagdir="/WEB-INF/tags"%>
<%@page import="com.sm.portal.edairy.model.EdairyYearsEnum"%>

<defaultTemplate:defaultDecorator>
<jsp:attribute name="title">E-Dairy</jsp:attribute>
<jsp:body>

 <h1>New Dairy :</h1>  <br/>
 <fieldset>
 <div class="row">
 <form:form action="${contextPath}/sm/submit_edairy" method="post" commandName="dairyInfo">
	<form:hidden path="userId" value="${userId }" />
        <div class="form-group col-xs-4">
		<label>Dairy Name<span style="color: red;">*</span>: </label>
		<form:input path="dairyName" id="dairyName" class="form-control"  maxlength="150" required="required"/></br>
		</div>
		<div class="form-group col-xs-4">
		<label>Year<span style="color: red;">*</span>:  </label>
		<form:select path="year" id="yearId" class="form-control" >
              <c:forEach var="yearEnumVar"  items="${edairyYearsEnum}">
              		  <c:choose>
          		<c:when test ="${year == yearEnumVar.yearId}">
          			<form:option value="${yearEnumVar.yearId}">${yearEnumVar.yearId}</form:option>
          		</c:when>
          		<c:otherwise>
          			<c:choose>
           			<c:when test="${year != yearEnumVar.yearId}">
           				<form:option value="${yearEnumVar.yearId}">${yearEnumVar.yearId}</form:option>
           			</c:when>
          			</c:choose>
          		</c:otherwise>
          	</c:choose>  
                 <form:option value="${yearEnumVar.yearId}">${yearEnumVar.yearId}</form:option>
              </c:forEach>
          </form:select></br>
	</div>	
	<div class="form-group col-xs-4" style="top: 26px;">
	 <input name="submit" type="submit"	class="btn btn-secondary" value="Save" />
	</div> 
</form:form>
</div>
</fieldset>

</jsp:body>
 </defaultTemplate:defaultDecorator>