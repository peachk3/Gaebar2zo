<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<head>
<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com"></script>
<!-- Alpine.js -->
    <script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js" defer></script></head>
    <style>
		/* 두 번째 모달이 첫 번째 모달 오른쪽에 위치하도록 설정 */
        .modal.right-modal .modal-dialog {
            position: absolute;
            right: -500px; /* 첫 번째 모달의 오른쪽에 위치하도록 설정 */
            top: 50%;
            transform: translateY(-50%);
        }
        .status-buttons { display: none; }
        .modal-dialog { max-width: 60%; padding: 50px;}
        .search-container { display: flex; margin-bottom: 20px; }
        .search-group { display: flex; align-items: center; }
        .table-container { margin-top: 20px; }
		  .custom-btn {
		    text-align: left; /* 텍스트를 왼쪽으로 정렬합니다 */
		    padding-left: 10px; /* 왼쪽 여백을 추가합니다 */
		    width: 100%; /* 버튼이 부모 요소에 맞게 전체 너비를 가지도록 설정합니다 */
		  }
		  
	</style> 
 
</head>  
   
<body class="bg-gray-100 font-sans">
	<div class="container mx-auto px-4 py-8">
		<div class="bg-white rounded-lg shadow-lg p-6">
			<h1 class="text-3xl font-semibold text-gray-800 mb-6">거래처 관리</h1>
			
				<!-- Search Form -->
                    <form action="/basicInfo/clientList" method="get" class="form-inline mt-3">
  				<div class="flex flex-wrap -mx-3 mb-4 md:flex-nowrap">
					<div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
						<div class="input-group w-500">
							<div class="input-group-prepend">
                                <select class="form-select custom-select-radius custom-select-width" id="searchType" name="searchType">
                                    <option value="" <c:if test="${empty searchType}">selected</c:if>>전체</option>
                                    <option value="code" <c:if test="${searchType eq 'code'}">selected</c:if>>거래처 코드</option>
                                    <option value="name" <c:if test="${searchType eq 'name'}">selected</c:if>>거래처명</option>
                                    <option value="crn" <c:if test="${searchType eq 'crn'}">selected</c:if>>사업자번호</option>
                                    <option value="cate" <c:if test="${searchType eq 'cate'}">selected</c:if>>구분</option>
                                    <option value="ind" <c:if test="${searchType eq 'ind'}">selected</c:if>>업종</option>
                                </select>
                            </div>
                            <input type="text" class="form-control" placeholder="검색어를 입력하세요" name="keyword" value="${keyword}">
                            <button class="btn btn-outline-secondary" type="submit">검색</button>
                        </div>
                       </div>
                </div>
		  </form>

	<div id="tableContainer" class="transition-all duration-300 ease-in-out">
	<div class="overflow-x-hidden bg-white border 1px solid overflow-y-hidden relative" id="dynamicTable">
            	<table class="border-collapse table-auto w-full whitespace-no-wrap bg-white table-hover relative">
      <thead>
         <tr class="text-center">
            <th class="checkbox-column">
                  <input type="checkbox" class="form-check-input focus:outline-none focus:shadow-outline" id="selectAll" onclick = "toggleCheckboxes(this)"> 
            </th>
            <th>거래처 코드</th>
            <th>거래처명</th>
            <th>사업자 등록 번호</th>
            <th>구분</th>
            <th>업종</th>
            <th>주소</th>
            <th>연락처</th>
            <th>이메일</th>
            <th>담당자</th>
         </tr>
      </thead>
      
						<c:set var="cellClass" value="clickable-cell text-gray-700 px-2 py-2 flex items-center" />
						
      <tbody class="bg-white divide-y divide-gray-200">
         <c:forEach var="cli" items="${clientList }">
            <tr class="hover:bg-gray-50">
               <td class="text-center">
                           <input type="checkbox" class="form-check-input rowCheckbox focus:outline-none focus:shadow-outline" value="" id="flexCheckDefault${cli.cli_num}">
                     </td>
                     <td><span class="${cellClass}">${cli.cli_num }</span></td>
                     <td><span class="${cellClass}">${cli.cli_name }</span></td>
                     <td><span class="${cellClass}">${cli.cli_crn }</span></td>
					 <td><span class="${cellClass}">
					 <c:choose>
						<c:when test="${cli.cli_cate == 'CLCU'}"> 고객사</c:when>
						<c:when test="${cli.cli_cate == 'CLPT'}"> 협력사</c:when>
						<c:otherwise>
                   		 ${cli.cli_cate}
                		</c:otherwise>
					</c:choose></span></td>
					<td><span class="${cellClass}">${cli.cli_ind }</span></td>
                     <td><span class="${cellClass}">${cli.cli_add1 }</span></td>
                     <td><span class="${cellClass}">${cli.cli_tel }</span></td>
                     <td><span class="${cellClass}">${cli.cli_email }</span></td>
                     <td><span class="${cellClass}">${cli.pic_username }</span></td>
            </tr>
         </c:forEach>
      </tbody>
   </table>
