
$(document).ready(function() {

	
	$('.submitFolder').click(function(event){
		event.preventDefault();
		var	href=$(this).attr('data-href');
		var userid = $(this).attr('data-userid');
		var parentid = $(this).attr('data-currentfolderpath');
		var folderName = $("#folderId").val();
		$.ajax({
			url: href+"?userid="+userid+"&foldername="+folderName+"&currentFolderPath="+parentid,
			type:'GET',
			cache: false,
			success: function(data) {
				$('#myModal').modal('hide');
				location.reload();
			}
		});

	});
	
	$('#openfolder').click(function(event){
		event.preventDefault();
		var	href=$(this).attr('data-href');
		var userid = $(this).attr('data-userid');
		var folderName = $(this).attr("data-folder");
		$.ajax({
			url: href+"?userid="+userid+"&foldername="+folderName,
			type:'GET',
			cache: false,
			success: function(data) {
				
				$("#navigatePath").html(data.foldersFiles);
			}
		});

	});
	
	  
	  $('#viewFileContent').on('click',function(){
		    var filename=$("#viewFileContent").attr("data-file");
		    	$(".filename").html(filename);
		        
		    
		});
	  
	  
		$('.changeCptrName').click(function(event){
			event.preventDefault();
			var	href=$(this).attr('data-href');
			console.log(href);
			$("#updateCptrNameFrom").attr("action", href);
			$("#updateCptrNameFrom").submit();
		});
		
		$("#fileOrigin").change(function(event){
			event.preventDefault();
			var	fileOrigin=$(this).val();
			var	href=$(this).attr('data-href');
			var	hiddenFileType=$("#hiddenFileType").val();
			console.log(fileOrigin);
			window.location.href=href+"?filesType="+hiddenFileType+"&fileOrigin="+fileOrigin;
		});
		
		
		$(".getGalleryContentFilter").click(function(){
			var	fileOrigin=$("#fileOrigin").val();
			var	href=$(this).attr('data-href');
			var	filesType=$(this).attr('data-filesType');
			console.log(href);
			if(filesType!=null){
				window.location.href=href+"?filesType="+filesType+"&fileOrigin="+fileOrigin;
			}else{
				window.location.href=href+"&fileOrigin="+fileOrigin;
			}
		});
		
		$('#fileBankWindow').click(function(event){
			event.preventDefault();
			var	href=$(this).attr('data-href');
			console.log(href);
			var	action=$(this).attr('data-action');
			var id=null,content=null,pageNo=null;
			if(action=="EBOOK"){
				 id=$(".bookId").val();
				 content=$(".ebookContentCls").val();
				 pageNo=$(".defaultPageNoCls").html();
			}else if(action=="EDAIRY"){
				 id=$(".dairyId").val();
				 content=$(".edairyContentCls").val();
				 pageNo=$("#pageNoId").html();
			}
			console.log("ID:"+id+"::PageNO:"+pageNo+"::Action:"+action);
			
			
			$.ajax({
				url: href,
				type:'GET',
				cache: false,
				success: function(data) {
					$("#fileBankFilesList").html(data);
					$(".fbCls").val(id);
					$(".contentCls").val(content);
					$(".pageNoCls").val(pageNo);
					$(".actionTypeCls").val(action);
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
	
		$('#fileBankFilesUpload').click(function(event){
			event.preventDefault();
			var r=confirm(" Are you sure want to upload cloud files ");
			if(r){
				var size=$("[name='filePaths']:checked").length;
				if(size > 0){
				 	$("#sellerimagebulkapprove").submit();
				}else{
					 alert('You should select atleast one file !');
				}
			}
		});	
		
});


