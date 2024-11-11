<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<body>
	<div class="container-lg px-4">
		<div class="row">
			<div class="col-12">
				<div class="card mb-4">
					<div class="card-body">
						<form class="row g-3 needs-validation" id="fm1" novalidate>
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
							<div class="headerClass">
								<h5 class="text-3xl font-semibold text-gray-800 mb-6">품목 등록</h5>
							</div>
<!-- 							<div class="col-md-6"> -->
<!-- 								<label for="item_num" class="form-label"> 품목 코드 </label>  -->
<!-- 								<input type="text" class="form-control" id="item_num" readonly> -->
<!-- 							</div> -->
							<div class="col-md-3">
								<label for="item_name" class="form-label"> 제품명 * </label> 
								<input type="text" class="form-control" id="item_name" name="item_name"required>
								<div class="invalid-feedback"> 제품명을 입력하세요 </div>
							</div>
							<div class="col-md-3">
								<label for="item_cate_code" class="form-label"> 대분류 제품 유형 * </label>
								<div>
								<select class="form-select" id="m_cate_item_code" name="m_cate_item_code" aria-label="Default select example" required>
									<option value="0"> 제품 유형을 선택하세요 </option>
									<option value="IT" id="m_cate_item_code"> 상의 </option>
									<option value="IB" id="m_cate_item_code"> 하의 </option>
									<option value="IO" id="m_cate_item_code"> 아우터 </option>
									<option value="IS" id="m_cate_item_code"> 원피스/스커트 </option>
								</select>
								</div>
								<div class="invalid-feedback" >제품 유형을 선택하세요 </div>
							</div>
							<div class="col-md-3">
								<label for="item_cate_code" class="form-label"> 소분류 제품 유형 * </label>
								<div>
								<select class="form-select" id="item_cate_code" name="item_cate_code" aria-label="Default select example" required>
									<option value="0"> 소분류 제품 유형을 선택하세요 </option>
								</select>
								</div>
								<div class="invalid-feedback" > 소분류 제품 유형을 선택하세요 </div>
							</div>
							<div class="col-md-3">
								<label for="validationCustom03" class="form-label">거래처 코드 * </label>
									<input type="text" class="form-control" id="validationCustom03" 
										   data-coreui-toggle="modal" data-coreui-target="#exampleModal1" name="item_cli_code"required>
								<div class="invalid-feedback">거래처를 입력해주세요</div>
							</div>
							<div class="col-md-3">
								<label for="validationCustom04" class="form-label">거래처 명 * </label>
									<input type="text" class="form-control" id="validationCustom04" 
										   data-coreui-toggle="modal" data-coreui-target="#exampleModal1" required>
								<div class="invalid-feedback">거래처를 입력해주세요</div>
							</div>
							<div class="col-md-3">
								<label for="item_mat" class="form-label"> 재질 </label> 
								<input type="text" class="form-control" id="item_mat" name="item_mat">
							</div>
							<div class="col-md-3">
								<label for="item_size" class="form-label"> 규격 </label> 
								<input type="text" class="form-control" id="item_size">
							</div>
							<div class="col-md-2">
								<label for="item_price" class="form-label"> 매입 단가 * </label> 
								<input type="number" class="form-control" id="item_purchase_price" name="item_purchase_price" placeholder="ex) 1000" required>
								<div class="invalid-feedback" >매입 단가를 입력하세요 </div>
							</div>
							<div class="col-md-1" id="money" >
								원
							</div>
							<div class="col-md-2">
								<label for="item_sale_price" class="form-label"> 매출 단가 * </label> 
								<input type="number" class="form-control" id="item_sale_price" name="item_sale_price" placeholder="ex) 10000" required>
								<div class="invalid-feedback" >매출 단가를 입력하세요 </div>
							</div>
							<div class="col-md-1" id="money">
								원
							</div>
