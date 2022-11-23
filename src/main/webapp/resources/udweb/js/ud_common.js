$(function () {
	$(".bookmark").click(function(e) {
		e.preventDefault();
		var bookmarkURL ="http://do-design.kr";
		var bookmarkTitle = "gMall.mallTitle";
		var triggerDefault = false;
		if (window.sidebar && window.sidebar.addPanel) {
			window.sidebar.addPanel(bookmarkTitle, bookmarkURL, "");
		} else if ((window.sidebar && (navigator.userAgent.toLowerCase().indexOf("firefox") > -1)) || (window.opera && window.print)) {
			$(this).attr("href", bookmarkURL).attr("title", bookmarkTitle).attr("rel", "sidebar").off(e);
		triggerDefault = true;
		} else if (window.external && ("AddFavorite" in window.external)) { 
			window.external.AddFavorite(bookmarkURL, bookmarkTitle);
		} else { alert((navigator.userAgent.toLowerCase().indexOf("mac") != -1 ? "Cmd" : "Ctrl") + "+D 키를 눌러 즐겨찾기에 등록하실 수 있습니다."); }
	});
});



$(document).ready(function() {

var msie6 = $.browser == 'msie' && $.browser.version < 7;
if (!msie6) {
	var top = $('.header_search').offset().top - parseFloat($('.header_search').css('margin-top').replace(/auto/, 0));					 
	jQuery(window).scroll(function(event) {	
		var y = $(this).scrollTop();
		if (y >= top) {
			$('.header_search').addClass('fixed');
			$('.gnb_all').addClass('fixed');
			$('.gnb_allmenu_wrap').addClass('fixed');

		} else {
			$('.header_search').removeClass('fixed');
			$('.gnb_all').removeClass('fixed');
			$('.gnb_allmenu_wrap').removeClass('fixed');
		}
	});
}


	/* 사이드 메뉴 */
    var gd_topmenu = function(){
        $('.sub_depth0 li').on({
            'mouseover':function(){
                $(this).find('> ul').stop(true,true).fadeIn('fast');
                $(this).find('> a').addClass('active');
            },
            'mouseleave':function(){
                $(this).find('> ul').stop(true,true).fadeOut('fast');
                $(this).find('> a').removeClass('active');
            }
        });
    };
    gd_topmenu();




	/* 상단 검색 */
    $('.top_search_cont input[name="keyword"]').on({
        'focus':function(){},
        'blur':function(){
            $('body').click(function(e){
                if (!$('.top_search_mouse').has(e.target).length && e.target.name != 'keyword') {
					$(".top_search_mouse i.xi-search").css("display","inline-block");
					$(".top_search").hide();
                }
            });
            $('.btn_top_search_close').click(function(){
				$(".top_search_mouse i.xi-search").css("display","inline-block");
				$(".top_search").hide();
            });
        }
    });
	$( ".top_search_mouse > i.xi-search" ).click(function() {
		$(".top_search_mouse > i.xi-search").css("display","none");		
		$(".top_search").show();
 	});

	$('.latest_search_tab li').click(function(){
		var index = $(this).index('.latest_search_tab li');
		console.log(index);
		$('.latest_search_tab li').removeClass('on');
		$('.latest_search_tab li').eq(index).addClass('on');

		$('.latest_search_box').removeClass('on');
		$('.latest_search_box').eq(index).addClass('on');

	});
    

		acco_popup();

		function acco_popup(){
			var img_width = $('#accoPopup_cont a img').width();

			$('#accoPopup_cont').addClass('accoPopup_close_first');
			$('#accoPopup_btn').click(function(e){
				if($('#accoPopup_cont').attr('class')=='accoPopup_close_first'){
					$('#accoPopup_cont').removeClass();
				}else if($('#accoPopup_cont').attr('class')=='accoPopup_close'){
					$('#accoPopup_cont').removeClass('accoPopup_close');
				}else{
					$('#accoPopup_cont').addClass('accoPopup_close');
				}
			});
			$('#accoPopup_close').click(function(e) {
				$('#accoPopup_cont').removeClass().addClass('accoPopup_close');
			});
		}




});