<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>상품 리스트</title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <meta property="og:type" content="website">
    <meta property="og:title" content="주식회사 마이셰프">
    <meta property="og:image" content="https://www.mychef.kr/data/common/snsRepresentImage.jpg">
    <meta property="og:url" content="https://www.mychef.kr/goods/goods_list.php?cateCd=017009">
    <meta property="og:description" content="밀키트는 마이셰프">
    <meta property="og:locale" content="ko_KR">
    <meta property="og:image:width" content="1200">
    <meta property="og:image:height" content="800">


    <style type="text/css">
        body {
        }

        /* body > #wrap > #header_warp : 상단 영역 */
        #header_warp {
        }

        /* body > #wrap > #container : 메인 영역 */
        #container {
        }

        /* body > #wrap > #footer_wrap : 하단 영역 */
        #footer_wrap {
        }
    </style>

<script>
    var productList = [];
    var productIdList = [];
    var cookieString = '';

    // 쿠키 생성
    function setCookie(cName, cValue, cDay){
        var expire = new Date();
        expire.setDate(expire.getDate() + cDay);
        cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
        if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
        document.cookie = cookies;
    }

    // 쿠키 가져오기
    function getCookie(cName) {
        cName = cName + '=';
        var cookieData = document.cookie;
        var start = cookieData.indexOf(cName);
        var cValue = '';
        if(start != -1){
            start += cName.length;
            var end = cookieData.indexOf(';', start);
            if(end == -1)end = cookieData.length;
            cValue = cookieData.substring(start, end);
        }
        return unescape(cValue);
    }

    function getCategoryCode(strCode){
        var strPCode = strCode;
        strPCode = strPCode.match(/cateCd=\d+/);
        strPCode = String(strPCode);
        var intPCode = strPCode.match(/\d+/);
        if(intPCode != null && intPCode.length > 0) {
            return intPCode[0];
        }
        return '';
    }

    function getProductCode(strCode){
        var strPCode = strCode;
        strPCode = strPCode.match(/goodsNo=\d+/);
        strPCode = String(strPCode);
        var intPCode = strPCode.match(/\d+/);
        if(intPCode != null && intPCode.length > 0) {
            return intPCode[0];
        }
        return '';
    }


    function removeHtml(str){
        var removed_str = str.replace(/\<.*?\>/g," ");
        return removed_str;
    }
    function removeComma(str){
        var removed_str = parseInt(str.replace(/,/g,""));
        return removed_str;
    }



    function callbackIsVisible(selector, callback) {
        var time = 0;
        var interval = setInterval(function () {
            if($(selector).is(':visible')) {
                // visible, do something
                callback();
                clearInterval(interval);
            } else {
                // not visible yet, do something
                time += 100;
            }
        }, 200);
    }

    function productClick(goodsNo){
        if(typeof productList != 'undefined') {
            for(var i in productList) {
                if(goodsNo == productList[i].id) {

                    gtag('event', 'select_content', {
                        'list_name': productList[i].list_name,
                        "content_type": "product",
                        "items": [productList[i]]
                    });
                    break;
                }

                if(i == (productList.length -1)) break;
            }
        }
    }
