<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../../include/header.jsp" %>

<!-- itemCode.js 연결 -->
<script src="../../../../resources/js/commonCode.js"></script>

<!-- sweet alert 사용 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<body class="bg-gray-100 font-sans">
	<div class="container mx-auto px-4 py-8">
		<div class="bg-white rounded-lg shadow-lg p-6">
			<h1 class="text-3xl font-semibold text-gray-800 mb-6">공통코드 관리</h1>
			
    <div class="d-grid gap-2 d-md-flex justify-content-md-end" style="margin-right: 10px; padding: 10px;">
        <button class="btn btn-primary" type="button" onclick="insertGroupCode()">등록</button>
        <button class="btn btn-primary" type="button" onclick="updateCode()">수정</button>
        <button class="btn btn-primary" style="background-color:white; color:black;" type="button" onclick="deleteCode()">삭제</button>
    </div>
    
<div id="tableContainer" class="transition-all duration-300 ease-in-out">
       <div class="overflow-x-hidden bg-white border overflow-y-hidden relative" id="dynamicTable">
            	<table class="border-collapse table-auto w-full whitespace-no-wrap bg-white table-hover relative">
        <thead>
            <tr class="text-center">
        	 <th class="checkbox-column">
                <input class="form-check-input focus:outline-none focus:shadow-outline" type="checkbox" value="" id="checkAll" onclick="checkAll(this)">
                </th>
                <th>그룹코드</th>
                <th>그룹코드 명</th>
            </tr>
        </thead>
      
			<c:set var="cellClass" value="text-gray-700 px-2 py-2 flex items-center" />

		<tbody class="bg-white divide-y divide-gray-200">
            <c:forEach var="codetbl" items="${codeList}">
                <tr>
                    <td class="text-center">
                  			<input class="form-check-input item-checkbox focus:outline-none focus:shadow-outline" type="checkbox" id="checkAll" value="${codetbl.group_code}">
                    </td>
                    <td><span class="${cellClass}">
                        <c:choose>
                            <c:when test="${fn:startsWith(codetbl.group_code, 'I')}">
                                <a href="item?group_code=${codetbl.group_code}" style="font-weight: bold; color: red;">
                                    <strong>${codetbl.group_code}</strong>
                                </a>
                            </c:when>
                            <c:otherwise>
                                ${codetbl.group_code}
                            </c:otherwise>
                        </c:choose></span>
                    </td>
                    <td><span class="${cellClass}">${codetbl.group_name}</span></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
    </div>
    </div>
 </div>  
	<!-- 등록 모달 -->
	<div class="modal fade" id="insertCodeModal" tabindex="-1" role="dialog" aria-labelledby="insertCodeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <form class="needs-validation" id="insertCodeForm" novalidate>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title w-100 text-center" id="insertCodeModalLabel">공통 그룹코드 등록</h5>
                    <button type="button" class="close" id="insertModalCloseBtn" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                    <table class="table text-center mb-0">
                        <thead>
                            <tr>
                                <th scope="col" class="align-middle">공통 그룹코드</th>
                                <th scope="col" class="align-middle">공통 그룹코드 명</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <input type="text" id="group_code" class="form-control" required>
                               		<span id="validationMessage"></span>
                                </td>
                                <td>
                                    <input type="text" id="group_name" class="form-control" required>
                                    <span id="validationMessage"></span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="saveGroupCode()">저장</button>
                </div>
              </div>
           </form>
       </div>
    </div>
	
	<!-- 상세&수정모달 -->
	<div class="modal fade" id="commonModal" tabindex="-1" role="dialog"
		aria-labelledby="commonModalLabel">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<form class="needs-validation" id="updateCommonForm" novalidate>
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title w-100 text-center" id="commonModalLabel">공통코드 상세정보</h5>
						<button type="button" class="close" id="commonModalCloseBtn" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<table class="table text-center mb-0">
						<thead>
							<tr>
								<th scope="col" class="align-middle">공통그룹 코드</th>
								<th scope="col" class="align-middle">공통그룹 코드 명</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="text" id="edit_group_code" class="form-control" readonly></td>
								<td><input type="text" id="edit_group_name" class="form-control"></td>
							</tr>
						</tbody>
					</table>
					<div class="modal-footer">
						 <button type="button" class="btn btn-secondary d-none" onclick="cancelEdit()">취소</button>
                        <button type="button" class="btn btn-primary" onclick="saveEditedCode()">저장</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	 <script>
    $(document).ready(function() {
        // 등록 모달 닫기와 폼 초기화
        $('#insertModalCloseBtn').on('click', function() {
            $('#insertCodeModal').modal('hide');
            $('#insertCodeForm')[0].reset(); // 폼 초기화
        });

        // 상세 모달 닫기와 폼 초기화
        $('#commonModalCloseBtn').on('click', function() {
            $('#commonModal').modal('hide');
            $('#updateCommonForm')[0].reset(); // 폼 초기화
        });
    });
    </script>

<%@ include file="../../include/footer.jsp" %>
</body>
</html>