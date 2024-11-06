<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<!-- sweet alert 추가 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<body class="bg-gray-100 font-sans">
		  <div class="container mx-auto px-4 py-8">
            <div class="bg-white rounded-lg shadow-lg p-6">
            <h1 class="text-3xl font-semibold text-gray-800 mb-6">사용자 관리</h1>
            
                    <form action="/system/employeeList" method="get" class="form-inline mt-3">
             		   <div class="flex flex-wrap -mx-3 mb-4 md:flex-nowrap">
					        <div class="w-full md:w-1/2 px-3 mb-6 md:mb-0">
                        <div class="input-group w-500">
                            <div class="input-group-prepend">
                                <select class="form-select custom-select-radius custom-select-width" id="searchType" name="searchType">
                                    <option value="" <c:if test="${empty searchType}">selected</c:if>>전체</option>
                                    <option value="code" <c:if test="${searchType eq 'code'}">selected</c:if>>사용자 ID</option>
                                    <option value="name" <c:if test="${searchType eq 'name'}">selected</c:if>>사용자 이름</option>
                                    <option value="position" <c:if test="${searchType eq 'position'}">selected</c:if>>직책</option>
                                    <option value="email" <c:if test="${searchType eq 'email'}">selected</c:if>>이메일</option>
                                    <option value="phone" <c:if test="${searchType eq 'phone'}">selected</c:if>>전화번호</option>
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
         <th class="checkbox-column"> 
           	   <input class="form-check-input focus:outline-none focus:shadow-outline" type="checkbox" value="" id="selectAll" onclick = "toggleCheckboxes(this)"> 
         </th>
	         <th>사용자ID</th>
	         <th>사용자명</th>
	         <th>비밀번호</th>
	         <th>직책</th>
	         <th>E-MAIL</th>
	         <th>전화번호</th>
      	</tr>
      </thead>
      
			<c:set var="cellClass" value="clickable-cell text-gray-700 px-2 py-2 flex items-center" />

		<tbody class="bg-white divide-y divide-gray-200">
			<c:forEach var="emptbl" items="${employeeList }">
				<tr>
					<td class="text-center">
                  			<input class="form-check-input itemCheckbox focus:outline-none focus:shadow-outline" type="checkbox"> 
               		</td>
               		<td><span class="${cellClass}">${emptbl.username }</span></td>
               		<td><span class="${cellClass}">${emptbl.user_per_name}</span></td>
               		<td><span class="${cellClass}">${emptbl.password }</span></td>
               		<td><span class="${cellClass}">${emptbl.user_pos}</span></td>
               		<td><span class="${cellClass}">${emptbl.user_email  }</span></td>
               		<td><span class="${cellClass}">${emptbl.user_phone }</span></td>
               		<td></td>
				</tr>	
			</c:forEach>
		</tbody>
   </table>
    </div>
	</div>

	<div class="px-5 py-5 bg-white border-t flex flex-col xs:flex-row items-center xs:justify-between">
		<c:url var="pageUrl" value="/system/employeeList">
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
    <!-- 하단버튼 -->
	<div class="flex justify-end items-center px-1 py-0 bg-white">
		<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MANAGER')">
			<button type="button" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded flex items-center mr-2" onclick="showRegisterModal()">
	        <span>등록</span>
	        </button>
			<button type="button" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded flex items-center mr-2" id="updateEmp">
	        <span>수정</span>
	        </button>
	        <button type="button" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded flex items-center" id="deleteEmp">
	        <span>삭제</span>
	       	</button>
	    </sec:authorize>
    </div>
	</div>
