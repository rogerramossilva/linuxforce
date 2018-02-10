/**
 * Coin Slider - Unique jQuery Image Slider
 * @version: 1.0 - (2010/04/04)
 * @requires jQuery v1.2.2 or later 
 * @author Ivan Lazarevic
 * Enhanced by Nicolae Gabriel - Ermark Studio
 * Examples and documentation at: http://workshop.rs/projects/coin-slider/
 
 * Licensed under MIT licence:
 *   http://www.opensource.org/licenses/mit-license.php
**/

(function($) {

	var params 		= new Array;
	var order		= new Array;
	var images		= new Array;
	var links		= new Array;
	var linksTarget = new Array;
	var linksCredit = new Array;
	var titles		= new Array;
	var excerpt		= new Array;
	var labelsImg	= new Array;
	var interval	= new Array;
	var imagePos	= new Array;
	var appInterval = new Array;	
	var squarePos	= new Array;	
	var reverse		= new Array;
	var firstSlide	= new Array;
	
	$.fn.coinslider= $.fn.CoinSlider = function(options){
		
		init = function(el){
				
			order[el.id] 		= new Array();	// order of square appereance
			images[el.id]		= new Array();
			links[el.id]		= new Array();
			linksTarget[el.id]	= new Array();
			linksCredit[el.id]	= new Array();
			titles[el.id]		= new Array();
			excerpt[el.id]		= new Array();
			labelsImg[el.id]	= new Array();
			firstSlide[el.id]	= 0;
			imagePos[el.id]		= 0;
			squarePos[el.id]	= 0;
			reverse[el.id]		= 1;						
				
			params[el.id] = $.extend({}, $.fn.coinslider.defaults, options);
						
			// create images, links and titles arrays
			$.each($('#'+el.id+' li>img'), function(i,item){
				images[el.id][i] 		= $(item).attr('src');
				/*
				links[el.id][i] 		= $(item).next().is('a') ? $(item).next().attr('href') : '';
				labelsImg[el.id][i] 	= $(item).next().is('a') ? $(item).next().attr('rel') : '';
				linksTarget[el.id][i] 	= $(item).parent().is('a') ? $(item).parent().attr('target') : '';
				titles[el.id][i] 		= $(item).next().is('a') ? $(item).next().attr('title') : '';
				excerpt[el.id][i] 		= $(item).next().is('a') ? $(item).next().html() : '';
				*/
				links[el.id][i] 		= $(item).next().is('div') ? $(item).next().find('a[rel=article]').attr('href') : '';
				titles[el.id][i] 		= $(item).next().is('div') ? $(item).next().find('a[rel=credits]').html() : '';
				linksCredit[el.id][i] 	= $(item).next().is('div') ? $(item).next().find('a[rel=credits]').attr('href') : '';
				excerpt[el.id][i] 		= $(item).next().is('div') ? $(item).next().find('p').html() : '';
				labelsImg[el.id][i] 	= $(item).next().is('div') ? $(item).next().find('img').attr('src') : '';
				//linksTarget[el.id][i] 	= $(item).parent().is('a') ? $(item).parent().attr('target') : '';
				$(item).hide();
				$(item).next().hide();
			});			
			

			// set panel
			$(el).css({
				'background-image':'url('+images[el.id][0]+')',
				'width': params[el.id].width,
				'height': params[el.id].height,
				'position': 'relative',
				'background-position': 'top left'
			}).wrap("<div class='coin-slider' id='coin-slider-"+el.id+"' />");	
			
				
			// create title bar
			$('#'+el.id).append("<div class='cs-title' id='cs-title-"+el.id+"' style='position: absolute; bottom:0; left: 0; z-index: 1000;'></div>");
			
			
			if (params[el.id].titleWrapp) { 
				$(params[el.id].titleContainer).mouseover(function(){
					params[el.id].pause = true;
				});
			
				$(params[el.id].titleContainer).mouseout(function(){
					params[el.id].pause = false;
				});	
			}
			
			$.setFields(el);
			
			if(params[el.id].navigation)
				$.setNavigation(el);
			
			if (params[el.id].autoStart){
				$.transition(el,0);
				$.transitionCall(el);
			}
				
		}
		
		// squares positions
		$.setFields = function(el){
			
			tWidth = sWidth = parseInt(params[el.id].width/params[el.id].spw);
			tHeight = sHeight = parseInt(params[el.id].height/params[el.id].sph);
			
			counter = sLeft = sTop = 0;
			tgapx = gapx = params[el.id].width - params[el.id].spw*sWidth;
			tgapy = gapy = params[el.id].height - params[el.id].sph*sHeight;
			
			for(i=1;i <= params[el.id].sph;i++){
				gapx = tgapx;
				
					if(gapy > 0){
						gapy--;
						sHeight = tHeight+1;
					} else {
						sHeight = tHeight;
					}
				
				for(j=1; j <= params[el.id].spw; j++){	

					if(gapx > 0){
						gapx--;
						sWidth = tWidth+1;
					} else {
						sWidth = tWidth;
					}

					order[el.id][counter] = i+''+j;
					counter++;
					
					if(params[el.id].links)
						$('#'+el.id).append("<a href='"+links[el.id][0]+"' class='cs-"+el.id+"' id='cs-"+el.id+i+j+"' style='width:"+sWidth+"px; height:"+sHeight+"px; float: left; position: absolute;'></a>");
					else
						$('#'+el.id).append("<div class='cs-"+el.id+"' id='cs-"+el.id+i+j+"' style='width:"+sWidth+"px; height:"+sHeight+"px; float: left; position: absolute;'></div>");
								
					// positioning squares
					$("#cs-"+el.id+i+j).css({ 
						'background-position': -sLeft +'px '+(-sTop+'px'),
						'left' : sLeft ,
						'top': sTop
					});
				
					sLeft += sWidth;
				}

				sTop += sHeight;
				sLeft = 0;					
					
			}
			
			
			$('.cs-'+el.id).mouseover(function(){
				$('#cs-navigation-'+el.id).show();
			});
		
			$('.cs-'+el.id).mouseout(function(){
				$('#cs-navigation-'+el.id).hide();
			});	
			
			$('#cs-title-'+el.id).mouseover(function(){
				$('#cs-navigation-'+el.id).show();
			});
		
			$('#cs-title-'+el.id).mouseout(function(){
				$('#cs-navigation-'+el.id).hide();
			});	
			
			if(params[el.id].hoverPause){	
				$('.cs-'+el.id).mouseover(function(){
					params[el.id].pause = true;
				});
			
				$('.cs-'+el.id).mouseout(function(){
					params[el.id].pause = false;
				});	
				
				$('#cs-title-'+el.id).mouseover(function(){
					params[el.id].pause = true;
				});
			
				$('#cs-title-'+el.id).mouseout(function(){
					params[el.id].pause = false;
				});	
			}
					
			
		};
				
		
		$.transitionCall = function(el){
			clearInterval(interval[el.id]);	
			delay = params[el.id].delay + params[el.id].spw*params[el.id].sph*params[el.id].sDelay;
			interval[el.id] = setInterval(function() { $.transition(el)  }, delay);
			
		};
		
		// transitions
		$.transition = function(el,direction){

			if(params[el.id].pause == true) return;
			
			$.effect(el);
			
			squarePos[el.id] = 0;
			appInterval[el.id] = setInterval(function() { $.appereance(el,order[el.id][squarePos[el.id]])  },params[el.id].sDelay);
					
			$(el).css({ 'background-image': 'url('+images[el.id][imagePos[el.id]]+')' });
			
			if(typeof(direction) == "undefined")
				imagePos[el.id]++;
			else
				if(direction == 'prev')
					imagePos[el.id]--;
				else
					imagePos[el.id] = direction;
		
			if  (imagePos[el.id] == images[el.id].length) {
				imagePos[el.id] = 0;
			}
			
			if (imagePos[el.id] == -1){
				imagePos[el.id] = images[el.id].length-1;
			}
	
			$('.cs-button-'+el.id).removeClass('active');
			$('#cs-button-'+el.id+"-"+(imagePos[el.id]+1)).addClass('active');
		}
		
		$.showLabels = function(el, first) {

		}
		
		$.appereance = function(el,sid){
			if (squarePos[el.id] == params[el.id].spw*params[el.id].sph) {
				clearInterval(appInterval[el.id]);

				params[el.id].slideChange(imagePos[el.id], {'creditURL':linksCredit[el.id][imagePos[el.id]],'credit':titles[el.id][imagePos[el.id]],'excerpt':excerpt[el.id][imagePos[el.id]],'link':links[el.id][imagePos[el.id]], 'image':labelsImg[el.id][imagePos[el.id]],'src':'appearamce'},params[el.id]);
				return;
			}

			$('#cs-'+el.id+sid).css({ opacity: 0, 'background-image': 'url('+images[el.id][imagePos[el.id]]+')' });
			$('#cs-'+el.id+sid).animate({ opacity: 1 }, 300, function(){
				
			});
			squarePos[el.id]++;
			
		};
		
		// navigation
		$.setNavigation = function(el){

			$(options.prevItem).click( function(e){
				e.preventDefault();
				e.stopPropagation();
				$.transition(el,'prev');
				$.transitionCall(el);		
			});
			
			$(options.nextItem).click( function(e){
				e.preventDefault();
				e.stopPropagation();
				$.transition(el);
				$.transitionCall(el);
			});

			if (options.navLetters){
				for(k=1;k<images[el.id].length+1;k++){
					$(options.navHolder).append("<a href='#' class='cs-button-"+el.id+"' id='cs-button-"+el.id+"-"+k+"'>"+k+"</a>");
				}
			}else{
				for(k=1;k<images[el.id].length+1;k++){
					$(options.navHolder).append("<a href='#' class='cs-button-"+el.id+"' id='cs-button-"+el.id+"-"+k+"'></a>");
				}
			}
			
			$.each($('.cs-button-'+el.id), function(i,item){ 
                    $(this).click( function(e){ 
                            e.preventDefault(); 
							
	                 if( $(this).hasClass('active')){ return; } 
						
                     $('.cs-button-'+el.id).removeClass('active'); 
                         $(this).addClass('active'); 
						params[el.id].forceChange(imagePos[el.id], {'creditURL':linksCredit[el.id][imagePos[el.id]],'credit':titles[el.id][imagePos[el.id]],'excerpt':excerpt[el.id][imagePos[el.id]],'link':links[el.id][imagePos[el.id]], 'image':labelsImg[el.id][imagePos[el.id]]},params[el.id]); 
                         $.transition(el,i); 
                         $.transitionCall(el);                     
                    }) 
               });     
		}


		// effects
		$.effect = function(el){
			
			effA = ['random','swirl','rain','straight'];
			
			if(params[el.id].effect == '')
				eff = effA[Math.floor(Math.random()*(effA.length))];
			else
				eff = params[el.id].effect;

			order[el.id] = new Array();

			if(eff == 'random'){
				counter = 0;
				  for(i=1;i <= params[el.id].sph;i++){
				  	for(j=1; j <= params[el.id].spw; j++){	
				  		order[el.id][counter] = i+''+j;
						counter++;
				  	}
				  }	
				$.random(order[el.id]);
			}
			
			if(eff == 'rain')	{
				$.rain(el);
			}
			
			if(eff == 'swirl'){
				$.swirl(el);
				}
				
			if(eff == 'straight') {
				$.straight(el);
			}
				
			reverse[el.id] *= -1;
			if(reverse[el.id] > 0){
				order[el.id].reverse();
			}
			
			
		}

			
		// shuffle array function
		$.random = function(arr) {
						
		  var i = arr.length;
		  if ( i == 0 ) return false;
		  while ( --i ) {
		     var j = Math.floor( Math.random() * ( i + 1 ) );
		     var tempi = arr[i];
		     var tempj = arr[j];
		     arr[i] = tempj;
		     arr[j] = tempi;
		   }
		}	
		
		//swirl effect by milos popovic
		$.swirl = function(el){

			var n = params[el.id].sph;
			var m = params[el.id].spw;

			var x = 1;
			var y = 1;
			var going = 0;
			var num = 0;
			var c = 0;
			
			var dowhile = true;
						
			while(dowhile) {
				
				num = (going==0 || going==2) ? m : n;
				
				for (i=1;i<=num;i++){
					
					order[el.id][c] = x+''+y;
					c++;

					if(i!=num){
						switch(going){
							case 0 : y++; break;
							case 1 : x++; break;
							case 2 : y--; break;
							case 3 : x--; break;
						
						}
					}
				}
				
				going = (going+1)%4;

				switch(going){
					case 0 : m--; y++; break;
					case 1 : n--; x++; break;
					case 2 : m--; y--; break;
					case 3 : n--; x--; break;		
				}
				
				check = $.max(n,m) - $.min(n,m);			
				if(m<=check && n<=check)
					dowhile = false;
									
			}
		}

		// rain effect
		$.rain = function(el){
			var n = params[el.id].sph;
			var m = params[el.id].spw;

			var c = 0;
			var to = to2 = from = 1;
			var dowhile = true;


			while(dowhile){
				
				for(i=from;i<=to;i++){
					order[el.id][c] = i+''+parseInt(to2-i+1);
					c++;
				}
				
				to2++;
				
				if(to < n && to2 < m && n<m){
					to++;	
				}
				
				if(to < n && n>=m){
					to++;	
				}
				
				if(to2 > m){
					from++;
				}
				
				if(from > to) dowhile= false;
				
			}			

		}

		// straight effect
		$.straight = function(el){
			counter = 0;
			for(i=1;i <= params[el.id].sph;i++){
				for(j=1; j <= params[el.id].spw; j++){	
					order[el.id][counter] = i+''+j;
					counter++;
				}
				
			}
		}

		$.min = function(n,m){
			if (n>m) return m;
			else return n;
		}
		
		$.max = function(n,m){
			if (n<m) return m;
			else return n;
		}		
	
	this.each (
		function(){ init(this); }
	);
	

	};
	
	
	// default values
	$.fn.coinslider.defaults = {	
		width: 565, // width of slider panel
		height: 290, // height of slider panel
		spw: 7, // squares per width
		sph: 5, // squares per height
		delay: 3000, // delay between images in ms
		sDelay: 30, // delay beetwen squares in ms
		opacity: 0.7, // opacity of title and navigation
		titleSpeed: 500, // speed of title appereance in ms
		effect: '', // random, swirl, rain, straight
		navigation: true, // prev next and buttons
		links : true, // show images as links 
		titleWrapp : true,
		titleContainer : '',
		titleEaseIn		:'',
		titleEaseOut	:'',
		autoStart: true,
		hoverPause: true // pause on hover		
	};	
	
})(jQuery);
	