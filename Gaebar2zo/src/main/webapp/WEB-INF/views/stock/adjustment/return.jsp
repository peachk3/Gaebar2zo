<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>


<body class="bg-gray-100 font-sans">
    <div class="container mx-auto px-4 py-8">
        <div class="bg-white rounded-lg shadow-lg p-6">
            <h1 class="text-3xl font-semibold text-gray-800 mb-6">반품 관리</h1>
            
            <!-- Search Form -->
		<form action="/stock/adjustment/return" method="get" class="form-inline mt-3">
     		<div class="flex flex-wrap -mx-3 mb-4 md:flex-nowrap">
		        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
		            <div class="input-group w-500">
		                <div class="input-group-prepend">
		                    <select class="form-select custom-select-radius custom-select-width" id="searchType" name="searchType">
		                        <option value="" <c:if test="${empty searchType}">selected</c:if>>전체</option>
		                        <option value="code" <c:if test="${searchType eq 'code'}">selected</c:if>>재고 번호</option>
		                        <option value="name" <c:if test="${searchType eq 'name'}">selected</c:if>>품목명</option>
		                        <option value="warehouse" <c:if test="${searchType eq 'warehouse'}">selected</c:if>>창고명</option>
		                        <option value="color" <c:if test="${searchType eq 'color'}">selected</c:if>>색상</option>
		                    </select>
		                </div>
		                <input type="text" class="form-control" placeholder="검색어를 입력하세요" name="keyword" value="${keyword}">
		                <button class="btn btn-outline-secondary" type="submit">검색</button>
		            </div>
		        </div>
		    </div>
		</form>
<div id="tableContainer" class="transition-all duration-300 ease-in-out" >
            <!-- Table -->
            <div class="overflow-x-hidden bg-white border overflow-y-hidden relative" id="dynamicTable">
            	<table class="border-collapse table-auto w-full whitespace-no-wrap bg-white table-hover relative">
                    <thead>
                        <tr class="text-center">
                            <th class="checkbox-column">
                            	<input type="checkbox" class="form-check-input focus:outline-none focus:shadow-outline" id="selectAll" onclick="toggleCheckboxes(this)">
                            </th>
                            <th>반품 번호</th>
                            <th>반품 거래처</th>
                            <th>품목명</th>
                            <th>반품 수량</th>
                            <th>반품 신청일</th>
                            <th>반품(예정)일</th>
                            <th>반품 사유</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    
						<c:set var="cellClass" value="clickable-cell text-gray-700 px-2 py-2 flex items-center" />
                    
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach var="re" items="${re}">
                            <c:forEach var="item" items="${re.itemList}">
                                <c:forEach var="inchange" items="${re.inchangeList}">
                                    <c:forEach var="goods" items="${item.tranGoodsList}">
                                        <tr>
                                            <td class="text-center">
                                            	<input type="checkbox" class="form-check-input rowCheckbox focus:outline-none focus:shadow-outline" value="" id="flexCheckDefault${goods.goods_num}">
                                            </td>
                                            <td><span class="${cellClass}">${re.tran_num}</span></td>
                                            <td><span class="${cellClass}">${re.cli_num}</span></td>
                                            <td><span class="${cellClass}">${item.item_name}</span></td>
                                            <td><span class="${cellClass}">${goods.goods_qty}</span></td>
                                            <td><span class="${cellClass}">${re.regdate}</span></td>
                                            <td><span class="${cellClass}">${re.tran_date}</span></td>
                                            <td><span class="${cellClass}">${re.comm}</span></td>
                                            <td><span class="${cellClass}">${re.pro_status}</span></td>
											<input type="hidden" class="top-tran-num" value="${re.top_tran_num}">
                                        </tr>
                                    </c:forEach>
                                </c:forEach>
                            </c:forEach>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            </div>
            <!-- Pagination -->
            <div class="px-5 py-5 bg-white border-t flex flex-col xs:flex-row items-center xs:justify-between">
                <c:url var="pageUrl" value="/stock/adjustment/return">
                    <c:param name="searchType" value="${searchType}"/>
                    <c:param name="keyword" value="${keyword}"/>
                </c:url>
            <nav aria-label="Page navigation" class="pagination-container">
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
            <div class="flex justify-between items-center px-1 py-0 bg-white">
    <div class="flex gap-2">
        <button type="button" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded flex items-left" id="preReceiveBtn">
            <span>반품예정</span>
        </button>
        <button type="button" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded flex items-center" id="completedReceiveBtn">
            <span>반품완료</span>
        </button>
    </div>
    <div class="flex gap-2">
        <button type="button" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded flex items-center" onclick="location.href='/stock/adjustment/returnAdd'">
            <span>등록</span>
        </button>
        <button type="button" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded flex items-center" id="deleteItemBtn">
            <span>삭제</span>
        </button>
    </div>
</div>
    </div>
</div>

<!-- Modal -->
    <div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">반품 리스트</h5>
                    <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="search-container">
                        <div class="col-md-6">
                            <label for="validationCustom01" class="form-label">주문 리스트</label>
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
					        <label for="validationCustom04" class="form-label">반품 예정일</label>
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
					<div class="search-container">
					    <div class="col-md-6">
					        <label for="modal-comm" class="form-label">반품 사유</label>
					        <select class="form-control" id="modal-comm" name="comm" disabled required>
					            <option value="" selected disabled>반품 사유를 선택해주세요</option>
					            <option value="불량 제품">불량 제품</option>
					            <option value="고객 요청">고객 요청</option>
					            <option value="기타">기타</option>
					        </select>
					    </div>
					</div>
               <div class="modal-footer">
                    <button type="button" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded inline-flex items-center" id="editButton">수정</button>
                    <button type="submit" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded mr-2" id="saveButton" style="display: none;">
                            저장
                    </button>
                    <button type="button" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded mr-2" id="saveCancelButton" style="display: none;">
                            취소
                    </button>
                    <button type="button" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded inline-flex items-center" data-coreui-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
