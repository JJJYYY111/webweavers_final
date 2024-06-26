<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="common"%>
<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
<common:adminHead />

<title>매출 관리</title>
<!-- This page plugin CSS -->
<link
	href="/resources/admin/assets/extra-libs/datatables.net-bs4/css/dataTables.bootstrap4.css"
	rel="stylesheet" />
<!-- Custom CSS -->
<link rel="stylesheet"
	href="/resources/admin/adminCSS/salesStatusCSS.css">
</head>

<body>
	<div class="preloader">
		<div class="lds-ripple">
			<div class="lds-pos"></div>
			<div class="lds-pos"></div>
		</div>
	</div>
	<div id="main-wrapper" data-theme="light" data-layout="vertical"
		data-navbarbg="skin6" data-sidebartype="full"
		data-sidebar-position="fixed" data-header-position="fixed"
		data-boxed-layout="full">
		<!-- ============================================================== -->
		<common:adminTopBar />
		<!-- ============================================================== -->
		<common:adminSideBar />
		<!-- ============================================================== -->
		<div class="page-wrapper">
			<!-- ============================================================== -->
			<div class="page-breadcrumb">
				<div class="row">
					<div class="col-7 align-self-center"></div>
				</div>
			</div>
			<!-- ============================================================== -->
			<div class="container-fluid">
				<div class="row">
					<div class="col-12 " name="cardTwo">
						<div class="card">
							<div class="card-body">
								<h4 class="card-title">주문통계내역 조회</h4>
								<hr>
								<!-- action='#' -->
								<form id="searchForm" action="#">
									<div class="col-lg-12 form-body">
										<div class="card-body-select">
											<div class="form-group">
												<div class="row">
													<label class="col-lg-1 text-center"
														style="margin-top: 7px; margin-bottom: 4px;">기간설정</label>
													<div class="col-lg-10">
														<div class="row">
															<div class="col-md-4 text-center">
																<input type="date" class="form-control col-md-12"
																	id="registFirstDay" name="startDate"
																	placeholder="앞기간설정" onfocus="this.placeholder = ''"
																	onblur="this.placeholder = '앞기간설정'"
																	style="display: inline-block;">
															</div>
															<div class="col-sm-auto text-center">
																<i class="fas fa-window-minimize"></i>
															</div>
															<div class="col-md-4 text-center">
																<input type="date" class="form-control col-md-11"
																	id="registLastDay" name="endDate" placeholder="뒷기간설정"
																	onfocus="this.placeholder = ''"
																	onblur="this.placeholder = '뒷기간설정'"
																	style="display: inline-block;">
															</div>
														</div>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class="row">
													<label class="col-lg-1 text-center"
														style="margin-top: 7px; margin-bottom: 4px;">카테고리</label>
													<div class="col-lg-11">
														<div class="row">
															<div class="col-md-2 text-center">
																<select class="custom-select form-control col-md-12"
																	id="categorySelect" name="categoryName"
																	onchange="changeFirstCategory()">
																	<option selected value="0">Category</option>
																	<option value="1">스킨케어</option>
																	<option value="2">클렌징</option>
																	<option value="3">마스크팩</option>
																</select>
															</div>
															<div class="col-md-2 text-center">
																<select class="custom-select form-control col-md-12"
																	id="subCategorySelect" name="subCategoryName">
																	<option selected value="0">SubCategory</option>
																</select>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<br>
										<hr>
										<br>
										<div class="form-actions">
											<div class="text-right">
												<button type="button" id="searchButton" class="btn btn-info">검색</button>
												<button type="reset" id="resetButton" class="btn btn-dark">리셋</button>
											</div>
										</div>
									</div>
								</form>

								<h4 class="card-title">상품조회</h4>
								<hr>
								<div class="table-responsive">
									<table id="zero_config"
										class="table table-striped table-bordered no-wrap">
										<thead>
											<tr>
												<th class="sorting_asc" style="background-color: #f2f2f2;">상품번호</th>
												<th class="sorting_asc" style="background-color: #f2f2f2;">상품명</th>
												<th class="sorting_asc" style="background-color: #f2f2f2;">카테고리</th>
												<th class="sorting_asc" style="background-color: #f2f2f2;">서브카테고리</th>
												<th class="sorting_asc" style="background-color: #f2f2f2;">가격</th>
												<th class="sorting_asc" style="background-color: #f2f2f2;">수량</th>
												<th class="sorting_asc" style="background-color: #f2f2f2;">금액</th>
											</tr>
										</thead>
										<tbody id="salesSearchdatas">
											<c:forEach var="data" items="${productSaleDatas}">
												<tr>
													<td>${data.productPK}</td>
													<td>${data.productName}</td>
													<td>${data.categoryName}</td>
													<td>${data.subCategoryName}</td>
													<td><fmt:formatNumber type="currency"
															value="${data.productPrice}" /></td>
													<td>${data.totalCnt}</td>
													<td><fmt:formatNumber type="currency"
															value="${data.totalPrice}" /></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- footer -->
		<footer class="footer text-center text-muted">
			Web Wevers <a href="http://koreaitsecurity.net/">WebWevers</a>
		</footer>
	</div>
	<!-- All Jquery -->
	<script src="/resources/admin/assets/libs/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap tether Core JavaScript -->
	<script
		src="/resources/admin/assets/libs/popper.js/dist/umd/popper.min.js"></script>
	<script
		src="/resources/admin/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- apps -->
	<!-- apps -->
	<script src="/resources/admin/dist/js/app-style-switcher.js"></script>
	<script src="/resources/admin/dist/js/feather.min.js"></script>
	<!-- slimscrollbar scrollbar JavaScript -->
	<script
		src="/resources/admin/assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
	<script src="/resources/admin/assets/extra-libs/sparkline/sparkline.js"></script>
	<!--Menu sidebar -->
	<script src="/resources/admin/dist/js/sidebarmenu.js"></script>
	<!--Custom JavaScript -->
	<script src="/resources/admin/dist/js/custom.min.js"></script>
	<!--This page plugins -->
	<script
		src="/resources/admin/assets/extra-libs/datatables.net/js/jquery.dataTables.min.js"></script>
	<script
		src="/resources/admin/dist/js/pages/datatable/datatable-basic.init.js"></script>

	<script src="/resources/admin/js/categorySelect.js"></script>
</body>

</html>