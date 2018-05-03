
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
			console.log(fileOrigin);
			window.location.href=href+"?fileOrigin="+fileOrigin;
		});
		
		$('#fileBankWindow').click(function(event){
			event.preventDefault();
			var	href=$(this).attr('data-href');
			console.log(href);
			$.ajax({
				url: href,
				type:'GET',
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


