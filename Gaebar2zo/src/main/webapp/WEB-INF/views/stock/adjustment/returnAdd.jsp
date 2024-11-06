<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>

<body>
<div class="container-lg px-4">
      <div class="row">
         <div class="col-12">
            <div class="card mb-4">
               <div class="card-body">
                  <form class="row g-3 needs-validation" action="/adjustment/returnAdd" method="post" novalidate>
                     <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">         
                  
                     <div class="col-md-6">
                        <label for="validationCustom01" class="form-label">거래 리스트</label>
                           <input type="text" class="form-control" id="validationCustom01" name="top_tran_num"
                                 data-coreui-toggle="modal" data-coreui-target="#exampleModal0" required>
                        <div class="invalid-feedback">거래 리스트를 입력해주세요</div>
                     </div>

                     <div class="col-md-3">
                        <label for="validationCustom03" class="form-label">거래처 번호</label>
                           <input type="text" class="form-control" id ="validationCustom03" name="cli_num" required>
                        <div class="invalid-feedback">거래처를 입력해주세요</div>
                     </div>
                     <div class="col-md-3">
                        <label for="validationCustom04" class="form-label">거래처명</label>
                           <input type="text" class="form-control" id="validationCustom04" required>
                     </div>
                     <div class="col-md-6">
                        <label for="validationCustom02" class="form-label">거래일</label> 
                           <input type="date" class="form-control" name="tran_date"
                           id="validationCustom02" required>
                        <div class="invalid-feedback">거래일 </div>
                     </div>
                     
                     <div class="col-md-3">
                        <label for="validationCustom05" class="form-label">담당자 아이디</label>
                           <input type="text" class="form-control" id="validationCustom05" name="pic_username" required>
                        <div class="invalid-feedback">담당자를 입력해주세요</div>
                     </div>
                     <div class="col-md-3">
                        <label for="validationCustom06" class="form-label">담당자명</label>
                           <input type="text" class="form-control" id="validationCustom06" required>
                     </div>
                     <div class="col-12">
                        <label for="validationCustom07" class="form-label">반품 사유</label>
                            <select class="form-control" id="validationCustom07" name="comm" required>
                                <option value="" selected disabled>반품 사유를 선택해주세요</option>
                                <option value="불량 제품">불량 제품</option>
                                <option value="고객 요청">고객 요청</option>
                                <option value="기타">기타</option>
                            </select>
                      </div>

                     
                  <div class="example">
                     <div class="tab-content rounded-bottom">

                     <ul class="nav nav-underline-border" role="tablist">
                     </ul>
                        <table class="table item-table text-left">
                            <thead class="table-light">
                                <tr>
                                    <th scope="col" style="width:25%">제품번호</th>
                                    <th scope="col" style="width:25%">제품명</th>
                                    <th scope="col" style="width:25%">수량</th>
                                </tr>
                            </thead>
                            <tbody id="tableBody">
                                <!-- 행이 동적으로 추가됩니다 -->
                            </tbody>
                        </table>
                     </div>
                  </div>
<!--                   <div class="flex justify-between items-center px-3 py-3 bg-gray-100"> -->
    <div class="flex gap-2">
        <button type="submit" id="submitFormBtn" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded flex items-center" >
            <span>등록</span>
        </button>
    </div>
                  </form>
                  
                  
                  <!-- Modal0 -->
                  <div class="modal fade" id="exampleModal0" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                     <div class="modal-dialog modal-dialog-scrollable">
                        <div class="modal-content">
                           <div class="modal-header">
                              <h5 class="modal-title" id="exampleModalLabel">거래 리스트</h5>
                              <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
                           </div>
                           <div class="modal-body">
                              <table class="table table-hover text-center" id="modal0-table">
                                 <thead class="table-light">
                                    <tr>
                                       <th scope="col"></th>
                                       <th scope="col">거래 번호</th>
                                    </tr>
                                 </thead>
                                 <tbody>
									<c:forEach var="po" items="${po}" varStatus="status">
							            <tr data-tran-num="${po.tran_num}">
							            	<th scope='row'>${status.index+1}</th>
							                <td>${po.tran_num}</td>
						            <c:forEach var="cli" items="${po.clientList}">
							                <td>${cli.cli_name}</td>
							        </c:forEach>
							        	</tr>
							        </c:forEach>
                                 </tbody>
                              </table>
                           </div>
                           <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">닫기</button>
                           </div>
                        </div>
                     </div>
                  </div>
                           </div>
                        </div>
                     </div>
               </div>
            </div>
</body>

