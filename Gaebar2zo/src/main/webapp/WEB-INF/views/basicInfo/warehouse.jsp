<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<style>
       table { 
             width: 100%; 
            border-collapse: collapse; 
         } 
         th, td { 
             padding: 10px; 
             text-align: center; 
        } 
        .cell {
            cursor: pointer;
        }
        .selected {
            background-color: #f0f0f0;
        }
 		.grid-container {
            display: grid;
            gap: 1px;
            background-color: #ccc;
        }
        .grid-item {
            padding: 10px;
            background-color: #fff;
            border: 1px solid #ddd;
            text-align: center;
            cursor: pointer;
        }
        .grid-item.selected {
            background-color: #f0f0f0;
        }
    </style>
<body>
        <h1>AA창고별 재고 출력</h1>

    <div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-right : 10px; padding : 10px;">
      <button class="btn btn-primary" id="registWhZoneBtn" name="registWhZoneBtn" type="button" >Zone 등록</button>
      <button class="btn btn-primary" id="registWhBtn" name="registWhBtn" type="button" >Rack 등록</button>
      <button class="btn btn-primary" id="deleteClientBtn" name="deleteClientBtn" type="button">삭제</button>
   </div>

	<div class="row">
		<div class="col">
			<select id="warehouseSelect" class="form-select"
				aria-label="Default select example">
				<option value="">Select Warehouse</option>
				<c:forEach items="${whCodeList}" var="whCodeList">
					<option value="${whCodeList.s_cate_wh_code}" data-wh-name="${whCodeList.s_cate_wh_name}">${whCodeList.s_cate_wh_name}</option>
				</c:forEach>
			</select> <br>
		</div>

		<div class="col">
			<select id="zoneSelect" class="form-select"
				aria-label="Default select example">
				<option value="">Select Zone</option>
			</select>
		</div>
		<div class="col">
			<select id="rackSelect" class="form-select"
				aria-label="Default select example">
				<option value="">Select Rack</option>
			</select> <br>
		</div>
	</div>
	
	<div id="gridContainer" class="grid-container"></div>
	

	<div id="exampleModalToggle" class="modal fade" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalToggleLabel">재고 리스트</h5>
				</div>
				<div class="modal-body">
					<ul id="inventoryList"></ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">닫기</button>				
				</div>
			</div>
		</div>
	</div>
	
	
</body>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@coreui/coreui@3.2.2/dist/js/coreui.min.js"></script>

<script>
const token = $("meta[name='_csrf']").attr("content")
const header = $("meta[name='_csrf_header']").attr("content");
const name = $("#userName").val();

