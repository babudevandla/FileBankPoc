<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@attribute name="title" fragment="true"%>

<head>
<title>SM</title>
<!--Favicon-->
<link rel="shortcut icon" type="image/png" href="${contextPath}/resources/default/images/fav.png"/>
   <!-- Stylesheets
 ================================================= -->
<link rel="stylesheet" href="${contextPath}/resources/default/css/bootstrap.min.css" />
<link rel="stylesheet" href="${contextPath}/resources/default/css/style.css" />
<link rel="stylesheet" href="${contextPath}/resources/default/css/ionicons.min.css" />
<link rel="stylesheet" href="${contextPath}/resources/default/css/font-awesome.min.css" />

<!--Google Font-->
<link href="https://fonts.googleapis.com/css?family=Lato:300,400,400i,700,700i" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/bs4/dt-1.10.16/datatables.min.css"/>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap.min.css"/>
		
		
<style type="text/css">
h2.mce-content-body {
  font-size: 200%;
  padding: 0 25px 0 25px;
  margin: 10px 0 10px 0;
}

body {
  background: transparent;  
}

.content {
  overflow: visible;
  position: relative;
  width: auto;
  margin-left: 0;
  min-height: auto;
  padding: inherit;
}

.edit {
    float: left;
    background: url(${contextPath}/resources/default/images/edit.png) no-repeat;
    width: 32px;
    height: 32px;
    display: block;
    cursor: pointer;
    margin-left: 10px;
}
.modal-dialog {
  width: 75%;
 }
.modal-header {
    background-color: #337AB7;
    padding:16px 16px;
    color:#FFF;
    border-bottom:2px dashed #337AB7;
 }
</style>
</head>
<body>