</div>  

	<!-- 추가 버튼 모달창 -->
	 <!-- Modal -->
	 <div class="modal fade" id="registerModal" role="dialog" tabindex="-1" aria-labelledby="registerModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title w-100 text-center" id="registerModalLabel">사용자등록</h5>
                    <button type="button" class="close" id="modalCloseBtn" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form class="row g-3 needs-validation" id="registerForm" novalidate>
                    <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> <!-- 시큐리티 토큰!! -->
						<div class="form-floating">
						  <input type="text" class="form-control" id="user_per_name" name="user_per_name" placeholder="이름" required>
						  <label for="user_per_name" style="margin-left: 10px">이름</label>
						   	<span id="nameError" class="text-danger" style="display: none;">유효하지 않은 이름입니다.</span>
                            <span id="nameSuccess" class="text-success" style="display: none;">사용 가능한 이름입니다.</span>
						</div>
						<div class="form-floating">
						  <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
						  <label for="password" style="margin-left: 10px">비밀번호</label>
						 	<span id="pwError" class="text-danger" style="display: none;">비밀번호는 8~16자의 영문, 숫자, 특수기호를 포함해야 합니다.</span>
						</div>
						<div class="form-floating">
						  <input type="password" class="form-control" id="passwordCheck" placeholder="passwordCheck" required>
						  <label for="passwordCheck" style="margin-left: 10px">비밀번호 재확인</label>
						 	<span id="pwMatchError" class="text-danger" style="display: none;">비밀번호가 일치하지 않습니다</span>
                            <span id="pwMatchSuccess" class="text-success" style="display: none;">비밀번호가 일치합니다</span>
						</div>
						<div class="form-floating">
						  <input type="email" class="form-control" id="user_email" name="user_email" placeholder="name@example.com" >
							<label for="user_email" style="margin-left: 10px">이메일</label>
							<span id="emailError" class="text-danger" style="display: none;">유효한 이메일을 입력해주세요.</span>
                            <span id="emailExists" class="text-danger" style="display: none;">사용중인 이메일입니다.</span>
                            <span id="emailAvailable" class="text-success" style="display: none;">사용 가능한 이메일입니다.</span>
						</div>
						<div class="form-floating">
						  <input type="text" class="form-control" id="user_phone" name="user_phone" placeholder="010-1111-2222" required>
						  <label for="user_phone" style="margin-left: 10px">전화번호</label>
						    <span id="telError" class="text-danger" style="display: none;">유효하지 않은 전화번호입니다.</span>
                            <span id="telSuccess" class="text-success" style="display: none;">사용 가능한 전화번호입니다.</span>
							 <span id="telExists" class="text-danger" style="display: none;">이미 사용 중인 전화번호입니다.</span>
						</div>
						<div class="mb-3">
							<select class="form-select" id="user_pos" name="user_pos" required aria-label="select example">
								<option value="운영자">운영자</option>
								<option value="관리자">관리자</option>
								<option value="사원">사원</option>
							</select>
							<div class="invalid-feedback" style="margin-left: 10px">직책을 선택해 주세요</div>
						</div>
						<div class="flex justify-end items-center px-1 py-0 bg-white">
						<button type="submit" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded flex items-center mr-2" 
							id="submitBtn" name="submitBtn">
				        	<span>저장</span>
				        </button>
				        <button type="button" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded flex items-center" data-coreui-dismiss="modal">
				        	<span>닫기</span>
				        </button>
				        </div>
					</form>
                </div>
            </div>
          </div>
    </div>  
    <!-- 상세&수정모달 -->
    <div class="modal fade" id="updateEmpModal" tabindex="-1" role="dialog" aria-labelledby="updateEmpModalLabel">
	  <div class="modal-dialog modal-fullscreen-sm-down" role="document">
        <form class="needs-validation" id="updateEmpForm" novalidate>
            <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title w-100 text-center" id="updateEmpModalLabel">사용자 정보 수정</h5>
                    <button type="button" class="close" id="updateEmpModalCloseBtn" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- 사용자ID -->
                    <div class="form-group mb-3">
                        <label for="edit_username" style="margin-bottom: 5px;"><strong>사용자ID</strong></label>
                        <input type="text" id="edit_username" class="form-control" readonly>
                    </div>
                    <!-- 사용자명 -->
                    <div class="form-group mb-3">
                        <label for="edit_user_per_name" style="margin-bottom: 5px;">사용자명</label>
                        <input type="text" id="edit_user_per_name" class="form-control" readonly>
                    </div>
                    <!-- 사용자 이메일 -->
                    <div class="form-group mb-3">
                        <label for="edit_user_email" style="margin-bottom: 5px;">사용자 이메일</label>
                        <input type="text" id="edit_user_email" class="form-control">
                    </div>
                    <!-- 사용자 전화번호 -->
                    <div class="form-group mb-3">
                        <label for="edit_user_phone" style="margin-bottom: 5px;">사용자 전화번호</label>
                        <input type="text" id="edit_user_phone" class="form-control">
                    </div>
                    <!-- 사용자 직책 -->
                    <div class="form-group mb-3" >
                        <label for="edit_user_pos" style="margin-bottom: 5px;">사용자 직책</label>
                        <select id="edit_user_pos" class="form-control">
                            <option value="운영자">운영자</option>
                            <option value="관리자">관리자</option>
                            <option value="사원">사원</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" id="cancelEditEmp">취소</button>
                    <button type="button" class="btn btn-primary" id="saveEditedEmp">저장</button>
                </div>
<!--                 <div class="flex justify-end items-center px-1 py-0 bg-white"> -->
<!-- 					<button type="button" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded flex items-center mr-2"  -->
<!-- 						id="saveEditedEmp" name="submitBtn"> -->
<!-- 			        	<span>저장</span> -->
<!-- 			        </button> -->
<!-- 			        <button type="button" class="bg-gray-600 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded flex items-center" data-coreui-dismiss="modal"> -->
<!-- 			        	<span>닫기</span> -->
<!-- 			        </button> -->
<!-- 		        </div> -->
            </div>
        </form>
    </div>
</div>
	
	
	
    <!-- addEmp.js 연결 -->   
    <script src="../resources/js/addEmp.js"></script>
    
</body>
<%@ include file="../include/footer.jsp" %>
</html>