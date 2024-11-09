<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<style>
.text-right {
    text-align: right;
    padding-right: 150px;
    padding-bottom: 30px;
}

</style>


<body>

	<div class="container-lg px-4">
		<div class="row">
			<div class="col-12">
				<div class="card mb-4">
					<div class="card-body">
						<form class="row g-3 needs-validation" id="fm1" novalidate>
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
							<div>
								<h5 class="text-3xl font-semibold text-gray-800 mb-6">거래처 등록</h5>
							</div>
<!-- 							<div class="col-md-6"> -->
<!-- 								<label for="cli_num" class="form-label"> 거래처 코드 </label>  -->
<!-- 								<input type="text" class="form-control" id="cli_num" readonly> -->
<!-- 							</div> -->
							<div class="col-md-3">
								<label for="cli_name" class="form-label"> 거래처명 </label> 
								<input type="text" class="form-control" id="cli_name" name="cli_name" required>
								<div class="invalid-feedback" >거래처명을 입력하세요 </div>
							</div>
							<div class="col-md-3">
								<label for="cli_cate" class="form-label"> 거래처 구분 </label>
								<div>
								<input type="radio" id="cli_cateCu" name="cli_cate" value="CLCU" required>
								<label for="cli_cateCu"> 고객사</label>
								<input type="radio" id="cli_catePt" name="cli_cate" value="CLPT" required> 
								<label for="cli_catePt">협력사</label>
								</div>
								<div class="invalid-feedback">거래처 구분을 선택하세요</div>
							</div>
							<div class="col-md-4">
								<label for="cli_crn" class="form-label"> 사업자 번호 </label> 
								<input type="text" class="form-control" id="cli_crn" name="cli_crn" required>
								<div class="invalid-feedback" > 사업자 번호를 입력하세요</div>
								<div id="cliCrnError" class="text-danger" style="display: none;">숫자만 입력하세요</div>
								<div id="cliCrnDuplicate" class="text-danger" style="display: none;">중복된 사업자입니다</div>
							</div>
							<div class="col-md-2">
								<label class="form-label"> &nbsp;</label>
								<div>
								<button type="button" id="cliCrnBtn" class="bg-gray-400 hover:bg-gray-700 text-white py-2 px-4 rounded flex items-center">중복 확인</button>
								</div>
							</div>
							<div class="col-md-3">
								<label for="cli_ind" class="form-label"> 업종</label> 
								<input type="text" class="form-control" id="cli_ind" name="cli_ind" placeholder="ex) 제조업, 도.소매업" required>
								<div class="invalid-feedback" > 업종을 선택하세요 </div>
							</div>
							<div class="col-md-3">
								<label for="cli_name" class="form-label"> 대표자 </label> 
								<input type="text" class="form-control" id="cli_rep" name="cli_rep" required>
								<div class="invalid-feedback" > 대표자를 입력하세요 </div>
							</div>
							<div class="col-md-3">
								<label for="validationCustom05" class="form-label">담당자 아이디</label> 
									<input type="text" class="form-control" id="validationCustom05" data-coreui-toggle="modal"
									data-coreui-target="#exampleModal2" name="pic_username" required>
								<div class="invalid-feedback" > 담당자를 입력해주세요 </div>
							</div>
							<div class="col-md-3">
								<label for="validationCustom06" class="form-label">담당자 명</label>
								<input type="text" class="form-control" id="validationCustom06" data-coreui-toggle="modal" data-coreui-target="#exampleModal2"
									required>
								<div class="invalid-feedback" >담당자를 입력해주세요</div>
							</div>
							<div class="col-md-6">
								<label for="cli_tel" class="form-label"> 대표 연락처 </label> 
								<input type="tel" class="form-control" id="cli_tel" name="cli_tel" required>
								<div class="invalid-feedback" > 연락처를 입력하세요</div>
								<div id="cliTelError" class="text-danger" style="display: none;">숫자만 입력하세요</div>
							</div>
							<div class="col-md-6">
								<label for="cli_email" class="form-label"> 이메일 </label> 
								<input type="email" class="form-control" id="cli_email" name="cli_email" placeholder="ex) itwill@google.com" >
							</div>
							<div class="col-md-2">
									<label for="cli_post_code" class="form-label">우편번호</label> 
									<input type="text" class="form-control" id="sample6_postcode" name="cli_postCode" readonly required>
							</div>
							<div class="col-md-2">
								<label class="form-label"> &nbsp;</label>
								<div>
								<input type="button" class="bg-gray-400 hover:bg-gray-700 text-white py-2 px-4 rounded flex items-center"  onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
								</div>
							</div>
							<div class="col-md-3">
								<label for="cli_add1" class="form-label">주소</label>
								<input type="text" class="form-control" id="sample6_address" placeholder="주소" name="cli_add1" required readonly>
							</div>
							<div class="col-md-3">
								<label for="cli_add2" class="form-label">상세 주소</label>
								<input type="text" class="form-control" id="sample6_detailAddress" placeholder="상세주소" name="cli_add2" required >
								<div class="invalid-feedback"  style="display: none;">주소를 입력하세요</div>
							</div>
							<div class="col-md-2">
									<label for="cli_extraAdd" class="form-label"> 참고 항목</label>
									<input type="text" class="form-control" id="sample6_extraAddress" placeholder="참고항목" name="cli_add3"required readonly>
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
<!-- 주소 api -->
	<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>


	
	<!-- 담당자 선택 모달창 -->
		<div class="modal fade" id="exampleModal2" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">담당자</h5>
					<button type="button" class="btn-close" data-coreui-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<table class="table table-hover" id="modal2-table">
						<thead class="table-light">
							<tr>
								<th scope="col"></th>
								<th scope="col">담당자 아이디</th>
								<th scope="col">담당자 명</th>
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


	<!-- <script src="path/to/bootstrap.bundle.min.js"></script> -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<!-- 주소 api -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<script>
	const token = $("meta[name='_csrf']").attr("content")
	   const header = $("meta[name='_csrf_header']").attr("content");
	   const name = $("#userName").val();
	   
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }

 document.addEventListener('DOMContentLoaded', function() {
		event.preventDefault(); // 기본 제출 동작 방지   
	       const submitFormBtn = document.getElementById('submitFormBtn');
	       const cliCateRadios = document.getElementsByName('cli_cate');
	   
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
	                    url: '/basicInfo/clientInsert',
	                    beforeSend: function(xhr) {
	                        xhr.setRequestHeader(header, token);
	                     },
	                    type: 'POST',
	                    data:$("#fm1").serialize(),

	                    success: function(result) {
	                            alert('등록되었습니다');
	                            
	                            form.reset();
	                            window.location.href = '/basicInfo/clientList';
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
	         
	      // 거래처 구분 선택 확인
 	         let cliCateSelected = false;
	         for (let radio of cliCateRadios) {
	           if (radio.checked) {
	             cliCateSelected = true;
	             break;
	           }
	         } 

	         if (!cliCateSelected) {
	           // 선택되지 않았을 경우, 첫 번째 라디오 버튼에 사용자 정의 유효성 메시지 설정
	           cliCateRadios[0].setCustomValidity("거래처 구분을 선택하세요");
	         } else {
	           // 선택되었을 경우, 유효성 메시지 초기화
	           cliCateRadios[0].setCustomValidity("");
	         }
	         cliCateRadios[0].reportValidity();
	       });

	       // 라디오 버튼 선택 변경 시 유효성 상태 초기화
 	       for (let radio of cliCateRadios) {
	         radio.addEventListener('change', function() {
	           cliCateRadios[0].setCustomValidity("");
	         });
	       } 
	       
	   
	       // 담당자 정보 가져오기
	       $('#modal2-table tbody').on('click', 'tr', function() {
	           var targetInput1 = document.getElementById('validationCustom05');
	           var targetInput2 = document.getElementById('validationCustom06');
	           var cliNum1 = $(this).find('td:nth-child(2)').text(); // 두 번째 열(거래처 코드)
	           var cliNum2 = $(this).find('td:nth-child(3)').text(); // 두 번째 열(거래처 코드)

	           // Modal에서 입력된 값을 가져와서 다른 input 요소에 설정
	           targetInput1.value = cliNum1;
	           targetInput2.value = cliNum2;
	       
	           // Modal 닫기 (Optional)
	           var modal = document.getElementById('exampleModal2');
	           var modalInstance = coreui.Modal.getInstance(modal);
	           modalInstance.hide();
	       });
	       
	       
	       // 전화번호 - 숫자만 입력 허용
	       $("#cli_tel").on("input", function() {
	    	   var value = this.value.replace(/[^0-9]/g, '');
 	           const errorMessage = document.getElementById('cliTelError');
               
	    	   if (value !== this.value) {
                   this.value = value;
                   errorMessage.style.display = 'block';
               } else {
            	   errorMessage.style.display = 'none';
               }
               this.reportValidity();
	           
	       });      
	    
	     	$("#cli_crn").on("input", function() {
		    	var value = this.value.replace(/[^0-9]/g, '');
	 	           const errorMessage = document.getElementById('cliCrnError');
	               
		    	   if (value !== this.value) {
	                   this.value = value;
	                   errorMessage.style.display = 'block';
	               } else {
	            	   errorMessage.style.display = 'none';
	               }
	               this.reportValidity();
            });
	     
	       $('#cliCrnBtn').click(function() {
	            var crnValue = $('#cli_crn').val().trim();
	            
	            $('#cliCrnError').hide();

	            // 서버에 중복 확인 요청
	            $.ajax({
	                url: '/basicInfo/check-crn',
	                type: 'GET',
	                data: { cli_crn: crnValue },
	                dataType: 'json',
	                success: function(response) {
	                	//alert('success ' + JSON.stringify(response));
	               
	                    if (response === 1) {
	                    	$('#cliCrnDuplicate').show();
	                    } else {
	                        $('#cliCrnDuplicate').hide();
	                        alert('사용 가능한 사업자 번호입니다.');
	                    }
	                } ,
	                error: function() {
	                    alert('중복 확인 중 오류가 발생했습니다.');
	                }
	            });
	        });
	      
	getManagerList();

	function getManagerList() {
	   
	   	$('#modal2-table tbody tr').remove();
	    
	    $.ajax({
	        url: "/common/managerList",
	        type: "get",
	        contentType: 'application/json; charset=utf-8',
	        dataType: "json",
	        success: function(data) {
	            // body 태그에 내용 추가
	            console.log(data);
	            data.forEach(function(item, idx){
	               console.log(idx);
	               var row = "<tr><th scope='row'>" + (parseInt(idx)+1) + "</th><td>" + item.username + "</td><td>" + item.user_per_name + "</td></tr>"
	                $('#modal2-table tbody').append(row);
	            });
	            
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	            console.log("AJAX 요청 실패: " + jqXHR.status + ", " + jqXHR.statusText + ", " + textStatus + ", " + errorThrown);
	            alert("AJAX 요청 실패!");
	        }
	    });
	}
	
});	
	   
	   

</script>

	<%@ include file="../include/footer.jsp"%>

</body>
</html>