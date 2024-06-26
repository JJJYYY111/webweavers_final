<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="common"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>WeaveGlow - ProductList</title>
<common:head />
<link rel="stylesheet" href="/resources/weaveGlowCSS/productListCSS.css">    

</head>
<body>
	<common:header />
	<common:banner bannerText='전체상품목록' />

	<!-- ================ 내용 ================= -->
	<br>
	<div class="product-filters-container">
		<section class="product-depth p_ver">
			<input type="hidden" id="checkSubCategoryPK" value="${subCategoryPK}"/>
			<input type="hidden" id="checkCategoryPK" value="${categoryPK}"/>
			<div class="depth-list-wrap">
				<div class="list-area">
					<ul class="grid-container">
						<li><a
							href="productList"
							id="" class="ctgr_box active"
							style="border-right: 1px solid rgba(0, 0, 0, 0.1)">전체</a></li>
						<!-- 선택된 카테고리의 경우 class 에 active 추가 -->
						<li><a id="L01M03S01"
							href="subCategoryProductList?categoryPK=1"
							class="ctgr_box "
							style="border-right: 1px solid rgba(0, 0, 0, 0.1)">스킨케어</a></li>
						<!-- 선택된 카테고리의 경우 class 에 active 추가 -->
						<li><a id="L01M03S02"
							href="subCategoryProductList?categoryPK=2"
							class="ctgr_box "
							style="border-right: 1px solid rgba(0, 0, 0, 0.1)">클렌징</a></li>
						<!-- 선택된 카테고리의 경우 class 에 active 추가 -->
						<li><a id="L01M03S03"
							href="subCategoryProductList?categoryPK=3"
							class="ctgr_box ">마스크,팩</a></li>
					</ul>
				</div>
			</div>
		</section>
	</div>
	<section class="section-margin--small mb-5">
		<div class="container">
			<div class="row">
				<!-- 필터 -->
				<div class="col-xl-3 col-lg-4 col-md-5">
					<div class="sidebar-filter">
						<div class="top-filter-head">Product Filters</div>
						<div class="common-filter" style="padding-bottom: 15px">
							<div class="head">가격</div>
							<div class="price-range-area">
								<div id="price-range"></div>
								<div class="value-wrapper d-flex">
									<div class="price">가격:</div>
									<div id="lower-value"></div>
									<span>&#8361;</span>
									<!-- 원화표시 -->
									<div class="to">to</div>
									<div id="upper-value"></div>
									<span>&#8361;</span>
									<!-- 원화표시 -->
								</div>
							</div>
							<div class="custom-button"  tabindex="0"
								style="text-align: right; margin-top: 5px">
								<button onclick="onClickFilter()"
									style="background-color: #384aeb; color: white; border: none; margin-right: 15px;">검색</button>
							</div>
						</div>
					</div>
				</div>
				<!-- /필터 -->
				<div class="col-xl-9 col-lg-8 col-md-7">
					<!-- 목록 순서 -->
					<div class="filter-bar d-flex flex-wrap align-items-center">
						<div class="sorting">
							<select id="shit" onchange="proList(this)">
								<option value="1" data-sort-type="신상순">신상순</option>
								<option value="2" data-sort-type="인기순">인기순</option>
								<option value="3" data-sort-type="낮은가격순">낮은가격순</option>
								<!--  <option value="1">추천순</option> 찜개수 -->
							</select>
						</div>
						<span id=productCount></span>

					</div>
					<!-- 목록 순서 -->
					<!-- 상품 -->
					<section class="lattest-product-area pb-40 category-list">
						<div class="row" id="productListForm">
							<!-- JS: 각 상품 데이터를 받아와서 해당 상품에 대한 HTML코드를 생성해 반환 -->
						</div>
						<div id='paging'>
						</div>
					</section>
					<!-- /상품 -->
				</div>
			</div>
		</div>
	</section>
	<!-- ================ /내용 ================= -->

	<common:footer />
	<script src="/resources/js/productList.js"></script>
</body>
</html>