$(document).ready(function() {
	
	$('#registWhZoneBtn').click(function(){
        var wh_code = $('#warehouseSelect').val();
        var fullWhName = $('#warehouseSelect option:selected').data('wh-name');
        
        // 앞 두 글자만 추출
        var wh_name = fullWhName ? fullWhName.substring(0, 2) : '';
        
        if (wh_code) {
            $.ajax({
                url: '/basicInfo/addZone',
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(header, token);
                },
                type: 'POST',
                dataType: 'json',
                data: { wh_code: wh_code, wh_name: wh_name },
                success: function(data) {
                    console.log('Response data:', data);
                    if (data.success) {
                    	console.log('Raw newZone data:', data.newZone);
                    	
                    	const asciiValues = data.newZone;
                    	
                    	let newZoneStr = String.fromCharCode(data.newZone);
                        
                    	console.log(newZoneStr);
                        alert("Zone이 성공적으로 추가되었습니다.");
                        // 새로 추가된 렉을 UI에 반영
                         $('#zoneSelect').append('<option value="' + newZoneStr + '">' + newZoneStr + '</option>');
                        // Optional: column과 row도 업데이트
                    } else {
                        alert("zone 추가에 실패했습니다.");
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error adding rack:', error);
                    alert('오류 발생: zone을 추가할 수 없습니다');
                }
            });
        } else {
            alert('창고 선택하세요.');
        }
    });
    
	$('#registWhBtn').click(function(){
        var wh_code = $('#warehouseSelect').val();
        var wh_zone = $('#zoneSelect').val();
        var fullWhName = $('#warehouseSelect option:selected').data('wh-name');
        
        // 앞 두 글자만 추출
        var wh_name = fullWhName ? fullWhName.substring(0, 2) : '';
        
        if (wh_code && wh_zone) {
            $.ajax({
                url: '/basicInfo/addRack',
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(header, token);
                },
                type: 'POST',
                dataType: 'json',
                data: { wh_code: wh_code, wh_zone: wh_zone, wh_name: wh_name },
                success: function(data) {
                    console.log('Response data:', data);
                    if (data.success) {
                    	console.log(data.newRack);
                        alert("렉이 성공적으로 추가되었습니다.");
                        // 새로 추가된 렉을 UI에 반영
                        $('#rackSelect').append('<option value="' + data.newRack + '">' + data.newRack + '</option>');
                        // Optional: column과 row도 업데이트
                    } else {
                        alert("렉 추가에 실패했습니다.");
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error adding rack:', error);
                    alert('오류 발생: 렉을 추가할 수 없습니다');
                }
            });
        } else {
            alert('창고와 구역을 선택하세요.');
        }
    });


	
    // 창고 선택
    $('#warehouseSelect').change(function() {
        var wh_code = $(this).val();
        $.ajax({
            url: '/basicInfo/getZones',
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
             },
            type: 'POST',
	        dataType: "json",
            data: { wh_code: wh_code },
            success: function(data) {
                console.log(data);
                $('#zoneSelect').empty();
                $('#zoneSelect').append('<option value="">Select Zone</option>');
                $.each(data, function(index, value) {
                    $('#zoneSelect').append('<option value="' + value + '">' + value + '</option>');
                });
            }
        });
    });
    
    // zone 선택
    $('#zoneSelect').change(function() {
        var wh_code = $('#warehouseSelect').val();
        var wh_zone = $(this).val();
        $.ajax({
            url: '/basicInfo/getRacks',
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
             },
            type: 'POST',
	        dataType: "json",
            data: { wh_code: wh_code, wh_zone: wh_zone },
            success: function(data) {
                $('#rackSelect').empty();
                $('#rackSelect').append('<option value="">Select Rack</option>');
                $.each(data, function(index, value) {
                    $('#rackSelect').append('<option value="' + value + '">' + value + '</option>');
                });
            }
        });
    });

    
    // rack 선택
    $('#rackSelect').change(function() {
        var wh_code = $('#warehouseSelect').val();
        var wh_zone = $('#zoneSelect').val();
        var wh_rack = $(this).val();
        $.ajax({
            url: '/basicInfo/getColumnRows',
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
             },
            type: 'POST',
	        dataType: "json",
            data: { wh_code: wh_code, wh_zone: wh_zone, wh_rack: wh_rack },
            success: function(data) {
            	 var columns = data.columns;
                 var rows = data.rows;
                 
                 var tableHtml = '<table class="table table-hover"><thead><tr><th></th>';
                 
              // Add column headers
                 $.each(columns, function(index, column) {
                     tableHtml += '<th>' + column + '</th>';
                 });
                 tableHtml += '</tr></thead><tbody>';

                 // Add rows
                 $.each(rows, function(rowIndex, row) {
                     tableHtml += '<tr><td>' + row + '</td>';
                     $.each(columns, function(columnIndex, column) {
                         tableHtml += '<td class="cell" data-row="' + row + '" data-column="' + column + '">' + row + '-' + column + '</td>';
                     });
                     tableHtml += '</tr>';
                 });

                 tableHtml += '</tbody></table>';
                 $('#gridContainer').html(tableHtml);
             }

        });
    });
    
    $('.modal').modal(); // Initialize modal
    
 // 표 선택
    $(document).on('click', '.cell', function() {
        var row = $(this).data('row');
        var column = $(this).data('column');
        var wh_code = $('#warehouseSelect').val();
        var wh_zone = $('#zoneSelect').val();
        var wh_rack = $('#rackSelect').val();
        var wh_num = wh_code + wh_zone + wh_rack + row + column

        $.ajax({
            url: '/basicInfo/getInventory',
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
             },
            type: 'POST',
	        dataType: "json",
            data: { wh_num: wh_num },
            success: function(response) {
            	
            	 console.log('Inventory data000:', response); // 데이터 확인
                     $('#inventoryList').empty();
            	 
                 if (response.length > 0) {
                	 var item = response[0];
                	 console.log(item);
                	 
                     var tableHtml = '<table class="table"><thead><tr><th>품목 번호</th><th>품목명</th><th>재고량</th></tr></thead><tbody>';
                     $.each(item.itemList, function(index, itemLDetail) {
                    	 tableHtml += '<tr><td>' + itemLDetail.goods_num + '</td><td>' + itemName.item_name + '</td><td>' + itemName.inven_qty + '</td></tr>';
//                          $('#inventoryList').append('<table><thead><tr><th>'+ 품목 번호 + '</th><th>' + 재고량 + '</th></tr></thead><tbody><td>'
//                         		  + value.goods_num + '</td><td>' + value.inven_qty + '</td></tbody></table>');
                     });
                     tableHtml += '</tbody></table>';
                     
                     $('#inventoryList').append(tableHtml);
                     
                 } else {
                	 $('#inventoryList').html('해당 구역 재고 없음 ');
                 }
	                 $('#exampleModalToggle').modal("show");
             },
             error: function(xhr, status, error) {
                 console.error('Error fetching inventory:', error); // 오류 처리
                 $('#inventoryList').html('<li>오류 발생: 재고를 가져올 수 없습니다</li>');
                 $('#inventoryModal').modal('open'); // Open the modal to show the error message
             }
        });

        // Highlight selected cell
        $('.cell').removeClass('selected');
        $(this).addClass('selected');
    });
    
    
});

</script>
<%@ include file="../include/footer.jsp" %>
</html>