<!-- 							<div class="col-md-3"> -->
<!-- 								<label for="item_inven_qty" class="form-label"> 현재고 </label>  -->
<!-- 								<input type="number" class="form-control" id="item_inven_qty"> -->
<!-- 							</div> -->
							<div class="col-md-6">
								<label for="item_comm" class="form-label"> 비고 </label> 
								<input type="text" class="form-control" id="comm" name="comm">
							</div>
							<div class="flex gap-2">
								<button type="submit" id="submitFormBtn" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded flex items-center" >등록</button>
							</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

		<!-- Modal1 -->
		<div class="modal fade" id="exampleModal1" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-scrollable">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">거래처</h5>
						<button type="button" class="btn-close"
							data-coreui-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<table class="table table-hover" id="modal1-table">
							<thead class="table-light">
								<tr>
									<th scope="col"></th>
									<th scope="col">거래처 코드</th>
									<th scope="col">거래처 명</th>
								</tr>
							</thead>
							<tbody>
								
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>



<style>
#money {
	padding-top: 45px;
}
.text-right {
    text-align: right;
    padding-right: 150px;
    padding-bottom: 30px;
}
</style>
							
<!-- <script src="path/to/bootstrap.bundle.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
const token = $("meta[name='_csrf']").attr("content")
const header = $("meta[name='_csrf_header']").attr("content");
const name = $("#userName").val();
   
