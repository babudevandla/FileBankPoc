<%@ page pageEncoding="ISO-8859-1"  contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@taglib prefix="defaultTemplate" tagdir="/WEB-INF/tags"%>
 <script src="${contextPath}/resources/default/js/jquery-3.1.1.min.js"></script>
 <%@ page import="com.sm.portal.edairy.model.EdairyActionEnum" %>

<defaultTemplate:defaultDecorator>
<jsp:attribute name="title">E-Dairy</jsp:attribute>
<jsp:body>
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/page_flip/css/default.css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/page_flip/css/bookblock.css" />
<!-- custom demo style -->
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/page_flip/css/demo1.css" />
<script src="${contextPath}/resources/page_flip/js/modernizr.custom.js"></script>


<script>
	$(document).ready(function() {
		 var list=${pagelist};
		 console.log(list);
		 // var list=$.parseJSON("${pagelist}");
		// var list=${pagelist};
		  /* $.each(list,function( index, value ) {
			 
			  if(value.pageNo==2){
				  alert(value.pageName);
				$("#pageContent").html(value.pageName);
				
				return false;
			  }
		});   */
		  
	 $("#nextBtn").click(function(){
		 var list=${pagelist};
		var currentPageNo= $("#pageNoId").html();
		var nextPageNo=parseInt(currentPageNo)+1;
		//alert(nextPageNo);
		 $.each(list,function( index, value ) {
			 
			  if(value.pageNo==nextPageNo){
				  //alert(value.pageName);
				$("#pageContent").html(value.content);
				$("#pageNoId").html(value.pageNo);
				$("#pageDateId").html(value.date);
				return false;
			  }
		}); 
	 });
		
	 $("#prevBtn").click(function(){
		 var list=${pagelist};
		var currentPageNo= $("#pageNoId").html();
		var previousPageNo=parseInt(currentPageNo)-1;
		//alert(nextPageNo);
		 $.each(list,function( index, value ) {
			 
			  if(value.pageNo==previousPageNo){
				  //alert(value.pageName);
				$("#pageContent").html(value.content);
				$("#pageNoId").html(value.pageNo);
				$("#pageDateId").html(value.date);
				return false;
			  }
		}); 
	 });
	 
	 /* $("#editDairyId").click(function(){
		 //var list=${pagelist};
		 var href=$(this).attr("data-href");
		var currentPageNo= $("#pageNoId").html();
		var actionBy =$(this).attr("data-actionBy");
		//var userId=$(this).attr("data-userId");
		//var dairyId=$(this).attr("data-dairyId");
		var pageContent=$("#pageContent").html();
		window.location.href=href+"?edit="+"YES"+"&defaultPageNo="+currentPageNo+"&actionBy="+actionBy;
		
	 }); */
	 
	 
	 $(".editDairyCls").click(function(){
		 //var list=${pagelist};
		 var href=$(this).attr("data-href");
		var currentPageNo= $(this).attr("data-pageNo");
		var actionBy =$(this).attr("data-actionBy");
		//var userId=$(this).attr("data-userId");
		//var dairyId=$(this).attr("data-dairyId");
		var pageContent=$("#pageContent").html();
		window.location.href=href+"?edit="+"YES"+"&defaultPageNo="+currentPageNo+"&actionBy="+actionBy;
		
	 });
		
	});
	
	
 
</script>
<style type="text/css">

