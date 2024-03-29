<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="common"%>
<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1"
	, viewport-fit="cover " />
<meta name="description" content="" />
<meta name="author" content="" />
<!-- Favicon icon -->
<link rel="icon" type="/admin/image/png" sizes="16x16"
	href="/admin/assets/images/favicon.png" />
<title>주문현황</title>
<!-- plugin CSS -->
<link
	href="/admin/assets/extra-libs/datatables.net-bs4/css/dataTables.bootstrap4.css"
	rel="stylesheet" />
<!-- Custom CSS -->
<link href="/admin/dist/css/style.min.css" rel="stylesheet" />
<!-- 스윗 알랏창  -->
<script src='https://unpkg.com/sweetalert/dist/sweetalert.min.js'></script>
<style>
.input {
	color: #000000;
	background-color: #ffffff4d;
	border: 3px solid #ffffff;
}

form .cur-row {
	display: flex;
	align-items: center;
	gap: 10px;
}

#myModal {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}
</style>



<style>
.custom {
	appearance: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	background: transparent url('path_to_arrow_icon.png') no-repeat right
		center;
	padding: 0.375rem 1.75rem 0.375rem 0.75rem;
	border: 1px solid #ced4da;
	border-radius: 0.25rem;
	line-height: 1.5;
	background: url(../../assets/images/custom-select.png) right 1.1rem
		center no-repeat;
}
</style>



<style>
.table-responsive {
	overflow-x: hidden;
	overflow-y: auto;
	/
}
</style>

<style>
.row.justify-content-center {
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>

<style>
.membertable {
	border-top: 1px solid #e8eef3;
}
</style>

<style>
table {
	width: 100%;
	border-collapse: collapse;
	table-layout: fixed;
}

th, td {
	border: 1px solid black;
	padding: 8px;
	text-align: left;
	overflow-x: auto;
	white-space: nowrap;
}

th {
	background-color: #f2f2f2;
}

@media screen and (max-width: 768px) {
	table {
		font-size: 14px;
	}
}
</style>

<style>
::-webkit-scrollbar {
	width: 5px;
}

* {
	scrollbar-width: thin;
}

*::-ms-scrollbar {
	width: 5px;
}
</style>

<style>
::placeholder {
	color: #000000;
	font-weight: 100;
}
</style>



<style>
#inlineFormCustomSelect {
	overflow-x: hidden;
	overflow-y: auto;
	width: 100%;
}
</style>

<style>
.row.justify-content-center {
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>

<style>
.membertable {
	border-top: 1px solid #e8eef3;
}

form {
	width: 500px;
}

table {
	border-collapse: collapse;
	margin-bottom: 10px;
}

th, td {
	padding: 3px 10px;
}

.off-screen {
	display: none;
}

#productNav {
	width: 500px;
	text-align: center;
	margin: 0 auto;
}

#productNav a {
	display: inline-block;
	padding: 3px 5px;
	margin-right: 10px;
	font-family: Tahoma;
	background: #ffffff;
	color: #000;
	text-decoration: none;
	position: relative;
}

#productNav a.active {
	background: #333;
	color: #fff;
}
</style>

<style>
/* 모달 스타일 */
.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(157, 157, 157, 0.5);
}

/* 모달 내용 스타일 */
.modal-content {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 5%;
	border: 1px solid #888;
	width: 60%;
	margin-left: 20%;
	/* 왼쪽 여백을 추가하여 오른쪽으로 이동 */
	box-shadow: 0 4px 8px 0 rgb(146, 145, 145), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
	animation-name: animatetop;
	animation-duration: 0.4s;
}

/* 애니메이션 효과 */
@
keyframes animatetop {from { top:-300px;
	opacity: 0
}

to {
	top: 0;
	opacity: 1
}

}

/* 닫기 버튼 스타일 */
.close {
	color: #000000;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.close {
	color: #000000;
	font-size: 28px;
	font-weight: bold;
	position: absolute;
	top: 0;
	right: 0;
	padding: 10px;
}

.productName:hover {
	cursor: pointer;
	text-decoration: underline;
	color: rgb(4, 184, 255);
}
</style>

<style>
#products th, #products td {
	width: 25%; /* 각 열의 너비를 25%로 설정합니다. */
}

.swal-text {
	color: black;
}

.table-wrapper{
	color: black;
}
</style>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>