</div>
</div>



	<div class="px-5 py-5 bg-white border-t flex flex-col xs:flex-row items-center xs:justify-between">
		<c:url var="pageUrl" value="/basicInfo/clientList">
            <c:param name="searchType" value="${searchType}"/>
            <c:param name="keyword" value="${keyword}"/>
        </c:url>

<!--         <nav aria-label="Page navigation" class="pagination-container"> -->
	<nav class="pagination-container" aria-label="Pagination">
            <ul class="pagination justify-content-center">
                <c:if test="${pageVO.prev}">
                    <li class="page-item">
                        <a class="page-link" href="${pageUrl}&page=${pageVO.startPage - 1}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                <c:forEach var="i" begin="${pageVO.startPage}" end="${pageVO.endPage}" step="1">
                    <li class="page-item ${pageVO.cri.page == i ? 'active' : ''}">
                        <a class="page-link" href="${pageUrl}&page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <c:if test="${pageVO.next && pageVO.endPage > 0}">
                    <li class="page-item">
                        <a class="page-link" href="${pageUrl}&page=${pageVO.endPage + 1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
  <!-- 하단버튼 -->
	<div class="flex justify-end items-center px-1 py-0 bg-white">
		<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
			<button type="button" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded flex items-center mr-2" onclick="location.href='/basicInfo/clientAdd'">
	        <span>등록</span>
	        </button>
	        <button type="button" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded flex items-center" id="deleteItemBtn">
	        <span>삭제</span>
	       	</button>
	    </sec:authorize>
    </div>
</div>
</div>

