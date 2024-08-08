<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    <style>
        .status-buttons { display: none; }
        .modal-dialog { max-width: 80%; }
        .search-container { display: flex; margin-bottom: 20px; }
        .search-group { display: flex; align-items: center; }
        .table-container { margin-top: 20px; }
    </style>

    <meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">
<body>
	<h1>/Styleboso/stock/releaseList.jsp</h1>
	<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-right : 10px; padding : 10px;">
		<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
           <input type="button" class="btn btn-primary" value="등록" onclick="location.href='/stock/releaseAdd'">
           <input type="button" id="deleteItemBtn" name="deleteItemBtn" class="btn btn-primary" value="삭제">
       </sec:authorize>
	</div>

<table class="table table-hover">
     	<thead>
    <tr>
        <th scope="col">
			<div class="form-check">
      			<input class="form-check-input" type="checkbox" value="" id="selectAll" onclick = "toggleCheckboxes(this)"> 
       		</div>
       </th>
        <th scope="col">출고번호</th>
        <th scope="col">제품코드</th>
        <th scope="col">품목명</th>
        <th scope="col">출고 수량</th>
        <th scope="col">출고일</th>
        <th scope="col">거래 번호</th>
        <th scope="col">재고 번호</th>
        <th scope="col">비고</th>
        <th scope="col">상태</th>
  	  </tr>
	</thead>
<tbody>
    <c:forEach var="rs" items="${rs}">
        <c:forEach var="item" items="${rs.itemList}">
            <c:forEach var="goods" items="${item.tranGoodsList}">
                <tr>
                    <td>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault${item.item_num}"> 
                        </div>
                    </td>
                    <td class="clickable-cell">${rs.tran_num}</td>
                    <td class="clickable-cell">${goods.goods_num}</td>
                    <td class="clickable-cell">${item.item_name}</td>
                    <td class="clickable-cell">${goods.goods_qty}</td>
                    <td class="clickable-cell">${rs.rel_date}</td>
                    <td class="clickable-cell">${rs.top_tran_num}</td>
                    <td class="clickable-cell">${rs.inchangeList[0].inven_num}</td>
                    <td class="clickable-cell">${rs.comm}</td>
                    <td class="clickable-cell">${rs.pro_status}</td>
                </tr>
            </c:forEach>
        </c:forEach>
    </c:forEach>
</tbody>
</table>

    <div class="container mt-3">
    <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
        <button id="statusChangeBtn" class="btn btn-outline-info">상태 변경</button>
        <div class="status-buttons mt-2">
            <button class="btn btn-outline-info" id="preReceiveBtn">출고 준비</button>
            <button class="btn btn-outline-info" id="completedReceiveBtn">출고 완료</button>
        </div>
   </sec:authorize>
    </div>

<!-- Modal -->
<div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">주문 리스트</h5>
                <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="search-container">
                    <div class="col-md-6">
                        <label for="validationCustom01" class="form-label">발주리스트</label>
                        <input type="text" class="form-control" id="modal-top_tran_num" readonly>
                    </div>
                    <div class="col-md-3">
                        <label for="validationCustom02" class="form-label">거래처 코드</label>
                        <input type="text" class="form-control" id="modal-cli_num" readonly>
                    </div>
                    <div class="col-md-3">
                        <label for="validationCustom03" class="form-label">거래처 명</label>
                        <input type="text" class="form-control" id="modal-cli_name" readonly>
                    </div>
                </div>
                <div class="search-container">
                    <div class="col-md-6">
                        <label for="validationCustom04" class="form-label">출고 예정일</label>
                        <input type="date" class="form-control" id="modal-tran_date" required>
                    </div>
                    <div class="col-md-3">
                        <label for="validationCustom05" class="form-label">담당자 아이디</label>
                        <input type="text" class="form-control" id="modal-pic_username" readonly>
                    </div>
                    <div class="col-md-3">
                        <label for="validationCustom06" class="form-label">담당자 명</label>
                        <input type="text" class="form-control" id="modal-user_per_name" readonly>
                    </div>
                </div>
                <input type="hidden" id="modal-tran_num">
                <div class="modal-body">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>제품코드</th>
                                    <th>품목명</th>
                                    <th>수량</th>
                                    <th>상위거래번호</th>
                                    <th>비고</th>
                                    <th>재고 번호</th>
                                    <th>거래 번호</th>
                                </tr>
                            </thead>
                            <tbody id="modal-table-body">
                            </tbody>
                        </table>
                    </div>
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
</div>
<!-- 페이징 처리 -->
   <nav aria-label="Page navigation" class="pagination-container">
      <ul class="pagination justify-content-center">
         <c:if test="${pageVO.prev}">
            <li class="page-item">
               <a class="page-link" href="/stock/releaseList?page=${pageVO.startPage - 1}" aria-label="Previous">
                  <span aria-hidden="true">&laquo;</span>
               </a>
            </li>
         </c:if>
         <c:forEach var="i" begin="${pageVO.startPage}" end="${pageVO.endPage}" step="1">
            <li class="page-item ${pageVO.cri.page == i ? 'active' : ''}">
               <a class="page-link" href="/stock/releaseList?page=${i}">${i}</a>
            </li>
         </c:forEach>
         <c:if test="${pageVO.next && pageVO.endPage > 0}">
            <li class="page-item">
               <a class="page-link" href="/stock/releaseList?page=${pageVO.endPage + 1}" aria-label="Next">
                  <span aria-hidden="true">&raquo;</span>
               </a>
            </li>
         </c:if>
      </ul>
   </nav>


	<!-- Modal2 -->
			<div class="modal fade" id="exampleModal2" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-scrollable">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">담당자</h5>
							<button type="button" class="btn-close"
								data-coreui-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<table class="table table-hover text-center" id="modal2-table">
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
							<button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>