<body>
	<!-- =======로딩======== -->
	<div class="preloader">
		<div class="lds-ripple">
			<div class="lds-pos"></div>
			<div class="lds-pos"></div>
		</div>
	</div>
	<!-- =========테마 색상========== -->
	<div id="main-wrapper" data-theme="light" data-layout="vertical"
		data-navbarbg="skin6" data-sidebartype="full"
		data-sidebar-position="fixed" data-header-position="fixed"
		data-boxed-layout="full">
		<!-- ==========사이드바============= -->
		<common:adminTopBar />
		<!-- =======사이드바======== -->
		<common:adminSideBar />


		<div class="page-wrapper">
			<div class="page-breadcrumb">
				<div class="row">
					<div class="col-7 align-self-center"></div>
				</div>
			</div>
			<div class="container-fluid">
				<!-- 페이지 시작 -->
				<div class="row">
					<div class="col-12">
						<div class="card" style="width: 100%">
							<div class="card-body" style="width: 100%">
								<h1 class="card-title">주문관리</h1>
								<br>
								<div class="row">
									<form style="width: 100%" action="" method="POST">
										<div class="col-12">
											<div class="card">
												<div class="card-body" style="width: 100%">
													<div class="table-responsive">

														<div class='cur-row' style="color: #000000">
															<div>주문상태</div>
															<div class="col-md-8" id="hi">
																<select class="custom-select mr-sm-2" id="serialStatus"
																	name="serialStatus" style="color: black; width: 30%">
																	<option value="">전체</option>
																	<option value="receipt">주문접수</option>
																	<option value="finish">배송완료</option>
																</select>
															</div>


														</div>
														<br>
														<div class='cur-row' style="color: #000000;">
															<div>회원이름</div>
															<div class="col-md-3">
																<input type="text" class="form-control"
																	placeholder="ex) 홍길동" id="memberName" name="memberName"
																	style="width: 70%">
															</div>

															<div>주문날짜</div>
															<div class="col-md-3">
																<input type="date" class="form-control"
																	style="width: 120%" id="serialRegdate"
																	name="serialRegdate">
															</div>

														</div>
														<br>
													</div>
												</div>
											</div>
											<div class="row"></div>

											<div class="row justify-content-center">
												<div class="col-md-6 text-center">
													<button type="button" class="btn btn-primary" id="search">
														<i
															class=" fas
                                                    fa-check"></i>
														검색
													</button>
												</div>
											</div>


											<!-- 필터검색 -->
											<script>
											$(document).on("click", "#search", function() {
												console.log('들어옴')
												var selectElement = document.getElementById("serialStatus"); // select 요소 가져오기
												
												var serialStatus = selectElement.options[selectElement.selectedIndex].value; // 선택된 option의 값 가져오기
												
												console.log('로그 [' + serialStatus + ']');
												var memberName = document.getElementById("memberName").value;
												
												console.log('로그1'+memberName);
												
												var serialRegdate= document.getElementById("serialRegdate").value;
												//memberId의 위에서 value를 가져온다.
												console.log('로그	2'+serialRegdate);
												
												$.ajax({
													
													type: "POST",
													url: "searchSerial",
													data: {
                                                        'serialStatus': serialStatus,
                                                        'memberName': memberName,
                                                       'serialRegdate': serialRegdate
                                                        
                                                    },
                                                    
                                                    dataType: 'json',
                                                    	
                                                    	success:function(datas) {
                                                    		console.log('콘솔 ['+datas +']');
                                                    	    var tableHTML = "<table id='products' border='1'>";
                                                    	    tableHTML += "<thead><tr><th>주문번호</th><th>주문날짜</th><th>주문자</th><th>상품명</th><th>총결제금액</th><th>주문상태</th><th>배송지</th></tr></thead>";
                                                    	    tableHTML += "<tbody>";
                                                    	    for (var i = 0; i < datas.length; i++) {
                                                    	        tableHTML += "<tr>";
                                                    	        tableHTML += "<td class=\"productName\" id=\"" + datas[i].serialPK + "\">" + datas[i].serialPK + "</td>";
                                                    	        tableHTML += "<td class=\"productName\" id=\"" + datas[i].serialPK + "\">" + datas[i].serialRegdate + "</td>";
                                                    	        tableHTML += "<td class=\"productName\" id=\"" + datas[i].serialPK + "\">" + datas[i].memberName + "</td>";
                                                    	        tableHTML += "<td class=\"productName\" id=\"" + datas[i].serialPK + "\">" + datas[i].productName + "외"+ datas[i].buyProductCnt+"개"+"</td>";
                                                    	        tableHTML += "<td class=\"productName\" id=\"" + datas[i].serialPK + "\">" + datas[i].totalPrice + "</td>";
                                                    	        tableHTML += "<td><select class=\"custom-select mr-sm-2 serialStatus\" style=\"color: #000000;\" id=\"" + datas[i].serialPK + "\">";
                                                    	        tableHTML += "<option value=\"receipt\" " + (datas[i].serialStatus === 'receipt' ? 'selected' : '') + ">접수</option>";
                                                    	        tableHTML += "<option value=\"finish\" " + (datas[i].serialStatus === 'finish' ? 'selected' : '') + ">완료</option>";
                                                    	        tableHTML += "</select></td>";
                                                    	        tableHTML += "<td class=\"productName\" id=\"" + datas[i].serialPK + "\">" + datas[i].serialDeliveryAddress + "</td>";
                                                    	        tableHTML += "</tr>";
                                                    	    }

                                                    	    
                                                    	    tableHTML += "</tbody></table>";
                                                    	    $("#products").html(tableHTML);
                                                    	   
                                                    	    tableHTML += "</tbody></table>";
                                                    	    $("#products").html(tableHTML);
                                                    	    
                                                    	    $("#productNav").remove();
                                                    	    
                                                    	    // 검색 후 페이징 처리 함수 호출
                                                            var rowPerPage = 10;
                                                            var $products = $('#products');
                                                            if ($products.length) {
                                                                createPagination($products, 'productNav', rowPerPage);
                                                            }
                                                    	    
                                                    },
                                                    error: function (error) {
                                                    	
                                                        console.log('에러의 종류:' + error)
                                                    }
												});
												
											
											});
											
											
											</script>
										</div>

										<br>
										<div class="table-wrapper">
											<table id="products" border="1">

												<thead>
													<tr style="color: #000000; width: 100%">
														<th>주문번호</th>
														<th>주문날짜</th>
														<th>주문자</th>
														<th>상품명</th>
														<th>총결제금액</th>
														<th>주문상태</th>
														<th>배송지</th>
													</tr>
												</thead>
												<tbody>

													<!-- tr이 반복됨-그 tr에 id=${productpd} -->
													<script>console.log('값이 들어온다.');</script>
													<!-- <script>console.log(`${serialPK}`);</script> -->
													<c:forEach var="data" items="${serialDatas}">

														<tr style="color: #000000;">
															<td class="productName" id="${data.serialPK}">${data.serialPK}</td>
															<td class="productName" id="${data.serialPK}">${data.serialRegdate}</td>
															<td class="productName" id="${data.serialPK}">${data.memberName}</td>
															<td class="productName" id="${data.serialPK}">${data.productName}외${data.buyProductCnt}개</td>
															<td class="productName" id="${data.serialPK}">${data.totalPrice}</td>
															<td><select class="custom-select mr-sm-2 serialStatus" style="color: #000000;" id="${data.serialPK}">
                <option value="receipt" ${data.serialStatus == 'receipt' ? 'selected' : ''}>접수</option>
                <option value="finish" ${data.serialStatus == 'finish' ? 'selected' : ''}>완료</option>
            </select></td>
															<td class="productName" id="${data.serialPK}">${data.serialDeliveryAddress}</td>
														</tr>
													</c:forEach>
												</tbody>

											</table>
		
											<script>
                                            var option = document.querySelector('option');
                                            var serialStatus = option.dataset.serialStatus;
                                            
                                            </script>


											<!-- <div id="productNav"></div> -->


											<!-- 모달 -->
											<div id="myModal" class="modal">
												<!-- 모달 내용 -->
												<div class="modal-content" style="color: black;">
													<span class="close">&times;</span>
													<p id="productNameModal">
													<div style="font-size: 30px; white-space: nowrap;">
														주문자: <span id="modalMemberName"></span>
													</div>

													<div style="font-size: 30px; white-space: nowrap;">
														주문날짜: <span id="modalMemberDate"></span>
													</div>

													<br>

													<table id="productsTable" border="1" style="width: 100%;">



														<!--  <tr id="productTable" style="width: 25%;"> -->
														<!--  <td id="productName"></td>
                                                                        <td style="width: 70%;" id="regdate"></td>
                                                                        <td id="member"></td>
                                                                         <td id="totalprice"></td> -->
														<!-- </tr> -->
														<tr>


														</tr>
														<tr>


														</tr>
													</table>
													</p>
													<!-- 상품명을 보여줄 요소 -->
												</div>
											</div>

											<script>
                                               
                                           			 // 상품명이 클릭되었을 때 모달을 표시하는 함수
                                                    $(document).on('click','.productName', function () {
                                                        var serialPK = $(this).prop('id');
                                                        var modal = document.getElementById("myModal");
                                                        var productNameModal = document.getElementById("productNameModal");
                                                        console.log('serialPK 들어옴 :'+serialPK);
                                                        
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "getOrderList",
                                                            data: {
                                                                'serialPK': serialPK
                                                            },
                                                            dataType: 'json',
                                                            success: function(data) {
                                                                console.log(data);
                                                                
                                                                $('#modalMemberName').text(data[0].memberName);
                                                                $('#modalMemberDate').text(data[0].serialRegdate);

                                                                var totalPriceSum = 0; // 총 금액을 누적하여 저장할 변수 선언
                                                                var tableHTML = `<tr style="color: #000000;">
                                                                <th style="width: 25%;">상품명</th>
                                                                <th style="width: 25%;">수량</th>
                                                                <th style="width: 25%;">금액</th>
                                                           </tr> `; // 테이블의 HTML 코드를 저장할 변수 선언
																
                                                                
                                                                // 각 행의 데이터를 테이블에 추가
                                                                for (var i = 0; i < data.length; i++) {
                                                                    tableHTML += "<tr>"; // 새로운 <tr> 생성
                                                                    console.log('data' + data);
                                                                    tableHTML += "<td>" + data[i].productName + "</td>";
                                                                    tableHTML += "<td>" + data[i].buyProductCnt+"개" + "</td>";
                                                                    tableHTML += "<td>" + data[i].totalPrice +"원" + "</td>";
                                                                    tableHTML += "</tr>"; // <tr> 닫기

                                                                    // totalPrice 값을 누적하여 더함
                                                                    totalPriceSum += parseInt(data[i].totalPrice);
                                                                }

                                                                // 총 금액을 하나의 행으로 표시
                                                                tableHTML += "<tr>";
                                                                tableHTML += "<td colspan='2'style='font-weight: bold; background-color: #f2f2f2;'>총 금액 </td>";
                                                                tableHTML += "<td>" + totalPriceSum +"원" + "</td>";
                                                                tableHTML += "</tr>";

                                                                // 테이블에 HTML 코드 추가
                                                                $("#productsTable").append(tableHTML);

                                                                modal.style.display = "block"; // 모달 표시
                                                            },

                                                            error: function (error) {
                                                            	
                                                            	console.log('테이블 에러');
                                                            	
                                                                console.log('에러의 종류:' + error)
                                                            }


                                                        });
                                                        
                                                      
                                                    });
                                                


                                                // 모달 닫기 버튼에 이벤트 바인딩
                                                document.querySelector('.close').addEventListener('click', function () {
                                                    var modal = document.getElementById("myModal");
                                                    modal.style.display = "none"; // 모달 숨김
                                                    $("#productsTable").empty();
                                                });

                                                // 모달 영역 밖을 클릭하면 모달 닫기
                                                window.onclick = function (event) {
                                                    var modal = document.getElementById("myModal");
                                                    if (event.target === modal) {
                                                        modal.style.display = "none"; // 모달 숨김
                                                        $("#productsTable").empty();
                                                    }
                                                }
                                            </script>


											<!-- 배송완료 누르면 값 전달 -->
											<script>
		$(document).on('change', '.serialStatus', function() {
        //console.log("주문상태 선택");
		
        
        	
        var self = this;
        // 사용자가 선택된 값 가져오기
        var selectedStatus = $(self).val();
        
        var serialPK = $(self).attr('id');

        // 이벤트 핸들러 일시적으로 해제
        $('#serialStatus').unbind('change');

        $.ajax({
            type: "POST",
            url: "/serialStatus",
            data: {
                'serialStatus': selectedStatus, // 변수명 수정
                'serialPK': serialPK
            },
            dataType: 'text',

            success: function(datas) {
                swal("주문상태가 변경되었습니다.");
                console.log('콘솔' + datas);
                console.log('serialPK : ' +  serialPK );
            },
            
            error: function(error) {
                console.log('serialPK' + `${serialDTO.serialPK}`);
                console.log('에러의 종류:' + error);
            }
        });
    });
