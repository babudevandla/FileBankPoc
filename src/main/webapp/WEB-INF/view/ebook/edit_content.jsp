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
 <h2>Edit Book :</h2>  <br/>
 
 <label id="userId" style="display:none">${eBook.userId}</label>
  <label id="bookId" style="display:none">${eBook.bookId}</label>
 <a class="btn btn-primary pull-left" id="ebookPrevBtn"  ><i class="fa fa-chevron-left" aria-hidden="true"></i> PRE </a>
	<a class="btn btn-primary pull-right nextBtn" id="ebookNextBtn" >NEXT <i class="fa fa-chevron-right" aria-hidden="true"></i></a>
    <table id="navigatorTable" class="table" cellspacing="0" style ="width: 100%">
	    <tbody>
	    	<tr>
	    		<td ><label>Chapter:</label></td><td id="ebookPageDateId" ><span id="cptrName">${eBook.defaultPage.chapterName}</span> <span class="dedit-remote-json"><img src="${contextPath}/resources/default/images/edit.png"> </span></td>
	    		<td><label>Page:</label></td><td id="ebookPageNoId" class="defaultPageNoCls">${eBook.defaultPage.pageNo}</td>
	    		<td><label>Select Date:</label></td><td id="sectedDateId"></td>
	    		<td align="right">
	    			<a id="viewBookId" data-href="${pageContext.request.contextPath}/sm/getEbookContent?userId=${eBook.userId}&bookId=${eBook.bookId}"  class="btn btn-success">
	    			<i class="fa fa-eye"></i> VIEW	</a>
	    		</td>
	    	</tr>
	    </tbody>
    </table>
 
	 <form:form action="${contextPath}/sm/saveEbookPageContent"  id="saveEbookPageId" method="post" modelAttribute="eBookPageDto">
	 	
	 	<!-- <input name="upload" type="button"	class="btn btn-primary uploadMultipleFiles1"  value="Uploadfiles" /> -->
	 	<button class="btn btn-primary uploadMultipleFiles1">
	 		<i class="fa fa-upload"></i> &nbsp;Local Files
	 	</button>
	 	<button id="fileBankWindow" data-href="${contextPath}/sm/getFileBankList" data-action="EBOOK" class="btn btn-primary" style="margin-left: 20px;margin-top: 0px;">
			 <i class="fa fa-upload"></i>&nbsp; File Bank
		</button>
		<textarea id="editor"  name="content" class="ebookContentCls">${eBook.defaultPage.content}</textarea><br/>
		<input type="hidden" name="bookId" class="bookId" value="${eBook.bookId}">
		<input type="hidden" name="userId" class="userId" value="${eBook.userId}">
		<input type="hidden" name="pageNo" class="pageNo">
		<input type="hidden" name="currentPageNo" class="pageNo">
		 <!-- <input name="submit" type="submit"	class="btn btn-primary" value="Update" /> -->
		 <input type="button" value="Update" id="saveEbookPageContentId"  class="btn btn-primary"  
		  data-href="${contextPath}/sm/saveEbookPageContent" />
	</form:form>

	
	
	<div class="modal fade" id="UploadfilesModel" role="dialog">
	    <div class="modal-dialog">
	    <form action="${contextPath}/sm/storeFilesInGalleryFromEbook" id="storeFilesInGallery" enctype="multipart/form-data" method="post" >
	        <div class="modal-content" style="width: 600px; left: 200px;">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" style="color: white;">&times;</button>
	                <h4 class="modal-title filename"></h4>
	            </div>
	             <table id="fuTable"  border="1" style="margin-left: 25px;margin-top: 12px;">
		    		<tr>
		        		<td> 
		        		<!-- <input name="files" type="file" multiple onchange="readURL(this);">
		        			<img id="blah" src="#" alt="your image" /> -->
		        			<input name="files" type="file" multiple>
		        		</td>
		   			 </tr>
	   		 </table>
	 		<br>
	 			<div align="right">
	       			<input  type="button" value="Add More File"  onclick="AddMoreFile('fuTable')" style="margin-top: -60px;">
	       		</div>
	            <div class="modal-body">
					<input type="hidden" name="bookId" class="bookId">
					<input type="hidden" name="userId" class="userId">
					<input type="hidden" name="pageNo" class="pageNo">
					<input type="hidden" name="bookPagecontent" id="pageContentIdVal">
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
	
	<div class="modal fade" id="updateCptrName" role="dialog">
	    <div class="modal-dialog">
	    <form action="${contextPath}/sm/updateChapter" id="updateCptrNameFrom"  method="get" >
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" style="color: white;">&times;</button>
	                <h4 class="modal-title filename">Change Chapter Name</h4>
	            </div>
	            <div class="modal-body">
	            	<input type="text" name="newChapterName" id="chaptername" class="form-control" >
					<input type="hidden" name="bookId" class="bookId">
					<input type="hidden" name="userId" class="userId">
					<input type="hidden" name="pageNo" class="pageNo">
					<input type="hidden" name="existingName" class="existingName">
	            </div>
	            <div class="modal-footer">
	            	  <button type="submit" class="btn btn-primary changeCptrName" id="updateCptr" data-href="${contextPath}/sm/updateChapter" >Update</button>
	            	  <button type="submit" class="btn btn-primary changeCptrName" id="createCptr" data-href="${contextPath}/sm/createNewChapter">Create</button>
	                 <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	            </div>
	        </div>
	      </form>
	    </div>
	</div>

