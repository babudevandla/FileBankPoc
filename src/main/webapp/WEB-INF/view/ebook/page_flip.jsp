
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/page_flip/css/default.css" />
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/page_flip/css/bookblock.css" />
<!-- custom demo style -->
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/page_flip/css/demo1.css" />
<script src="${contextPath}/resources/page_flip/js/modernizr.custom.js"></script>
		
<div class="main clearfix">
	<div class="bb-custom-wrapper">
	<img src="${contextPath}${WebDavServerURL}?filePath=${eBook.coverImage}" alt="user" class="profile-photo-lg" style="border-radius:0px;"/>
		<h3 align="center">Illustrations by <a href="http://dribbble.com/kevinhowdeshell">Kevin Howdeshell</a></h3>
		<div id="bb-bookblock" class="bb-bookblock">
			<div class="bb-item">
				<a href="http://drbl.in/bKVq"><img src="images/demo1/1.jpg" alt="image01"/></a>
			</div>
			<div class="bb-item">
				<a href="http://drbl.in/ciTX"><img src="images/demo1/2.jpg" alt="image02"/></a>
			</div>
			<div class="bb-item">
				<a href="http://drbl.in/cLHx"><img src="images/demo1/3.jpg" alt="image03"/></a>
			</div>
			<div class="bb-item">
				<a href="http://drbl.in/bAfn"><img src="images/demo1/4.jpg" alt="image04"/></a>
			</div>
			<div class="bb-item">
				<a href="http://drbl.in/dcbE"><img src="images/demo1/5.jpg" alt="image05"/></a>
			</div>
		</div>
		<nav style="left: 214px;">
			<a id="bb-nav-first" href="#" class="bb-custom-icon bb-custom-icon-first">First page</a>
			<a id="bb-nav-prev" href="#" class="bb-custom-icon bb-custom-icon-arrow-left">Previous</a>
			<a id="bb-nav-next" href="#" class="bb-custom-icon bb-custom-icon-arrow-right">Next</a>
			<a id="bb-nav-last" href="#" class="bb-custom-icon bb-custom-icon-last">Last page</a>
		</nav>
	</div>
</div>

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
</script>