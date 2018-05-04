<%@ page import="com.sm.portal.constants.WebDavServerConstant" %>
<% 
	//pageContext.setAttribute("WebDav_Server_Url", WebDavServerConstant.WEBDAV_SERVER_URL);
	pageContext.setAttribute("WebDav_Server_Url", WebDavServerConstant.MEDIA_URL);
%>
<%@ page pageEncoding="ISO-8859-1"  contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%@taglib prefix="defaultTemplate" tagdir="/WEB-INF/tags"%>
<style type="text/css">

 div#fileBankDetailsId {
    overflow-y: auto;
    height: 100%;
    overflow-x: hidden;
    width: 100%;
} 
</style>

	<div class="create-post" style="min-height: 0px;">
      
        <div class="col-md-12 col-sm-12">
        	<div class="col-md-3 col-sm-3" align="left" style="right: -37px;top: -10px;">
        		<select name="fileOrigin" id="fileBankWindowId" >
          		<option value="ALL" <c:if test="${fileOrigin eq 'ALL' }"> selected</c:if>> --- ALL ---</option>
          		<option value="LOCKER" <c:if test="${fileOrigin eq 'LOCKER' }"> selected</c:if> >FILE BANK</option>
          		<option value="GALLERY" <c:if test="${fileOrigin eq 'GALLERY' }"> selected</c:if>>GALLERY</option>
          		<option value="E-BOOK" <c:if test="${fileOrigin eq 'E-BOOK' }"> selected</c:if>>E-BOOK</option>
          		<option value="E-DAIRY" <c:if test="${fileOrigin eq 'E-DAIRY' }"> selected</c:if>>E-DAIRY</option>
         		</select>
        	</div>
        	<div  class="col-md-9 col-sm-9" align="right" style="left: 70px;top: -18px;">
         	<a  data-href="${contextPath}/sm/getFileBankList?userid=${userid}&filesType=ALL" class="${allCls?'btn active':''} fileBankWindowCls" style="cursor: pointer;"> ALL</a>  &nbsp; | &nbsp; &nbsp;
         	<a  data-href="${contextPath}/sm/getFileBankList?userid=${userid}&filesType=IMAGE" class="${imgCls?'btn active':''} fileBankWindowCls" style="cursor: pointer;"><i class="fa fa-image" aria-hidden="true"></i> IMAGE</a>  &nbsp; &nbsp;|  &nbsp; &nbsp;
         	<a  data-href="${contextPath}/sm/getFileBankList?userid=${userid}&filesType=AUDIO" class="${audCls?'btn active':''} fileBankWindowCls" style="cursor: pointer;"><i class="fa fa-file-audio-o" aria-hidden="true"></i> AUDIO</a>  &nbsp; &nbsp;|  &nbsp; &nbsp;
         	<a  data-href="${contextPath}/sm/getFileBankList?userid=${userid}&filesType=VIDEO" class="${vedCls?'btn active':''} fileBankWindowCls" style="cursor: pointer;"><i class="fa fa-file-video-o" aria-hidden="true"></i> VIDEO</a>  &nbsp; &nbsp;|  &nbsp; &nbsp;
          <a  data-href="${contextPath}/sm/getFileBankList?userid=${userid}&filesType=DOCUMENT" class="${docCls?'btn active':''} fileBankWindowCls" style="cursor: pointer;"><i class="fa fa-file-text" aria-hidden="true"></i> DOCUMENTS</a> &nbsp; &nbsp;|  &nbsp; &nbsp;
          <a  data-href="${contextPath}/sm/getFileBankList?userid=${userid}&fileStatus=DELETED" class="${recyleCls?'btn active':''} fileBankWindowCls" style="cursor: pointer;"><img alt="" src="${contextPath}/resources/default/images/bin-blue-icon.png"> RECYCLE BIN</a>
        	</div>
        </div>
    </div>
   <!--  Total Files selected (<span id="selectedFilesCount"></span>)
    <br/> -->
  <strong > SELECT ALL: <input type="checkbox" class="checkallsellerimages"> </strong>
  <div class="media" style="height:300px;margin-top: -2px;" id="fileBankDetailsId">
  <form action="${contextPath}/sm/uploadFileBankFilesInCloud" id="sellerimagebulkapprove" method="post">
  	<input type="hidden" name="id"  class="fbCls" id="FBID">
	<input type="hidden" name="content" class="contentCls">
	<input type="hidden" name="pageNo" class="pageNoCls">
	<input type="hidden" name="actionType" class="actionTypeCls" >
   	<div class="row js-masonry" data-masonry='{ "itemSelector": ".grid-item", "columnWidth": ".grid-sizer", "percentPosition": true }'>
      <c:forEach items="${galleryContent}" var="files" varStatus="status">
    	<div class="grid-item col-md-2 col-sm-2" >
          	<div class="media-grid" style="height: 122px;">
                  <div class="img-wrapper" data-toggle="modal"  data-target=".modal-${status.count}">
                  <c:choose>
				      <c:when test="${files.fileType eq 'IMAGE' }">
                    		<img src="${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}" alt="" class="img-responsive post-image" style="height: 100px;"/>
                   	  </c:when> 
                   	  <c:when test="${files.fileType eq 'DOCUMENT' && files.fileExtension eq 'pdf' }">
              				<embed src="${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}" style="height: 100px;"/>
              		  </c:when>
              		  <c:when test="${files.fileType eq 'DOCUMENT' && ( files.fileExtension eq 'xls' || files.fileExtension eq 'xlsx') }">
              				<iframe src="http://docs.google.com/gview?url=${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}&embedded=true"  ></iframe>
              		  </c:when>
              		  <c:when test="${files.fileType eq 'DOCUMENT' && (files.fileExtension eq 'log' ||files.fileExtension eq 'txt' ||files.fileExtension eq 'json')}">
              				<iframe src="${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}" ></iframe>
              		  </c:when>
              		  <c:when test="${files.fileType eq 'DOCUMENT' && (files.fileExtension eq 'ppt'  )}">
              				<iframe src="http://docs.google.com/gview?url=${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}&embedded=true" ></iframe>
              		  </c:when>
              		  <c:when test="${files.fileType eq 'DOCUMENT' && (files.fileExtension eq 'doc' || files.fileExtension eq 'docx'  )}">
              				<iframe src="http://docs.google.com/gview?url=${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}&embedded=true"  ></iframe>
              		  </c:when>
              		  <c:when test="${files.fileType eq 'VIDEO' }">
             			<video  height="134" controls>
						  <source src="${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}" type="video/mp4" style="height: 100px;"/>
						</video>
              		 </c:when>
           			 <c:when test="${files.fileType eq 'AUDIO' }">
           				<audio height="134" controls>
				 		 <source src="${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}" type="audio/mpeg"  style="height: 100px;">
						</audio>
           			 </c:when>
           			 <c:when test="${files.fileType eq 'doc' }">
           				<img alt="" src="${contextPath}/resources/default/images/doc_icon.png" style="height: 100px;"/>
           			 </c:when>
           			 <c:otherwise>
           				<img src="${contextPath}/resources/default/images/folder_icon.png" alt="" class="img-responsive post-image" style="height: 100px;"/>
           			 </c:otherwise>
              		</c:choose>
                  </div>
                  &nbsp;<input type="checkbox" name="filePaths" class="selectCheck" value="${files.filePath}"> select
                </div>
            </div> 
          </c:forEach>   
       </div>
       </form>
    </div>
    
  <script type="text/javascript" >
  
  $('.fileBankWindowCls').on('click',function(event){
		 event.preventDefault();
		 var href=$(this).attr("data-href");
		 console.log(href);
		 $.ajax({
				url: href,
				cache: false,
				success: function(data) {
					$("#fileBankFilesList").html(data);
					 $('#fileBankModelPopup').modal({
			        	backdrop: 'static', 
			        	keyboard: false,
			        	show:true,
			        	height:'100%',
			        	width:'100%'
			        });
				}
			});
		});
  
  $('#fileBankWindowId').change(function(event){
		 event.preventDefault();
		 var fileOrigin=$(this).val();
		 var href="${contextPath}/sm/getFileBankList?fileOrigin="+fileOrigin;
		 console.log(href);
		 $.ajax({
				url: href,
				cache: false,
				success: function(data) {
					$("#fileBankFilesList").html(data);
					 $('#fileBankModelPopup').modal({
			        	backdrop: 'static', 
			        	keyboard: false,
			        	show:true,
			        	height:'100%',
			        	width:'100%'
			        });
				}
			});
		});
  
  
  $('.checkallsellerimages').click(function () {
	  $("#sellerimagebulkapprove").find(':checkbox').attr('checked', this.checked);
		//var size=$("[name='filePathIds']:checked").length;
		//$("#selectedFilesCount").html(size);
	});
  $(".selectCheck").click(function(){
	  $(this).attr('checked', this.checked);
	  var size=$("[name='filePaths']:checked").length;
	  $("#selectedFilesCount").html(size);
	  console.log(size);
	  var files= $("[name='filePaths']:checked").val();
  	  console.log(files);
  	/*  var tdTag='';
	 if( size > 0 ){
		 for(var i=0;i<size;i++){
			 tdTag=+'<div class="grid-item col-md-2 col-sm-2" id="selectedFiles"><div class="media-grid" style="height: 122px;">'
			  +'<div class="img-wrapper" data-toggle="modal"  data-target=".modal-${status.count}">'
			 +'<img src="${contextPath}${WebDav_Server_Url}?filePath='+files+'" alt="" class="digilocker-photo-sm " />'
			 +'</div>'
			+'</div></div> '
		 }
	 }
  	  console.log(tdTag);	
  	  $("#selectedFiles").html(tdTag); */
  });
  
  $(document).ready(function() {
	  var size=$("[name='filePathIds']:checked").length;
	  console.log("default::"+size);
	  if(size==0){
		  $("#selectedFilesCount").html(size);
	  }
  })
  
  
 
  </script>  