<sec:authentication property="principal.username" var="authorize"/>
    <!-- Header
    ================================================= -->
	<header id="header">
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
            <a class="navbar-brand" href="${contextPath}/sm/dashboard"><strong style="color: white;"> 
            	<img src="${contextPath}/resources/default/images/sm_logo.png" alt="Folder" style="width: 60px;margin-top: -7px;"> </strong>
            </a>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right main-menu">
            <sec:authorize access="isAuthenticated()">
              <li class="dropdown"><a href="${contextPath}/sm/profile"><i class="icon ion-person"></i>&nbsp; Profile</a></li>
              <li class="dropdown"><a href="<c:url value="/j_spring_security_logout" />" class="btn"> <i class="icon ion-log-out"></i>&nbsp; Logout</a></li>
          </sec:authorize>
           </ul>
          </div><!-- /.navbar-collapse -->
        </div><!-- /.container -->
      </nav>
    </header>
   
     <div id="page-contents">
	     <div class="container">
    		<div class="row">

    		<div class="col-md-3 static">
            <div class="profile-card">
            	<img src="${contextPath}/resources/default/images/avatar.png" alt="user" class="profile-photo" />
            	<h5><a class="text-white">${user.firstname}&nbsp;${user.lastname}</a></h5>
            	<a  class="text-white"><i class="fa fa-phone" aria-hidden="true"></i> ${user.mobile_no}</a>
            </div><!--profile card ends-->
            <ul class="nav-news-feed">
              <li class="${digiLockActive?'active':''}"><i class="fa fa-dashboard"></i><div><a href="${contextPath}/sm/dashboard">Dashboard</a></div></li>
              <li class="${digiLockActive?'active':''}"><i class="icon ion-lock-combination"></i><div><a href="${contextPath}/sm/file_management">File Bank</a></div></li>
              <li class="${diaryActive?'active':''}"><i class="fa fa-calendar" aria-hidden="true"></i><div><a href="${contextPath}/sm/getUserDairiesList">My Dairies</a></div></li>
              <%-- <li class="${msgActive?'active':''}"><i class="icon ion-chatboxes"></i><div><a href="${contextPath}/sm/messanger">Messanger</a></div></li> --%>
              <li class="${galleryActive?'active':''}"><i class="fa fa-book" aria-hidden="true"></i><div><a href="${contextPath}/sm/eBooklist">My Books</a></div></li>
              <li class="${paActive?'active':''}"><i class="fa fa-bell-o" aria-hidden="true"></i><div><a href="${contextPath}/sm/personallist">My PA</a></div></li>
              <li class="${settActive?'active':''}"><i class="fa  fa-cog" aria-hidden="true"></i><div><a href="${contextPath}/sm/settings">Settings</a></div></li>
              <!-- <li><i class="icon ion-ios-videocam"></i><div><a href="newsfeed-videos.html">Videos</a></div></li> -->
            </ul>
            <!-- <div id="chat-block">
              <div class="title">Chat online</div>
              <ul class="online-users list-inline">
                <li><a href="newsfeed-messages.html" title="Linda Lohan"><img src="images/users/user-2.jpg" alt="user" class="img-responsive profile-photo" /><span class="online-dot"></span></a></li>
                <li><a href="newsfeed-messages.html" title="Sophia Lee"><img src="images/users/user-3.jpg" alt="user" class="img-responsive profile-photo" /><span class="online-dot"></span></a></li>
                <li><a href="newsfeed-messages.html" title="John Doe"><img src="images/users/user-4.jpg" alt="user" class="img-responsive profile-photo" /><span class="online-dot"></span></a></li>
                <li><a href="newsfeed-messages.html" title="Alexis Clark"><img src="images/users/user-5.jpg" alt="user" class="img-responsive profile-photo" /><span class="online-dot"></span></a></li>
                <li><a href="newsfeed-messages.html" title="James Carter"><img src="images/users/user-6.jpg" alt="user" class="img-responsive profile-photo" /><span class="online-dot"></span></a></li>
                <li><a href="newsfeed-messages.html" title="Robert Cook"><img src="images/users/user-7.jpg" alt="user" class="img-responsive profile-photo" /><span class="online-dot"></span></a></li>
                <li><a href="newsfeed-messages.html" title="Richard Bell"><img src="images/users/user-8.jpg" alt="user" class="img-responsive profile-photo" /><span class="online-dot"></span></a></li>
                <li><a href="newsfeed-messages.html" title="Anna Young"><img src="images/users/user-9.jpg" alt="user" class="img-responsive profile-photo" /><span class="online-dot"></span></a></li>
                <li><a href="newsfeed-messages.html" title="Julia Cox"><img src="images/users/user-10.jpg" alt="user" class="img-responsive profile-photo" /><span class="online-dot"></span></a></li>
              </ul>
            </div> -->
          </div>
    		<div class="col-md-7">
    			<jsp:doBody />
			</div>
    		</div>
    	</div>		
    </div>

<!-- Footer
    ================================================= -->
    <footer id="footer">
      <div class="container">
      	<div class="row">
          <%-- <div class="footer-wrapper">
            <div class="col-md-3 col-sm-3" >
              <a href="#" style="font-size: 30px;" > SM Portal</a>
              <ul class="list-inline social-icons">
              	<li><a href="#"><i class="icon ion-social-facebook"></i></a></li>
              	<li><a href="#"><i class="icon ion-social-twitter"></i></a></li>
              	<li><a href="#"><i class="icon ion-social-googleplus"></i></a></li>
              	<li><a href="#"><i class="icon ion-social-pinterest"></i></a></li>
              	<li><a href="#"><i class="icon ion-social-linkedin"></i></a></li>
              </ul>
            </div> 
            <div class="col-md-2 col-sm-2">
              <h5>For individuals</h5>
              <ul class="footer-links">
                <li><a href="${contextPath}/signup">Signup</a></li>
                <li><a href="${contextPath}/login">login</a></li>
              </ul>
            </div>
             <div class="col-md-2 col-sm-2">
              <h5>For businesses</h5>
              <ul class="footer-links">
                <li><a href="#">Business signup</a></li>
                <li><a href="#">Business login</a></li>
                <li><a href="#">Benefits</a></li>
                <li><a href="#">Resources</a></li>
                <li><a href="#">Advertise</a></li>
                <li><a href="#">Setup</a></li>
              </ul>
            </div>
            <div class="col-md-2 col-sm-2">
              <h5>About</h5>
              <ul class="footer-links">
                <li><a href="#">About us</a></li>
                <li><a href="#">Contact us</a></li>
                <li><a href="#">Privacy Policy</a></li>
                <li><a href="#">Terms</a></li>
                <li><a href="#">Help</a></li>
              </ul>
            </div>
             <div class="col-md-3 col-sm-3">
              <h5>Contact Us</h5>
              <ul class="contact">
                <li><i class="icon ion-ios-telephone-outline"></i>+1 (234) 222 0754</li>
                <li><i class="icon ion-ios-email-outline"></i>info@thunder-team.com</li>
                <li><i class="icon ion-ios-location-outline"></i>228 Park Ave S NY, USA</li>
              </ul>
            </div> 
          </div> --%>
      	</div>
      </div>
      <div class="copyright">
        <p>SM Team © 2018. All rights reserved</p>
      </div>
		</footer>
		
		
		
