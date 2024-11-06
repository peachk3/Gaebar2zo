<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<body class="bg-gray-100 font-sans">
	<div class="container mx-auto px-4 py-8">
		<div class="bg-white rounded-lg shadow-lg p-6">
			<h1 class="text-3xl font-semibold text-gray-800 mb-6">재고 현황</h1>
               	<!-- Search Form -->
                <form action="/stock/status" method="get" class="form-inline mt-3">
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
			
			<div id="tableContainer" class="transition-all duration-300 ease-in-out">
				<div class="overflow-x-hidden bg-white border overflow-y-hidden relative" id="dynamicTable">
            		<table class="border-collapse table-auto w-full whitespace-no-wrap bg-white table-hover relative">
                    	<thead>
                 			<tr class="text-center">
		                    	<th>재고 번호</th>
			                    <th>품목명</th>
			                    <th>사이즈</th>
			                    <th>색상</th>
			                    <th>창고명</th>
			                    <th>구역명</th>
			                    <th>재고 위치</th>
			                    <th>재고 수량</th>
			                </tr>
			            </thead>
			            
						<c:set var="cellClass" value="clickable-cell text-gray-700 px-6 py-2 flex items-center" />
			
						<tbody class="bg-white divide-y divide-gray-200">
						    <c:forEach var="sl" items="${sl}">
						        <c:forEach var="item" items="${sl.itemList}">
						            <c:forEach var="warehouse" items="${sl.warehouseList}">
						                <c:forEach var="goods" items="${sl.goodsList}">
						                    <tr>
						                        <td><span class="${cellClass}">${sl.inven_num}</span></td>
						                        <td><span class="${cellClass}">${item.item_name}</span></td>
						                        <td><span class="${cellClass}">${goods.goods_size}</span></td>
						                        <td><span class="${cellClass}">${goods.goods_color}</span></td>
						                        <td><span class="${cellClass}">${warehouse.wh_name}</span></td>
						                        <td><span class="${cellClass}">${warehouse.wh_zone}</span></td>
						                        <td><span class="${cellClass}">${warehouse.wh_rack}</span></td>
						                        <td><span class="${cellClass}">${sl.inven_qty}</span></td>
						                    </tr>
						                </c:forEach>
						            </c:forEach>
						        </c:forEach>
						    </c:forEach>
						</tbody>
						
			        </table>
				</div>
			</div>
			<div class="px-5 py-5 bg-white border-t flex flex-col xs:flex-row items-center xs:justify-between">
		        <c:url var="pageUrl" value="/stock/status">
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
		</div>
	</div>
	
<!-- Modal -->
<div class="modal fade" id="itemModal" tabindex="-1" aria-labelledby="itemModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="itemModalLabel">상세 정보</h5>
                <button type="button" class="btn-close" data-coreui-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p><strong>품목코드:</strong> <span id="modalItemCode"></span></p>
                <p><strong>품목명:</strong> <span id="modalItemName"></span></p>
                <p><strong>창고명:</strong> <span id="modalWhName"></span></p>
                <p><strong>구역명:</strong> <span id="modalWhZone"></span></p>
                <p><strong>재고위치:</strong> <span id="modalWhRack"></span></p>
                <p><strong>현재재고:</strong> <span id="modalInvenQty"></span></p>
                <p><strong>입고단가:</strong> <span id="modalPurchasePrice"></span></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-coreui-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // 테이블의 모든 행을 선택
    const rows = document.querySelectorAll('tbody tr');
    
    rows.forEach(row => {
        row.addEventListener('click', function() {
            // 데이터 속성에서 값을 가져옴
            const data = this.dataset;
            
            // 모달의 각 요소에 값을 설정
            document.getElementById('modalItemCode').textContent = data.itemCode || '정보 없음';
            document.getElementById('modalItemName').textContent = data.itemName || '정보 없음';
            document.getElementById('modalWhName').textContent = data.whName || '정보 없음';
            document.getElementById('modalWhZone').textContent = data.whZone || '정보 없음';
            document.getElementById('modalWhRack').textContent = data.whRack || '정보 없음';
            document.getElementById('modalInvenQty').textContent = data.invenQty || '정보 없음';
            document.getElementById('modalPurchasePrice').textContent = 
                data.purchasePrice && data.purchasePrice !== '0' ? data.purchasePrice : '정보 없음';

            // 모달 표시
            const itemModal = new coreui.Modal(document.getElementById('itemModal'));
            itemModal.show();
        });
    });
    
    // 행에 커서 포인터 스타일 추가
    rows.forEach(row => {
        row.style.cursor = 'pointer';
    });
});
// document.addEventListener('DOMContentLoaded', function() {
//     const rows = document.querySelectorAll('#stockTable .table-row');
//     rows.forEach(row => {
//         row.addEventListener('click', function() {
//             const itemCode = this.dataset.itemCode;
//             const itemName = this.dataset.itemName;
//             const whName = this.dataset.whName;
//             const whZone = this.dataset.whZone;
//             const whRack = this.dataset.whRack;
//             const invenQty = this.dataset.invenQty;
//             const purchasePrice = this.dataset.purchasePrice;

//             document.getElementById('modalItemCode').innerText = itemCode;
//             document.getElementById('modalItemName').innerText = itemName;
//             document.getElementById('modalWhName').innerText = whName;
//             document.getElementById('modalWhZone').innerText = whZone;
//             document.getElementById('modalWhRack').innerText = whRack;
//             document.getElementById('modalInvenQty').innerText = invenQty;
//             document.getElementById('modalPurchasePrice').textContent = 
//                 purchasePrice && purchasePrice !== '0' ? purchasePrice : '정보 없음';

//             const itemModal = new coreui.Modal(document.getElementById('itemModal'));
//             itemModal.show();
//         });
//     });
// });
</script>

</body>

<%@ include file="../include/footer.jsp" %>

</html>