<!-- Modal -->
<!-- <div class="modal fade" id="exampleModalToggle" data-coreui-backdrop="static" data-coreui-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true"> -->
<!--     <div class="modal-dialog modal-lg"> -->
<div class="modal fade" id="exampleModalToggle" data-coreui-backdrop="static" data-coreui-keyboard="false" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
<!--                 <h5 class="modal-title" id="staticBackdropLabel"> 거래처 상세 보기 </h5> -->
                <h5 class="modal-title" id="exampleModalToggleLabel">거래처 상세 보기</h5>
                <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form class="needs-validation" id="fm1" novalidate>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <td><label for="validationCustom01" class="form-label">거래처 코드</label></td>
                                <td><input type="text" class="form-control" id="cli_num" readonly></td>
                            </tr>
                            <tr>
                                <td><label for="validationCustom02" class="form-label">거래처명</label></td>
                                <td><input type="text" class="form-control" id="cli_name" readonly></td>
                            </tr>
                            <tr>
                                <td><label for="cli_cate" class="form-label">거래처 구분</label></td>
                                <td>
                                    <div>
                                        <input type="radio" id="cli_cateCu" name="cli_cate" value="CLCU" disabled>
                                        <label for="cli_cateCu">고객사</label>
                                        <input type="radio" id="cli_catePt" name="cli_cate" value="CLPT" disabled>
                                        <label for="cli_catePt">협력사</label>
                                    </div>
                                    <div class="invalid-feedback">거래처 구분을 선택하세요</div>
                                </td>
                           </tr>
                           <tr>
                                <td><label for="validationCustom03" class="form-label">사업자 등록 번호</label></td>
                                <td><input type="text" class="form-control" id="cli_crn" readonly></td>
                            </tr>
                            <tr>
                                <td><label for="validationCustom03" class="form-label">거래처 업종</label></td>
                                <td><input type="text" class="form-control" id="cli_ind" readonly></td>
                            </tr>
                            <tr>
                                <td><label for="validationCustom03" class="form-label">우편번호</label></td>
                                <td>
                                    <div class="d-flex">
                                        <input type="text" class="form-control" id="sample6_postcode" readonly>
                                        <button type="button" style="border: 1px solid;" id="postCodeButton" onclick="sample6_execDaumPostcode()" disabled>찾기</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><label for="validationCustom03" class="form-label">주소</label></td>
                                <td><input type="text" class="form-control" id="sample6_address" readonly></td>
                            </tr>
                            <tr>    
                                <td><label for="validationCustom03" class="form-label">상세 주소</label></td>
                                <td><input type="text" class="form-control" id="sample6_detailAddress" readonly></td>
                            </tr>
                            <tr>
                                <td><label for="validationCustom03" class="form-label">참고 항목</label></td>
                                <td><input type="text" class="form-control" id="sample6_extraAddress" readonly></td>
                            </tr>
                            <tr>
                                <td><label for="validationCustom03" class="form-label">연락처</label></td>
                                <td><input type="text" class="form-control" id="cli_tel" readonly></td>
                            </tr>
                            <tr>
                                <td><label for="validationCustom03" class="form-label">대표자</label></td>
                                <td><input type="text" class="form-control" id="cli_rep" readonly></td>
                            </tr>
                            <tr>
                                <td><label for="validationCustom03" class="form-label">이메일</label></td>
                                <td><input type="text" class="form-control" id="cli_email" readonly></td>
                            </tr>
                            <tr>
                                <td><label for="validationCustom05" class="form-label">담당자 아이디</label></td>
                                <td><input type="text" class="form-control" id="validationCustom05" data-coreui-toggle="modal"
									data-coreui-target="#exampleModalToggle2" name="pic_username" required disabled></td>

                            </tr>
                            <tr>
                                <td><label for="validationCustom06" class="form-label">담당자 이름</label></td>
                                <td><input type="text" class="form-control" id="validationCustom06" data-coreui-toggle="modal" data-coreui-target="#exampleModalToggle2"
									required disabled></td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </div>
            <div class="modal-footer">
            <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
                <button type="button" class="btn btn-secondary" id="editButton">수정</button>
                <button type="submit" class="btn btn-success" id="saveButton" style="display: none;">저장</button>
                <button type="button" class="btn btn-success" id="saveCancelButton" style="display: none;">취소</button>
            </sec:authorize>
                <button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

	<!-- 담당자 선택 모달창 -->
<!-- 	<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true"> -->
<!-- 		<div class="modal-dialog"> -->
	<div class="modal fade" id="exampleModalToggle2" data-coreui-backdrop="static" data-coreui-keyboard="false" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<!-- <h5 class="modal-title" id="exampleModalLabel">담당자</h5> -->
					<h5 class="modal-title" id="exampleModalToggleLabel2">담당자</h5>
<!-- 					<button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button> -->
				</div>
				<div class="modal-body">
					<table class="table table-hover" id="modal2-table">
						<thead class="table-light">
							<tr>
								<th scope="col"></th>
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
<!-- 					<button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">Close</button> -->
				<button class="btn btn-primary" data-coreui-target="#exampleModalToggle" data-coreui-toggle="modal">확인</button>
				</div>
			</div>
		</div>
	</div>

<!-- 주소 api -->
	<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>

</body>  

   <!-- <script src="path/to/bootstrap.bundle.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@coreui/coreui@3.2.2/dist/js/coreui.min.js"></script>