#pageContent{
	width: 100%;
    background-color: #FBF6F5;
    padding-left: 15px;
    border-color: darkgrey;
    /* color: black; */
    border-style: solid;
    border-top-width: 2px;
    padding-top: 18px;
    padding-left: 24px;
    padding-right: 18px;
}
div#pageContent {
    overflow-y: auto;
    height: 100%;
    overflow-x: hidden;
    width: 100%;
} 
</style>
 
   	<%-- <a class="btn btn-primary pull-left" id="prevBtn"  ><i class="fa fa-chevron-left" aria-hidden="true"></i> PRE </a>
	<a class="btn btn-primary pull-right nextBtn" id="nextBtn" >NEXT <i class="fa fa-chevron-right" aria-hidden="true"></i></a>
    <table id="navigatorTable" class="table" cellspacing="0" style ="width: 100%">
	    <tbody>
	    	<tr>
	    		<td ><label>Date:</label></td><td id="pageDateId">${dairyInfo.defaultPage.date}</td>
	    		<td><label>Page:</label></td><td id="pageNoId">${dairyInfo.defaultPage.pageNo}</td>
	    		<td><label>Select Date:</label></td><td id="sectedDateId"></td>
	    		<td align="right">
	    			<a id="editDairyId" data-href="${pageContext.request.contextPath}/sm/getDairyInfo/${userId}/${dairyId}" data-actionBy="${EdairyActionEnum.EDIT_PAGE}" data-userId="${userId}" data-dairyId="${dairyId}" class="btn btn-warning">
	    				<i class="fa fa-edit"></i> WRITE
	    			</a>
	    		</td>
	    	</tr>
	    </tbody>
    </table>
    <div id="pageContent" >
    	${dairyInfo.defaultPage.content}
    </div> --%>
    <c:if test="${pages.size() > 0 }">
    <button onclick="goBack()">Go Back </button><br/><br/>
    <form action="${contextPath}/sm/getDairyInfo/${userId}/${dairyId}" method="get" >
       	<div class="col-md-4 col-sm-4" style=" left: -12px;">
      		<input type="text"  name="defaultPageNo" class="form-control" placeholder="Search PageNo" value="${defaultPageNo}" style="height: 37px;" >
      	</div>
      	<div class="col-md-1 col-sm-1" style=" ">
      		OR
      	</div>
      	<div class="col-md-4 col-sm-4" style=" ">
      		<input size="16" type="text" id="datepicker" class="form-control" placeholder="Date Filter" >
      	</div>
      	 <div class="col-md-2 col-sm-2" >
      		<input type="submit" value="Search" class="btn btn-secondary" style="height: 37px;">
      	</div>	
      </form><br/><br/>
      
	<div align="center"> Dairy Title - <span style="font-size: 14px;;font-weight: bold;color: slategray;" > ${dairyInfo.dairyName}</span></div>
	
	<div class="bb-custom-wrapper">
		<div id="bb-bookblock" class="bb-bookblock" style="width: 916px;">
			<c:forEach items="${pages}" var="pageContent">
				<div class="bb-item" id="pageContent" style="visibility: visible;">
					<div class="reader-header-left" style="width: 100%;">
		                <h4 class="reader-name-inner" style="overflow-wrap: break-word;">
		                	<span class="cptrName" style="float: left; font-size: 14px;"> <f:formatDate type = "date"  dateStyle = "medium" timeStyle = "medium" value = "${pageContent.date}" /></span>  
		                    <a  id="editDairyId" data-href="${pageContext.request.contextPath}/sm/getDairyInfo/${userId}/${dairyId}" data-pageNo="${pageContent.pageNo}" data-actionBy="${EdairyActionEnum.EDIT_PAGE}" data-userId="${userId}" data-dairyId="${dairyId}" class="btn btn-warning pull-right editDairyCls">
			    				<i class="fa fa-edit"></i> EDIT
			    			</a>
			    			
			    			
			    			<div style="font-size: 14px;">
			    			 Page : <span class="ebookPageNoCls" style="color: #337ab7;">${pageContent.pageNo} </span>
			    			 <c:choose>
			    				<c:when test="${pageContent.favouriteStatus}">
			    					<a href="${pageContext.request.contextPath}/sm/updateFavourite?dairyId=${dairyId}&pageNo=${pageContent.pageNo}&favourate=false" style="margin-left: 200px;" class="updateFavouratePage"> 
			    						<i class="fa fa-heart" aria-hidden="true"></i> 
			    					</a>
			    				</c:when>
			    				<c:otherwise>
			    					<a href="${pageContext.request.contextPath}/sm/updateFavourite?dairyId=${dairyId}&pageNo=${pageContent.pageNo}&favourate=true" style="margin-left: 200px;" class="updateFavouratePage"> 
			    						<i class="fa fa-heart-o" aria-hidden="true"></i> 
			    					</a>
			    				</c:otherwise>
			    			</c:choose>
			    			</div> 
		                 </h4>
		            </div>
		            <hr>
					<span class="pageContentCls" style="">${pageContent.content}</span>
				</div>
			</c:forEach>
			
		</div>
		<nav style="left: 241px;">
			<a id="bb-nav-first" href="#" class="bb-custom-icon bb-custom-icon-first" style="text-decoration:none;">First page</a>
			<a id="bb-nav-prev" href="#" class="bb-custom-icon bb-custom-icon-arrow-left" style="text-decoration:none;">Previous</a>
			<a id="bb-nav-next" href="#" class="bb-custom-icon bb-custom-icon-arrow-right" style="text-decoration:none;">Next</a>
			<a id="bb-nav-last" href="#" class="bb-custom-icon bb-custom-icon-last" style="text-decoration:none;">Last page</a>
		</nav>
	</div>
