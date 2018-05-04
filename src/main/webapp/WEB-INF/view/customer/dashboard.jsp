<%@ page pageEncoding="ISO-8859-1"  contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@taglib prefix="defaultTemplate" tagdir="/WEB-INF/tags"%>
<link rel="stylesheet" href="${contextPath}/resources/default/css/paper-dashboard.css" />

<defaultTemplate:defaultDecorator>
<jsp:attribute name="title">Dashboard</jsp:attribute>
<jsp:body>
 <style type="text/css">
 .hdtxt {
    font-size: 16px;
    color: #351d8b;
    border-bottom: 1px solid rgba(106, 67, 253, 0.25);
    padding-bottom: 5px;
    margin-bottom: 20px;
}
</style> 

 
   <br/>
     <p class="hdtxt hidden-xs">Your dashboard </p>
     <div class="row"  >
       <div class="col-lg-3 col-sm-6">
           <div class="card">
               <div class="content">
                   <div class="row">
                       <div class="col-xs-5">
                           <div class="icon-big icon-warning text-center">
                               <i class="ti-server"></i>
                           </div>
                       </div>
                       <div class="col-xs-7">
                           <div class="numbers">
                               <p>Total E-Dairys</p>
                               2
                           </div>
                       </div>
                   </div>
                   <div class="footer">
                       <hr>
                       <div class="stats">
                           <i class="fa fa-reload"></i> Updated now
                       </div>
                   </div>
               </div>
           </div>
       </div>
       <div class="col-lg-3 col-sm-6">
           <div class="card">
               <div class="content">
                   <div class="row">
                       <div class="col-xs-5">
                           <div class="icon-big icon-success text-center">
                               <i class="ti-wallet"></i>
                           </div>
                       </div>
                       <div class="col-xs-7">
                           <div class="numbers">
                               <p>Total EBooks</p>
                               10
                           </div>
                       </div>
                   </div>
                   <div class="footer">
                       <hr>
                       <div class="stats">
                           <i class="ti-calendar"></i> Last day
                       </div>
                   </div>
               </div>
           </div>
       </div>
       <div class="col-lg-3 col-sm-6">
           <div class="card">
               <div class="content">
                   <div class="row">
                       <div class="col-xs-5">
                           <div class="icon-big icon-danger text-center">
                               <i class="ti-pulse"></i>
                           </div>
                       </div>
                       <div class="col-xs-7">
                           <div class="numbers">
                               <p>Errors</p>
                               23
                           </div>
                       </div>
                   </div>
                   <div class="footer">
                       <hr>
                       <div class="stats">
                           <i class="ti-timer"></i> In the last hour
                       </div>
                   </div>
               </div>
           </div>
       </div>
       <div class="col-lg-3 col-sm-6">
           <div class="card">
               <div class="content">
                   <div class="row">
                       <div class="col-xs-12">
                       <ul>
                       		<li>File book details updated.</li>
                       		<li>One Ebook created.</li>
                       </ul>
                       </div>
                   </div>
                   <div class="footer">
                       <hr>
                       <div class="stats">
                           <i class="ti-reload"></i> Recent Activities 
                       </div>
                   </div>
               </div>
           </div>
       </div>
   </div>
   
  </jsp:body>
 </defaultTemplate:defaultDecorator>
  