<script type="text/javascript">
$(document).ready(function () {
	/* $('.dedit-remote-json').doomEdit({editForm:{method:'post', action:'remote_json.html', id:'ebookPageDateId'}, afterFormSubmit: function (data, form, el) {data = $.parseJSON(data);el.text(data.message);alert(data.message);}}); */
});

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
	  		var currentPageNo= $("#ebookPageNoId").html();
	  		var dairyId= $("#bookId").html();
	  		var userId= $("#userId").html();
	  		
	  		$(".bookId").val(dairyId);
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
	        	width:'50%'
	  			});
	  		});
	  
	
	
 $("#ebookNextBtn").click(function(){
	 var list=${pagelist};
	var currentPageNo= $("#ebookPageNoId").html();
	var nextPageNo=parseInt(currentPageNo)+1;
	//alert(nextPageNo);
	 $.each(list,function( index, value ) {
		 
		  if(value.pageNo==nextPageNo){
			  //alert(value.pageName);
			//$("#editor").html(value.pageName);
			//$("#editor").html("some thing");
			tinymce.editors[0].setContent(value.content);
			$("#ebookPageNoId").html(value.pageNo);
			$("#ebookPageDateId").html(value.date);
			$("#cptrName").html(value.chapterName);
			return false;
		  }
	}); 
});
	
$("#ebookPrevBtn").click(function(){
	 var list=${pagelist};
	var currentPageNo= $("#ebookPageNoId").html();
	var previousPageNo=parseInt(currentPageNo)-1;
	//alert(nextPageNo);
	 $.each(list,function( index, value ) {
		 
		  if(value.pageNo==previousPageNo){
			  //alert(value.pageName);
			//$("#editor").html(value.pageName);
			tinymce.editors[0].setContent(value.content);
			$("#ebookPageNoId").html(value.pageNo);
			$("#ebookPageDateId").html(value.date);
			$("#cptrName").html(value.chapterName);
			return false;
		  }
	}); 
}); 
  	  
$("#viewBookId").click(function(){
	 //var list=${pagelist};
	 var href=$(this).attr("data-href");
	var currentPageNo= $("#ebookPageNoId").html();
	//var actionBy =$(this).attr("data-actionBy");
	//var userId=$(this).attr("data-userId");
	//var dairyId=$(this).attr("data-dairyId");
	var pageContent=$("#bookPageContent").html();
	window.location.href=href+"&defaultPageNo="+currentPageNo;
	
});    


 
	$("#saveEbookPageContentId").click(function(){
		var currentPageNo= $("#ebookPageNoId").html();
		$(".pageNo").val(currentPageNo);
		if(currentPageNo!='' && currentPageNo!=null){
			$("#saveEbookPageId").submit();
		}
		
	});
 
 
 
	$(".dedit-remote-json").click(function(e){
  		e.preventDefault();
  		
  		var currentPageNo= $("#ebookPageNoId").html();
  		var dairyId= $("#bookId").html();
  		var userId= $("#userId").html();
  		var cptrName=$("#cptrName").html();
  		$(".existingName").val(cptrName);
  		$(".bookId").val(dairyId);
		$(".userId").val(userId);
		$(".pageNo").val(currentPageNo);
  		$("#chaptername").val(cptrName);
  		
  		
  		console.log(cptrName);
  		
  		$("#updateCptrName").modal({
  			backdrop: 'static', 
        	keyboard: false,
        	show:true,
        	height:'100%',
        	width:'100%'
  			});
  		});
 }); 
 
 

 </script>
	  	  
</jsp:body>
 </defaultTemplate:defaultDecorator>
 
