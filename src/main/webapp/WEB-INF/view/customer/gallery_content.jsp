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

<defaultTemplate:defaultDecorator>
<jsp:attribute name="title">File Manager</jsp:attribute>
<jsp:body>
 
<style>
/* .modal-dialog {
  width: 75%;
 }
.modal-header {
    background-color: #337AB7;
    padding:16px 16px;
    color:#FFF;
    border-bottom:2px dashed #337AB7;
 } */
</style>
  
    <div class="create-post">
        <div class="row">
	               
	        <form action="${contextPath}/sm/storeFilesFromGallery" method="post" enctype="multipart/form-data">
              <div class="col-md-3 col-sm-3">
            	<div class="form-group">
            		<button class="btn btn-primary pull-right">
                		<!-- <i class="fa fa-cloud-upload" aria-hidden="true"></i>&nbsp;  --> 
	                	<input type="file" name="files" multiple="multiple" />	
	                	<input type="hidden" name="userId" value="${userid}">
	                	<input type="hidden" name="folderPath" value="${folderInfo.folderPath}">
	                	<input type="hidden" name="folderId" value="${folderInfo.fId}">
                	</button>
                	&nbsp;&nbsp;  
                	<button type="submit" class="btn btn-primary pull-right"><i class="fa fa-upload" aria-hidden="true"></i> Upload</button>
                	<!-- <input type="submit" class="btn btn-primary pull-right" value="Upload"> -->
              	</div>
              </div>
              </form>
              <%--  <button id="fileBankWindow" data-href="${contextPath}/sm/getFileBankList?userid=${userid}" data-action="GALLERY" class="fileBankWindowCls" style="margin-left: 292px;margin-top: -12px;">
              		<img alt="File Bank" src="${contextPath}/resources/default/images/filebank.ico" style="width: 25px;"> File Bank
               </button> --%>
            </div><br/><br/>
            <div class="col-md-12 col-sm-12">
            	<div class="col-md-3 col-sm-3" align="left" style="right: 45px;top: -10px;">
            		<select name="fileOrigin" id="fileOrigin" data-href="${contextPath}/sm/getGallerContent">
	             		<option value=""> --- Select File Origin ---</option>
	             		<option value="LOCKER" >FILE BANK</option>
	             		<option value="GALLERY">GALLERY</option>
	             		<option value="EBOOK">E-BOOK</option>
	             		<option value="EDAIRY">E-DAIRY</option>
	             		
	             		<%-- <core:forEach items="${fileOriginList}" var="origin">
	             			 <core:choose>
                                 <core:when test ="${fileOrigin eq  origin}">
                                    <option value="${origin}">${origin}</option>
                                 </core:when>
                              </core:choose>
                              <option value="${origin}">${origin}</option>
                          </core:forEach>   --%>           		
	             		
             		</select>
            	</div>
            	<div  class="col-md-9 col-sm-9" align="right" style="left: 103px;top: -18px;">
	            	<a href="${contextPath}/sm/getGallerContent?userid=${userid}&filesType=ALL" class="${allCls?'btn active':''}"> ALL</a>  &nbsp; | &nbsp; &nbsp;
	            	<a href="${contextPath}/sm/getGallerContent?userid=${userid}&filesType=IMAGE" class="${imgCls?'btn active':''}"><i class="fa fa-image" aria-hidden="true"></i> IMAGE</a>  &nbsp; &nbsp;|  &nbsp; &nbsp;
	            	<a href="${contextPath}/sm/getGallerContent?userid=${userid}&filesType=AUDIO" class="${audCls?'btn active':''}"><i class="fa fa-file-audio-o" aria-hidden="true"></i> AUDIO</a>  &nbsp; &nbsp;|  &nbsp; &nbsp;
	            	<a href="${contextPath}/sm/getGallerContent?userid=${userid}&filesType=VIDEO" class="${vedCls?'btn active':''}"><i class="fa fa-file-video-o" aria-hidden="true"></i> VIDEO</a>  &nbsp; &nbsp;|  &nbsp; &nbsp;
		            <a href="${contextPath}/sm/getGallerContent?userid=${userid}&filesType=DOCUMENT" class="${docCls?'btn active':''}"><i class="fa fa-file-text" aria-hidden="true"></i> DOCUMENTS</a> &nbsp; &nbsp;|  &nbsp; &nbsp;
		            <a href="${contextPath}/sm/getGallerContent?userid=${userid}&fileStatus=DELETED" class="${recyleCls?'btn active':''}"><img alt="" src="${contextPath}/resources/default/images/bin-blue-icon.png"> RECYCLE BIN</a>
            	</div>
            </div>
        </div>
         <br/>
    
   <div class="media">
   	<div class="row js-masonry" data-masonry='{ "itemSelector": ".grid-item", "columnWidth": ".grid-sizer", "percentPosition": true }'>
      <c:forEach items="${galleryContent}" var="files" varStatus="status">
    	<div class="grid-item col-md-4 col-sm-4" >
          	<div class="media-grid" style="height: 240px;">
                  <div class="img-wrapper" data-toggle="modal"  data-target=".modal-${status.count}">
                  <c:choose>
				      <c:when test="${files.fileType eq 'IMAGE' }">
                    		<img src="${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}" alt="" class="img-responsive post-image" style="height: 134px;"/>
                   	  </c:when> 
                   	  <c:when test="${files.fileType eq 'DOCUMENT' && files.fileExtension eq 'pdf' }">
              				<embed src="${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}" style="height: 134px;"/>
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
						  <source src="${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}" type="video/mp4" style="height: 134px;"/>
						</video>
              		 </c:when>
           			 <c:when test="${files.fileType eq 'AUDIO' }">
           				<audio height="134" controls>
				 		 <source src="${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}" type="audio/mpeg"  style="height: 134px;">
						</audio>
           			 </c:when>
           			 <c:when test="${files.fileType eq 'doc' }">
           				<img alt="" src="${contextPath}/resources/default/images/doc_icon.png" style="height: 134px;"/>
           			 </c:when>
           			 <c:otherwise>
           				<img src="${contextPath}/resources/default/images/folder_icon.png" alt="" class="img-responsive post-image" style="height: 134px;"/>
           			 </c:otherwise>
              		</c:choose>
                  </div>
                  <div class="media-info">
                    <!-- <div class="reaction">
                      <a class="btn text-green"><i class="fa fa-thumbs-up"></i> 73</a>
                      <a class="btn text-red"><i class="fa fa-thumbs-down"></i> 4</a>
                    </div> -->
                    <div class="user-info">
                    <c:choose>
                    	<c:when test="${files.fileType eq 'DOCUMENT' && (files.fileExtension eq 'pdf'  )}">
                      		<img src="${contextPath}/resources/default/images/pdf_icon.png" alt="" class="profile-photo-sm pull-left" />
                      </c:when>
                      <c:when test="${files.fileType eq 'DOCUMENT' && ( files.fileExtension eq 'xls' || files.fileExtension eq 'xlsx' ) }">
           					<img src="${contextPath}/resources/default/images/excel_icon.png"  class="profile-photo-sm pull-left"/>
           		  	  </c:when>
           		  	  <c:when test="${files.fileType eq 'DOCUMENT' && (files.fileExtension eq 'doc' || files.fileExtension eq 'docx'  )}">
              				<img src="${contextPath}/resources/default/images/doc_icon.png"  class="profile-photo-sm pull-left"/>
              		  </c:when>
              		  <c:when test="${files.fileType eq 'AUDIO' }">
              		  		<img src="${contextPath}/resources/default/images/audio_icon.png"  class="profile-photo-sm pull-left"/>
              		  </c:when>
              		  <c:when test="${files.fileType eq 'VIDEO' }">
              		  		<img src="${contextPath}/resources/default/images/vedio_icon.png"  class="profile-photo-sm pull-left"/>
              		  </c:when>
                      <c:otherwise>
                      		<img src="${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}" alt="" class="profile-photo-sm pull-left" />
                      </c:otherwise>
                      </c:choose>
                      <div class="user">
                        <h6>${files.fileName}</h6>
                        <h6>Origin: ${files.origin} </h6>
                        <c:choose>
		               		<c:when test="${files.fileStatus eq 'ACTIVE'}">
		               			<span class="label label-success">${files.fileStatus}</span>
		               		</c:when>
		               		<c:when test="${files.fileStatus eq 'HIDE'}">
		               			<span class="label label-warning">${files.fileStatus}</span>
		               		</c:when>
		               		<c:otherwise>
		               			<c:choose>
		               				<c:when test="${files.folderStatus eq 'DELETED'}">
		               					<span class="label label-danger">${files.folderStatus}</span>
		               				</c:when>
		               				<c:otherwise>
		               					<span class="label label-danger">${files.fileStatus}</span>
		               				</c:otherwise>
		               			</c:choose>
		               		</c:otherwise>
		               </c:choose>
                      </div>
                    </div>
                  </div>
                </div>
                <%-- <div class="modal fade modal-${status.count}" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static"> --%>
                <div class="modal fade modal-${status.count}" tabindex="-1" role="dialog" aria-hidden="true" > 
                 <div class="modal-dialog modal-lg">
                   <div class="modal-content">
                   <button type="button" class="close" data-dismiss="modal" style="width: 30px;">&times;</button>
                     <div class="post-content">
                     <c:choose>
					      <c:when test="${files.fileType eq 'IMAGE' }">
	                       	<img src="${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}" alt="post-image" class="img-responsive post-image" />
	                       </c:when>
	                       <c:when test="${files.fileType eq 'VIDEO' }">
	             				<video controls>
							  		<source src="${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}" type="video/mp4" style="height: 134px;">
								</video>
	              			</c:when>
	              			<c:when test="${files.fileType eq 'AUDIO' }">
	              				<audio  controls>
								  <source src="${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}" type="audio/mpeg"  style="height: 134px;">
								</audio>
	              			</c:when>
	              			<c:when test="${files.fileType eq 'DOCUMENT' && files.fileExtension eq 'pdf' }">
	              				<embed src="${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}"   frameborder="0" width="100%" height="600px"/>
	              		  </c:when>
	              		  <c:when test="${files.fileType eq 'DOCUMENT' && ( files.fileExtension eq 'xls' || files.fileExtension eq 'xlsx' ) }">
              					<iframe src="http://docs.google.com/gview?url=${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}"  height= "100%"  width= "100%"></iframe>
              		  	  </c:when>
              		  	   <c:when test="${files.fileType eq 'DOCUMENT' && (files.fileExtension eq 'log' ||files.fileExtension eq 'txt' ||files.fileExtension eq 'json' )}">
              					<iframe src="${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}" height= "100%"  width= "100%"></iframe>
              		  		</c:when>
              		  		<c:when test="${files.fileType eq 'DOCUMENT' && (files.fileExtension eq 'ppt'  )}">
	              				<iframe src="http://docs.google.com/gview?url=${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}"  height= "100%"  width= "100%"></iframe>
	              		  </c:when>
	              		  <c:when test="${files.fileType eq 'DOCUMENT' && (files.fileExtension eq 'doc' || files.fileExtension eq 'docx' )}">
              				<iframe src="http://docs.google.com/gview?url=${contextPath}${WebDav_Server_Url}?filePath=${files.filePath}"  height= "100%"  width= "100%"></iframe>
              		      </c:when>
                      </c:choose> 
                     </div>
                   </div>
                 </div>
               </div> 
            </div> 
          </c:forEach>   
     </div>
    </div>
  


<script type="text/javascript">

	
	
</script>
    
  </jsp:body>
 </defaultTemplate:defaultDecorator>
  