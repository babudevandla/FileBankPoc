<%@ page pageEncoding="ISO-8859-1"  contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@taglib prefix="defaultTemplate" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html lang="en">
	
<head>
	<link rel="stylesheet" href="${contextPath}/resources/default/css/bootstrap.min.css" />
	<link rel="stylesheet" href="${contextPath}/resources/default/css/style.css" />
	<link rel="stylesheet" href="${contextPath}/resources/default/css/ionicons.min.css" />
    <link rel="stylesheet" href="${contextPath}/resources/default/css/font-awesome.min.css" />
   
   <!--Google Font-->
   <link href="https://fonts.googleapis.com/css?family=Lato:300,400,400i,700,700i" rel="stylesheet">
   
   <!--Favicon-->
   <link rel="shortcut icon" type="image/png" href="${contextPath}/resources/default/images/fav.png"/>
</head>
<body>

    <!-- Header
    ================================================= -->
		<header id="header-inverse">
      <nav class="navbar navbar-default navbar-fixed-top menu">
        <div class="container">

          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${contextPath}/"><strong style="color: white;"> 
            	<img src="${contextPath}/resources/default/images/sm_logo.png" alt="Folder" style="width: 60px;"> </strong>
            </a>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right main-menu">
            	<li class="dropdown">
              		 <a href="${contextPath}/login" >Login </a>
             	</li> 
              	<li class="dropdown">
                	<a href="${contextPath}/signup" >Register </a>
             	</li>
              	<li class="dropdown"><a href="${contextPath}/contact">Contact</a></li>
            </ul>
            
          </div>
        </div>
      </nav>
    </header>
    <!--Header End-->
    
    <!-- Landing Page Contents
    ================================================= -->
    <div id="lp-register">
    	<div class="container wrapper">
        <div class="row">
        	<div class="col-sm-5">
            <div class="intro-texts">
            	<h1 class="text-white">Contact US!!!</h1>
            	<p>Address: Bangalore Karnataka</p>
            	<p>	Phone: 1234567890 </p>
            </div>
          </div>
        	<div class="col-sm-6 col-sm-offset-1">
            
            
             	<div id="map" style="width:100%;height:500px"></div>
             
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-6 col-sm-offset-6">
          
            <!--Social Icons-->
            <ul class="list-inline social-icons">
              <li><a href="#"><i class="icon ion-social-facebook"></i></a></li>
              <li><a href="#"><i class="icon ion-social-twitter"></i></a></li>
              <li><a href="#"><i class="icon ion-social-googleplus"></i></a></li>
              <li><a href="#"><i class="icon ion-social-pinterest"></i></a></li>
              <li><a href="#"><i class="icon ion-social-linkedin"></i></a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>

    <!--preloader-->
    <!-- <div id="spinner-wrapper">
      <div class="spinner"></div>
    </div> -->
    
    


    <!-- Scripts
    ================================================= -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBu-916DdpKAjTmJNIgngS6HL_kDIKU0aU&callback=myMap"></script>
     <script src="${contextPath}/resources/default/js/jquery-3.1.1.min.js"></script>
    <script src="${contextPath}/resources/default/js/bootstrap.min.js"></script>
    <script src="${contextPath}/resources/default/js/jquery.appear.min.js"></script>
	<script src="${contextPath}/resources/default/js/jquery.incremental-counter.js"></script>
    <script src="${contextPath}/resources/default/js/script.js"></script>
 <script>
 $(document).ready(function() {
  var myCenter = new google.maps.LatLng(12.934533,77.626579);
  var mapCanvas = document.getElementById("map");
  var mapOptions = {center: myCenter, zoom: 10};
  var map = new google.maps.Map(mapCanvas, mapOptions);
  var marker = new google.maps.Marker({position:myCenter});
  marker.setMap(map);
})
</script>
    
 
	</body>

</html>

