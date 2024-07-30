<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp" %>
<body>
  
	<div class="container-lg px-4">
		<div class="row">
			<div class="col-12">
				<div class="card mb-4">
					<div class="card-body">
						<form class="row g-3 needs-validation" novalidate>
							<div class="col-md-6">
								<label for="validationCustom01" class="form-label">주문내역</label>
									<input type="text" class="form-control" id="validationCustom01" 
										   data-coreui-toggle="modal" data-coreui-target="#exampleModal0" required>
								<div class="invalid-feedback">주문내역을 선택해주세요</div>
							</div>
							<div class="col-md-6">
								<label for="validationCustom02" class="form-label">수주일자</label> 
									<input type="date" class="form-control"
									id="validationCustom02" required>
								<div class="invalid-feedback">수주일자를 입력해주세요</div>
							</div>
							<div class="col-md-3">
								<label for="validationCustom03" class="form-label">거래처 코드</label>
									<input type="text" class="form-control" id="validationCustom03" 
										   data-coreui-toggle="modal" data-coreui-target="#exampleModal1" required>
								<div class="invalid-feedback">거래처를 입력해주세요</div>
							</div>
							<div class="col-md-3">
								<label for="validationCustom04" class="form-label">거래처 명</label>
									<input type="text" class="form-control" id="validationCustom04" 
										   data-coreui-toggle="modal" data-coreui-target="#exampleModal1" required>
							</div>
							<div class="col-md-3">
								<label for="validationCustom05" class="form-label">담당자 아이디</label>
									<input type="text" class="form-control" id="validationCustom05"
										   data-coreui-toggle="modal" data-coreui-target="#exampleModal2" required>
								<div class="invalid-feedback">담당자를 입력해주세요</div>
							</div>
							<div class="col-md-3">
								<label for="validationCustom06" class="form-label">담당자 명</label>
									<input type="text" class="form-control" id="validationCustom06"
										   data-coreui-toggle="modal" data-coreui-target="#exampleModal2" required>
							</div>
						<div class="example">
							<div class="tab-content rounded-bottom">

								<button id="addRowBtn" class="btn btn-outline-info"
									type="button" style="margin-bottom: 10px;" onclick="addRow();">품목 추가</button>
									
							<ul class="nav nav-underline-border" role="tablist">
							</ul>
								<table class="table item-table">
									<thead class="table-light">
										<tr>
											<th scope="col">#</th>
											<th scope="col">제품번호</th>
											<th scope="col">제품명</th>
											<th scope="col">수량</th>
											<th scope="col">비고</th>
										</tr>
									</thead>
									<tbody id="tableBody">
											<tr id="row1">
												<th scope="row"><input class="form-check-input"
													type="checkbox" id="check1"></th>
												<td> <div class="col-auto">
												    <input type="text" id="goods-num1" class="form-control form-control-sm" 
												    		data-coreui-toggle="modal" data-coreui-target="#exampleModal3" required>
												  </div></td>
												<td><div class="col-auto">
												    <input type="text" id="goods-name1" class="form-control form-control-sm" disabled>
												  </div></td>
												<td><div class="col-auto">
												    <input type="text" id="goods-qty1" class="form-control form-control-sm" required>
												  </div></td>
												<td><div class="col-auto">
												    <input type="text" id="goods-comm1" class="form-control form-control-sm">
												  </div></td>
											</tr>
									</tbody>
								</table>
							</div>
						</div>
							<div class="col-12">
								<button class="btn btn-primary" type="submit" id="submitFormBtn">Submit form</button>
							</div>
							<!-- Modal0 -->
							<div class="modal fade" id="exampleModal0" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-dialog-scrollable">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">주문내역</h5>
											<button type="button" class="btn-close"
												data-coreui-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<table class="table table-hover text-center" id="modal0-table">
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
											<button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">닫기</button>
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
											<table class="table table-hover text-center" id="modal1-table">
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
											<button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">닫기</button>
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
							<!-- Modal3 -->
							<div class="modal fade" id="exampleModal3" tabindex="-1"
								aria-labelledby="exampleModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-dialog-scrollable modal-lg">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLabel">제품<input class="hidden" id="click-row" value=""></h5>
											<button type="button" class="btn-close"
												data-coreui-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<table class="table table-hover text-center" id="modal3-table">
												<thead class="table-light">
													<tr>
														<th scope="col"></th>
														<th scope="col">제품 번호</th>
														<th scope="col">제품 명</th>
														<th scope="col">제품 사이즈</th>
														<th scope="col">제품 색상</th>
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
							
						</form>
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
		display: none;
	}
</style>