</c:if>
<c:if test="${pages.size() eq 0 }">
	<div align="center" style="color: red;"> No favourite records found!</div>			
</c:if>

<input type="hidden" id="defaultPN" value="${defaultPageNo}">
<span style="display: none;" id="pageListCont">${pagelist}</span>


<script src="${contextPath}/resources/page_flip/js/jquerypp.custom.js"></script>
<script src="${contextPath}/resources/page_flip/js/jquery.bookblock.js"></script>

<script>
	var Page = (function() {
		
		var config = {
				$bookBlock : $( '#bb-bookblock' ),
				$navNext : $( '#bb-nav-next' ),
				$navPrev : $( '#bb-nav-prev' ),
				$navFirst : $( '#bb-nav-first' ),
				$navLast : $( '#bb-nav-last' )
			},
			init = function() {
				config.$bookBlock.bookblock( {
					speed : 800,
					shadowSides : 0.8,
					shadowFlip : 0.7
				} );
				initEvents();
			},
			initEvents = function() {
				
				var $slides = config.$bookBlock.children();

				// add navigation events
				config.$navNext.on( 'click touchstart', function() {
					config.$bookBlock.bookblock( 'next' );
					return false;
				} );

				config.$navPrev.on( 'click touchstart', function() {
					config.$bookBlock.bookblock( 'prev' );
					return false;
				} );

				config.$navFirst.on( 'click touchstart', function() {
					config.$bookBlock.bookblock( 'first' );
					return false;
				} );

				config.$navLast.on( 'click touchstart', function() {
					config.$bookBlock.bookblock( 'last' );
					return false;
				} );
				
				// add swipe events
				$slides.on( {
					'swipeleft' : function( event ) {
						config.$bookBlock.bookblock( 'next' );
						return false;
					},
					'swiperight' : function( event ) {
						config.$bookBlock.bookblock( 'prev' );
						return false;
					}
				} );

				// add keyboard events
				$( document ).keydown( function(e) {
					var keyCode = e.keyCode || e.which,
						arrow = {
							left : 37,
							up : 38,
							right : 39,
							down : 40
						};

					switch (keyCode) {
						case arrow.left:
							config.$bookBlock.bookblock( 'prev' );
							break;
						case arrow.right:
							config.$bookBlock.bookblock( 'next' );
							break;
					}
				} );
			};

			return { init : init };

	})();
	
	
</script>
<script>
 Page.init();

 function goBack() {
	    window.history.go(-1);
	}
</script>    
</jsp:body>
 </defaultTemplate:defaultDecorator>