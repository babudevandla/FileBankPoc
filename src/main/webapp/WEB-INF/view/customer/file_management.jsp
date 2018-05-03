<%@ page import="com.sm.portal.constants.WebDavServerConstant" %>
<% 
	pageContext.setAttribute("Media_rul", WebDavServerConstant.MEDIA_URL);
	pageContext.setAttribute("Media_rul2", WebDavServerConstant.MEDIA_URL2);
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
<jsp:attribute name="title">File Bank</jsp:attribute>
<jsp:body>
 
<style>
/* .modal-dialog {
  width: 75%;
 }
.modal-header {
    background-color: #337AB7;
    padding:5px 16px;
    color:#FFF;
    border-bottom:2px dashed #337AB7;
 } */
</style>
  
    <div class="create-post">
        <div class="row">
        	<c:if test="${not empty message}"><div class="btn btn-success">${message}</div> <br/><br/></c:if> 
        	<div class="col-md-3 col-sm-3">
              <div class="form-group">
                	<button class="btn btn-primary pull-right" data-toggle="modal" data-target="#myModal">
                		<i class="fa fa-folder-o" aria-hidden="true"></i> &nbsp; New Folder
                	</button>
              </div>
              </div>
              <form action="${contextPath}/sm/upload_files" method="post" enctype="multipart/form-data" >
              <div class="col-md-3 col-sm-3">
            	<div class="form-group">
            	<button class="btn btn-primary pull-right">
                		<!-- <i class="fa fa-cloud-upload" aria-hidden="true"></i>&nbsp;  --> 
                	<input type="file" name="fileName" multiple="multiple"/>	
                	<input type="hidden" name="userid" value="${userid}">
                	<input type="hidden" name="folderPath" value="${folderInfo.folderPath}">
                	<input type="hidden" name="folderId" value="${folderInfo.fId}">
                	</button>
                	&nbsp;&nbsp;  
                	<button type="submit" class="btn btn-primary pull-right"><i class="fa fa-upload" aria-hidden="true"></i> Upload</button> &nbsp; 
                	
              	</div>
              </div>
              </form>
             
               	<a href="${contextPath}/sm/getGallerContent?userid=${userId}" class="btn btn-primary pull-right"><i class="fa fa-image" aria-hidden="true"></i> GALLERY</button></a>
            </div>
        </div>
      	 <%-- <button id="fileBankWindow" data-href="${contextPath}/sm/getFileBankList?userid=${userid}" class="fileBankWindowCls" >
       		<img alt="File Bank" src="${contextPath}/resources/default/images/filebank.ico" style="width: 25px;"> File Bank
        </button><br/> --%>
         <div class="pull-right"><a href="${contextPath}/sm/showHiddenFoldersAndFiles/${folderInfo.fId}?userid=${userid}"><label style="color:red">show hidden files and folders</label></a></div>
        
        <a href="${contextPath}/sm/file_management" style="cursor: pointer;"	class="user-link">Home &nbsp;<i class="fa fa-chevron-right" aria-hidden="true"></i></a>
         <c:forEach items="${addressBar}" var="folderPath" varStatus="status">
         	<c:if test="${not empty folderPath.folderName}">
             	<a href="${contextPath}/sm/getfolderinfo/${folderPath.folderId}" style="cursor: pointer;"	class="user-link">${folderPath.folderName} &nbsp;<i class="fa fa-chevron-right" aria-hidden="true"></i> </a>
       		</c:if>
        </c:forEach>
     <div class="media">
       	<div class="row js-masonry" data-masonry='{ "itemSelector": ".grid-item", "columnWidth": ".grid-sizer", "percentPosition": true }'>
           	<div class="widget">
            <div >
            <table class="table user-list"  style="margin-left: 10px;">
              <thead>
                <tr>
                  <th><span>Name <i class="fa fa-chevron-right" aria-hidden="true"></i></span></th>
                  <th><span>Size <i class="fa fa-chevron-right" aria-hidden="true"></i></span></th>
                  <th><span>Last Modified <i class="fa fa-chevron-right" aria-hidden="true"></i></span></th>
                   <th><span>Owner <i class="fa fa-chevron-right" aria-hidden="true"></i></span></th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
               
                <c:choose>
                	<c:when test="${isInternalFolder eq 'Yes' }">
                		<c:forEach items="${folderInfo.childFolders}" var="folders" varStatus="status">
			                <tr>
				                <td>
				                	<a href="${contextPath}/sm/getfolderinfo/${folders.fId}" style="cursor: pointer;"	class="user-link">
				                		<strong style="color: black;"> <!-- <i class="fa fa-folder-open" aria-hidden="true"></i> -->
				                		<i class="fa fa-folder" aria-hidden="true"></i> &nbsp;${folders.fName} </strong>
                					</a>
                				</td>	
                				<%-- <td>	
                					<a href="${contextPath}/sm/deleteOrHidefile?folderId=${folders.fId}&deleteInfo=Folder&parentId=${folders.parentId}&userid=${userid}&action=Delete" style="cursor: pointer;"	class="user-link">
				                		<img src="${contextPath}/resources/default/images/delete.jpg" alt="File" style="width: 25px;"/>
                					</a>
                				</td>
                				<td>
                					<a href="${contextPath}/sm/deleteOrHidefile?folderId=${folders.fId}&deleteInfo=Folder&parentId=${folders.parentId}&userid=${userid}&action=Hide" style="cursor: pointer;"	class="user-link">
				                		<img src="${contextPath}/resources/default/images/showorhide.png" alt="File" style="width: 25px;"/>
                					</a>
                				</td> --%>
                				<td>
                					10 kb
                				</td>
                				<td>
                					2018-02-28
                				</td>
                				<td>
                					${user.firstname}
                				</td>
                				<td>
                					<!-- <a href="#" class="table-link">
				                      <span class="fa-stack">
				                        <i class="fa fa-square fa-stack-2x"></i>
				                        <i class="fa fa-pencil fa-stack-1x fa-inverse"></i>
				                      </span>
				                    </a> -->
				                    <a href="${contextPath}/sm/deleteOrHidefile?folderId=${folders.fId}&deleteInfo=Folder&parentId=${folders.parentId}&userid=${userid}&action=Delete" class="table-link danger">
				                      <span class="fa-stack">
				                        <i class="fa fa-square fa-stack-2x"></i>
				                        <i class="fa fa-trash-o fa-stack-1x fa-inverse"></i>
				                      </span>
				                    </a>
				                    
				                    <a href="${contextPath}/sm/deleteOrHidefile?folderId=${folders.fId}&deleteInfo=Folder&parentId=${folders.parentId}&userid=${userid}&action=Hide" style="cursor: pointer;"	class="user-link">
				                      <span class="fa-stack">
				                        <i class="fa fa-square fa-stack-2x"></i>
				                        <i class="fa fa-eye-slash fa-stack-1x fa-inverse"></i>
				                      </span>
				                    </a>
				                    <!-- <a href="#" class="table-link">
				                      <span class="fa-stack">
				                        <i class="fa fa-square fa-stack-2x"></i>
				                        <i class="fa fa-share fa-stack-1x fa-inverse"></i>
				                      </span>
				                    </a> -->
				                    <!-- <a href="#" class="table-link">
				                      <span class="fa-stack">
				                        <i class="fa fa-square fa-stack-2x"></i>
				                        <i class="fa fa-download fa-stack-1x fa-inverse"></i>
				                      </span>
				                    </a> -->
				                </td>
			                </tr>
                		</c:forEach>
                		
                		<c:forEach items="${folderInfo.localFilesInfo}" var="files" varStatus="status">
			                <tr>
				                <td>
				                	<a href="${contextPath}${Media_rul2}?filePath=${files.filePath}"  target="_blank" style="cursor: pointer;"	class="user-link">
				                		<c:choose>
				                			<c:when test="${files.fileType eq 'IMAGE' }">
				                				<img src="${contextPath}${Media_rul}?filePath=${files.filePath}" alt="" class="digilocker-photo-sm " />
				                				<%-- <img alt="" src="${contextPath}/resources/default/images/img_icon.png" style="width: 20px;margin-top: -3px;"> --%>
				                			</c:when>
				                			<c:when test="${files.fileType eq 'DOCUMENT' && files.fileExtension eq 'pdf' }">
				                				<!-- <i class="fa fa-file-pdf-o" aria-hidden="true"></i> -->
				                				<img alt="" src="${contextPath}/resources/default/images/pdf_icon.png" style="width: 20px;margin-top: -3px;">
				                			</c:when>
				                			<c:when test="${files.fileType eq 'VIDEO' }">
				                				<!-- <i class="fa fa-file-video-o" aria-hidden="true"></i> -->
				                				<img alt="" src="${contextPath}/resources/default/images/vedio_icon.png" style="width: 25px;margin-top: -3px;">
				                			</c:when>
				                			<c:when test="${files.fileType eq 'AUDIO' }">
				                				<!-- <i class="fa fa-file-audio-o" aria-hidden="true"></i> -->
				                				<img alt="" src="${contextPath}/resources/default/images/audio_icon.png" style="width: 25px;margin-top: -3px;">
				                			</c:when>
				                			<c:when test="${files.fileExtension eq 'xls' || files.fileExtension eq 'xlsx' }">
				                				 <img alt="" src="${contextPath}/resources/default/images/excel_icon.png" style="width: 25px;margin-top: -3px;"> 
				                			</c:when>
				                			<c:when test="${files.fileType eq 'DOCUMENT' && (files.fileExtension eq 'doc' || files.fileExtension eq 'docx')}">
				                				<img alt="" src="${contextPath}/resources/default/images/doc_icon.png" style="width: 25px;margin-top: -3px;">
				                			</c:when>
				                			<c:when test="${files.fileExtension eq 'txt' }">
				                				<img alt="" src="${contextPath}/resources/default/images/text-icon.png" style="width: 25px;margin-top: -3px;"> 
				                			</c:when>
				                			<c:otherwise>
				                				<i class="fa fa-file" aria-hidden="true"></i>
				                			</c:otherwise>
				                		</c:choose>
				                		${files.fileName}
                					</a>
                					
                				</td>
                				<%-- <td>
                					<a href="${contextPath}/sm/deleteOrHidefile?folderId=${folders.fId}&deleteInfo=File&&parentId=${folderInfo.fId}&userid=${userid}&action=Delete&fileId=${files.fileId}" style="cursor: pointer;"	class="user-link">
				                		<img src="${contextPath}/resources/default/images/delete.jpg" alt="File" style="width: 25px;"/>
                					</a>
                				</td>
                				<td>
                					<a href="${contextPath}/sm/deleteOrHidefile?folderId=${folders.fId}&deleteInfo=File&&parentId=${folderInfo.fId}&userid=${userid}&action=Hide&fileId=${files.fileId}" style="cursor: pointer;"	class="user-link">
				                		<img src="${contextPath}/resources/default/images/showorhide.png" alt="File" style="width: 25px;"/>
                					</a>	
				                </td>
				                <td>
                					</div><a href="${contextPath}/sm/downloadFile/${folderInfo.fId}?filePath=${files.filePath}" id="downloadFile" style="cursor: pointer;"	class="user-link" target="_self">
				                		<img src="${contextPath}/resources/default/images/download.jpg" alt="File" style="width: 25px;"/>
                					</a>	
				                </td> --%>
				                <td>
                					10 kb
                				</td>
                				<td>
                					2018-02-28
                				</td>
                				<td>
                					${user.firstname}
                				</td>
				                <td>
                					<!-- <a href="#" class="table-link">
				                      <span class="fa-stack">
				                        <i class="fa fa-square fa-stack-2x"></i>
				                        <i class="fa fa-pencil fa-stack-1x fa-inverse"></i>
				                      </span>
				                    </a> -->
				                    <a href="${contextPath}/sm/deleteOrHidefile?folderId=${folders.fId}&deleteInfo=File&&parentId=${folderInfo.fId}&userid=${userid}&action=Delete&fileId=${files.fileId}" class="table-link danger">
				                      <span class="fa-stack">
				                        <i class="fa fa-square fa-stack-2x"></i>
				                        <i class="fa fa-trash-o fa-stack-1x fa-inverse"></i>
				                      </span>
				                    </a>
				                    <a href="${contextPath}/sm/deleteOrHidefile?folderId=${folders.fId}&deleteInfo=File&&parentId=${folderInfo.fId}&userid=${userid}&action=Hide&fileId=${files.fileId}" class="table-link danger">
				                      <span class="fa-stack">
				                        <i class="fa fa-square fa-stack-2x"></i>
				                        <i class="fa fa-eye-slash fa-stack-1x fa-inverse"></i>
				                      </span>
				                    </a>
				                    <!-- <a href="#" class="table-link">
				                      <span class="fa-stack">
				                        <i class="fa fa-square fa-stack-2x"></i>
				                        <i class="fa fa-share fa-stack-1x fa-inverse"></i>
				                      </span>
				                    </a> -->
				                     <a href="${contextPath}/sm/downloadFile/${folderInfo.fId}?filePath=${files.filePath}" class="table-link">
				                      <span class="fa-stack">
				                        <i class="fa fa-square fa-stack-2x"></i>
				                        <i class="fa fa-download fa-stack-1x fa-inverse"></i>
				                      </span>
				                    </a>
				                    
				                    <a href="${contextPath}/sm/downloadFile/${folderInfo.fId}?filePath=${files.filePath}" class="table-link">
				                      <span class="fa-stack">
				                        <i class="fa fa-square fa-stack-2x"></i>
				                       <i class="fa fa-arrow-right  fa-stack-1x fa-inverse" aria-hidden="true"></i>
				                      </span>
				                    </a>
				                    
				                </td>
			                </tr>
                		</c:forEach>
                	</c:when>
                	<c:otherwise>
                		 <c:forEach items="${digiLockerHomeData}" var="folders" varStatus="status">
                		 	<c:if test="${not empty folders.fName}">
			                
			                	<c:choose>
			                		<c:when test="${folders.origin eq 'LOCKER' }">
					                	<tr>
						                <td>
							                <a href="${contextPath}/sm/getfolderinfo/${folders.fId}" style="cursor: pointer;"	class="user-link">
				                				<strong style="color: black;"><i class="fa fa-folder"></i> &nbsp;${folders.fName} </strong>
							                 </a>	
						                 </td>
						                 <td>
		                					10 kb
			                				</td>
			                				<td>
			                					2018-02-28
			                				</td>
			                				<td>
			                					${user.firstname}
			                				</td>
							                <td>
							                        
							                </td>
					                 	</tr>
			                 		</c:when>
			                	</c:choose>
			                	
			                 </c:if>
			                 </c:forEach>
                	</c:otherwise>
                </c:choose>
              </tbody>
            </table>
            </div>
            </div>
        </div>
     </div>     
     
    
    
    
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content" style="width: 600px; left: 200px;">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Create Folder</h4>
        </div>
        <div class="modal-body" >
           <input type="text" name="folderName" id="folderId" placeholder="Folder name" class="form-control">
        </div>
        <div class="modal-footer">
         <button type="button" class="btn btn-primary submitFolder" 
         	data-href="${contextPath}/sm/create_folder" 	data-userid="${userid}"	data-currentfolderpath="${currentFolderPath}"  >Create</button>
          <button type="button" class="btn btn-primary"  data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
  
 

<div class="modal fade" id="viewFile" role="dialog">
    <div class="modal-dialog">
    
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" style="color: white;">&times;</button>
                <h4 class="modal-title filename"></h4>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                 <a href="#" class="table-link">
                     <span class="fa-stack">
                       <i class="fa fa-square fa-stack-2x"></i>
                       <i class="fa fa-download fa-stack-1x fa-inverse"></i>
                     </span>
                   </a> 
                 <!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
            </div>
        </div>
      
    </div>
</div>


  
  
  
<script type="text/javascript">


/* function BrowseServer()
{
	 CKFinder.popup( {
         chooseFiles: true,
         onInit: function( finder ) {
             finder.on( 'files:choose', function( evt ) {
                 var file = evt.data.files.first();
                 document.getElementById( '${contextPath}/resources/default/images/sm_logo.png' ).value = file.getUrl();
             } );
             finder.on( 'file:choose:resizedImage', function( evt ) {
                 document.getElementById( '${contextPath}/resources/default/images/sm_logo.png' ).value = evt.data.resizedUrl;
             } );
         }
     } );
} */

</script>
    
  </jsp:body>
 </defaultTemplate:defaultDecorator>
  