</div>
    
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

    <%@ include file="../../include/footer.jsp" %>


<script>
function toggleCheckboxes(source) {
    const checkboxes = document.querySelectorAll('input[type="checkbox"].rowCheckbox');
    checkboxes.forEach(checkbox => checkbox.checked = source.checked);
}

function formatDateForInput(dateStr) {
    if (!dateStr) return '';
    dateStr = dateStr.split('T')[0];
    return dateStr;
}

$(document).ready(function() {
    const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");

    $(".clickable-cell").click(function() {
        var tran_num = $(this).closest("tr").find("td:nth-child(2)").text().trim();
        var top_tran_num = $(this).closest("tr").find("td:nth-child(7)").text().trim();
        
        $.ajax({
            url: '/stock/getReturnDetails',
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
                $("#modal-comm").val(response.comm);
                
                // 숨겨진 필드에 tran_num 설정
            	$("#modal-tran_num").val(tran_num); // 여기서 tran_num 값을 올바르게 설정
                console.log("Modal tran_num 설정: " + $("#modal-tran_num").val()); // 확인용 로그 추가

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
                $('#exampleModal1').modal('show');
            	},
            error: function(error) {
                console.log("에러 발생: ", error);
            }
        });
    });

//     $("#statusChangeBtn").click(function() {
//         $(".status-buttons").toggle();
//     });

//     $(".status-buttons .btn").click(function() {
//         const pro_status = $(this).text().trim();

		$("#preReturnBtn, #completedReturnpreReceiveBtnBtn").click(function() {
		const pro_status = $(this).text().trim();

        const checkedCheckboxes = $('input[type="checkbox"].rowCheckbox:checked');
        const tran_nums = [];
        const top_tran_nums = [];

        checkedCheckboxes.each(function() {
        	const row = $(this).closest('tr');        	
        	const tran_num = $(this).closest('tr').find('td:eq(1)').text().trim();
        	var top_tran_num = $(this).closest("tr").find(".top-tran-num").val();
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
            url: '/stock/updateReturnStatus',
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
                console.error("Error details:", xhr.responseText);
                alert("상태 변경 중 오류가 발생했습니다: " + xhr.responseText);
            }
        });
    });

    $("#deleteItemBtn").click(function(){
        const checkedCheckboxes = $('input[type="checkbox"].rowCheckbox:checked');
        console.log("선택된 체크박스 수:", checkedCheckboxes.length);
        const tran_nums = [];
        const top_tran_nums = [];

        checkedCheckboxes.each(function() {
        	const row = $(this).closest('tr');        	
        	const tran_num = $(this).closest('tr').find('td:eq(1)').text().trim();
        	var top_tran_num = $(this).closest("tr").find(".top-tran-num").val();
        	if (tran_num) {
                tran_nums.push(tran_num);
                top_tran_nums.push(top_tran_num);
            }
        });

        
        console.log("최종 tran_nums 배열:", tran_nums);
        
        if (tran_nums.length === 0) {
            alert('삭제할 항목을 선택해주세요.');
            return;
        }

        if (confirm('선택한 ' + tran_nums.length + '개의 항목을 삭제하시겠습니까?')) {
            $.ajax({
                url: '/stock/deleteRE',
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(header, token);
                },
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ 
                    tran_nums: tran_nums, 
                    top_tran_nums: top_tran_nums
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
	$("#modal-comm").removeAttr('disabled');
        
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
        console.log("Save Button 클릭 시 tran_num: " + tran_num);
        
        const updatedData = {
        		tran_num: tran_num,
                tran_date: $("#modal-tran_date").val(),
                pic_username: $("#modal-pic_username").val(),
                user_per_name: $("#modal-user_per_name").val(),
                comm: $("#modal-comm").val()
        };

        console.log("Updated Data: ", updatedData);
        
        $.ajax({
            url: '/stock/updateDetails',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(updatedData),
            beforeSend: function(xhr) {
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
        $("#modal-comm").attr('disabled', 'disabled');
        $(this).hide();
        $("#editButton").show();
        $("#saveCancelButton").hide();
    });

    $("#saveCancelButton").click(function(event) {
        event.preventDefault();
        
        $("#modal-tran_date").attr('readonly', 'readonly');
        $("#modal-comm").attr('disabled', 'disabled');
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

function toggleMenu() {
    const menu = document.getElementById('statusMenu');
    const container = document.body;
    
    menu.classList.toggle('hidden');
    menu.classList.toggle('active');
    container.classList.toggle('menu-open');
    
    if (!menu.classList.contains('hidden')) {
        // 메뉴가 열릴 때 테이블 컨테이너를 아래로 밀어냄
        document.getElementById('tableContainer').style.marginTop = menu.offsetHeight + 'px';
    } else {
        // 메뉴가 닫힐 때 테이블 컨테이너를 원래 위치로 되돌림
        document.getElementById('tableContainer').style.marginTop = '0';
    }
}

// 메뉴 외부 클릭 시 닫기
document.addEventListener('click', function(event) {
    const menu = document.getElementById('statusMenu');
    const toggleButton = document.querySelector('[x-data]');
    
    if (!menu.contains(event.target) && !toggleButton.contains(event.target)) {
        menu.classList.add('hidden');
        menu.classList.remove('active');
        document.body.classList.remove('menu-open');
        document.getElementById('tableContainer').style.marginTop = '0';
    }
});
</script>