<style>
   .custom-btn {
      text-align: left; /* 텍스트를 왼쪽으로 정렬합니다 */
      padding-left: 10px; /* 왼쪽 여백을 추가합니다 */
      width: 100%; /* 버튼이 부모 요소에 맞게 전체 너비를 가지도록 설정합니다 */
   }
   
   .hidden {
      isplay: none;
   }
</style>

<!-- <script src="path/to/bootstrap.bundle.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 날짜 포맷팅  -->
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('.needs-validation');
    const submitFormBtn = document.getElementById('submitFormBtn');
    const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");
    const name = $("#userName").val();

    // 날짜 포맷팅 함수
    function formatDateForInput(dateStr) {
        if (!dateStr) return '';
        var date = new Date(dateStr);
        return date.toISOString().split('T')[0];
    }

    // 폼 제출 이벤트
    submitFormBtn.addEventListener('click', function(event) {
        event.preventDefault();
        
        const formData = {
            top_tran_num: String(document.getElementById('validationCustom01').value),
            tran_date: String(document.getElementById('validationCustom02').value),
            cli_num: document.getElementById('validationCustom03').value,
            pic_username: document.getElementById('validationCustom05').value,
            tran_cate_code: "RE",
            comm: document.getElementById('validationCustom07').value
        };
        
        const tableData = dataChangeJSON();
        
        const forms = document.querySelectorAll('.needs-validation');
        let allFormsValid = true;
        
        Array.from(forms).forEach(form => {
            if (!form.checkValidity()) {
                event.stopPropagation();
                allFormsValid = false;
            }
            form.classList.add('was-validated');
        });
        
        if (allFormsValid) {
        	$.ajax({
        	    type: 'POST',
        	    url: '/stock/adjustment/returnAdd',
        	    beforeSend: function(xhr) {
        	        xhr.setRequestHeader(header, token);
        	    },
        	    contentType: 'application/json; charset=utf-8',
        	    data: JSON.stringify({
        	        tvo: JSON.stringify(formData),
        	        icvo: JSON.stringify(tableData)
        	    }),
        	    success: function(response) {
        	        console.log('서버 응답:', response);  // 이 로그가 출력되는지 확인
        	        alert('반품 등록이 성공적으로 완료되었습니다.');  // 사용자에게 알림
        	        setTimeout(function() {
        	            window.location.href = '/stock/adjustment/return';
        	        }, 100);  // 100ms 후에 페이지 이동
        	    },
        	    error: function(error) {
        	        console.error('에러 발생:', error);
        	        alert('반품 등록이 성공적으로 완료되었습니다.');  // 사용자에게 오류 알림
        	        setTimeout(function() {
        	            window.location.href = '/stock/adjustment/return';
        	        }, 100);
        	    }
        	});
        }
    });

    // 모달 관련 이벤트
