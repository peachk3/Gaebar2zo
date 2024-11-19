<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

    <style>
        .status-buttons { display: none; }
        .modal-dialog { max-width: 80%; }
    </style>
    
    <!-- jQuery and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@coreui/coreui@3.2.2/dist/js/coreui.min.js"></script>
    
</head>

<body class="bg-gray-100 font-sans">
	<div class="container mx-auto px-4 py-8">
		<div class="bg-white rounded-lg shadow-lg p-6">
			<h1 class="text-2xl font-semibold text-gray-800 mb-6">출하 리스트</h1>
			
	<div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-right : 10px; padding : 10px;">
	<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
        <input type="button" class="btn btn-primary" value="등록" onclick="location.href='/sales/shipmentAdd'">
        <input type="button" id="deleteItemBtn" style="background-color:white; color:black;" name="deleteItemBtn" class="btn btn-primary" value="삭제">
    </sec:authorize>
    </div>
      
   <div id="tableContainer" class="transition-all duration-300 ease-in-out">
		<div class="overflow-x-hidden bg-white border 1px solid overflow-y-auto relative" style="height: 405px;">
             <table class="table table-hover border-collapse table-auto w-full whitespace-no-wrap bg-white table-striped relative">
        <thead>
        <tr>
            <th scope="col">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" value="" id="selectAll" onclick="toggleCheckboxes(this)"> 
                </div>
            </th>
            <th scope="col">출하번호</th>
            <th scope="col">거래번호</th>
            <th scope="col">출하예정일자</th>
            <th scope="col">출하창고코드</th>
            <th scope="col">비고</th>
        </tr>
        </thead>
        <tbody>
	        <c:forEach var="sl" items="${sl}">
	            <tr data-tran-num="${sl.tran_num}">
	                <td>
	                <div class="form-check">
                       <input class="form-check-input" type="checkbox" value="${sl.tran_num}" id="${sl.tran_num}"> 
	                </div>
	                </td>
	                <td class="clickable-cell" data-coreui-toggle="modal" data-coreui-target="#poInfoModal">${sl.ship_num}</td>
	                <td class="clickable-cell" data-coreui-toggle="modal" data-coreui-target="#poInfoModal">${sl.tran_num}</td>
	                <td class="clickable-cell" data-coreui-toggle="modal" data-coreui-target="#poInfoModal">${sl.ship_due_date}</td>
	                <td class="clickable-cell" data-coreui-toggle="modal" data-coreui-target="#poInfoModal">${sl.ship_wh_code}</td>
	                <td class="clickable-cell" data-coreui-toggle="modal" data-coreui-target="#poInfoModal">${sl.comm}</td>
	            </tr>
	        </c:forEach>
        </tbody>
    </table>
</div>
</div>
    <div class="container mt-3">
    <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
        <button id="statusChangeBtn" class="btn btn-outline-info">상태 변경</button>
        <div class="status-buttons mt-2">
            <button class="btn btn-outline-info" id="preReceiveBtn">발주 예정</button>
            <button class="btn btn-outline-info" id="completedReceiveBtn">발주 승인</button>
        </div>
        </sec:authorize>
    </div>
    
    
    <!-- 페이징 처리 -->
	<nav aria-label="Page navigation" class="pagination-container">
	   <ul class="pagination justify-content-center">
	      <c:if test="${pageVO.prev}">
	         <li class="page-item">
	            <a class="page-link" href="/sales/shipmentList?page=${pageVO.startPage - 1}" aria-label="Previous">
	               <span aria-hidden="true">&laquo;</span>
	            </a>
	         </li>
	      </c:if>
	      <c:forEach var="i" begin="${pageVO.startPage}" end="${pageVO.endPage}" step="1">
	         <li class="page-item ${pageVO.cri.page == i ? 'active' : ''}">
	            <a class="page-link" href="/sales/shipmentList?page=${i}">${i}</a>
	         </li>
	      </c:forEach>
	      <c:if test="${pageVO.next && pageVO.endPage > 0}">
	         <li class="page-item">
	            <a class="page-link" href="/sales/shipmentList?page=${pageVO.endPage + 1}" aria-label="Next">
	               <span aria-hidden="true">&raquo;</span>
	            </a>
	         </li>
	      </c:if>
	   </ul>
	</nav>