<!-- 주소 api -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
<script>
const token = $("meta[name='_csrf']").attr("content")
const header = $("meta[name='_csrf_header']").attr("content");
const name = $("#userName").val();

// 전체 선택
function toggleCheckboxes(source) {
    const checkboxes = document.getElementsByClassName('form-check-input');
    for (let checkbox of checkboxes) {
        checkbox.checked = source.checked;
    }
}

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

function toggleCheckboxes(source) {
    const checkboxes = document.querySelectorAll('input[type="checkbox"].form-check-input');
    checkboxes.forEach(checkbox => checkbox.checked = source.checked);
}

$(document).ready(function() {
	// 삭제
	$("#deleteClientBtn").click(function(){
		
		const checkedCheckboxes = $('input[type="checkbox"].form-check-input:checked');
       	console.log("선택된 체크박스 수:", checkedCheckboxes.length);
        const cli_nums = [];
		
        checkedCheckboxes.each(function() {
        	const cli_num = $(this).closest('tr').find('td:eq(1)').text(); // cli_num이 있는 열의 인덱스에 따라 조정
        	if (cli_num) {  // 빈 문자열이 아닌 경우에만 추가
                console.log("추출된 cli_num:", cli_num);
                cli_nums.push(cli_num);
            }
        });
        
     	// 중복 제거
        const uniqueCliNums = [...new Set(cli_nums)];
        
     	console.log("최종 cli_nums 배열:", cli_nums);
        
        
        if (cli_nums.length === 0) {
            alert('삭제할 항목을 선택해주세요.');
            return;
        }
        
        if (confirm('선택한 ' + cli_nums.length + '개의 항목을 삭제하시겠습니까?')) {
		$.ajax({
			url: '/basicInfo/deleteClient',
			beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
             },
			type: 'POST',
			contentType: 'application/json',
            data: JSON.stringify({ cli_nums: cli_nums }),
            success: function(response) {
                // Handle success, e.g., reload the page or show a message
                location.reload();
                alert("삭제 완료 되었습니다");
            },
            error: function(xhr, status, error) {
                // Handle error
                alert("An error occurred: " + error);
            }
        });
      }
    });
	
	
    // 상세보기
    $(".clickable-cell").click(function() {
        var cli_num = $(this).closest("tr").find("td:nth-child(2)").text().trim();
        currentClientNum = cli_num;
        
        $.ajax({
            url: '/basicInfo/clientDetails',
            type: 'GET',
            data: { cli_num: cli_num },
            dataType: "json",
            success: function(response) {
                console.log(response);  // 응답 데이터 확인
                
                if (response.length > 0) {
                    var client = response[0];
                    console.log(client);  // 클라이언트 데이터 확인
                
                // 각 요소에 값을 설정
                $("#cli_num").val(client.cli_num);
                $("#cli_name").val(client.cli_name);
                $("#cli_crn").val(client.cli_crn);
                $("#cli_cate").val(client.cli_cate);
                $("#cli_ind").val(client.cli_ind);
                $("#sample6_postcode").val(client.cli_postCode);
                $("#sample6_address").val(client.cli_add1);
                $("#sample6_detailAddress").val(client.cli_add2);
                $("#sample6_extraAddress").val(client.cli_add3);
                $("#cli_tel").val(client.cli_tel);
                $("#cli_rep").val(client.cli_rep);
                $("#cli_email").val(client.cli_email);
                $("#validationCustom05").val(client.pic_username);
                $("#validationCustom06").val(client.usersList[0].user_per_name);
                
	                if (client.cli_cate === 'CLCU') {
	                    document.getElementById('cli_cateCu').checked = true;
	                } else if (client.cli_cate === 'CLPT') {
	                    document.getElementById('cli_catePt').checked = true;
	                }
	                
	             // 모든 입력 필드를 읽기 전용으로 설정
                    $("#exampleModalToggle input").attr('readonly', true);
                    $("#exampleModalToggle input[type=radio]").prop('disabled', true);
                    $("#validationCustom05, #validationCustom06").attr('disabled', true);

                    // 수정 버튼 보이기, 저장 및 취소 버튼 숨기기
                    $("#editButton").show();
                    $("#saveButton, #saveCancelButton, #postCodeButton").hide();
                
	             	// 원래 값을 저장
                    originalValues = {
                        cli_num: client.cli_num,
                        cli_name: client.cli_name,
                        cli_crn: client.cli_crn,
                        cli_cate: client.cli_cate,
                        cli_ind: client.cli_ind,
                        cli_postCode: client.cli_postCode,
                        cli_add1: client.cli_add1,
                        cli_add2: client.cli_add2,
                        cli_add3: client.cli_add3,
                        cli_tel: client.cli_tel,
                        cli_rep: client.cli_rep,
                        cli_email: client.cli_email,
                        pic_username: client.pic_username,
                        user_per_name: client.usersList[0].user_per_name
                    };
	             	
                	$("#exampleModalToggle").modal("show");
                }
            },
            error: function() {
            	console.log(error);
                alert('Failed to fetch transaction details.');
            }
        });
 	 });
 
 	// 수정 버튼 
    $("#editButton").click(function(event) {
    	event.preventDefault();
    	
    	// 선택된 클라이언트의 입력 필드만 수정 가능하게 변경
       	//$("#exampleModalToggle input").removeAttr('readonly'); // 전체 readonly 해제
    	$("#exampleModalToggle input:not(#cli_num,#cli_crn,#sample6_postcode,#sample6_address,#sample6_extraAddress)").removeAttr('readonly');
        $("#exampleModalToggle input[type=radio]").prop('disabled', false);
        $("#validationCustom05, #validationCustom06").removeAttr('disabled');
    	
        $(this).hide();
        $("#postCodeButton").show();
        $("#saveButton").show();
        $("#postCodeButton").prop("disabled", false);
        $("#saveCancelButton").show();
        
        saveOriginalValues(); // 수정 모드로 전환할 때 원래 값 저장
    });

 	// 담당자 정보 가져오기 (체크로)
    $('#modal2-table tbody').on('change', 'input[type="checkbox"]', function() {
        if ($(this).prop('checked')) {
        
            // 체크박스가 선택되면, 해당 행의 값을 가져와서 입력 요소에 설정
            var $row = $(this).closest('tr');
            var cliNum1 = $row.find('td:nth-child(3)').text();
            var cliNum2 = $row.find('td:nth-child(4)').text();
            $('#validationCustom05').val(cliNum1);
            $('#validationCustom06').val(cliNum2);
            
            // 다른 체크박스는 해제
            $('#modal2-table tbody input[type="checkbox"]').not(this).prop('checked', false);
        }
    });
 
    var originalValues = {}; // 입력 필드의 원래 값을 저장할 객체

    // 페이지 로드 시 입력 필드의 원래 값을 저장
    function saveOriginalValues() {
        $("#exampleModalToggle input").each(function() {
            originalValues[this.id] = $(this).val();
        });
        $("#exampleModalToggle input[type=radio]").each(function() {
            if ($(this).is(':checked')) {
                originalValues[this.name] = $(this).val();
            }
        });
    }

    // 원래 값과 현재 값을 비교
    function hasChanges() {
        var changed = false;

        $("#exampleModalToggle input").each(function() {
            if (originalValues[this.id] !== $(this).val()) {
                changed = true;
                return false; // 변경이 발견되면 반복문 종료
            }
        });

        $("#exampleModalToggle input[type=radio]").each(function() {
            if ($(this).is(':checked') && originalValues[this.name] !== $(this).val()) {
                changed = true;
                return false; // 변경이 발견되면 반복문 종료
            }
        });

        return changed;
    }

    // 페이지 로드 시 원래 값 저장
    saveOriginalValues();

    $("#saveButton").click(function(event) {
        // 모달 창 닫히는 기본 동작 방지
        event.preventDefault();

        if (!hasChanges()) {
            alert("수정사항이 없습니다.");
            return;
        }
        
        const updatedClient = {
                cli_num: $("#cli_num").val(),
                cli_name: $("#cli_name").val(),
                cli_crn: $("#cli_crn").val(),
                cli_cate: $("input[name='cli_cate']:checked").val(),
                cli_ind: $("#cli_ind").val(),
                cli_postCode: $("#sample6_postcode").val(),
                cli_add1: $("#sample6_address").val(),
                cli_add2: $("#sample6_detailAddress").val(),
                cli_add3: $("#sample6_extraAddress").val(),
                cli_tel: $("#cli_tel").val(),
                cli_rep: $("#cli_rep").val(),
                cli_email: $("#cli_email").val(),
                pic_username: $("#validationCustom05").val(),
                // user_per_name: $("#validationCustom06").val()
            };
        
        $.ajax({
        	url: '/basicInfo/updateClient',
        	beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
             },
        	type: 'POST',
        	contentType: 'application/json',
        	data: JSON.stringify(updatedClient),
        	success: function(response){
        		alert(" 수정되었습니다. ");
        		$("#exampleModalToggle").modal("hide");
        	},
        	error: function(textStatus){
        		console.log(textStatus);
        	}
        });
        
        // 모든 입력 필드를 readonly로 설정
        $("#exampleModalToggle input").attr('readonly', 'readonly');
        $("#exampleModalToggle input[type=radio]").prop('disabled', true);
        $("#validationCustom05, #validationCustom06").attr('disabled', true);

        // 저장 버튼 숨기기, 수정 버튼 보이기
        $(this).hide();
        $("#editButton").show();
        $("#postCodeButton").prop("disabled", true);
        //$("#postCodeButton").hide();
        $("#saveCancelButton").hide();
        
        currentClientNum = null;
    });
    
    // 저장 취소 버튼
    $("#saveCancelButton").click(function(event) {
        event.preventDefault();
        
        var userConfirmed = confirm("취소하시겠습니까?");
        
        if (userConfirmed) {
       
       	// 취소 작업 수행 => 원래 값으로 복원
        $("#cli_num").val(originalValues.cli_num);
        $("#cli_name").val(originalValues.cli_name);
        $("#cli_crn").val(originalValues.cli_crn);
        $("#cli_cate").val(originalValues.cli_cate);
        $("#cli_ind").val(originalValues.cli_ind);
        $("#sample6_postcode").val(originalValues.cli_postCode);
        $("#sample6_address").val(originalValues.cli_add1);
        $("#sample6_detailAddress").val(originalValues.cli_add2);
        $("#sample6_extraAddress").val(originalValues.cli_add3);
        $("#cli_tel").val(originalValues.cli_tel);
        $("#cli_rep").val(originalValues.cli_rep);
        $("#cli_email").val(originalValues.cli_email);
        $("#pic_username").val(originalValues.pic_username);
        $("#user_per_name").val(originalValues.user_per_name);
        
        // 입력 필드 및 라디오 버튼 readonly 및 disabled 상태로 복원
        $("#exampleModalToggle input:not(#cli_num,#cli_crn,#sample6_postcode,#sample6_address,#sample6_extraAddress)").attr('readonly', 'readonly');
        $("#exampleModalToggle input[type=radio]").prop('disabled', true);
        $("#validationCustom05, #validationCustom06").attr('disabled', true);
        
        $(this).hide();
        $("#saveButton").hide();
        $("#postCodeButton").prop("disabled", true);
        $("#editButton").show();
        
            alert("변경 사항이 취소되었습니다.");
            // 필요한 경우 폼 초기화 또는 다른 취소 작업 수행
        } else {
            // 아무 작업도 하지 않음 (원래의 수정상태로 유지)
            alert("취소 작업이 중단되었습니다.");
        }
        //alert(" 취소하시겠습니까? ");
        
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
	               var row = "<tr><th scope='row'><input type='checkbox' onclick='checkOneOnly(this)'></th><td>" + (parseInt(idx)+1) + "</td><td>" + item.username + "</td><td>" + item.user_per_name + "</td></tr>"
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

<%@ include file="../include/footer.jsp" %>

</html>