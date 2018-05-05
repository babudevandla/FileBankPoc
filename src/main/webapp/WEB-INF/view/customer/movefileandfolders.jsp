<%@ page import="com.sm.portal.constants.WebDavServerConstant" %>
<% 
	//pageContext.setAttribute("WebDav_Server_Url", WebDavServerConstant.WEBDAV_SERVER_URL);
	pageContext.setAttribute("WebDav_Server_Url", WebDavServerConstant.MEDIA_URL);
	pageContext.setAttribute("Media_rul", WebDavServerConstant.MEDIA_URL);
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
<%@ page import="com.sm.portal.digilocker.model.FileAndFolderMoveEnum" %>


 <div class="media" style="height:300px;margin-top: -2px;" id="fileBankDetailsId">
	<a href="${contextPath}/sm/getfolderinfowhilemoving?destinationFolderId=-1" style="cursor: pointer;"	class="user-link getFolderInfoCls">Home &nbsp;<i class="fa fa-chevron-right" aria-hidden="true"></i></a>
         <c:forEach items="${addressBar}" var="folderPath" varStatus="status">
         	<c:if test="${not empty folderPath.folderName}">
             	<a href="${contextPath}/sm/getfolderinfowhilemoving?destinationFolderId=${folderPath.folderId}" style="cursor: pointer;"	class="user-link getFolderInfoCls">${folderPath.folderName} &nbsp;<i class="fa fa-chevron-right" aria-hidden="true"></i> </a>
       		</c:if>
        </c:forEach>
        <div class="media">
       	<div class="row js-masonry" data-masonry='{ "itemSelector": ".grid-item", "columnWidth": ".grid-sizer", "percentPosition": true }'>
           	<div class="widget">
            <div >
             <div class="table100 ver1 m-b-110" style="margin-left: 12px;width: 913px;">
					<div class="table100-head">
						<table>
							<thead>
								<tr class="row100 head">
									<th class="cell100 column1">Name</th>
									<th class="cell100 column2">Size</th>
									<th class="cell100 column3">Last Modified</th>
									<th class="cell100 column4">Owner</th>
									<th class="cell100 column5">Action</th>
								</tr>
							</thead>
						</table>
					</div>
					<input type="hidden" name="sourceFolderId"  value="${moveFilesAndFoldersBean.sourceFolderId}"  class="sourceFolderIdCls">
					<input type="hidden" name="sourceFileId" value='${moveFilesAndFoldersBean.sourceFileId }' class="sourceFileIdCls">
					<input type="hidden" name="destinationFolderId" value="${moveFilesAndFoldersBean.destinationFolderId }" class="destinationFolderIdCls">
					<input type="hidden" name="moveType" value="${moveFilesAndFoldersBean.moveType }" class="moveTypeCls" >
					<input type="hidden" name="destinationFolderParentId" value="${moveFilesAndFoldersBean.destinationFolderParentId }" class="destinationFolderParentIdCls" >
					
					<div class="table100-body js-pscroll">
						<table>
							<tbody>
							<c:choose>
			                	<c:when test="${isInternalFolder eq 'Yes' }">
			                		<c:forEach items="${folderInfo.childFolders}" var="folders" varStatus="status">
						                <tr class="row100 body">
							                <td class="cell100 column1">
							                	<c:choose>
							                		<c:when test="${folders.folderStatus eq 'DISABLED' }">
									                	<a  style="cursor: pointer;"	class="getFolderInfoCls user-link ">
									                		<strong style="color: black;"><img alt="${folders.fName}" src="${contextPath}/resources/default/images/folder_PNG8773.png" style="width: 20px;"> &nbsp;${folders.fName} </strong>
					                					</a>
			                						</c:when>
			                						<c:otherwise>
			                							<a href="${contextPath}/sm/getfolderinfowhilemoving?destinationFolderId=${folders.fId}&destinationFolderParentId=${folders.parentId}" style="cursor: pointer;"	class="getFolderInfoCls user-link ">
									                		<strong style="color: black;"><img alt="${folders.fName}" src="${contextPath}/resources/default/images/folder_PNG8773.png" style="width: 20px;"> &nbsp;${folders.fName} </strong>
					                					</a>
			                						</c:otherwise>
			                					</c:choose>
			                				</td>	
			                				<td class="cell100 column2">10 kb</td>
			                				<td class="cell100 column3">2018-02-28</td>
			                				<td class="cell100 column4">${user.firstname}</td>
			                				
						                </tr>
			                		</c:forEach>
			                		
			                		<c:forEach items="${folderInfo.localFilesInfo}" var="files" varStatus="status">
						                <tr class="row100 body">
							                <td class="cell100 column1">
							                	<%-- <a href="${contextPath}${Media_rul2}?filePath=${files.filePath}"  target="_blank" style="cursor: pointer;"	class="user-link"> --%>
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
							                		<strong style="color: black;" id="textellipse">&nbsp;${files.fileName} </strong>
			                					<!-- </a> -->
			                					
			                				</td>
							                <td class="cell100 column2">10 kb</td>
			                				<td class="cell100 column3">2018-02-28</td>
			                				<td class="cell100 column4">${user.firstname}</td>
							               
						                </tr>
			                		</c:forEach>
			                	</c:when>
			                	<c:otherwise>
			                		 <c:forEach items="${digiLockerHomeData}" var="folders" varStatus="status">
						                	<c:choose>
						                		<c:when test="${(folders.origin eq 'LOCKER') && (not empty folders.fName) && (folders.isThisFolderForRootFiles eq 'NO')}">
								                	<tr  class="row100 body">
										                <td class="cell100 column1">
										                <c:choose>
									                		<c:when test="${folders.folderStatus eq 'DISABLED' }">
											                	<a  style="cursor: pointer;"	class="getFolderInfoCls user-link ">
										                				<strong style="color: black;" id="textellipse"><img alt="${folders.fName}" src="${contextPath}/resources/default/images/folder_PNG8773.png" style="width: 20px;"> &nbsp;${folders.fName}</strong> 
													                 </a>
					                						</c:when>
					                						<c:otherwise>
					                							<a href="${contextPath}/sm/getfolderinfowhilemoving?destinationFolderId=${folders.fId}&destinationFolderParentId=${folders.parentId}" style="cursor: pointer;"	class="getFolderInfoCls user-link ">
										                				<strong style="color: black;" id="textellipse"><img alt="${folders.fName}" src="${contextPath}/resources/default/images/folder_PNG8773.png" style="width: 20px;"> &nbsp;${folders.fName}</strong> 
													                 </a>
					                						</c:otherwise>
					                					</c:choose>												                	
										                 </td>
										                 <td class="cell100 column2">10 kb</td>
						                				 <td class="cell100 column3">2018-02-28</td>
						                				 <td class="cell100 column4">${user.firstname}</td>
										                 <td class="cell100 column5"></td>
								                 	</tr>
						                 		</c:when>
						                	</c:choose>
						                	
						                	<c:choose>
						                		<c:when test="${(folders.origin eq 'LOCKER') && (not empty folders.fName) && (folders.isThisFolderForRootFiles eq 'YES')}">						                 		
						                 			<c:forEach items="${folders.localFilesInfo}" var="files" varStatus="status">
										                <tr class="row100 body">
											                <td class="cell100 column1">
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
											                		<strong style="color: black;" id="textellipse">&nbsp;${files.fileName} </strong>
							                					</a>
							                					
							                				</td>
											                <td class="cell100 column2">10 kb</td>
							                				<td class="cell100 column3">2018-02-28</td>
							                				<td class="cell100 column4">${user.firstname}</td>
											                </td>
										                </tr>
							                		</c:forEach>
						                 		</c:when>
						                	</c:choose>
						                	
						                	
						                 </c:forEach>
			                	</c:otherwise>
			                </c:choose>
								
							</tbody>
						</table>
					</div>
				</div>
            </div>
            </div>
        </div>
     </div> 
     </div>
     
     <script type="text/javascript" >
 $(document).ready(function() {
	 
  $('.getFolderInfoCls').click(function(event){
		 event.preventDefault();
		 var href1=$(this).attr("href");
		 var sourceFolderId=$(".sourceFolderIdCls").val();
		 var sourceFileId=$(".sourceFileIdCls").val();
		 var moveType=$(".moveTypeCls").val();
		// var destinationFolderParentId =$(".destinationFolderParentIdCls").val();
		 var href;
		//alert("rsf");
		 href=encodeURI(href1+"&sourceFolderId="+sourceFolderId+"&sourceFileId="+sourceFileId+"&moveType="+moveType);
		 console.log(href);
			$.ajax({
				url: href,
				type:'GET',
				cache: false,
				success: function(data) {
					$("#moveFilesAndFoldersId").html(data);
					$('#fileAndFolderMoveModelPopup').modal({
			        	backdrop: 'static', 
			        	keyboard: false,
			        	show:true,
			        	height:'100%',
			        	width:'100%'
			        });
				}
			});
		/*  $.ajax({
				url: href,
				cache: false,
				success: function(data) {
					$("#moveFilesAndFoldersId").html(data);
					 $('#fileAndFolderMoveModelPopup').modal({
			        	backdrop: 'static', 
			        	keyboard: false,
			        	show:true,
			        	height:'100%',
			        	width:'100%'
			        });
				}
			}); */
		});
 });
  </script>  