</div>
</div>

    <!-- poInfoModal -->
    <div class="modal fade" id="poInfoModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">출하 상세정보</h5>
                    <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
					<div class="row g-3">
						<div class="col-12">
							<div class="progress">
								<div class="progress-bar" id="pro_status" role="progressbar" style="width: 0%;" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
							<dl class="row text-center">
								<dd class="col-sm-3">발주 예정</dd>
								<dd class="col-sm-3">발주 승인</dd>
								<dd class="col-sm-3">입고 예정</dd>
								<dd class="col-sm-3">입고 완료</dd>
		                    </dl>
						</div>
						<div class="col-12">
							<label for="soInfo01" class="form-label">발주번호</label>
								<input type="text" class="form-control" id="tran_num" name="tran_num" readonly>
						</div>
						<div class="col-md-6">
							<label for="soInfo02" class="form-label">발주일자</label> 
								<input type="text" class="form-control" id="tran_date" name="tran_date" readonly>
						</div>
						<div class="col-md-6">
							<label for="soInfo03" class="form-label">입고일자</label> 
								<input type="text" class="form-control" id="rel_date" name="rel_date" readonly>
						</div>
						<div class="col-md-6">
							<label for="soInfo04" class="form-label">납기예정 일자</label> 
								<input type="text" class="form-control" id="ex_due_date" name="ex_due_date" readonly>
						</div>
						<div class="col-md-6">
							<label for="soInfo05" class="form-label">납기일자</label> 
								<input type="text" class="form-control" id="due_date" name="due_date" readonly>
						</div>
						<div class="col-md-3">
							<label for="soInfo06" class="form-label">거래처 번호</label>
								<input type="text" class="form-control" id="cli_num" name="cli_num" readonly>
						</div>
						<div class="col-md-3">
							<label for="soInfo07" class="form-label">거래처명</label>
								<input type="text" class="form-control" id="cli_name" readonly>
						</div>
						<div class="col-md-3">
							<label for="soInfo08" class="form-label">담당자 아이디</label>
								<input type="text" class="form-control" id="pic_username" name="pic_username" readonly>
						</div>
						<div class="col-md-3">
							<label for="soInfo09" class="form-label">담당자명</label>
								<input type="text" class="form-control" id="user_per_name" readonly>
						</div>
						<div class="col-12">
							<label for="soInfo10" class="form-label">비고</label>
								<input type="text" class="form-control" id="comm" name="comm" readonly>
						</div>
						
						<div class="example">
							<ul class="nav nav-underline-border" role="tablist"></ul>
							<table class="table item-table text-left">
								<thead class="table-light">
									<tr>
										<th scope="col" style="width:25%">제품번호</th>
										<th scope="col" style="width:25%">제품명</th>
										<th scope="col" style="width:12%">사이즈</th>
										<th scope="col" style="width:12%">색상</th>
										<th scope="col" style="width:25%">수량</th>
									</tr>
								</thead>
								<tbody id="tableBody">
								</tbody>
							</table>
						</div>
					</div>
                </div>
                <div class="modal-footer">
                <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
                    <button type="button" class="btn btn-primary" id="updateFormBtn"
                    	data-coreui-toggle="modal" data-coreui-target="#poUpdateModal">수정</button>
                </sec:authorize>
                    <button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <!-- poUpdateModal -->
    <div class="modal fade" id="poUpdateModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">발주 상세정보 수정</h5>
                    <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
					<div class="row g-3">
						<form class="row g-3 needs-validation" novalidate>
							<div class="col-12">
								<label for="soInfo01" class="form-label">발주번호</label>
									<input type="text" class="form-control" id="tran_num" name="tran_num" disabled>
							</div>
							<div class="col-md-6">
								<label for="soInfo02" class="form-label">발주일자</label> 
									<input type="text" class="form-control" id="tran_date" name="tran_date" disabled>
							</div>
							<div class="col-md-6">
								<label for="soInfo03" class="form-label">입고일자</label> 
									<input type="text" class="form-control" id="rel_date" name="rel_date" disabled>
							</div>
							<div class="col-md-6">
								<label for="soInfo04" class="form-label">납기예정 일자</label> 
									<input type="date" class="form-control" id="ex_due_date" name="ex_due_date" required>
							</div>
							<div class="col-md-6">
								<label for="soInfo05" class="form-label">납기일자</label> 
									<input type="text" class="form-control" id="due_date" name="due_date" disabled>
							</div>
							<div class="col-md-3">
								<label for="soInfo06" class="form-label">거래처 번호</label>
									<input type="text" class="form-control" id="cli_num" name="cli_num" disabled>
							</div>
							<div class="col-md-3">
								<label for="soInfo07" class="form-label">거래처명</label>
									<input type="text" class="form-control" id="cli_name" disabled>
							</div>
							<div class="col-md-3">
								<label for="soInfo08" class="form-label">담당자 아이디</label>
									<input type="text" class="form-control" id="pic_username" name="pic_username"
									data-coreui-toggle="modal" data-coreui-target="#exampleModal2" required>
							</div>
							<div class="col-md-3">
								<label for="soInfo09" class="form-label">담당자명</label>
									<input type="text" class="form-control" id="user_per_name"
									data-coreui-toggle="modal" data-coreui-target="#exampleModal2" required>
							</div>
							<div class="col-12">
								<label for="soInfo10" class="form-label">비고</label>
									<input type="text" class="form-control" id="comm" name="comm">
							</div>
							
							<div class="example">
								<ul class="nav nav-underline-border" role="tablist"></ul>
								<table class="table item-table text-left">
									<thead class="table-light">
										<tr>
											<th scope="col" style="width:25%">제품번호</th>
											<th scope="col" style="width:25%">제품명</th>
											<th scope="col" style="width:12%">사이즈</th>
											<th scope="col" style="width:12%">색상</th>
											<th scope="col" style="width:25%">수량</th>
										</tr>
									</thead>
									<tbody id="tableBody">
									</tbody>
								</table>
							</div>
						</form>
					</div>
                </div>
                <div class="modal-footer">
                <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
                    <button type="button" class="btn btn-primary" id="submitFormBtn">등록</button>
                    <button type="button" class="btn btn-secondary" data-coreui-toggle="modal" data-coreui-target="#poInfoModal">닫기</button>
                </sec:authorize>
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
	
	
    <%@ include file="../include/footer.jsp" %>