<!-- <script src="path/to/bootstrap.bundle.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
   
   document.addEventListener('DOMContentLoaded', function() {
		
		const submitFormBtn = document.getElementById('submitFormBtn');
   
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
         });
       });

      $('#modal1-table tbody').on('click', 'tr', function() {
          var targetInput1 = document.getElementById('validationCustom03');
          var targetInput2 = document.getElementById('validationCustom04');
          var cli1 = $(this).find('td:nth-child(2)').text(); // 두 번째 열(거래처 코드)
          var cli2 = $(this).find('td:nth-child(3)').text(); // 두 번째 열(거래처 코드)

          // Modal에서 입력된 값을 가져와서 다른 input 요소에 설정
          targetInput1.value = cli1;
          targetInput2.value = cli2;
      
          // Modal 닫기 (Optional)
          var modal = document.getElementById('exampleModal1');
          var modalInstance = coreui.Modal.getInstance(modal);
          modalInstance.hide();
      });

      $('#modal2-table tbody').on('click', 'tr', function() {
          var targetInput1 = document.getElementById('validationCustom05');
          var targetInput2 = document.getElementById('validationCustom06');
          var user1 = $(this).find('td:nth-child(2)').text(); // 두 번째 열(거래처 코드)
          var user2 = $(this).find('td:nth-child(3)').text(); // 두 번째 열(거래처 코드)

          // Modal에서 입력된 값을 가져와서 다른 input 요소에 설정
          targetInput1.value = user1;
          targetInput2.value = user2;
      
          // Modal 닫기 (Optional)
          var modal = document.getElementById('exampleModal2');
          var modalInstance = coreui.Modal.getInstance(modal);
          modalInstance.hide();
      });
      
      $('#modal3-table tbody').on('click', 'tr', function() {
          var rowNum = $('#click-row').val();
          var targetInput1 = document.getElementById('goods-num'+ rowNum);
          var targetInput2 = document.getElementById('goods-name'+ rowNum);
          var goods1 = $(this).find('td:nth-child(2)').text();
          var goods2 = $(this).find('td:nth-child(3)').text();
          
          
          // Modal에서 입력된 값을 가져와서 다른 input 요소에 설정
          targetInput1.value = goods1;
          targetInput2.value = goods2;
      
          // Modal 닫기 (Optional)
          var modal = document.getElementById('exampleModal3');
          var modalInstance = coreui.Modal.getInstance(modal);
          modalInstance.hide();
      });
      
      getClientList();
      
      function getClientList() {
         
          $('#modal1-table tbody tr').remove();
          
          $.ajax({
              url: "/common/clientList",
              type: "get",
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
      
      getGoodsList();
      
      function getGoodsList() {
         
          $('#modal3-table tbody tr').remove();
          
          $.ajax({
              url: "/common/goodsList",
              type: "get",
              contentType: 'application/json; charset=utf-8',
              dataType: "json",
              success: function(data) {
                  // body 태그에 내용 추가
                  console.log(data);
                  data.forEach(function(item, idx){
                     console.log(idx);
                     var row = "<tr><th scope='row'>" + (parseInt(idx)+1) + "</th><td>" + item.goods_num + "</td><td>" + item.itemList.map(itemVO => itemVO.item_name).join(', ') + "</td><td>" + item.goods_size + "</td><td>" + item.goods_color + "</td></tr>"
                      $('#modal3-table tbody').append(row);
                  });
                  
              },
              error: function(jqXHR, textStatus, errorThrown) {
                  console.log("AJAX 요청 실패: " + jqXHR.status + ", " + jqXHR.statusText + ", " + textStatus + ", " + errorThrown);
                  alert("AJAX 요청 실패!");
              }
          });
      }
      
      
   });
   
	var cnt = 2;
      
	function addRow() {
		var row = "<tr id='row"+ cnt +"'>" +
			"<th scope='row'><input class='form-check-input' type='checkbox' id='check"+ cnt +"'></th>" +
			"<td> <div class='col-auto'>" +
			"<input type='text' id='goods-num"+ cnt +"' class='form-control form-control-sm' data-coreui-toggle='modal' data-coreui-target='#exampleModal3' required>" +
			"</div></td>" +
			"<td><div class='col-auto'>" +
			"<input type='text' id='goods-name"+ cnt +"' class='form-control form-control-sm' disabled>" +
			"</div></td>" +
			"<td><div class='col-auto'>" +
			"<input type='text' id='goods-qty"+ cnt +"' class='form-control form-control-sm' required>" +
			"</div></td>" +
			"<td><div class='col-auto'>" +
			"<input type='text' id='goods-comm"+ cnt +"' class='form-control form-control-sm'>" +
			"</div></td>" +
		"</tr>";
		$(".item-table tbody").append(row);
		cnt++;
	}
	
    $('#exampleModal3').on('shown.coreui.modal', function(event) {
    	
        // 클릭된 버튼 요소
        var triggerElement = $(event.relatedTarget);
        // 클릭된 버튼 요소의 부모 tr에서 값을 가져옴
        var numArr = triggerElement.closest('tr').attr('id').match(/\d+/g);
        var num = parseInt(numArr[0], 10);
        
        $('#exampleModal3').find('#click-row').val(num);
    });
    
</script>
<%@ include file="../../include/footer.jsp" %>
</body>
</html>