</script>


										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

	<!-- ============================================================== -->
	<!-- footer -->
	<footer class="footer text-center text-muted">
		Web Wevers <a href="http://koreaitsecurity.net/">WebWevers</a>
	</footer>
	<!-- End footer -->
	<!-- ============================================================== -->
	<!-- All Jquery -->
	<script src="/admin/assets/libs/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap tether Core JavaScript -->
	<script src="/admin/assets/libs/popper.js/dist/umd/popper.min.js"></script>
	<script src="/admin/assets/libs/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- apps -->
	<!-- apps -->
	<script src="/admin/dist/js/app-style-switcher.js"></script>
	<script src="/admin/dist/js/feather.min.js"></script>
	<!-- slimscrollbar scrollbar JavaScript -->
	<script
		src="/admin/assets/libs/perfect-scrollbar/dist/perfect-scrollbar.jquery.min.js"></script>
	<script src="/admin/assets/extra-libs/sparkline/sparkline.js"></script>
	<!--Wave Effects -->
	<!-- themejs -->
	<!--Menu sidebar -->
	<script src="/admin/dist/js/sidebarmenu.js"></script>
	<!--Custom JavaScript -->
	<script src="/admin/dist/js/custom.min.js"></script>
	<!--This page plugins -->
	<script
		src="/admin/assets/extra-libs/datatables.net/js/jquery.dataTables.min.js"></script>
	<script src="/admin/dist/js/pages/datatable/datatable-basic.init.js"></script>
	<!-- 페이징처리 -->
	<script src="/admin/dist/js/tablePage.js"></script>
</body>
</html>