$('#modal1-table tbody').on('click', 'tr', function() {
        var selectedRow = $(this);
        var productNum = selectedRow.find('td:eq(0)').text();
        var productName = selectedRow.find('td:eq(1)').text();
        var inventoryNum = selectedRow.find('td:eq(2)').text();
        var quantity = selectedRow.find('td:eq(3)').text();
        
        // 테이블에 데이터 추가
        var newRow = '<tr>' +
            '<td>' + productNum + '</td>' +
            '<td>' + productName + '</td>' +
            '<td>' + quantity + '</td>' +
            '</tr>';
        $('#tableBody').append(newRow);

        $('#exampleModal1').modal('hide');
    });
    
   // 재고 모달에서 선택된 데이터 처리
   $('#inventoryModalBody').on('click', 'tr', function() {
       var inventoryNum = $(this).data('inventory');
       var warehouseName = $(this).data('warehouse');
   
       var input = $('.inventory-input[data-row="' + $(this).data('row') + '"]');
       input.val(inventoryNum);
       
       $('#inventoryModal').modal('hide');
   });
    

    $('#modal0-table tbody').on('click', 'tr', function() {
        var targetInput1 = document.getElementById('validationCustom01');
        var tranList = $(this).find('td:nth-child(2)').text();
        targetInput1.value = tranList;
        
        var modal = document.getElementById('exampleModal0');
        var modalInstance = coreui.Modal.getInstance(modal);
        modalInstance.hide();

        // 거래 상세 정보 가져오기
        $.ajax({
            url: '/common/transactionDetails',
            type: 'GET',
            data: { tran_num: tranList },
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function(data) {
                // 폼 필드 채우기
                document.getElementById('validationCustom03').value = data.tranDetails.cli_num;
                document.getElementById('validationCustom04').value = data.tranDetails.clientList[0].cli_name;
                document.getElementById('validationCustom02').value = formatDateForInput(data.tranDetails.tran_date);
                document.getElementById('validationCustom05').value = data.tranDetails.pic_username;
                document.getElementById('validationCustom06').value = data.tranDetails.userList[0].user_per_name;

                // 테이블 데이터 채우기
                var tableBody = $('#tableBody');
                tableBody.empty();
                data.tranGoods.forEach(function(item, index) {
                   var row = '<tr>' +
                    '<td>' + item.goods_num + '</td>' +
                    '<td>' + item.itemList[0].item_name + '</td>' +
                    '<td>' + item.goods_qty + '</td>' +
                    '</tr>';
                    tableBody.append(row);
                });

            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log("AJAX 요청 실패: " + jqXHR.status + ", " + jqXHR.statusText + ", " + textStatus + ", " + errorThrown);
                alert("AJAX 요청 실패!");
            }
        });
    });

    // 거래 리스트 가져오기
    function getTransactionList() {
        $('#modal0-table tbody tr').remove();
        
        $.ajax({
        	 url: "/common/transactionList",
             type: "get",
             contentType: 'application/json; charset=utf-8',
             dataType: "json",
             success: function(data) {
                 console.log("Received data:", data);  // 전체 데이터 로깅
                 if (Array.isArray(data)) {
                     data.forEach(function(item, idx) {
                         console.log("Processing item:", item);  // 각 항목 로깅
                         if (item.pro_status === '출고 완료' && item.tran_num.substring(0, 2) === 'SO' && item.pro_status !== '반품 접수') {
                             var row = "<tr><th scope='row'>" + (parseInt(idx) + 1) + "</th><td>" + item.tran_num + "</td></tr>";
                             $('#modal0-table tbody').append(row);
                         }
                     });
                 } else {
                     console.log("Data is not an array:", data);
                 }
                 
                 if ($('#modal0-table tbody tr').length === 0) {
                     $('#modal0-table tbody').append("<tr><td colspan='2'>No data available</td></tr>");
                 }
             },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log("AJAX 요청 실패: " + jqXHR.status + ", " + jqXHR.statusText + ", " + textStatus + ", " + errorThrown);
                alert("AJAX 요청 실패!");
            }
        });
    }

 // 재고번호와 창고명 입력 필드에 클릭 이벤트 추가
    $('.inventory-input, .warehouse-input').on('click', function() {
        var rowIndex = $(this).data('row');
        var goods_num = $(this).closest('tr').find('td:first').text();
        openInventoryModal(rowIndex, goods_num);
    });

    function openInventoryModal(rowIndex, goods_num) {
        console.log("Opening modal for rowIndex:", rowIndex, "with goods_num:", goods_num);  // 로깅 추가
        $('#inventoryModal').modal('show');
        loadInventoryData(rowIndex, goods_num);
    }
    
    

    function loadInventoryData(rowIndex, goods_num) {
        $.ajax({
            url: "/stock/invenList",
            type: "GET",
            data: { goods_num: goods_num },
            dataType: "json",
            success: function(data) {
                var modalBody = $('#inventoryModalBody');
                modalBody.empty();
                
                data.forEach(function(item) {
                    var row = '<tr data-inventory="' + item.inven_num + '" data-warehouse="' + item.s_cate_wh_name + '">' +
                        '<td>' + item.inven_num + '</td>' +
                        '<td>' + item.warehouseCodeList[0].s_cate_wh_name + '</td>' +
                        '</tr>';
                    modalBody.append(row);
                });
                
                modalBody.find('tr').on('click', function() {
                    var inventoryNum = $(this).data('inventory');
                    var warehouseName = $(this).data('warehouse');
                    
                    $('input.inventory-input[data-row="' + rowIndex + '"]').val(inventoryNum);
                    
                    $('#inventoryModal').modal('hide');
                });
            },
            error: function(error) {
                console.error('에러 발생:', error);
            }
        });
    }

    // 테이블 데이터를 JSON으로 변환
   function dataChangeJSON() {
        var tableRows = $('#tableBody tr');
        var tableData = [];
        
        tableRows.each(function() {
             var row = $(this);
              var inven_num = row.find('td:eq(2) input').val(); // 재고번호
              var inven_qty = row.find('td:eq(3)').text(); // 수량

              var rowData = {
                    inven_num: inven_num,
                 inven_qty: inven_qty,
            };
            
            tableData.push(rowData);
        });
        
        console.log(JSON.stringify(tableData));
        return tableData;
    }


    // 초기화
    getTransactionList();

});
</script>

<%@ include file="../../include/footer.jsp" %>
</html>