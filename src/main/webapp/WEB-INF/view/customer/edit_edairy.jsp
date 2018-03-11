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
<jsp:attribute name="title">E-Dairy</jsp:attribute>
<jsp:body>
 <h1>Edit Dairy :</h1>  <br/>
 
 <label id="userId" style="display:none">${userId}</label>
  <label id="dairyId" style="display:none">${dairyId}</label>
 <a class="btn btn-primary pull-left" id="prevBtn"  ><i class="fa fa-chevron-left" aria-hidden="true"></i> PRE </a>
	<a class="btn btn-primary pull-right nextBtn" id="nextBtn" >NEXT <i class="fa fa-chevron-right" aria-hidden="true"></i></a>
    <table id="navigatorTable" class="table" cellspacing="0" style ="width: 100%">
	    <tbody>
	    	<tr>
	    		<td ><label>Date:</label></td><td id="pageDateId">${dairyInfo.defaultPage.date}</td>
	    		<td><label>Page:</label></td><td id="pageNoId">${dairyInfo.defaultPage.pageNo}</td>
	    		<td><label>Select Date:</label></td><td id="sectedDateId"></td>
	    		<td><a id="viewDairyId" data-href="${pageContext.request.contextPath}/sm/getDairyInfo/${userId}/${dairyId}" data-actionBy="${EdairyActionEnum.VIEW_PAGE}" data-userId="${userId}" data-dairyId="${dairyId}">VIEW</a></td>
	    	</tr>
	    </tbody>
    </table>
 
 <form:form action="${contextPath}/sm/savePageContent"  id="savePageId" method="post" modelAttribute="dairyInfo1">
 	<%-- <form:hidden path="${userId}"/>
 	<form:hidden path="${ dairyId}"/> --%>
 	<input name="upload" type="button"	class="btn btn-primary uploadMultipleFiles1"  value="Uploadfiles" />
	<textarea id="editor"  name="defaultPage.content">${dairyInfo.defaultPage.content}</textarea><br/>
	<input type="text" name="dairyId" class="dairyId">
	<input type="text" name="userId" class="userId">
	<input type="text" name="defaultPage.pageNo" class="pageNo">
	 <!-- <input name="submit" type="submit"	class="btn btn-primary" value="Update" /> -->
	 <input type="button" value="Update" id="savePageContentId"  class="btn btn-primary"   data-href="${contextPath}/sm/savePageContent/${userId}/${dairyId}" />
</form:form>



<div class="modal fade" id="UploadfilesModel" role="dialog">
    <div class="modal-dialog">
    <form action="${contextPath}/sm/storeFilesInGallery" id="storeFilesInGallery" enctype="multipart/form-data" method="post" >
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" style="color: white;">&times;</button>
                <h4 class="modal-title filename"></h4>
            </div>
             <table id="fuTable"  border="1">
	    		<tr>
	        		<td> 
	        		<!-- <input name="files" type="file" multiple onchange="readURL(this);">
	        			<img id="blah" src="#" alt="your image" /> -->
	        		<input name="files" type="file" multiple>
	        		
	        		</td>
	   			 </tr>
 
   		 </table>
 		<br>
       <input  type="button" value="Add More File"  onclick="AddMoreFile('fuTable')">
            <div class="modal-body">
				<input type="text" name="dairyId" class="dairyId">
				<input type="text" name="userId" class="userId">
				<input type="text" name="pageNo" class="pageNo">
				<input type="text" name="pagecontent" id="pageContentIdVal">
				<!-- <span id="pageContentId"></span> -->
            </div>
            <div class="modal-footer">
            	 <button type="submit" class="btn btn-primary" id="" >Submit</button>
                 <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
      </form>
    </div>
</div>



<script type="text/javascript">
	
function AddMoreFile(tableID) {
    var table = document.getElementById(tableID);
    var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);
    var col1 = row.insertCell(0);
    var colInput = document.createElement("input");
    colInput.type = "file";
    colInput.name="files["+(rowCount)+"]";
    col1.appendChild(colInput);
}

$(document).ready(function() {
	
	  $(".uploadMultipleFiles1").click(function(e){
	  		e.preventDefault();
	  		
	  		var pageContent=$("#editor").val();
	  		var currentPageNo= $("#pageNoId").html();
	  		var dairyId= $("#dairyId").html();
	  		var userId= $("#userId").html();
	  		
	  		$(".dairyId").val(dairyId);
			$(".userId").val(userId);
			$(".pageNo").val(currentPageNo);
	  		
	  		
	  		console.log(pageContent);
	  		$("#pageContentIdVal").val(pageContent);
	  		$("#pageContentId").html(pageContent);
	  		$("#UploadfilesModel").modal({
	  			backdrop: 'static', 
	        	keyboard: false,
	        	show:true,
	        	height:'100%',
	        	width:'100%'
	  			});
	  		});
	  
	
	// var list=${pagelist};
	// console.log(list);
	 // var list=$.parseJSON("${pagelist}");
	// var list=${pagelist};
	  /* $.each(list,function( index, value ) {
		 
		  if(value.pageNo==2){
			  alert(value.pageName);
			$("#pageContent").html(value.pageName);
			
			return false;
		  }
	});   */
	
	/* $("#nextBtn1").click(function(){
		//$(".abc").html("some thing");
		tinymce.editors[0].setContent("hello world");
		
	}); */
 $("#nextBtn").click(function(){
	 var list=${pagelist};
	var currentPageNo= $("#pageNoId").html();
	var nextPageNo=parseInt(currentPageNo)+1;
	//alert(nextPageNo);
	 $.each(list,function( index, value ) {
		 
		  if(value.pageNo==nextPageNo){
			  //alert(value.pageName);
			//$("#editor").html(value.pageName);
			//$("#editor").html("some thing");
			tinymce.editors[0].setContent(value.content);
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
			//$("#editor").html(value.pageName);
			tinymce.editors[0].setContent(value.content);
			$("#pageNoId").html(value.pageNo);
			$("#pageDateId").html(value.date);
			return false;
		  }
	}); 
}); 
  	  
$("#viewDairyId").click(function(){
	 //var list=${pagelist};
	 var href=$(this).attr("data-href");
	var currentPageNo= $("#pageNoId").html();
	var actionBy =$(this).attr("data-actionBy");
	//var userId=$(this).attr("data-userId");
	//var dairyId=$(this).attr("data-dairyId");
	var pageContent=$("#pageContent").html();
	window.location.href=href+"?defaultPageNo="+currentPageNo+"&actionBy="+actionBy;
	
});    

$("#savePageContentId").click(function(){
	 //var list=${pagelist};
	 var href=$(this).attr("data-href");
	var currentPageNo= $("#pageNoId").html();
	var actionBy =$(this).attr("data-actionBy");
	//var userId=$(this).attr("data-userId");
	//var dairyId=$(this).attr("data-dairyId");
	var pageContent=$("#editor").html();
	var formData= $("#savePageId").serialize();
	window.location.href=href+"?currentPageNo="+currentPageNo+"&pageContent="+pageContent;
	
});
 }); 
 
 

/* function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#blah')
                .attr('src', e.target.result)
                .width(150)
                .height(200);
        };

        reader.readAsDataURL(input.files[0]);
    }
} */
	
 /* $(document).ready(function() {
	    	
	    	
	   
	  	  
*/	
 </script>
	  	  
</jsp:body>
 </defaultTemplate:defaultDecorator>
 