<%@ include file="../include/footer.jsp" %>	
</body>
</html>


   <!-- jQuery and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@coreui/coreui@3.2.2/dist/js/coreui.min.js"></script>

<script>
function toggleCheckboxes(source) {
    const checkboxes = document.querySelectorAll('input[type="checkbox"].form-check-input');
    checkboxes.forEach(checkbox => checkbox.checked = source.checked);
}

function formatDateForInput(dateStr) {
    if (!dateStr) return '';
    // 날짜 문자열에서 'T'와 그 이후의 모든 문자를 제거합니다.
    dateStr = dateStr.split('T')[0];
    return dateStr;
}




$(document).ready(function() {
	const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");
	
	 $(".clickable-cell").click(function() {
        var tran_num = $(this).closest("tr").find("td:nth-child(2)").text();
        var top_tran_num = $(this).closest("tr").find("td:nth-child(7)").text();

        $.ajax({
            url: '/stock/getTransactionDetails2',
            type: 'GET',
            data: { 
                tran_num: tran_num,
                top_tran_num: top_tran_num
            },
            dataType: "json",
            success: function(response) {
                console.log("AJAX 응답:", response);
                
                // 기본 거래 정보 설정
                $("#modal-top_tran_num").val(response.top_tran_num);
                $("#modal-cli_num").val(response.cli_num);
                $("#modal-cli_name").val(response.cli_name);
                $("#modal-tran_date").val(formatDateForInput(response.tran_date)); 
                $("#modal-pic_username").val(response.pic_username);
                $("#modal-user_per_name").val(response.user_per_name);
                
                // 숨겨진 필드에 tran_num 설정
            	$("#modal-tran_num").val(tran_num); // 여기서 tran_num 값을 올바르게 설정

            	// 테이블 바디를 비웁니다.
                $("#modal-table-body").empty();
                
                // 중복 제거를 위한 객체
                var uniqueItems = {};
                
                // 품목 정보 행 생성 및 추가
                $(response.items).each(function(idx, item){
                    // item_num과 inven_num을 조합하여 고유 키 생성
                    var uniqueKey = item.item_num + '_' + item.inven_num;
                    
                    if (!uniqueItems[uniqueKey]) {
                        var row = "<tr><th scope='row'></th><td>" + item.item_num + "</td><td>" 
                            + item.item_name + "</td><td>" + item.goods_qty + "</td><td>" + item.top_tran_num + "</td><td>" 
                            + item.comm + "</td><td>" + item.inven_num + "</td><td>" + item.tran_num + "</td></tr>";
                        
                        $("#modal-table-body").append(row);
                        
                        // 항목을 uniqueItems에 추가
                        uniqueItems[uniqueKey] = true;
                    }
                });
                
                // 모달을 엽니다.
                $("#exampleModal1").modal("show");
            	},
            error: function(error) {
                console.log("에러 발생: ", error);
            }
        });
    });


	    $("#statusChangeBtn").click(function() {
	        $(".status-buttons").toggle();
	    });

	    $(".status-buttons .btn").click(function() {
	        const pro_status = $(this).text().trim(); // "출고 준비" 혹은 "출고 완료" 버튼의 텍스트를 상태로 사용
	        const checkedCheckboxes = $('input[type="checkbox"].form-check-input:checked');
	        const tran_nums = [];
	        const top_tran_nums = [];

	        checkedCheckboxes.each(function() {
	            const row = $(this).closest('tr');
	            const tran_num = row.find('td:eq(1)').text(); // 출고번호가 두 번째 열에 있다고 가정
	            const top_tran_num = row.find('td:eq(6)').text(); // 거래 번호가 7번째 열에 있다고 가정

	            if (tran_num) {
	                tran_nums.push(tran_num);
	                top_tran_nums.push(top_tran_num);
	            }
	        });

	        if (tran_nums.length === 0) {
	            alert('변경할 항목을 선택해주세요.');
	            return;
	        }

	        $.ajax({
	            url: '/stock/updateReleaseStatus',
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify({ 
	                tran_nums: tran_nums, 
	                top_tran_nums: top_tran_nums, 
	                pro_status: pro_status 
	            }),
	            beforeSend: function(xhr) {
	                xhr.setRequestHeader(header, token);
	            },
	            success: function(response) {
	                location.reload();
	                alert("상태가 성공적으로 변경되었습니다.");
	            },
	            error: function(xhr, status, error) {
	                alert("An error occurred: " + error);
	            }
	        });
	    });
    
    
	    $("#deleteItemBtn").click(function(){
	        const checkedCheckboxes = $('input[type="checkbox"].form-check-input:checked');
	        console.log("선택된 체크박스 수:", checkedCheckboxes.length);
	        const tran_nums = []; // 여기서 tran_nums를 배열로 선언
	        const top_tran_nums = []; // top_tran_nums 배열 추가

	        checkedCheckboxes.each(function() {
	            const row = $(this).closest('tr'); // 여기에 row 정의 추가
	            const tran_num = $(this).closest('tr').find('td:eq(1)').text();
	            const top_tran_num = row.find('td:eq(6)').text(); // top_tran_num이 7번째 열에 있다고 가정

	            if (tran_num) {
	                console.log("추출된 tran_num:", tran_num);
	                console.log("추출된 top_tran_num:", top_tran_num);
	                tran_nums.push(tran_num);
	                top_tran_nums.push(top_tran_num);
	            }
	        });
	        
	        console.log("최종 tran_nums 배열:", tran_nums);
	        console.log("최종 top_tran_nums 배열:", top_tran_nums);
	        
	        if (tran_nums.length === 0) {
	            alert('삭제할 항목을 선택해주세요.');
	            return;
	        }

	        if (confirm('선택한 ' + tran_nums.length + '개의 항목을 삭제하시겠습니까?')) {
	            $.ajax({
	                url: '/stock/deleteRL',
	                beforeSend: function(xhr) {
	                    xhr.setRequestHeader(header, token);
	                },
	                type: 'POST',
	                contentType: 'application/json',
	                data: JSON.stringify({ 
	                    tran_nums: tran_nums,
	                    top_tran_nums: top_tran_nums // top_tran_nums 추가
	                }),
	                success: function(response) {
	                    location.reload();
	                    alert("삭제 완료 되었습니다");
	                },
	                error: function(xhr, status, error) {
	                    console.error("AJAX 오류:", status, error);
	                    alert("An error occurred: " + error);
	                }
	            });
	        }
	    });
	    
	    

	    $("#editButton").click(function(event) {
	        event.preventDefault();
	        
	        $("#modal-tran_date").removeAttr('readonly');
	        
	        // 담당자 아이디/담당자 명 클릭 시 모달 열기
	        $("#modal-pic_username, #modal-user_per_name").click(function() {
	            $("#exampleModal2").modal("show");
	        });
	        
	        $(this).hide();
	        $("#saveButton, #saveCancelButton").show();
	    });

	    
	    
	    $("#saveButton").click(function(event) {
	        event.preventDefault();

	        const tran_num = $("#modal-tran_num").val();
	        console.log("Save Button 클릭 시 tran_num: " + tran_num); // 확인용 로그 추가
	        
	        const updatedData = {
        		tran_num: tran_num,
                tran_date: $("#modal-tran_date").val(),
                pic_username: $("#modal-pic_username").val(),
                user_per_name: $("#modal-user_per_name").val()
            };

	        console.log("Updated Data: ", updatedData); // 확인용 로그 추가
	        
	        $.ajax({
	            url: '/stock/updateDetails',
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify(updatedData),
	            beforeSend: function(xhr) {
	                const token = $("meta[name='_csrf']").attr("content");
	                const header = $("meta[name='_csrf_header']").attr("content");
	                xhr.setRequestHeader(header, token);
	            },
	            success: function(response) {
	                alert("수정되었습니다.");
	                $("#exampleModal1").modal("hide");
	                location.reload();
	            },
	            error: function(xhr, status, error) {
	                alert("An error occurred: " + error);
	            }
	        });

	        $("#modal-tran_date").attr('readonly', 'readonly');
	        $(this).hide();
	        $("#editButton").show();
	        $("#saveCancelButton").hide();
	    });

	    $("#saveCancelButton").click(function(event) {
	        event.preventDefault();
	        
	        $("#modal-tran_date").attr('readonly', 'readonly');
	        $(this).hide();
	        $("#saveButton").hide();
	        $("#editButton").show();
	    });

	    $('#modal2-table tbody').on('click', 'tr', function() {
	        var username = $(this).find('td:nth-child(2)').text();
	        var user_per_name = $(this).find('td:nth-child(3)').text();

	        $("#modal-pic_username").val(username);
	        $("#modal-user_per_name").val(user_per_name);

	        $("#exampleModal2").modal("hide");
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
