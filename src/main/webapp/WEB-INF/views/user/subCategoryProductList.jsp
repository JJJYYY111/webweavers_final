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
<style type="text/css">
.grid-container {
	display: flex; /* 내부 요소를 수평으로 배치하기 위해 flex 사용 */
	flex-wrap: wrap; /* 요소들이 넘치면 다음 줄로 이동하도록 설정 */
	justify-content: center; /* 요소들을 수평 가운데 정렬 */
	padding: 0;
	list-style: none; /* 리스트 스타일 제거 */
	height: 80px; /* 박스의 높이 */
}

.ctgr_box {
	width: 275px; /* 박스의 너비 */
	display: flex; /* 내부 요소를 가로로 배열하기 위해 flex 사용 */
	align-items: center; /* 내부 요소를 수직 가운데 정렬 */
	justify-content: center; /* 내부 요소를 수평 가운데 정렬 */
	text-decoration: none; /* 링크에 밑줄 제거 */
	color: black; /* 링크 색상 */
	font-size: 20px;
	text-align: center;
}

.grid-container li {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100%;
}

.ctgr_box.active {
	font-weight: bold; /* 선택된 항목에 대한 강조 표시 */
}

.list-area ul {
	display: flex; /* Flexbox 사용 */
	flex-wrap: wrap; /* 요소들이 필요한 만큼 줄 바꿈되도록 설정 */
	justify-content: flex-start; /* 왼쪽 정렬 */
	padding: 0; /* 기본 패딩 제거 */
	list-style: none; /* 목록 스타일 제거 */
	width: 100%; /* 전체 너비 설정 */
}

.list-area ul li {
	width: 25%; /* 요소들의 너비를 25%로 설정하여 네 개의 요소가 가로로 나열되도록 함 */
	box-sizing: border-box; /* 요소의 너비에 패딩과 테두리를 포함하도록 설정 */
	padding: 5px; /* 내부 여백 설정 */
}

#paging {
	width: 100%;
	text-align: center;
	margin-top: 20px;
}

#paging ul {
	display: flex;
	flex-wrap: wrap;
	list-style: none;
	padding: 0;
	justify-content: center; /* ul을 수평 가운데 정렬 */
}

#paging ul li {
	display: inline-block;
	margin-right: 5px; /* 각 페이지 번호 사이의 간격 조절 */
}

#paging ul li:first-child {
	margin-right: 5px; /* 첫 번째 페이지 번호의 간격을 따로 조절 */
}

#paging ul li a {
	display: block;
	padding: 8px 16px;
	font-size: 16px;
	color: #000;
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 4px;
	text-decoration: none;
}

#paging ul li.active a {
    background-color: #007bff; /* active 클래스가 있는 li의 하위에 있는 a 태그의 배경색을 파란색(#333)으로 변경 */
    /* background-color: #333; */ /* active 클래스가 있는 li의 하위에 있는 a 태그의 배경색을 파란색(#333)으로 변경 */
    color: #fff; /* 텍스트 색상을 하얀색(#fff)으로 변경 */
    border-color: #333; /* 테두리 색상 변경 */
}


#paging ul li.paging_num {
	display: inline-block;
	margin-right: 5px; /* 각 페이지 번호 사이의 간격 조절 */
}

#paging ul li.paging_num:first-child {
	margin-right: 5px; /* 첫 번째 페이지 번호의 간격을 따로 조절 */
} 

.custom-button:focus {
    outline: none; /* 포커스된 요소의 기본 테두리 제거 */
}
</style>

</head>
<body>
	<common:header />
	<common:banner bannerText='스킨케어' />

	<!-- ================ 내용 ================= -->
	<br>
	<section class="product-depth p_ver">
		<div class="depth-list-wrap">
			<%-- <c:if test="${datas[0].categoryPK == 1}"> --%>
			<div class="list-area">
				<ul>
					<li><a href="subCategoryProductList" id=""
						class="ctgr_box active">전체</a></li>
					<!-- 선택된 카테고리의 경우 class 에 active 추가 -->
					<li><a id="L01M01S01" href="subCategoryProductList"
						class="ctgr_box ">스킨</a></li>
					<!-- 선택된 카테고리의 경우 class 에 active 추가 -->
					<li><a id="L01M01S02" href="subCategoryProductList"
						class="ctgr_box ">로션/에멀젼</a></li>
					<!-- 선택된 카테고리의 경우 class 에 active 추가 -->
					<li><a id="L01M01S03" href="subCategoryProductList"
						class="ctgr_box ">에센스/세럼/앰플</a></li>
					<li><a id="L01M01S04" href="subCategoryProductList"
						class="ctgr_box ">크림</a></li>
					<!-- 선택된 카테고리의 경우 class 에 active 추가 -->
					<li><a id="L01M01S05" href="subCategoryProductList"
						class="ctgr_box ">아이케어</a></li>
					<!-- 선택된 카테고리의 경우 class 에 active 추가 -->
					<li><a id="L01M01S07" href="subCategoryProductList"
						class="ctgr_box ">미스트/부스터</a></li>
					<!-- 선택된 카테고리의 경우 class 에 active 추가 -->
					<li><a id="L01M01S08" href="subCategoryProductList"
						class="ctgr_box ">세트</a></li>
				</ul>
			</div>

			<br>
			<%-- </c:if> --%>
			<c:if test="${datas[0].categoryPK == 2}">
				<div class="list-area">
					<ul>
						<li><a href="subCategoryProductList" id=""
							class="ctgr_box active">전체</a></li>
						<!-- 선택된 카테고리의 경우 class 에 active 추가 -->
						<li><a id="L01M01S01" href="subCategoryProductList"
							class="ctgr_box ">클렌징폼</a></li>
						<!-- 선택된 카테고리의 경우 class 에 active 추가 -->
						<li><a id="L01M01S02" href="subCategoryProductList"
							class="ctgr_box ">클렌징크림/로션/워터</a></li>
						<!-- 선택된 카테고리의 경우 class 에 active 추가 -->
						<li><a id="L01M01S03" href="subCategoryProductList"
							class="ctgr_box ">클렌징젤/오일/티슈</a></li>
						<li><a id="L01M01S04" href="subCategoryProductList"
							class="ctgr_box ">립&아이 리무버</a></li>
					</ul>
				</div>
				<br>

			</c:if>
			<c:if test="${datas[0].categoryPK == 3}">
				<div class="list-area">
					<ul>
						<li><a href="subCategoryProductList" id=""
							class="ctgr_box active">전체</a></li>
						<!-- 선택된 카테고리의 경우 class 에 active 추가 -->
						<li><a id="L01M01S01" href="subCategoryProductList"
							class="ctgr_box ">마사지/워시오프 팩</a></li>
						<!-- 선택된 카테고리의 경우 class 에 active 추가 -->
						<li><a id="L01M01S02" href="subCategoryProductList"
							class="ctgr_box ">필링/스크럽</a></li>
						<!-- 선택된 카테고리의 경우 class 에 active 추가 -->
						<li><a id="L01M01S03" href="subCategoryProductList"
							class="ctgr_box ">시트마스크</a></li>
						<li><a id="L01M01S04" href="subCategoryProductList"
							class="ctgr_box ">코팩</a></li>
					</ul>
				</div>
				<br>
			</c:if>
		</div>
	</section>
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
							<div class="custom-button" tabindex="0"
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

	<script src="/resources/js/productList2.js"></script>
</body>
</html>