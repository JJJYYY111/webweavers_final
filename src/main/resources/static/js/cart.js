/**
 * 장바구니 cart 관련 js파일 
 * <pre>
 * <b>History:</b>
 *    작성자, 1.0, 216.1.3 최초작성
 * </pre>
 *
 * @author 천지성
 * @version 1.0, 216.1.3 소스 수정
 * @see    None
 */


/*  장바구니안에서 개수 및 가격 변경 */
/**
 * updateQuantity 함수: 제품 수량을 업데이트하고, 서버에 업데이트 요청을 보냄
 * Parameters:
 * 
 * ppk: 제품 고유 식별자
 * updown: '1'일 경우 수량 증가, '0'일 경우 수량 감소
 * price: 제품 가격
 * 
 */
function updateQuantity(ppk, updown, price) {
    // 해당 제품의 수량 입력 필드와 총 가격 표시 영역을 jQuery로 선택함
    var result = $('#qty_' + ppk);
    var sumPrice = $('#total_' + ppk);

    // 현재 수량과 총 가격을 가져옴
    var qty = result.val();
    var total = parseInt(price) * parseInt(qty);

    // 수량이 이미 1이고 감소 버튼이 클릭된 경우
    if (updown === '0' && parseInt(qty) <= 1) {
        return; // 더 이상 수량을 감소하지 않음
    }
		console.log(qty);
		
    // jQuery를 사용하여 AJAX POST 요청을 보냄
    $.ajax({
        url: 'async/cartUpdate',
        type: 'POST',
        data: {
            productPK: ppk,
            cartCnt: (updown == 1 ? parseInt(qty)+1 : parseInt(qty)-1)
        },
        success: function(data) {
			console.log(qty);
            // 성공적으로 처리된 경우에는 클라이언트 측에서 수량을 업데이트함
            if (data == 'true' && updown == 1) {
                result.val(parseInt(qty) + 1);
            } else if(data == 'true' && updown == 0) {
                result.val(parseInt(qty) - 1);
            }

            // 총 가격을 계산하고 화면에 업데이트함
            total = parseInt(price) * parseInt(result.val());
			// 숫자 현지화 메서드 사용
			formattedPrice = total.toLocaleString();
            sumPrice.text(formattedPrice);

            // 수정: 수량이 변경될 때마다 전체 소계를 업데이트함
            updateSubtotal();
        },
        error: function() {
            // 에러 처리 로직을 추가할 수 있음
        }
    });
}

// 체크 박스 클릭시 해당 상품 총합 추가
$(document).on('change', 'input[name="selectedProducts"]', function() {
    // 체크된 상품의 가격을 기반으로 전체 소계를 업데이트함
    updateSubtotal();
});

// 전체 선택 및 해제 버튼에 이벤트 추가
$('#selectAllCheckbox').change(function() {
    selectAllProduct(); // 전체 선택 함수 호출
});


$(document).ready(function() {
    // 페이지 로드 시에도 총 가격을 초기화하기 위해 updateSubtotal 함수 호출
    updateSubtotal();
});

// updateSubtotal 함수: 장바구니의 전체 소계를 업데이트함
function updateSubtotal() {
    var total = 0;

    // 모든 체크된 상품 행을 선택함
    var checkedProducts = document.querySelectorAll('input[name="selectedProducts"]:checked');

    // 각 체크된 상품의 가격을 합산함
    checkedProducts.forEach((checkbox) => {
        var productRow = checkbox.closest('tr'); // 상품 행 가져옴
        var productPriceElement = productRow.querySelector('.productPrice'); // 상품 가격 요소 가져옴
        var productPrice = priceStrToInt(productPriceElement.textContent); // 상품 가격을 숫자로 변환하여 가져옴
        total += productPrice; // 총 가격에 상품 가격 추가
    });

    // 숫자를 통화 형식으로 변환하여 총 가격을 표시함
    var formattedPrice = total.toLocaleString();
    $('#cartTotalPrice').text(formattedPrice); // jQuery를 사용하여 화면에 전체 소계를 업데이트 함
    
}



/* 장바구니 추가 */
// addToCart 함수: 장바구니에 제품 추가하는 함수
function addToCart() {
    // getProductPPK 함수를 통해 동적으로 설정된 데이터 속성 'data-ppk' 값을 가져옴
    var ppk = getProductPPK();  

    // 수량 입력값 가져오기
    var quantity = document.getElementById('sst').value;

    // AJAX를 사용하여 서버에 데이터 전송
    var data = {
        productPK: ppk,
        cartCnt: quantity
    };

    $.ajax({
        type: 'POST',
        url: 'async/cartInsert',  
        data: data,
        success: function(data) {
            // 서버 응답에 따라 알림 표시
            if (data == "true") {
               /* alert('상품이 장바구니에 추가되었습니다.');*/
               Swal.fire({
						hideClass : {
						  popup : 'animate__animated animate__fadeOut animate__faster'
						},
					  title: "장바구니 추가 완료",
					  imageUrl: "resources/img/cart.png",
					  imageWidth: 100,
					  imageHeight: 100,
					  imageAlt: "Custom image",
					  showConfirmButton : false,
					  width : "20%",
					  timer : "1000"
					});
            } else {
				if(sessionStorage.getItem("sessionMid") == null){
					alert('로그인을 해야 사용가능합니다.');
				}
				else{
                	alert('장바구니 추가에 실패했습니다.');
				}
            }
        },
        error: function() {
            alert('AJAX 요청 실패');
        }
    });
}

// getProductPPK 함수: HTML에서 설정한 데이터 속성 'data-ppk' 값을 읽어오는 함수
function getProductPPK() {
    // HTML에서 설정한 데이터 속성을 읽어옴
    var ppk = document.querySelector('.product_image_area').getAttribute('data-ppk');
    return ppk;
}

function selectedDelete(){
	document.cartForm.action = "cartDeleteSelected";
	console.log(document.cartForm.action);
}

//--------구매버튼 클릭시 체크박스 확인 -----
const submitCheck = document.getElementById('cartForm');
if(submitCheck != null){
submitCheck.addEventListener("submit", (event) => {
    var checkFlag = false; // 기본값 false
    const checkboxes = document.querySelectorAll('input[name="selectedProducts"]');
    
    checkboxes.forEach((checkbox) => {
        if (checkbox.checked) {
            checkFlag = true;
        }
    });
    if (!checkFlag) {
        alert("상품을 선택해주세요!");
        event.preventDefault(); // 폼 제출 기본 동작 막음
    }
});	
}

 //-------- 전체선택,해제 선택 버튼 코드----
 
function selectAllProduct() {
    // 선택된 모든 제품 체크박스 가져오기
    const checkboxes = document.querySelectorAll('input[name="selectedProducts"]');
    
    // 하나라도 체크된 체크박스가 있는지 확인하기 위한 변수
    let anyChecked = false;

    // 모든 체크박스를 확인하여 하나라도 체크된 체크박스가 있는지 확인
    checkboxes.forEach((checkbox) => {
        if (checkbox.checked) {
            anyChecked = true;
            return; // 체크된 체크박스가 있으면 반복문 종료
        }
    });

    // 하나라도 체크된 체크박스가 있는 경우 모든 체크박스 해제, 그렇지 않으면 모든 체크박스 선택
    checkboxes.forEach((checkbox) => {
        checkbox.checked = !anyChecked;
    });
    
    // 변경된 체크박스 상태를 확인하고 총 가격 업데이트
    updateSubtotal();
}


