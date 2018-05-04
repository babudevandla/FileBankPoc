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
    <link rel="stylesheet" href="${contextPath}/resources/engine1/style.css" />
   
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
            	<h1 class="text-white">Make you feel happy !!!</h1>
            	<p>SM is a social network template that can be used to connect people. The template offers Landing pages, News Feed, Image/Video Feed, Chat Box, Timeline and lot more. <br /> <br />Why are you waiting for? Buy it now.</p>
              <button class="btn btn-primary">Learn More</button>
            </div>
          </div>
        	<div class="col-sm-6 col-sm-offset-1">
	            <div class=""> 
	            	<!-- Start WOWSlider.com BODY section -->
					<div id="wowslider-container1">
					<div class="ws_images"><ul>
							<li><img src="${contextPath}/resources/data1/images/digilocker.jpg" alt="digilocker" title="digilocker" id="wows1_0"/></li>
							<li><img src="${contextPath}/resources/data1/images/digilocker_flow.png" alt="digilocker_flow" title="digilocker_flow" id="wows1_1"/></li>
							<li><img src="${contextPath}/resources/data1/images/my_personal_diary.jpg" alt="my_personal_diary" title="my_personal_diary" id="wows1_2"/></li>
							<li><img src="${contextPath}/resources/data1/images/my_edairys.jpg" alt="my_edairys" title="my_edairys" id="wows1_3"/></li>
							<li><img src="${contextPath}/resources/data1/images/diaries_writting.jpg" alt="diaries_writting" title="diaries_writting" id="wows1_4"/></li>
							<li><img src="${contextPath}/resources/data1/images/ebooks_library.jpg" alt="Ebooks_library" title="Ebooks_library" id="wows1_5"/></li>
							<li><img src="${contextPath}/resources/data1/images/books_sections.jpg" alt="books_sections" title="books_sections" id="wows1_6"/></li>
							<li><img src="${contextPath}/resources/data1/images/book.jpg" alt="book" title="book" id="wows1_7"/></li>
							<li><img src="${contextPath}/resources/data1/images/ebooks_standards.png" alt="ebooks_standards" title="ebooks_standards" id="wows1_8"/></li>
							<li><img src="${contextPath}/resources/data1/images/pa_flow.jpg" alt="PA_flow" title="PA_flow" id="wows1_9"/></li>
							<li><a href="http://wowslider.net"><img src="${contextPath}/resources/data1/images/pa_helps.jpg" alt="html slider" title="PA_helps" id="wows1_10"/></a></li>
							<li><img src="${contextPath}/resources/data1/images/oneassistantallneeds.jpg" alt="oneassistantallneeds" title="oneassistantallneeds" id="wows1_11"/></li>
						</ul></div>
						<div class="ws_bullets"><div>
							<a href="#" title="digilocker"><span><img src="${contextPath}/resources/data1/tooltips/digilocker.jpg" alt="digilocker"/>1</span></a>
							<a href="#" title="digilocker_flow"><span><img src="${contextPath}/resources/data1/tooltips/digilocker_flow.png" alt="digilocker_flow"/>2</span></a>
							<a href="#" title="my_personal_diary"><span><img src="${contextPath}/resources/data1/tooltips/my_personal_diary.jpg" alt="my_personal_diary"/>3</span></a>
							<a href="#" title="my_edairys"><span><img src="${contextPath}/resources/data1/tooltips/my_edairys.jpg" alt="my_edairys"/>4</span></a>
							<a href="#" title="diaries_writting"><span><img src="${contextPath}/resources/data1/tooltips/diaries_writting.jpg" alt="diaries_writting"/>5</span></a>
							<a href="#" title="Ebooks_library"><span><img src="${contextPath}/resources/data1/tooltips/ebooks_library.jpg" alt="Ebooks_library"/>6</span></a>
							<a href="#" title="books_sections"><span><img src="${contextPath}/resources/data1/tooltips/books_sections.jpg" alt="books_sections"/>7</span></a>
							<a href="#" title="book"><span><img src="${contextPath}/resources/data1/tooltips/book.jpg" alt="book"/>8</span></a>
							<a href="#" title="ebooks_standards"><span><img src="${contextPath}/resources/data1/tooltips/ebooks_standards.png" alt="ebooks_standards"/>9</span></a>
							<a href="#" title="PA_flow"><span><img src="${contextPath}/resources/data1/tooltips/pa_flow.jpg" alt="PA_flow"/>10</span></a>
							<a href="#" title="PA_helps"><span><img src="${contextPath}/resources/data1/tooltips/pa_helps.jpg" alt="PA_helps"/>11</span></a>
							<a href="#" title="oneassistantallneeds"><span><img src="${contextPath}/resources/data1/tooltips/oneassistantallneeds.jpg" alt="oneassistantallneeds"/>12</span></a>
						</div></div><div class="ws_script" style="position:absolute;left:-99%"><a href="http://wowslider.net">javascript slideshow</a> by WOWSlider.com v8.8</div>
					<div class="ws_shadow"></div>
					</div>	
	             
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
     <script src="${contextPath}/resources/default/js/jquery-3.1.1.min.js"></script>
    <script src="${contextPath}/resources/default/js/bootstrap.min.js"></script>
    <script src="${contextPath}/resources/default/js/jquery.appear.min.js"></script>
	<script src="${contextPath}/resources/default/js/jquery.incremental-counter.js"></script>
    <script src="${contextPath}/resources/default/js/script.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/engine1/wowslider.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/engine1/script.js"></script>
	</body>

<!-- Mirrored from thunder-team.com/friend-finder/index-register.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 18 Oct 2017 07:24:12 GMT -->
</html>