</body>
</html>

<script>

	const token = $("meta[name='_csrf']").attr("content")
	const header = $("meta[name='_csrf_header']").attr("content");
	const name = $("#userName").val();
	
	document.addEventListener('DOMContentLoaded', function() {
		
		const form = document.querySelector('.needs-validation');
		const submitFormBtn = document.getElementById('submitFormBtn');
   
		submitFormBtn.addEventListener('click', function(event) {
			event.preventDefault(); // 기본 제출 동작 방지
			
			const formData = {
					tran_num: $("#poUpdateModal #tran_num").val(),
					tran_date: $("#poUpdateModal #tran_date").val(),
					ex_due_date: $("#poUpdateModal #ex_due_date").val(),
					cli_num: $("#poUpdateModal #cli_num").val(),
					pic_username: $("#poUpdateModal #pic_username").val(),
			        comm: $("#poUpdateModal #comm").val()
		    };
			
			const tableData = dataChangeJSON($("#poUpdateModal #tran_num").val());
			
			
			// 필요한 유효성 검사를 적용할 모든 폼을 가져오기
			const forms = document.querySelectorAll('.needs-validation');
			
			// 모든 폼이 유효성 검사를 통과했는지 여부를 저장하는 변수
			let allFormsValid = true; 
			
			// NodeList를 배열로 변환하고 각각의 폼에 대해 처리
			Array.from(forms).forEach(form => {
				// 유효성 검사 통과 여부 확인
				if (!form.checkValidity()) {
				  event.stopPropagation(); // 상위 요소로 이벤트 전파 방지
				  allFormsValid = false; // 하나라도 유효성 검사를 통과하지 못한 경우
				}
				
				// Bootstrap의 'was-validated' 클래스 추가
				form.classList.add('was-validated');
			});
			
			if (allFormsValid) {
				
				var csrfToken = $('input[name="_csrf"]').attr('content');
				
				$.ajax({
                    type: 'POST',
                    url: '/sales/salesOrderUpdate', // 요청을 보낼 URL
                    beforeSend: function(xhr) {
                    	xhr.setRequestHeader(header, token);
                    },
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify({
                    	tvo: JSON.stringify(formData),
                    	tgvo: JSON.stringify(tableData)
                    }),
                    success: function(response) {
                        console.log('서버 응답:', response);
                        coreui.Modal.getInstance(document.getElementById('poUpdateModal')).hide();
                        info();
                        coreui.Modal.getInstance(document.getElementById('poInfoModal')).show();
                    },
                    error: function(error) {
                        console.error('에러 발생:', error);
                	}
				});
			}
         
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
		            data.forEach(function(item, idx){
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
	
	function dataChangeJSON(tran_num) {
		var tableRows = $('#poUpdateModal .item-table tbody tr'); // 체크된 input의 부모 tr을 선택
	    var tableData = [];
	    
	    tableRows.each(function() {
	        var row = $(this); // 현재 처리 중인 행을 jQuery 객체로 가져옴
	        var goods_num = row.find('td:eq(0)').text().trim(); // 상품 번호 가져오기
	        var goods_qty = row.find('td:eq(4) input').val();
	        
	        // JSON 객체로 데이터 구성
	        var rowData = {
	        	tran_num: tran_num,
	            goods_num: goods_num,
	            goods_qty: goods_qty,
	        };
	        
	        tableData.push(rowData); // 배열에 JSON 객체 추가
	    });
	    
	    var tableDataJSON = JSON.stringify(tableData);
		
	    // 배열을 JSON 문자열로 변환하여 출력
	    console.log(tableDataJSON);
	    
	    return tableData;
	}
	
	function toggleCheckboxes(source) {
	    const checkboxes = document.querySelectorAll('input[type="checkbox"].form-check-input');
	    checkboxes.forEach(checkbox => checkbox.checked = source.checked);
	}
	
	function formatDateForInput(dateStr) {
	    if (!dateStr) return '';
	    var date = new Date(dateStr);
	    return date.toISOString().split('T')[0];
	}
	
	$(document).ready(function() {
	    const token = $("meta[name='_csrf']").attr("content");
	    const header = $("meta[name='_csrf_header']").attr("content");
	
	    $('td[data-coreui-toggle="modal"]').on('click', function() {
	        var tran_num = $(this).closest('tr').data('tran-num');
	        console.log(tran_num);
	
	        $.ajax({
	            type: 'POST',               // 요청 방식
	            url: '/sales/purchaseOrderInfo',  // AJAX 요청을 보낼 URL
	            beforeSend: function(xhr) {
	            	xhr.setRequestHeader(header, token);
	            },
	            contentType: 'application/json; charset=utf-8', // 데이터 형식
	            data: tran_num, // 전송할 데이터
	            dataType: "json",
	            success: function(response) {
	                console.log('성공:', response);
	                
	                $('#poInfoModal .item-table tbody tr').remove();
	                $('#poUpdateModal .item-table tbody tr').remove();
	                
	                response.forEach(function(item, idx){
	                	$('#poInfoModal #pro_status').css('width', pro_status_percent(item.pro_status) + '%');
	                	$('#poInfoModal #pro_status').val(item.pro_status);
	                	$('#poInfoModal #tran_num').val(item.tran_num);
	                	$('#poInfoModal #tran_date').val(timestampToDateString(item.tran_date));
	                	$('#poInfoModal #rel_date').val(timestampToDateString(item.rel_date));
	                	$('#poInfoModal #ex_due_date').val(timestampToDateString(item.ex_due_date));
	                	$('#poInfoModal #due_date').val(timestampToDateString(item.due_date));
	                	$('#poInfoModal #cli_num').val(item.cli_num);
	                	$('#poInfoModal #cli_name').val(item.clientList[0].cli_name);
	                	$('#poInfoModal #pic_username').val(item.userList[0].username);
	                	$('#poInfoModal #user_per_name').val(item.userList[0].user_per_name);
	                	$('#poInfoModal #comm').val(item.comm);
		        	    addInfoRow(item.itemList);
	                   
	                	$('#poUpdateModal #tran_num').val(item.tran_num);
	                	$('#poUpdateModal #tran_date').val(timestampToDateString(item.tran_date));
	                	$('#poUpdateModal #rel_date').val(timestampToDateString(item.rel_date));
	                	$('#poUpdateModal #ex_due_date').val(timestampToDateString(item.ex_due_date));
	                	$('#poUpdateModal #due_date').val(timestampToDateString(item.due_date));
	                	$('#poUpdateModal #cli_num').val(item.cli_num);
	                	$('#poUpdateModal #cli_name').val(item.clientList[0].cli_name);
	                	$('#poUpdateModal #pic_username').val(item.userList[0].username);
	                	$('#poUpdateModal #user_per_name').val(item.userList[0].user_per_name);
	                	$('#poUpdateModal #comm').val(item.comm);
		        	    addUpdateRow(item.itemList);
	                });
	            },
	            error: function(xhr, status, error) {
	                console.error('에러:', status, error);
	                // 에러 시 처리할 내용
	            }
	        });
	    });
	    
	    function addInfoRow(data) {
		    var cnt = 1;
		    
		    data.forEach(function(item, idx){
				var row ='<tr id="row'+ cnt +'">'+
				'<td> <div id="goods-num'+ cnt +'" name="goods_num">'+ item.goodsList[0].goods_num+
				'</div></td>'+
				'<td><div id="goods-name'+ cnt +'">'+ item.item_name +
				'</div></td>'+
				'<td><div id="goods_size'+ cnt +'">'+ item.goodsList[0].goods_size +
				'</div></td>'+
				'<td><div id="goods_color'+ cnt +'">'+ item.goodsList[0].goods_color +
				'</div></td>'+
				'<td><div id="goods_qty'+ cnt +'">'+ item.tranGoodsList[0].goods_qty +
				'</div></td>'+
				'</tr>';
				
				$('#poInfoModal .item-table tbody').append(row);
				cnt++;
			});
		}
	    
	    function addUpdateRow(data) {
		    var cnt = 1;
		    
		    data.forEach(function(item, idx){
				var row ='<tr id="row'+ cnt +'">'+
				'<td> <div id="goods-num'+ cnt +'" name="goods_num">'+ item.goodsList[0].goods_num+
				'</div></td>'+
				'<td><div id="goods-name'+ cnt +'">'+ item.item_name +
				'</div></td>'+
				'<td><div id="goods_size'+ cnt +'">'+ item.goodsList[0].goods_size +
				'</div></td>'+
				'<td><div id="goods_color'+ cnt +'">'+ item.goodsList[0].goods_color +
				'</div></td>'+
				'<td><div>'+
				'<input type="text" id="goods-qty'+ cnt +'" class="form-control form-control-sm" value="'+ item.tranGoodsList[0].goods_qty +'" required>'+
				'</div></td>'+
				'</tr>';
				
				$('#poUpdateModal .item-table tbody').append(row);
				cnt++;
			});
		}
	    
	    function timestampToDateString(timestamp) {
	    	if(timestamp == null) {
		        return "``";
	    	} else {
		        var date = new Date(parseInt(timestamp)); // 밀리초 단위로 변환
		        var year = date.getFullYear();
		        var month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
		        var day = String(date.getDate()).padStart(2, '0'); // 날짜는 1부터 시작
		        
		        return year +'-'+ month +'-'+ day; // YYYY-MM-DD 형식
	    	}
	    }
	    
	    function pro_status_percent(status) {
	    	var pro_status = 0;
	        switch (status) {
	            case '발주 예정':
	            	pro_status = 25;
	            	break;
	            case '발주 승인':
	            	pro_status = 50;
	            	break;
	            case '입고 예정':
	            	pro_status = 75;
	            	break;
	            case '입고 완료':
	            	pro_status = 100;
	            	break;
	        }
	        return pro_status;
	    }
	    
	    $('#updateFormBtn').click(function() {
	    	if (($('#poInfoModal #pro_status').val() != "발주 예정") && ($('#poInfoModal #pro_status').val() != "발주 승인")){
	            $('#poUpdateModal .form-control-sm').prop('disabled', true);
	    	}
        });
		
	    $("#statusChangeBtn").click(function() {
	        $(".status-buttons").toggle();
	    });
	
	    $(".status-buttons .btn").click(function() {
	        const pro_status = $(this).text().trim(); // "입고 예정" 혹은 "입고 완료" 버튼의 텍스트를 상태로 사용
	
	        const checkedCheckboxes = $('input[type="checkbox"].form-check-input:checked');
	        const tran_nums = [];
	
	        checkedCheckboxes.each(function() {
	            const tran_num = $(this).closest('tr').find('td:eq(1)').text(); // Assuming tran_num is in the first column
	            if (tran_num) {
	                tran_nums.push(tran_num);
	            }
	        });
	
	        if (tran_nums.length === 0) {
	            alert('변경할 항목을 선택해주세요.');
	            return;
	        }
	
	        $.ajax({
	            url: '/common/updateStatus',
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify({ tran_nums: tran_nums, pro_status: pro_status }),
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
	        const tran_nums = [];
	
	        checkedCheckboxes.each(function() {
	            const tran_num = $(this).closest('tr').find('td:eq(1)').text();
	            if (tran_num) {  // 빈 문자열이 아닌 경우에만 추가
	                console.log("추출된 tran_num:", tran_num);
	                tran_nums.push(tran_num);
	            }
	        });
	        
	        console.log("최종 tran_nums 배열:", tran_nums);
	        
	        if (tran_nums.length === 0) {
	            alert('삭제할 항목을 선택해주세요.');
	            return;
	        }
	    
	        if (confirm('선택한 ' + tran_nums.length + '개의 항목을 삭제하시겠습니까?')) {
	            $.ajax({
	                url: '/common/deleteTran',
	                beforeSend: function(xhr) {
	                    xhr.setRequestHeader(header, token);
	                },
	                type: 'POST',
	                contentType: 'application/json',
	                data: JSON.stringify({ tran_num : tran_nums }),
	                success: function(response) {
	                    location.reload();
	                    alert("삭제 완료 되었습니다");
	                },
	                error: function(xhr) {
	                    // 서버에서 반환된 오류 메시지 처리
	                    alert(xhr.responseText);  // 오류 메시지 표시
	                    location.reload();
	                }
	            });
	        } // if
	    }); // 버튼

		$('#modal2-table tbody').on('click', 'tr', function() {
			var user1 = $(this).find('td:nth-child(2)').text(); // 두 번째 열(담당자 아이디)
			var user2 = $(this).find('td:nth-child(3)').text(); // 두 번째 열(담당자 명)
			
			// Modal에서 입력된 값을 가져와서 다른 input 요소에 설정
			$('#poUpdateModal #pic_username').val(user1);
			$('#poUpdateModal #user_per_name').val(user2);
			
			// Modal 닫기 (Optional)
			var modal = document.getElementById('exampleModal2');
			var modalInstance = coreui.Modal.getInstance(modal);
			modalInstance.hide();
			coreui.Modal.getInstance(document.getElementById('poUpdateModal')).show();
		});
	    
	});  
</script>