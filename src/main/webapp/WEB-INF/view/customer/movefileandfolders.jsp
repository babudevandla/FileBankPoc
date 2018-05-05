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
<%@ page import="com.sm.portal.digilocker.model.FileAndFolderMoveEnum" %>


 <div class="media" style="height:300px;margin-top: -2px;" id="fileBankDetailsId">
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

					<div class="table100-body js-pscroll">
						<table>
							<tbody>
							<c:choose>
			                	<c:when test="${isInternalFolder eq 'Yes' }">
			                		<c:forEach items="${folderInfo.childFolders}" var="folders" varStatus="status">
						                <tr class="row100 body">
							                <td class="cell100 column1">
							                	<a href="${contextPath}/sm/getfolderinfo/${folders.fId}" style="cursor: pointer;"	class="user-link">
							                		<strong style="color: black;" id="textellipse"><img alt="${folders.fName}" src="${contextPath}/resources/default/images/folder_PNG8773.png" style="width: 20px;"> &nbsp;${folders.fName} </strong>
			                					</a>
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
			                		 	<c:if test="${not empty folders.fName}">
						                	<c:choose>
						                		<c:when test="${folders.origin eq 'LOCKER' }">
								                	<tr  class="row100 body">
										                <td class="cell100 column1">
											                <a href="${contextPath}/sm/getfolderinfo/${folders.fId}" style="cursor: pointer;"	class="user-link">
								                				<strong style="color: black;" id="textellipse"><img alt="${folders.fName}" src="${contextPath}/resources/default/images/folder_PNG8773.png" style="width: 20px;"> &nbsp;${folders.fName}</strong> 
											                 </a>	
										                 </td>
										                 <td class="cell100 column2">10 kb</td>
						                				 <td class="cell100 column3">2018-02-28</td>
						                				 <td class="cell100 column4">${user.firstname}</td>
										                 <td class="cell100 column5"></td>
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
        </div>
     </div> 
     </div>