</script>
</head>
<body>
	<div id="container">
		<!-- 본문 시작 -->
		<div class="content" style="min-height: 500px;">
			<div class="goods_list_item">
				<div class="goods_list_item_tit">
					<h2>전체</h2>
				</div>
				<div class="list_item_category">
					<ul>
						<li class="on">
							<a href="/"><span>전체 <em>(상품 개수)</em></span></a>
						</li>
						<li class>
							<a href="/"><span>한식 <em>(상품 개수)</em></span></a>
						</li>
						<li class>
							<a href="/"><span>중식/일식 <em>(상품 개수)</em></span></a>
						</li>
						<li class>
							<a href="/"><span>양식 <em>(상품 개수)</em></span></a>
						</li>
						<li class>
							<a href="/"><span>안주거리 <em>(상품 개수)</em></span></a>
						</li>
						<li class>
							<a href="/"><span>간식 <em>(상품 개수)</em></span></a>
						</li>
					</ul>
				</div>
				<div class="goods_pick_list">
					<span class="pick_list_num">상품 <strong>(상품 개수)</strong>개</span>
					<form name="frmList" action="">
                		<input type="hidden" name="cateCd" value="000000">	<!-- 상품 카테고리 코드? -->
                			<div class="pick_list_box">
		                    <ul class="pick_list">
		                        <li>
		                            <input type="radio" id="sort1" class="radio" name="sort" value="">
		                            <label for="sort1" class="on">추천순</label>
		                        </li>
		                        <li>
		                            <input type="radio" id="sort2" class="radio" name="sort" value="price_asc">
		                            <label for="sort2">낮은 가격순</label>
		                        </li>
		                        <li>
		                            <input type="radio" id="sort3" class="radio" name="sort" value="price_dsc">
		                            <label for="sort3">높은 가격순</label>
		                        </li>
		                        <li>
		                            <input type="radio" id="sort4" class="radio" name="sort" value="review">
		                            <label for="sort4">상품평순</label>
		                        </li>
		                        <li>
		                            <input type="radio" id="sort5" class="radio" name="sort" value="date">
		                            <label for="sort5">신상품순</label>
		                        </li>
		                    </ul>
                    		<div class="choice_num_view">
		                        <select class="chosen-select" name="pageNum" style="display: none;">
		                            <option value="24" selected="selected">24개씩보기</option>
		                            <option value="48">48개씩보기</option>
		                            <option value="72">72개씩보기</option>
		                        </select><div class="chosen-container chosen-container-single chosen-container-single-nosearch" style="width: 120px;" title=""><a class="chosen-single"><span>36개씩보기</span><div><b></b></div></a><div class="chosen-drop"><div class="chosen-search"><input type="text" autocomplete="off" readonly=""></div><ul class="chosen-results"></ul></div></div>
                    		</div>
                    	<!-- choice_num_view -->
                		</div>
               		<!-- pick_list_box -->
           			</form>
				</div>
				<!-- goods_pick_list -->
				<div class="goods_list">
		            <div class="goods_list_cont">
		            <!-- 상품 리스트 -->
					<div class="item_basket_type">
					    <ul>
					    	<!-- 4% 할인 상품 -->
					        <li style="width:25%;">
					            <div class="item_cont">
					                <div class="item_photo_box" data-image-add1="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/22/05/20/1000002243/1000002243_add1_061.jpg" data-image-add2="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/22/05/20/1000002243/1000002243_add2_05.jpg" data-image-list="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/22/05/20/1000002243/1000002243_list_021.jpg" data-image-main="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/22/05/20/1000002243/1000002243_main_011.jpg" data-image-detail="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/22/05/20/1000002243/1000002243_detail_023.jpg" data-image-magnify="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/22/05/20/1000002243/1000002243_magnify_059.jpg">
					                    <a href="../goods/goods_view.php?goodsNo=1000002243">
					                        <img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/22/05/20/1000002243/1000002243_add2_05.jpg" width="280" alt="[마이셰프X큐커] 매콤 주꾸미 삼겹살(2인)" title="[마이셰프X큐커] 매콤 주꾸미 삼겹살(2인)" class="middle">
					                    </a>
					                    <div class="item_link">
					                        <button type="button" class="btn_basket_get btn_add_wish_" data-goods-no="1000002243" data-goods-nm="[마이셰프X큐커] 매콤 주꾸미 삼겹살(2인)" data-goods-price="19900.00" data-goods-image-src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/22/05/20/1000002243/1000002243_add2_05.jpg" data-optionfl="n" data-min-order-cnt="1" data-option-sno="" data-goods-image="" data-sales-unit="" data-fixed-sales="" data-fixed-order-cnt=""><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_get.png" alt=""><span>찜하기</span></button>
					                        <button type="button" href="#optionViewLayer" class="btn_basket_cart btn_add_cart_ btn_open_layer" data-mode="cartIn" data-goods-no="1000002243"><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_cart.png" alt=""><span>장바구니</span></button>
					                    </div>
					                    <!-- //item_link -->
					                </div>
					                <!-- //item_photo_box -->
					                <div class="item_info_cont">
					                    <div class="item_tit_box">
					                        <a href="../goods/goods_view.php?goodsNo=1000002243">
					                            <strong class="item_name">[마이셰프X큐커] 매콤 주꾸미 삼겹살(2인)</strong>
					                        </a>
					                    </div>
					                    <!-- //item_tit_box -->
					                    <div class="item_money_box">
											<span class="item_price_rate">SAVE<br>4%</span>
					                        <strong class="item_price">
					                            <span style="">19,900원 </span>
					                        </strong>
					                        <span style="text-decoration: line-through;color:#CECECE;color:#CECECE;font-size:12px;text-decoration:line-through;">20,900원 </span>
					                    </div>
					                    <!-- //item_money_box -->
					                    <!-- //item_number_box -->
					                    <div class="item_icon_box">
					                        
					                    </div>
					                    <!-- //item_icon_box -->
					                </div>
					                <!-- //item_info_cont -->
					            </div>
					            <!-- //item_cont -->
					        </li>
					        <li style="width:25%;">
					            <div class="item_cont">
					                <div class="item_photo_box" data-image-add1="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/22/02/08/1000002155/1000002155_add1_09.jpg" data-image-add2="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/22/02/08/1000002155/1000002155_add2_072.jpg" data-image-list="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/22/02/08/1000002155/1000002155_list_074.jpg" data-image-main="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/22/02/08/1000002155/1000002155_main_078.jpg" data-image-detail="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/22/02/08/1000002155/1000002155_detail_019.jpg" data-image-magnify="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/22/02/08/1000002155/1000002155_magnify_099.jpg">
					                    <a href="../goods/goods_view.php?goodsNo=1000002155">
					                        <img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/22/02/08/1000002155/1000002155_add2_072.jpg" width="280" alt="[마이셰프x동원F&amp;B] 맵칼 낙골새(2인)" title="[마이셰프x동원F&amp;B] 맵칼 낙골새(2인)" class="middle">
					                    </a>
					                    <div class="item_link">
					                        <button type="button" class="btn_basket_get btn_add_wish_" data-goods-no="1000002155" data-goods-nm="[마이셰프x동원F&amp;B] 맵칼 낙골새(2인)" data-goods-price="19900.00" data-goods-image-src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/22/02/08/1000002155/1000002155_add2_072.jpg" data-optionfl="n" data-min-order-cnt="1" data-option-sno="" data-goods-image="" data-sales-unit="" data-fixed-sales="" data-fixed-order-cnt=""><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_get.png" alt=""><span>찜하기</span></button>
					                        <button type="button" href="#optionViewLayer" class="btn_basket_cart btn_add_cart_ btn_open_layer" data-mode="cartIn" data-goods-no="1000002155"><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_cart.png" alt=""><span>장바구니</span></button>
					                    </div>
					                    <!-- //item_link -->
					                </div>
					                <!-- //item_photo_box -->
					                <div class="item_info_cont">
					                    <div class="item_tit_box">
					                        <a href="../goods/goods_view.php?goodsNo=1000002155">
					                            <strong class="item_name">[마이셰프x동원F&amp;B] 맵칼 낙골새(2인)</strong>
					                        </a>
					                    </div>
					                    <!-- //item_tit_box -->
					                    <div class="item_money_box">
					                        <strong class="item_price">
					                            <span style="">19,900원 </span>
					                        </strong>
					                    </div>
					                    <!-- //item_money_box -->
					                    <!-- //item_number_box -->
					                    <div class="item_icon_box">
					                        
					                    </div>
					                    <!-- //item_icon_box -->
					                </div>
					                <!-- //item_info_cont -->
					            </div>
					            <!-- //item_cont -->
					        </li>
					        <!-- 13% 할인 상품, 블프 특가 -->
					        <li style="width:25%;">
					            <div class="item_cont">
					                <div class="item_photo_box" data-image-main="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/18/06/25/1000001141/1000001141_main_066.jpg" data-image-add1="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/18/06/25/1000001141/1000001141_add1_057.jpg" data-image-add2="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/18/06/25/1000001141/1000001141_add2_012.jpg" data-image-list="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/18/06/25/1000001141/1000001141_list_06.jpg" data-image-detail="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/18/06/25/1000001141/1000001141_detail_070.jpg" data-image-magnify="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/18/06/25/1000001141/1000001141_magnify_083.jpg">
					                    <a href="../goods/goods_view.php?goodsNo=1000001141">
					                        <img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/18/06/25/1000001141/1000001141_add2_012.jpg" width="280" alt="★블프특가 [마이셰프] 레드와인스테이크(2인)" title="★블프특가 [마이셰프] 레드와인스테이크(2인)" class="middle">
					                    </a>
					                    <div class="item_link">
					                        <button type="button" class="btn_basket_get btn_add_wish_" data-goods-no="1000001141" data-goods-nm="★블프특가 [마이셰프] 레드와인스테이크(2인)" data-goods-price="18900.00" data-goods-image-src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/18/06/25/1000001141/1000001141_add2_012.jpg" data-optionfl="n" data-min-order-cnt="1" data-option-sno="" data-goods-image="" data-sales-unit="" data-fixed-sales="" data-fixed-order-cnt=""><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_get.png" alt=""><span>찜하기</span></button>
					                        <button type="button" href="#optionViewLayer" class="btn_basket_cart btn_add_cart_ btn_open_layer" data-mode="cartIn" data-goods-no="1000001141"><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_cart.png" alt=""><span>장바구니</span></button>
					                    </div>
					                    <!-- //item_link -->
					                </div>
					                <!-- //item_photo_box -->
					                <div class="item_info_cont">
					                    <div class="item_tit_box">
					                        <a href="../goods/goods_view.php?goodsNo=1000001141">
					                            <strong class="item_name">★블프특가 [마이셰프] 레드와인스테이크(2인)</strong>
					                        </a>
					                    </div>
					                    <!-- //item_tit_box -->
					                    <div class="item_money_box">
											<span class="item_price_rate">SAVE<br>13%</span>
					                        <strong class="item_price">
					                            <span style="">18,900원 </span>
					                        </strong>
					                        <span style="text-decoration: line-through;color:#CECECE;color:#CECECE;font-size:12px;text-decoration:line-through;">21,900원 </span>
					                    </div>
					                    <!-- //item_money_box -->
					                    <!-- //item_number_box -->
					                    <div class="item_icon_box">
					                        
					                    </div>
					                    <!-- //item_icon_box -->
					                </div>
					                <!-- //item_info_cont -->
					            </div>
					            <!-- //item_cont -->
					        </li>
					        <li style="width:25%;">
					            <div class="item_cont">
					                <div class="item_photo_box" data-image-add1="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/18/10/44/1000001153/1000001153_add1_025.jpg" data-image-add2="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/18/10/44/1000001153/1000001153_add2_074.jpg" data-image-list="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/18/10/44/1000001153/1000001153_list_076.jpg" data-image-main="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/18/10/44/1000001153/1000001153_main_043.jpg" data-image-detail="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/18/10/44/1000001153/1000001153_detail_079.jpg" data-image-magnify="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/18/10/44/1000001153/1000001153_magnify_077.jpg">
					                    <a href="../goods/goods_view.php?goodsNo=1000001153">
					                        <img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/18/10/44/1000001153/1000001153_add2_074.jpg" width="280" alt="★블프특가 [마이셰프] 하우스비프스테이크(2인)" title="★블프특가 [마이셰프] 하우스비프스테이크(2인)" class="middle">
					                    </a>
					                    <div class="item_link">
					                        <button type="button" class="btn_basket_get btn_add_wish_" data-goods-no="1000001153" data-goods-nm="★블프특가 [마이셰프] 하우스비프스테이크(2인)" data-goods-price="10900.00" data-goods-image-src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/18/10/44/1000001153/1000001153_add2_074.jpg" data-optionfl="n" data-min-order-cnt="1" data-option-sno="" data-goods-image="" data-sales-unit="" data-fixed-sales="" data-fixed-order-cnt=""><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_get.png" alt=""><span>찜하기</span></button>
					                        <button type="button" href="#optionViewLayer" class="btn_basket_cart btn_add_cart_ btn_open_layer" data-mode="cartIn" data-goods-no="1000001153"><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_cart.png" alt=""><span>장바구니</span></button>
					                    </div>
					                    <!-- //item_link -->
					                </div>
					                <!-- //item_photo_box -->
					                <div class="item_info_cont">
					                    <div class="item_tit_box">
					                        <a href="../goods/goods_view.php?goodsNo=1000001153">
					                            <strong class="item_name">★블프특가 [마이셰프] 하우스비프스테이크(2인)</strong>
					                        </a>
					                    </div>
					                    <!-- //item_tit_box -->
					                    <div class="item_money_box">
											<span class="item_price_rate">SAVE<br>26%</span>
					                        <strong class="item_price">
					                            <span style="">10,900원 </span>
					                        </strong>
					                        <span style="text-decoration: line-through;color:#CECECE;color:#CECECE;font-size:12px;text-decoration:line-through;">14,900원 </span>
					                    </div>
					                    <!-- //item_money_box -->
					                    <!-- //item_number_box -->
					                    <div class="item_icon_box">
					                        
					                    </div>
					                    <!-- //item_icon_box -->
					                </div>
					                <!-- //item_info_cont -->
					            </div>
					            <!-- //item_cont -->
					        </li>
					        <li style="width:25%;">
					            <div class="item_cont">
					                <div class="item_photo_box" data-image-add1="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/16/09/26/1000000312/1000000312_add1_085.jpg" data-image-add2="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/16/09/26/1000000312/1000000312_add2_048.jpg" data-image-list="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/16/09/26/1000000312/1000000312_list_093.jpg" data-image-main="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/16/09/26/1000000312/1000000312_main_072.jpg" data-image-detail="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/16/09/26/1000000312/1000000312_detail_09.jpg" data-image-magnify="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/16/09/26/1000000312/1000000312_magnify_091.jpg">
					                    <a href="../goods/goods_view.php?goodsNo=1000000312">
					                        <img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/16/09/26/1000000312/1000000312_add2_048.jpg" width="280" alt="★블프특가 [마이셰프] 감바스알아히요(2인)" title="★블프특가 [마이셰프] 감바스알아히요(2인)" class="middle">
					                    </a>
					                    <div class="item_link">
					                        <button type="button" class="btn_basket_get btn_add_wish_" data-goods-no="1000000312" data-goods-nm="★블프특가 [마이셰프] 감바스알아히요(2인)" data-goods-price="12900.00" data-goods-image-src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/16/09/26/1000000312/1000000312_add2_048.jpg" data-optionfl="n" data-min-order-cnt="1" data-option-sno="" data-goods-image="" data-sales-unit="" data-fixed-sales="" data-fixed-order-cnt=""><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_get.png" alt=""><span>찜하기</span></button>
					                        <button type="button" href="#optionViewLayer" class="btn_basket_cart btn_add_cart_ btn_open_layer" data-mode="cartIn" data-goods-no="1000000312"><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_cart.png" alt=""><span>장바구니</span></button>
					                    </div>
					                    <!-- //item_link -->
					                </div>
					                <!-- //item_photo_box -->
					                <div class="item_info_cont">
					                    <div class="item_tit_box">
					                        <a href="../goods/goods_view.php?goodsNo=1000000312">
					                            <strong class="item_name">★블프특가 [마이셰프] 감바스알아히요(2인)</strong>
					                        </a>
					                    </div>
					                    <!-- //item_tit_box -->
					                    <div class="item_money_box">
											<span class="item_price_rate">SAVE<br>27%</span>
					                        <strong class="item_price">
					                            <span style="">12,900원 </span>
					                        </strong>
					                        <span style="text-decoration: line-through;color:#CECECE;color:#CECECE;font-size:12px;text-decoration:line-through;">17,900원 </span>
					                    </div>
					                    <!-- //item_money_box -->
					                    <!-- //item_number_box -->
					                    <div class="item_icon_box">
					                        
					                    </div>
					                    <!-- //item_icon_box -->
					                </div>
					                <!-- //item_info_cont -->
					            </div>
					            <!-- //item_cont -->
					        </li>
					        <li style="width:25%;">
					            <div class="item_cont">
					                <div class="item_photo_box" data-image-add1="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/19/11/48/1000001229/1000001229_add1_047.jpg" data-image-add2="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/19/11/48/1000001229/1000001229_add2_084.jpg" data-image-list="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/19/11/48/1000001229/1000001229_list_049.jpg" data-image-main="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/19/11/48/1000001229/1000001229_main_080.jpg" data-image-detail="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/19/11/48/1000001229/1000001229_detail_016.jpg" data-image-magnify="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/19/11/48/1000001229/1000001229_magnify_035.jpg">
					                    <a href="../goods/goods_view.php?goodsNo=1000001229">
					                        <img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/19/11/48/1000001229/1000001229_add2_084.jpg" width="280" alt="[마이셰프] 고기듬뿍 토마토 파스타(2인)" title="[마이셰프] 고기듬뿍 토마토 파스타(2인)" class="middle">
					                    </a>
					                    <div class="item_link">
					                        <button type="button" class="btn_basket_get btn_add_wish_" data-goods-no="1000001229" data-goods-nm="[마이셰프] 고기듬뿍 토마토 파스타(2인)" data-goods-price="15900.00" data-goods-image-src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/19/11/48/1000001229/1000001229_add2_084.jpg" data-optionfl="n" data-min-order-cnt="1" data-option-sno="" data-goods-image="" data-sales-unit="" data-fixed-sales="" data-fixed-order-cnt=""><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_get.png" alt=""><span>찜하기</span></button>
					                        <button type="button" href="#optionViewLayer" class="btn_basket_cart btn_add_cart_ btn_open_layer" data-mode="cartIn" data-goods-no="1000001229"><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_cart.png" alt=""><span>장바구니</span></button>
					                    </div>
					                    <!-- //item_link -->
					                </div>
					                <!-- //item_photo_box -->
					                <div class="item_info_cont">
					                    <div class="item_tit_box">
					                        <a href="../goods/goods_view.php?goodsNo=1000001229">
					                            <strong class="item_name">[마이셰프] 고기듬뿍 토마토 파스타(2인)</strong>
					                        </a>
					                    </div>
					                    <!-- //item_tit_box -->
					                    <div class="item_money_box">
					                        <strong class="item_price">
					                            <span style="">15,900원 </span>
					                        </strong>
					                    </div>
					                    <!-- //item_money_box -->
					                    <!-- //item_number_box -->
					                    <div class="item_icon_box">
					                        
					                    </div>
					                    <!-- //item_icon_box -->
					                </div>
					                <!-- //item_info_cont -->
					            </div>
					            <!-- //item_cont -->
					        </li>
					        <li style="width:25%;">
					            <div class="item_cont">
					                <div class="item_photo_box" data-image-add1="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/03/13/1000001253/1000001253_add1_026.jpg" data-image-add2="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/03/13/1000001253/1000001253_add2_064.jpg" data-image-list="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/03/13/1000001253/1000001253_list_023.jpg" data-image-main="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/03/13/1000001253/1000001253_main_070.jpg" data-image-detail="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/03/13/1000001253/1000001253_detail_035.jpg" data-image-magnify="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/03/13/1000001253/1000001253_magnify_081.jpg">
					                    <a href="../goods/goods_view.php?goodsNo=1000001253">
					                        <img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/03/13/1000001253/1000001253_add2_064.jpg" width="280" alt="[마이셰프] 로얄크리미 스테이크(1인)" title="[마이셰프] 로얄크리미 스테이크(1인)" class="middle">
					                    </a>
					                    <div class="item_link">
					                        <button type="button" class="btn_basket_get btn_add_wish_" data-goods-no="1000001253" data-goods-nm="[마이셰프] 로얄크리미 스테이크(1인)" data-goods-price="16900.00" data-goods-image-src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/03/13/1000001253/1000001253_add2_064.jpg" data-optionfl="n" data-min-order-cnt="1" data-option-sno="" data-goods-image="" data-sales-unit="" data-fixed-sales="" data-fixed-order-cnt=""><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_get.png" alt=""><span>찜하기</span></button>
					                        <button type="button" href="#optionViewLayer" class="btn_basket_cart btn_add_cart_ btn_open_layer" data-mode="cartIn" data-goods-no="1000001253"><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_cart.png" alt=""><span>장바구니</span></button>
					                    </div>
					                    <!-- //item_link -->
					                </div>
					                <!-- //item_photo_box -->
					                <div class="item_info_cont">
					                    <div class="item_tit_box">
					                        <a href="../goods/goods_view.php?goodsNo=1000001253">
					                            <strong class="item_name">[마이셰프] 로얄크리미 스테이크(1인)</strong>
					                        </a>
					                    </div>
					                    <!-- //item_tit_box -->
					                    <div class="item_money_box">
					                        <strong class="item_price">
					                            <span style="">16,900원 </span>
					                        </strong>
					                    </div>
					                    <!-- //item_money_box -->
					                    <!-- //item_number_box -->
					                    <div class="item_icon_box">
					                        
					                    </div>
					                    <!-- //item_icon_box -->
					                </div>
					                <!-- //item_info_cont -->
					            </div>
					            <!-- //item_cont -->
					        </li>
					        <li style="width:25%;">
					            <div class="item_cont">
					                <div class="item_photo_box" data-image-add1="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/03/13/1000001254/1000001254_add1_077.jpg" data-image-add2="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/03/13/1000001254/1000001254_add2_018.jpg" data-image-list="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/03/13/1000001254/1000001254_list_093.jpg" data-image-main="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/03/13/1000001254/1000001254_main_099.jpg" data-image-magnify="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/03/13/1000001254/1000001254_magnify_079.jpg" data-image-detail="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/03/13/1000001254/1000001254_detail_011.jpg">
					                    <a href="../goods/goods_view.php?goodsNo=1000001254">
					                        <img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/03/13/1000001254/1000001254_add2_018.jpg" width="280" alt="★블프특가 [마이셰프] 르네 프렌치스테이크(2인)" title="★블프특가 [마이셰프] 르네 프렌치스테이크(2인)" class="middle">
					                    </a>
					                    <div class="item_link">
					                        <button type="button" class="btn_basket_get btn_add_wish_" data-goods-no="1000001254" data-goods-nm="★블프특가 [마이셰프] 르네 프렌치스테이크(2인)" data-goods-price="13900.00" data-goods-image-src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/03/13/1000001254/1000001254_add2_018.jpg" data-optionfl="n" data-min-order-cnt="1" data-option-sno="" data-goods-image="" data-sales-unit="" data-fixed-sales="" data-fixed-order-cnt=""><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_get.png" alt=""><span>찜하기</span></button>
					                        <button type="button" href="#optionViewLayer" class="btn_basket_cart btn_add_cart_ btn_open_layer" data-mode="cartIn" data-goods-no="1000001254"><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_cart.png" alt=""><span>장바구니</span></button>
					                    </div>
					                    <!-- //item_link -->
					                </div>
					                <!-- //item_photo_box -->
					                <div class="item_info_cont">
					                    <div class="item_tit_box">
					                        <a href="../goods/goods_view.php?goodsNo=1000001254">
					                            <strong class="item_name">★블프특가 [마이셰프] 르네 프렌치스테이크(2인)</strong>
					                        </a>
					                    </div>
					                    <!-- //item_tit_box -->
					                    <div class="item_money_box">
											<span class="item_price_rate">SAVE<br>6%</span>
					                        <strong class="item_price">
					                            <span style="">13,900원 </span>
					                        </strong>
					                        <span style="text-decoration: line-through;color:#CECECE;color:#CECECE;font-size:12px;text-decoration:line-through;">14,900원 </span>
					                    </div>
					                    <!-- //item_money_box -->
					                    <!-- //item_number_box -->
					                    <div class="item_icon_box">
					                        
					                    </div>
					                    <!-- //item_icon_box -->
					                </div>
					                <!-- //item_info_cont -->
					            </div>
					            <!-- //item_cont -->
					        </li>
					        <li style="width:25%;">
					            <div class="item_cont">
					                <div class="item_photo_box" data-image-add1="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/11/48/1000001553/1000001553_add1_089.jpg" data-image-add2="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/11/48/1000001553/1000001553_add2_086.jpg" data-image-list="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/11/48/1000001553/1000001553_list_095.jpg" data-image-main="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/11/48/1000001553/1000001553_main_025.jpg" data-image-detail="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/11/48/1000001553/1000001553_detail_092.jpg" data-image-magnify="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/11/48/1000001553/1000001553_magnify_018.jpg">
					                    <a href="../goods/goods_view.php?goodsNo=1000001553">
					                        <img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/11/48/1000001553/1000001553_add2_086.jpg" width="280" alt="[마이셰프] 보니따 리꼬 스테이크(1인)" title="[마이셰프] 보니따 리꼬 스테이크(1인)" class="middle">
					                    </a>
					                    <div class="item_link">
					                        <button type="button" class="btn_basket_get btn_add_wish_" data-goods-no="1000001553" data-goods-nm="[마이셰프] 보니따 리꼬 스테이크(1인)" data-goods-price="9900.00" data-goods-image-src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/11/48/1000001553/1000001553_add2_086.jpg" data-optionfl="n" data-min-order-cnt="1" data-option-sno="" data-goods-image="" data-sales-unit="" data-fixed-sales="" data-fixed-order-cnt=""><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_get.png" alt=""><span>찜하기</span></button>
					                        <button type="button" href="#optionViewLayer" class="btn_basket_cart btn_add_cart_ btn_open_layer" data-mode="cartIn" data-goods-no="1000001553"><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_cart.png" alt=""><span>장바구니</span></button>
					                    </div>
					                    <!-- //item_link -->
					                </div>
					                <!-- //item_photo_box -->
					                <div class="item_info_cont">
					                    <div class="item_tit_box">
					                        <a href="../goods/goods_view.php?goodsNo=1000001553">
					                            <strong class="item_name">[마이셰프] 보니따 리꼬 스테이크(1인)</strong>
					                        </a>
					                    </div>
					                    <!-- //item_tit_box -->
					                    <div class="item_money_box">
					                        <strong class="item_price">
					                            <span style="">9,900원 </span>
					                        </strong>
					                    </div>
					                    <!-- //item_money_box -->
					                    <!-- //item_number_box -->
					                    <div class="item_icon_box">
					                        
					                    </div>
					                    <!-- //item_icon_box -->
					                </div>
					                <!-- //item_info_cont -->
					            </div>
					            <!-- //item_cont -->
					        </li>
					        <li style="width:25%;">
					            <div class="item_cont">
					                <div class="item_photo_box" data-image-add1="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/11/48/1000001554/1000001554_add1_019.jpg" data-image-add2="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/11/48/1000001554/1000001554_add2_027.jpg" data-image-list="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/11/48/1000001554/1000001554_list_038.jpg" data-image-main="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/11/48/1000001554/1000001554_main_094.jpg" data-image-detail="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/11/48/1000001554/1000001554_detail_044.jpg" data-image-magnify="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/11/48/1000001554/1000001554_magnify_023.jpg">
					                    <a href="../goods/goods_view.php?goodsNo=1000001554">
					                        <img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/11/48/1000001554/1000001554_add2_027.jpg" width="280" alt="[마이셰프] 부엔 까르네 스테이크(1인)" title="[마이셰프] 부엔 까르네 스테이크(1인)" class="middle">
					                    </a>
					                    <div class="item_link">
					                        <button type="button" class="btn_basket_get btn_add_wish_" data-goods-no="1000001554" data-goods-nm="[마이셰프] 부엔 까르네 스테이크(1인)" data-goods-price="8900.00" data-goods-image-src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/11/48/1000001554/1000001554_add2_027.jpg" data-optionfl="n" data-min-order-cnt="1" data-option-sno="" data-goods-image="" data-sales-unit="" data-fixed-sales="" data-fixed-order-cnt=""><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_get.png" alt=""><span>찜하기</span></button>
					                        <button type="button" href="#optionViewLayer" class="btn_basket_cart btn_add_cart_ btn_open_layer" data-mode="cartIn" data-goods-no="1000001554"><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_cart.png" alt=""><span>장바구니</span></button>
					                    </div>
					                    <!-- //item_link -->
					                </div>
					                <!-- //item_photo_box -->
					                <div class="item_info_cont">
					                    <div class="item_tit_box">
					                        <a href="../goods/goods_view.php?goodsNo=1000001554">
					                            <strong class="item_name">[마이셰프] 부엔 까르네 스테이크(1인)</strong>
					                        </a>
					                    </div>
					                    <!-- //item_tit_box -->
					                    <div class="item_money_box">
											<span class="item_price_rate">SAVE<br>18%</span>
					                        <strong class="item_price">
					                            <span style="">8,900원 </span>
					                        </strong>
					                        <span style="text-decoration: line-through;color:#CECECE;color:#CECECE;font-size:12px;text-decoration:line-through;">10,900원 </span>
					                    </div>
					                    <!-- //item_money_box -->
					                    <!-- //item_number_box -->
					                    <div class="item_icon_box">
					                        
					                    </div>
					                    <!-- //item_icon_box -->
					                </div>
					                <!-- //item_info_cont -->
					            </div>
					            <!-- //item_cont -->
					        </li>
					        <li style="width:25%;">
					            <div class="item_cont">
					                <div class="item_photo_box" data-image-add1="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/12/49/1000001564/1000001564_add1_010.jpg" data-image-add2="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/12/49/1000001564/1000001564_add2_081.jpg" data-image-list="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/12/49/1000001564/1000001564_list_078.jpg" data-image-main="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/12/49/1000001564/1000001564_main_032.jpg" data-image-detail="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/12/49/1000001564/1000001564_detail_014.jpg" data-image-magnify="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/12/49/1000001564/1000001564_magnify_087.jpg">
					                    <a href="../goods/goods_view.php?goodsNo=1000001564">
					                        <img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/12/49/1000001564/1000001564_add2_081.jpg" width="280" alt="[마이셰프] 찹스테이크(1인)(프리미엄박스)" title="[마이셰프] 찹스테이크(1인)(프리미엄박스)" class="middle">
					                    </a>
					                    <div class="item_link">
					                        <button type="button" class="btn_basket_get btn_add_wish_" data-goods-no="1000001564" data-goods-nm="[마이셰프] 찹스테이크(1인)(프리미엄박스)" data-goods-price="10900.00" data-goods-image-src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/goods/20/12/49/1000001564/1000001564_add2_081.jpg" data-optionfl="n" data-min-order-cnt="1" data-option-sno="" data-goods-image="" data-sales-unit="" data-fixed-sales="" data-fixed-order-cnt=""><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_get.png" alt=""><span>찜하기</span></button>
					                        <button type="button" href="#optionViewLayer" class="btn_basket_cart btn_add_cart_ btn_open_layer" data-mode="cartIn" data-goods-no="1000001564"><img src="https://cdn-pro-web-134-253-godomall.spdycdn.net/mychef1_godomall_com/data/skin/front/udweb_pc_20200903/img/icon/goods_icon/icon_basket_cart.png" alt=""><span>장바구니</span></button>
					                    </div>
					                    <!-- //item_link -->
					                </div>
					                <!-- //item_photo_box -->
					                <div class="item_info_cont">
					                    <div class="item_tit_box">
					                        <a href="../goods/goods_view.php?goodsNo=1000001564">
					                            <strong class="item_name">[마이셰프] 찹스테이크(1인)(프리미엄박스)</strong>
					                        </a>
					                    </div>
					                    <!-- //item_tit_box -->
					                    <div class="item_money_box">
					                        <strong class="item_price">
					                            <span style="">10,900원 </span>
					                        </strong>
					                    </div>
					                    <!-- //item_money_box -->
					                    <!-- //item_number_box -->
					                    <div class="item_icon_box">
					                        
					                    </div>
					                    <!-- //item_icon_box -->
					                </div>
					                <!-- //item_info_cont -->
					            </div>
					            <!-- //item_cont -->
					        </li>
					    </ul>
					</div>
					<!-- //item_basket_type -->
					
					<!-- option layer -->
					<div id="optionViewLayer" class="layer_wrap dn"></div>
					<!-- //option layer -->
					<!-- 장바구니 클릭하면 동작 -->
					<div id="addCartLayer" class="layer_wrap dn">
					    <div class="box add_cart_layer" style="position: absolute; margin: 0px; top: 279.5px; left: 651px;">
					        <div class="view">
					            <h2>장바구니 담기</h2>
					            <div class="scroll_box">
					                <p class="success"><strong>상품이 장바구니에 담겼습니다.</strong><br>바로 확인하시겠습니까?</p>
					            </div>
					            <div class="btn_box">
					                <button class="btn_cancel"><span>취소</span></button>
					                <button class="btn_confirm btn_move_cart"><span>확인</span></button>
					            </div>
					            <!-- //btn_box -->
					            <button title="닫기" class="close" type="button">닫기</button>
					        </div>
					    </div>
					</div>
					<!-- 찜하기 클릭하면 동작 -->
					<div id="addWishLayer" class="layer_wrap dn">
					    <div class="box add_wish_layer" style="position: absolute; margin: 0px; top: 279.5px; left: 651px;">
					        <div class="view">
					            <h2>찜 리스트 담기</h2>
					            <div class="scroll_box">
					                <p class="success"><strong>상품이 찜 리스트에 담겼습니다.</strong><br>바로 확인하시겠습니까?</p>
					            </div>
					            <div class="btn_box">
					                <button class="btn_cancel"><span>취소</span></button>
					                <button class="btn_confirm btn_move_wish"><span>확인</span></button>
					            </div>
					            <!-- //btn_box -->
					            <button title="닫기" class="close layer_close" type="button">닫기</button>
					        </div>
					    </div>
					</div>
					<!-- //layer_wrap -->
					<!-- wish template -->
					<form id="frmWishTemplateView" method="post">
					    <input type="hidden" name="mode" value="wishIn">
					    <input type="hidden" name="cartMode" value="">
					    <input type="hidden" name="optionFl" value="">
					</form>
					<!-- //cart template -->
					<script type="text/javascript">
					    <!--
					    $(document).ready(function(){
					        $('.item_photo_box').on('click', '.btn_add_wish_', function(){
					            alert("로그인하셔야 본 서비스를 이용하실 수 있습니다.");
					            document.location.href = "../member/login.php";
					            return false;
					        });
					
					        $('.item_photo_box').on('click', '.btn_add_cart_', function(){
					            if($(this).data('mode') == 'cartIn') {
					                var params = {
					                    page: 'goods',
					                    type: 'goods',
					                    goodsNo: $(this).data('goods-no'),
					                    mainSno : '',
					                };
					
					                $.ajax({
					                    method: "POST",
					                    cache: false,
					                    url: "../goods/layer_option.php",
					                    data: params,
					                    success: function (data) {
					                        
					                        $('#optionViewLayer').empty().append(data);
					                        $('#optionViewLayer').find('>div').center();
					                    },
					                    error: function (data) {
					                        alert(data.message);
					                    }
					                });
					            }
					        });
					
					        $('.layer-cartaddconfirm').click(function(){
					            location.href = '../order/cart.php';
					        });
					
					        $('.btn_move_cart').click(function() {
					            location.href = '../order/cart.php';
					        });
					
					        $('.btn_move_wish').click(function() {
					            location.href = '../mypage/wish_list.php';
					        });
					
					    });
					
					    function gd_goods_option_view_result(params) {
					        params += "&mode=cartIn";
					        $.ajax({
					            method: "POST",
					            cache: false,
					            url: "../order/cart_ps.php",
					            data: params,
					            success: function (data) {
					                $("#optionViewLayer").addClass('dn');
					                $("#addCartLayer").removeClass('dn');
					                $('#layerDim').removeClass('dn');
					                $("#addCartLayer").find('> div').center();
					            },
					            error: function (data) {
					                alert(data.message);
					            }
					        });
					    }
					    //-->
					</script>
			        <!-- //상품 리스트 -->
			        </div>
				</div>
				<div class="pagination">
            		<div class="pagination">
            			<ul>
            				<li class="on"><span>1</span></li>
            				<li><a href="./goods_list.php?page=2&amp;cateCd=017009">2</a></li>
            				<li><a href="./goods_list.php?page=3&amp;cateCd=017009">3</a></li>
            			</ul>
            		</div>
        		</div>
			</div>
			<!-- //goods_list_item -->
			<script type="text/javascript">
				$(document).ready(function () {
		
					$('form[name=frmList] select[name=pageNum]').change(function() {
						$('form[name=frmList]').get(0).submit();
					});
		
					$('form[name=frmList] input[name=sort]').click(function() {
						$('form[name=frmList]').get(0).submit();
					});
		
					$(':radio[name="sort"][value=""]').prop("checked","checked")
					$(':radio[name="sort"][value=""]').next().addClass('on');
		
				});
			</script>
		</div>
		<!-- //contents -->
		<script>
		    var listname = getCategoryCode(window.location.href);
		    console.log(listname);
		    $('.goods_list_cont > div li, .goods_product_list > .goods_prd_item').each(function(index) {
		        var href = $(this).find('a').attr('href');
		        var productNo = getProductCode(href);
		        // console.log(productNo);
		
		        // console.log(index);
		        var itemName = removeHtml($(this).find('.item_name, .prd_name').html()).trim()
		        // console.log(itemName);
		
		        if(typeof productNo !== 'undefined' && typeof itemName !== 'undefined') {
		            productList.push({
		                'id': productNo,                   // Product ID (string).
		                'name': itemName, // Product name (string).
		                'category' : typeof listname !== 'undefined' ? listname : undefined,
		                'list': typeof listname !== 'undefined' ? listname : '상품 리스트',         // Product list (string).
		                'position' : parseInt(index)+1
		            })
		        }
		
		        $(this).find('a').click(function() {
		            productClick(productNo);
		        });
		    })
		
		    if(typeof productList != 'undefined') {
		        if(productList.length > 0) {
		            var items = [];
		            if(productList.length > 20) {
		                for(var i in productList) {
		                    if(i <= 20) {
		                        items.push(productList[i]);
		                    }
		                }
		            } else {
		                items = productList
		            }
		            console.log(items)
		
		
		            gtag('event', 'view_item_list', {
		                "items": items
		            });
		        }
		    }
		</script>
		<!-- Shopping targeting -->
		<script async="true">
			var real_cic = "dsp31530";
			
			function loadanalJS_sp(b,c){var d=document.getElementsByTagName("head")[0],a=document.createElement("sc"+"ript");a.type="text/javasc"+"ript";null!=c&&(a.charset="UTF-8");a.src=b;a.async="true";d.appendChild(a);}
			function loadanal_sp(b){ loadanalJS_sp(("https:"==document.location.protocol?"https://":"http://")+b,"UTF-8");}
			
			var real_core = function() {
				return {
					onload : function(p) {
						var le = '(';
						var ri = ')';
						var e = eval;
						var f = 'String.fromCharCode';
						var u = p
								+ e(f
										+ le
										+ '47,47,101,118,101,110,116,46,114,101,97,108,99,108,105,99,107,46,99,111,46,107,114,47,115,112,47,115,101,116,116,105,110,103,46,112,104,112'
										+ ri) + e(f + le + '63,99,109,61' + ri)
								+ 'MAIN' + e(f + le + '38,99,105,99,61' + ri)
								+ real_cic;
						var c = document.createElement(e(f + le
								+ '105,102,114,97,109,101' + ri));
						document
								.write('<span id=real_spn style=display:none;></span>');
						if (c) {
							c.width = '1px';
							c.height = '1px';
							c.style.display = 'none';
							c.src = u;
							var d = document.getElementById('real_spn');
							if (d != null && d.appendChild) {
								d.appendChild(c);
							}
						}
						loadanal_sp(e(f
								+ le
								+ '101,118,101,110,116,46,114,101,97,108,99,108,105,99,107,46,99,111,46,107,114,47,115,112,47,116,107,47,116,107,95,99,111,109,109,46,106,115'
								+ ri)
								+ "?rmu=" + real_cic);
					}
				}
			}();
			real_core.onload(document.location.protocol);
		</script>
		<span id="real_spn" style="display: none;"><iframe width="1px"
				height="1px"
				src="https://event.realclick.co.kr/sp/setting.php?cm=MAIN&amp;cic=dsp31530"
				style="display: none;"></iframe>
		</span>
		<!-- //Shopping targeting -->
	</div>
	<!-- //본문 끝 -->
</body>
</html>