<div class="modal fade" id="fileBankModelPopup" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content" style="width: 100%">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">File Bank</h4>
        </div>
        <div class="modal-body" >
          <div id="fileBankFilesList" style=" margin-top: -15px"></div>
        </div>
        <div class="modal-footer">
        <%-- <div class="media">
         <div class="row js-masonry" data-masonry='{ "itemSelector": ".grid-item", "columnWidth": ".grid-sizer", "percentPosition": true }'>
	       	<form action="" id="sellerimagebulkapprove">
		      	<div id="selectedFiles">
          		 
                 </div>
	     	</form>
     	   </div>
     	</div> --%>
          <button type="button" class="btn btn-primary" id="fileBankFilesUpload"  >Submit</button>
            <button type="button" class="btn btn-primary"  data-dismiss="modal">Cancel</button>
        </div>
      </div>
      
    </div>
  </div>
		
		
    <!--preloader-->
   <!--  <div id="spinner-wrapper">
      <div class="spinner"></div>
    </div> -->
    
 <!-- Scripts
 ================================================= -->
 <script src="${contextPath}/resources/default/js/jquery-3.1.1.min.js"></script>
 <script src="${contextPath}/resources/default/js/bootstrap.min.js"></script>
 <script src="${contextPath}/resources/default/js/jquery.appear.min.js"></script>
<script src="${contextPath}/resources/default/js/jquery.incremental-counter.js"></script>
 <script src="${contextPath}/resources/default/js/script.js"></script>
 <script src="${contextPath}/resources/default/js/sm_custome.js"></script>

<!--  TinyMCE plug-ins  -->
<script src="${contextPath}/resources/default/tinymce/tinymce.min.js"></script>
<script src="${contextPath}/resources/default/tinymce/plugins/compat3x/plugin.min.js"></script>

<script type="text/javascript" src="https://cdn.datatables.net/v/bs4/dt-1.10.16/datatables.min.js"></script>
<script src="${contextPath}/resources/default/datatables/media/js/jquery.dataTables.min.js"></script>
<script src="${contextPath}/resources/default/_mod/datatables/jquery.dataTables.bootstrap.min.js"></script>
<script src="${contextPath}/resources/default/datatables.net-buttons/js/dataTables.buttons.min.js"></script>


<script type="text/javascript">
	
 $(document).ready(function() {
	    $('#example').DataTable();
	    $('#dynamic-table').DataTable();
	    
	} );
	
	
  tinymce.init({
	  selector: '#editor',
	  paste_data_images: true,
	  file_browser_callback_types: 'file image media',
	  media_live_embeds: true,
	  height: 500,
	  plugins: [
	        "advlist autolink lists link image charmap print preview anchor",
	        "searchreplace visualblocks code fullscreen",
	        "insertdatetime media table contextmenu paste imagetools  "
	    ],
	    toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image  ",
	  // imagetools_cors_hosts: ['www.tinymce.com', 'codepen.io'],
	  content_css: [
	    '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i',
	    '//www.tinymce.com/css/codepen.min.css'
	  ]
	});
  
  
 
  
  </script>
  

	
</body>

</html>