document.addEventListener('DOMContentLoaded', function() {
      
       const submitFormBtn = document.getElementById('submitFormBtn');
       const productTypeSelect = document.getElementById('m_cate_item_code');
       const subProductTypeSelect = document.getElementById('item_cate_code');
       const itemPriceInput = document.getElementById('item_purchase_price');
       const itemPriceInput2 = document.getElementById('item_sale_price');

       const subCategories = {
           'IT': [
               { value: 'ITA', text: '반소매 티셔츠' },
               { value: 'ITB', text: '긴소매 티셔츠' },
               { value: 'ITC', text: '민소매 티셔츠' },
               { value: 'ITD', text: '셔츠/블라우스' },
               { value: 'ITE', text: '후드 티셔츠' },
               { value: 'ITF', text: '맨투맨' },
               { value: 'ITG', text: '니트/스웨터' }
           ],
           'IB': [
               { value: 'IBA', text: '데님 팬츠' },
               { value: 'IBB', text: '코튼 팬츠' },
               { value: 'IBC', text: '슬랙스' },
               { value: 'IBD', text: '트레이닝 팬츠' },
               { value: 'IBE', text: '숏팬츠' },
               { value: 'IBF', text: '레깅스' }
           ],
           'IO': [
               { value: 'IOA', text: '후드집업' },
               { value: 'IOB', text: '레더 자켓' },
               { value: 'IOC', text: '블레이저 자켓' },
               { value: 'IOD', text: '블루종' },
               { value: 'IOE', text: '가디건' },
               { value: 'IOF', text: '아노락' },
               { value: 'IOG', text: '코트' }
           ],
           'IS': [
               { value: 'ISA', text: '미니 원피스' },
               { value: 'ISB', text: '미디 원피스' },
               { value: 'ISC',  text: '롱 원피스' },
               { value: 'ISD', text: '미니 스커트' },
               { value: 'ISE', text: '미디 스커트' },
               { value: 'ISF', text: '롱 스커트' }
           ]
       };

       productTypeSelect.addEventListener('change', function() {
           const selectedCategory = this.value;
           subProductTypeSelect.innerHTML = '<option value="0"> 소분류 제품 유형을 선택하세요 </option>'; // 초기화

           if (selectedCategory in subCategories) {
               subCategories[selectedCategory].forEach(function(subCategory) {
                   const option = document.createElement('option');
                   option.value = subCategory.value;
                   option.text = subCategory.text;
                   subProductTypeSelect.appendChild(option);
               });
           }

           // 유효성 상태 초기화
           subProductTypeSelect.setCustomValidity("");
       });
       
       
       submitFormBtn.addEventListener('click', function(event) {
         event.preventDefault(); // 기본 제출 동작 방지
   
         // 필요한 유효성 검사를 적용할 모든 폼을 가져오기
         const forms = document.querySelectorAll('.needs-validation');
         
         // NodeList를 배열로 변환하고 각각의 폼에 대해 처리
         Array.from(forms).forEach(form => {
            // 유효성 검사 통과 여부 확인
            if (!form.checkValidity()) {
              event.stopPropagation(); // 상위 요소로 이벤트 전파 방지
            }
            
            // Bootstrap의 'was-validated' 클래스 추가
            form.classList.add('was-validated');
            
            // 모든 유효성 검사가 통과되었을 경우에만 폼 데이터 전송
            if (document.querySelector('.was-validated:invalid') === null) {
            	
                // 폼 데이터 수집
                const formData = new FormData(form);
                const data = Object.fromEntries(formData.entries());
                
                $.ajax({
                    url: '/basicInfo/itemInsert',
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader(header, token);
                     },
                    type: 'POST',
                    data:$("#fm1").serialize(),
                    success: function(result) {
                            alert('등록되었습니다');
                            
                            form.reset();
                            window.location.href = '/basicInfo/itemList';
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.error('AJAX Error:', textStatus, errorThrown);
                        console.log('Response Text:', jqXHR.responseText);
                        console.log('Status Code:', jqXHR.status);
                        alert('An error occurred while submitting the form. Check console for details.');
                    }
                });
            }
        }); 
       
       });

      // 제품 유형 선택 확인
         if (productTypeSelect.value === "0" && subProductTypeSelect.value !== "0") {
             productTypeSelect.setCustomValidity("제품 유형을 선택하세요");
         } else {
             productTypeSelect.setCustomValidity("");
         }
         productTypeSelect.reportValidity();
       
    // 선택 변경 시 유효성 상태 초기화
       productTypeSelect.addEventListener('change', function() {
           this.setCustomValidity("");
       });
    
    // 매입 단가 음수 입력 불가
       itemPriceInput.addEventListener('input', function() {
           if (this.value < 0) {
               this.value = '';
               this.setCustomValidity('매입 단가는 음수가 될 수 없습니다');
           } else {
               this.setCustomValidity('');
           }
           this.reportValidity();
       });
    
    // 매출 단가 음수 입력 불가
       itemPriceInput2.addEventListener('input', function() {
           if (this.value < 0) {
               this.value = '';
               this.setCustomValidity('매출 단가는 음수가 될 수 없습니다');
           } else {
               this.setCustomValidity('');
           }
           this.reportValidity();
       });
       
       getClientList();
       
       function getClientList() {
          
           $('#modal1-table tbody tr').remove();
           
           // 품목 등록시에는 협력사만 출력되도록 해야 함
           const cli_cate = "CLPT"; 
           
           $.ajax({
               url: "/common/clientList2",
               type: "get",
               data: {cli_cate: cli_cate},
               contentType: 'application/json; charset=utf-8',
               dataType: "json",
               success: function(data) {
                   // body 태그에 내용 추가
                   console.log(data);
                   data.forEach(function(item, idx){
                      console.log(idx);
                      var row = "<tr><th scope='row'>" + (parseInt(idx)+1) + "</th><td>" + item.cli_num + "</td><td>" + item.cli_name + "</td></tr>"
                       $('#modal1-table tbody').append(row);
                   });
                   
               },
               error: function(jqXHR, textStatus, errorThrown) {
                   console.log("AJAX 요청 실패: " + jqXHR.status + ", " + jqXHR.statusText + ", " + textStatus + ", " + errorThrown);
                   alert("AJAX 요청 실패!");
               }
           });
       }
       

      $('#modal1-table tbody').on('click', 'tr', function() {
          var targetInput1 = document.getElementById('validationCustom03');
          var targetInput2 = document.getElementById('validationCustom04');
          var cliNum1 = $(this).find('td:nth-child(2)').text(); // 두 번째 열(거래처 코드)
          var cliNum2 = $(this).find('td:nth-child(3)').text(); // 두 번째 열(거래처 코드)

          // Modal에서 입력된 값을 가져와서 다른 input 요소에 설정
          targetInput1.value = cliNum1;
          targetInput2.value = cliNum2;
      
          // Modal 닫기 (Optional)
          var modal = document.getElementById('exampleModal1');
          var modalInstance = coreui.Modal.getInstance(modal);
          modalInstance.hide();
      });
   });	
   
</script>
<%@ include file="../include/footer.jsp" %>

</body>
</html>