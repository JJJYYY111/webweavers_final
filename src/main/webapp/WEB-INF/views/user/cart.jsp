<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="common"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>WeaveGlow - Cart</title>
<common:head />
</head>
<body>
	<common:header />
	<common:banner bannerText='장바구니' />

	<!-- ================ 내용 ================= -->
	<section class="cart_area">
		<div class="container">
			<div class="cart_inner">
				<div class="table-responsive" id="orderList">
					<form action="checkout" method="POST" name="cartForm" id="cartForm">
						<table class="table" id="cart" style="text-align: right;">
							<colgroup>
								<col width="60%" />
								<col width="13.3333%" />
								<col width="13.3333%" />
								<col width="13.3333%" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col" class="col-lg-4" style="text-align: left;">
										<span style="display: inline-block; text-align: center;">
											<button
												class="btn waves-effect waves-light btn-outline-primary"
												onclick="selectAllProduct(); event.preventDefault();"
												name="selectAll">전체 선택/해제</button>
											<button
												class="btn waves-effect waves-light btn-outline-primary"
												onclick="selectedDelete()" style="text-align: left;">선택삭제</button>
									</span> <span
										style="display: inline-block; margin-left: 20%; text-align: right;">
											Product </span>
									</th>

									<th scope="col"
										style="text-align: center; padding-bottom: 20px;">Price</th>
									<th scope="col"
										style="text-align: center; padding-bottom: 20px;">Quantity</th>
									<th scope="col"
										style="text-align: center; padding-bottom: 20px;">Total</th>
								</tr>
							</thead>
							<tbody>
								<!-- 장바구니 목록 출력 -->
								<c:if test="${fn:length(cdatas) <= 0}">
									<br>
									<br>
									<h4 style="text-align: center;">장바구니가 비었습니다.</h4>
									<br>
									<br>
								</c:if>
								<c:if test="${fn:length(cdatas) > 0}">
									<c:forEach var='data' items='${cdatas}'>
										<tr>
											<td style="text-align: left;">
												<!-- 체크박스와 이미지를 같은 줄에 배치하기 위해 div로 감싸기 -->
												<div style="display: flex; align-items: center;">
													<!-- 체크박스 추가 -->
													<input type="checkbox" name="selectedProducts"
														value="${data.cartPK}" style="margin-right: 10px;">
													<!-- 상품 이미지와 링크 -->
													<a href="/productDetail?productPK=${data.productPK}"> <img
														src="${data.productImg}" alt="${data.productPK}번 상품사진"
														style="width: 150px;">
													</a>
													<!-- 상품 이름 -->
													<div class="media-body" style="margin-left: 10px;">
														<!-- 여백 조정 -->
														<a href="/productDetail?productPK=${data.productPK}"
															id="cartProduct" style="margin-bottom: 0;">
															<p style="margin-bottom: 0;">${data.productName}</p>
														</a>
													</div>
												</div>
											</td>
											<td>
												<h5 id="cartProductPrice_${data.productPK}">
													<fmt:formatNumber value="${data.productPrice}"
														currencyCode="KRW" />
													원
												</h5>
											</td>
											<!-- 장바구니 수량 변경 -->
											<td style="padding-left: 3rem; padding-right: 0;">
												<div class="product_count">
													<input type="text" name="cartCnt"
														id="qty_${data.productPK}" maxlength="12"
														value="${data.cartCnt}" title="Quantity:"
														class="input-text qty"
														onchange="updateQuantity('${data.productPK}', ${data.productPrice});"
														readonly>
													<button
														onclick="updateQuantity('${data.productPK}', '1', ${data.productPrice})"
														class="increase items-count" type="button">
														<i class="lnr lnr-chevron-up"></i>
													</button>
													<button
														onclick="updateQuantity('${data.productPK}', '0', ${data.productPrice})"
														class="reduced items-count" type="button">
														<i class="lnr lnr-chevron-down"></i>
													</button>
												</div>
											</td>
											<!-- /장바구니 수량 변경 -->
											<td>
												<h5>
													<span class="productPrice" id="total_${data.productPK}"><fmt:formatNumber
															value="${data.productPrice * data.cartCnt}"
															currencyCode="KRW" /></span>원
												</h5>
											</td>
											<!-- //0403 cartDelete로 다이렉트 -->
											<!-- //0403 삭제 js 추가 -->
											<%-- <td><input type="button" name="close" id="close"
												style="display: none;"> <label for="close">
													<a onclick="deleteCartItem(${data.cartPK})"> <img
														src="/resources/img/close.png" alt="닫기버튼"
														style="width: 20px; height: 20px"></a>
											</label></td> --%>
											<td><input type="button" name="close" id="close"
												style="display: none;"> <label for="close">
													<a href="cartDelete?cartPK=${data.cartPK}"><img
														src="/resources/img/close.png" alt="닫기버튼"
														style="width: 20px; height: 20px"></a>
											</label></td>

										</tr>
									</c:forEach>
								</c:if>
								<!-- /장바구니 목록 출력 -->
								<!-- 합계 -->
								<tr class="bottom_button">
									<td></td>
									<td>
										<h5>subtotal</h5>
									</td>
									<td></td>
									<td>
										 <h5>
											<span id="cartTotalPrice"></span>원
										</h5> 
									</td>
								</tr>
								<!-- /합계 -->
								<tr class="out_button_area">
									<td class="d-none-l"></td>
									<td></td>
									<td></td>
									<td></td>
									<td>
										<div class="checkout_btn_inner align-items-center">
											<button type="button" class="gray_btn"
												onclick="location.href='productList'">쇼핑하기</button>
											<button type="submit" class="gray_btn ml-2"
												onsubmit="return false;">구매하기</button>
											<!-- <a class="gray_btn" href="productList">쇼핑하기</a> <a
												class="gray_btn ml-2" href="checkout">구매하기</a> -->
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
			</div>
		</div>
	</section>
	<!-- ================ /내용 ================= -->
	<script src="/resources/js/cart.js"></script>
	<common:footer />
</body>
</html>
