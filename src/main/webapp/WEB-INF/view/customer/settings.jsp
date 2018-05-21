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
<jsp:attribute name="title">Settings</jsp:attribute>
<jsp:body>
   
   <div class="col-md-5">
   		<div class="edit-profile-container">
                <div class="block-title">
                  <h4 class="grey"><i class="fa fa-lock"></i>Update Password</h4>
                  <div class="line"></div>
                  <c:if test="${not empty message}">
                  	${message}
                  </c:if>
                </div>
                <div class="edit-block">
                 <form:form action="${contextPath}/sm/settings" class="form-inline" commandName="users" method="post">
                  <input type="hidden" name="userId" value="${userId}">
                    <div class="row">
                      <div class="form-group col-xs-12">
                        <label for="school">Current Password <span style="color: red;">*</span></label>
                        <form:input id="oldpassword" class="form-control input-group-lg"  path="oldpassword" placeholder="Old Password"  required="required" />
                      	<span style="color: red"><form:errors path="oldpassword" /></span>
                      </div>
                    </div>
                    <div class="row">
                      <div class="form-group col-xs-12">
                        <label for="school">New Password <span style="color: red;">*</span></label>
                        <form:input id="newpassword" class="form-control input-group-lg" path="password"  placeholder="New Password" required="required" />
                      	<span style="color: red"><form:errors path="password" /></span>
                      </div>
                    </div>
                    <div class="row">
                      <div class="form-group col-xs-12">
                        <label for="school">Confirm Password <span style="color: red;">*</span></label>
                        <form:input id="confirmpassword" class="form-control input-group-lg"  path="confirmpassword"  placeholder="Confirm Password" required="required" />
                     	<span style="color: red"><form:errors path="confirmpassword" /></span>
                      </div>
                    </div>
                    <button class="btn btn-primary">Update</button>
                  </form:form>
                </div>
              </div>
     </div>
  </jsp:body>
 </defaultTemplate:defaultDecorator>
  