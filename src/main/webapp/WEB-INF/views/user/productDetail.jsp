<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="common"%>
<%@ taglib prefix="star" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<title>WeaveGlow - ProductDetail</title>
<common:head />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>

<body>
	<common:header />

	<common:banner bannerText='상품상세' />

	<!--================ 상품 기본정보 =================-->
	<div class="product_image_area" data-ppk="${productPK}">
		<div class="container">
			<div class="row s_product_inner">
				<div class="col-lg-6">
					<div class="owl-carousel owl-theme s_Product_carousel">
						<div class="single-prd-item">
							<img class="img-fluid" src="${productImg}"
								alt="${productPK}번 상품사진">
						</div>
					</div>
				</div>
				<div class="col-lg-5 offset-lg-1">
					<input type="hidden" id="productNumber" value="${productPK}">
					<input type="hidden" id="sessionMid" value="${sessionMid}">
					<div class="s_product_text">
						<h4>${productName}</h4>
						<h2>
							<fmt:formatNumber value="${productPrice}" currencyCode="KRW" />
							원
						</h2>
						<p>${productName}</p>

						<div class="product_count" style="width: 160px">
							<label for="qty">수량:</label> <input type="text" name="cartCnt"
								id="sst" size="2" maxlength="12" value="1" title="Quantity:"
								class="input-text qty" readonly>

							<!-- 상품 수량 + or - 버튼 -->
							<button
								onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst )) result.value++;return false;"
								class="increase items-count" type="button">
								<i class="ti-angle-up"></i>
							</button>
							<button
								onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst ) && sst > 1 ) result.value--;return false;"
								class="reduced items-count" type="button">
								<i class="ti-angle-down"></i>
							</button>
						</div>

						<!-- 장바구니 담기 버튼 -->
						<button onclick="addToCart()" id="addToCartBtn"
							class="button primary-btn" style="margin-left: 20px;">장바구니</button>
						<div class="card_area d-flex align-items-center"
							id="detailWishBtn">

							<!-- 찜추가버튼 추가하면 빨강 취소하면 흰색 -->
							<button onclick="wishClick(getProductPPK(),'${sessionMid}')"
								class="product-btn-${productPK}" style="border: unset;">
								<c:if test="${like == 1}">
									<i class="fa-solid fa-heart"
										style="color: red; -webkit-text-stroke-width: 0.5px; -webkit-text-stroke-color: gray;"></i>
									<!-- <i class="ti-heart" style="color: red; "></i> -->
								</c:if>
								<c:if test="${like == 0}">
									<i class="fa-solid fa-heart"
										style="color: white; -webkit-text-stroke-width: 0.5px; -webkit-text-stroke-color: gray;"></i>
									<!-- <i class="ti-heart" style="color: #fff; "></i> -->
								</c:if>
							</button>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<!--================ /상품 기본정보 =================-->

	<!--================ 상품 상세정보 =================-->
	<section class="product_description_area">
		<div class="container">
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item"><a class="nav-link" id="home-tab"
					data-toggle="tab" href="#home" role="tab" aria-controls="home"
					aria-selected="true">상세정보</a></li>
				<li class="nav-item"><a class="nav-link active" id="review-tab"
					data-toggle="tab" href="#review" role="tab" aria-controls="review"
					aria-selected="false">리뷰</a></li>
			</ul>

			<div class="tab-content" id="myTabContent">
				<!-- 상품 상세정보(설명) -->
				<div class="tab-pane fade" id="home" role="tabpanel"
					aria-labelledby="home-tab">
					<img class="img-fluid" src="${productDetailImg}"
						alt="${productPK}번 상품사진">
				</div>
				<!-- /상세정보 -->

				<!-- 리뷰 -->
				<div class="tab-pane fade show active" id="review" role="tabpanel"
					aria-labelledby="review-tab">
					<div class="row">
						<div class="col-lg-12">
							<div class="row total_rate">
								<div class="col-3">
									<div class="box_total">
										<h5>별점</h5>
										<h4 id="avgScore"></h4>
										<!-- 별점 평균 점수 -->
										<h6>리뷰: ${fn:length(rdatas)}개</h6>
										<!-- 리뷰 총 갯수 -->
									</div>
								</div>
								<div class="col-9">
									<div class="rating_list">
										<h3>List</h3>
										<ul class="list">
											                                            <li><a>5 Star <i class="fa fa-star"></i><i
                                                    class="fa fa-star"></i><i class="fa fa-star"></i><i
                                                    class="fa fa-star"></i><i class="fa fa-star"></i> <span
                                                    id="starVal5"></span> <!-- 별점5점인 리뷰가 몇개인지 갯수 -->
                                            </a></li>
                                            <li><a>4 Star <i class="fa fa-star"></i><i
                                                    class="fa fa-star"></i><i class="fa fa-star"></i><i
                                                    class="fa fa-star"></i><i class="fa fa-star"
                                                    style="color: black;"></i> <span id="starVal4"></span> <!-- 별점4점인 리뷰가 몇개인지 갯수 -->
                                            </a></li>
                                            <li><a>3 Star <i class="fa fa-star"></i><i
                                                    class="fa fa-star"></i><i class="fa fa-star"></i><i
                                                    class="fa fa-star" style="color: black;"></i><i
                                                    class="fa fa-star" style="color: black;"></i> <span
                                                    id="starVal3"></span> <!-- 별점3점인 리뷰가 몇개인지 갯수 -->
                                            </a></li>
                                            <li><a>2 Star <i class="fa fa-star"></i><i
                                                    class="fa fa-star"></i><i class="fa fa-star"
                                                    style="color: black;"></i><i class="fa fa-star"
                                                    style="color: black;"></i><i class="fa fa-star"
                                                    style="color: black;"></i> <span id="starVal2"></span> <!-- 별점2점인 리뷰가 몇개인지 갯수 -->
                                            </a></li>
                                            <li><a>1 Star <i class="fa fa-star"></i><i
                                                    class="fa fa-star" style="color: black;"></i><i
                                                    class="fa fa-star" style="color: black;"></i><i
                                                    class="fa fa-star" style="color: black;"></i><i
                                                    class="fa fa-star" style="color: black;"></i> <span
                                                    id="starVal1"></span> <!-- 별점1점인 리뷰가 몇개인지 갯수 -->
                                            </a></li>
										</ul>
									</div>
								</div>
							</div>
							<hr>

							<div class="button-with-line-container">
								<button class="button-with-line" id="like" value="reviewLike">좋아요순</button>
								<button class="button-with-line" id="recent" value="regdate">최신순</button>
							</div>
							<hr>
							<div class="review_list">
								<c:if test="${fn:length(rdatas) <= 0}">
									<br>
									<br>
									<h4 style="text-align: center;">리뷰가 없습니다.</h4>
									<br>
									<br>
								</c:if>
								<!-- 리뷰가 없을 경우 -->
								<c:forEach var='data' items='${rdatas}'>



									<!-- 일반 회원의 리뷰 -->

									<div class="review_item">
										<div class="media">
											<div class="media-body">
												<c:if test="${data.gradePK == 5}">
													<h4>탈퇴한 회원의 리뷰입니다.</h4>
												</c:if>
												<!-- 리뷰리스트에서 리뷰를 작성한 회원이 탈퇴하였을 경우 해당 리뷰는 탈퇴한 회원이라는 문구로 표시 -->
												<c:if test="${data.gradePK != 5}">
													<span>${data.reviewRegdate}</span>
													<br>
													<br>
													<h4>
														<span>작성자 : ${data.memberNickname}</span>
														<button
															onclick="reviewLikeClick('${data.reviewPK}','${sessionMid}')"
															class="review-btn-${data.reviewPK}"
															style="margin-top: 3px; background: #ffffff; border: none;">
															<c:if test="${data.reviewLike == 1}">
																<!-- 1이면 리뷰 좋아요 -->
																<img src="/resources/reviewLikeRed.png" alt="좋아요"
																	style="width: 25px;">
															</c:if>
															<c:if test="${data.reviewLike == 0}">
																<img src="/resources/reviewLike.png"
																	alt="좋아요를 누르지 않은 상태" style="width: 25px;">
															</c:if>
														</button>
														<span id="reviewCnt${data.reviewPK}">${data.reviewLikeCnt}</span>
													</h4>
												</c:if>
												<br> <input class="starValue" type="hidden"
													name="reviewScope" id="scope_${data.reviewPK}"
													value="${data.reviewScope}">
												<!-- 해당 회원이 작성한 리뷰 별점 	-->
												<div class="starRating" id="starRating-${data.reviewPK}">

												</div>
												<script>
                                        // 리뷰 별점을 표시하는 스크립트
                                        var starHTML = '';
                                        for (var i = 0; i < ${data.reviewScope}; i++) {
                                            starHTML += '<i class="fas fa-star" style="margin-right: 2px;"></i>'; // 별과 별 사이에 더 넓은 공백 추가
                                        }
                                        for (var i = ${data.reviewScope}; i < 5; i++) {
                                            starHTML += '<i class="far fa-star" style="margin-right: 2px;"></i>'; // 별과 별 사이에 더 넓은 공백 추가
                                        }
                                        document.getElementById('starRating-${data.reviewPK}').innerHTML = starHTML;
                                   	 </script>

											</div>
											<div class="d-flex">
												<c:if test="${data.reviewImg == null}">
												</c:if>
												<c:if test="${data.reviewImg != null}">
													<div class="feature-img">
														<img style="max-width: 200%; max-height: 200px;"
															class="img-fluid" src="${data.reviewImg}" alt="리뷰작성 이미지">
														<!-- 리뷰 작성할때 사용자가 등록한 이미지 -->
													</div>
												</c:if>


											</div>
										</div>

										<br>
										<div>
											<textarea class="col-lg-12" rows="3" name="reviewContent"
												placeholder="리뷰 내용" readonly
												style="resize: none; border: 2px solid gray; border-radius: 5px; line-height: 2; font-size: large;">${data.reviewContent}
																	</textarea>
										</div>
									</div>
								</c:forEach>


							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================ /상품 상세정보 =================-->

	<script src="/resources/js/productDetail.js"></script>
	<script src="/resources/js/cart.js"></script>
	<common:footer />
</body>

</html>
