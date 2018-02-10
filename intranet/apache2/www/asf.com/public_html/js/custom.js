	/*** DOM Loaded ***/
	$(function() {
		
		// check if the slider exist on the current page
		if ( $("#slider-full").size() ) {
			var labelHide;
			var slideCount =0;
			var overSlides = false;
			var labelSpeed = 500;		// the speed of the label on slide in / slide out animation
			var slideDelay = 5000;
			//var imgURL = 'img/slides/'; // please configure this  URL, it's relative to site's domain.
			
			// pause the slider on slide hover
			$('#fullSlides').hover(function(){
				overSlides=true;
			}, function(){
				overSlides=false;
			});
			
			// pause the slider on label hover
			$('#slider-full .labels').hover(function(){
				if (overSlides==false){ overSlides=true; }
			}, function(){
				overSlides=false;
			});
			
			// attach the slider to #fullSlides elements
			$("#fullSlides").coinslider({
				width			: 940, 						// width of slider panel
				height			: 395, 						// height of slider panel
				spw				: 12,						// squares per width
				sph				: 1, 						// squares per height
				delay			: slideDelay,				// delay between images in ms
				sDelay			: 70, 						// delay beetwen squares in ms
				opacity			: 0.7, 						// opacity of title and navigation
				titleSpeed		: 500, 						// speed of title appereance in ms
				effect			: 'straight', 				// random, swirl, rain, straight
				navigation		: true, 					// prev next and buttonsu 
				links 			: false, 					// show images as links 
				navLetters		: false,					// show letters on nav buttons
				navHolder		: '#slider-full div.pager',	// pager navigation
				hoverPause		: true, 					// pause on hover
				forceChange		: function(current, options, params){
					//log('forceChange['+current+']');						// debuging purpose
					
					var tcLabels = $('#slider-full>.labels .innerLabel');
					var tcParagraph = $('#slider-full>.labels p');
					
					clearInterval(labelHide);
					$(tcParagraph).fadeOut('fast', function(){});	
					$(tcLabels).animate( {left:'300px'},labelSpeed );
				},
				
				slideChange		: function(current, options, params){
					//log('slideChange['+current+'][overSlides:'+overSlides+']');		//debuging purpose
					
					var tcLabels = $('#slider-full>.labels .innerLabel');
					var tcParagraph = $('#slider-full>.labels p');
					
					$('a',tcLabels).html(options.credit).attr('href',options.creditURL);	
					$(tcParagraph).html(options.excerpt+'<div><a class="arrow" href="'+options.link+'">Saiba mais</a></div>');	
					$(tcLabels).css('background','url('+options.image+') no-repeat 70% -15px');
					$(tcLabels).animate({'left':'0px'},labelSpeed, 'easeInOutBack',function(){
						$(tcParagraph).fadeIn('fast');
					});	
					
					if(overSlides == true) return;
					
					labelHide = setInterval(function() { 
						clearInterval(labelHide);
						
						if(overSlides == true) return;
						//log('slideChange['+current+'][labelHide]');			//debuging purpose
						
						$(tcParagraph).fadeOut('fast', function(){
							$(tcLabels).animate( {left:'300px'},labelSpeed );
						});	
						
					}, slideDelay-1000);
				
				}	// slideChange()
			}); // coinslider()
			
		} // if slider full  exists
	  
	  

	});
	
	// debuging purpose when new functionality is added
	function log(msg){
		if(window.console&&window.console.log){
			window.console.log("[fullSlider] "+msg);
		}
	}
			