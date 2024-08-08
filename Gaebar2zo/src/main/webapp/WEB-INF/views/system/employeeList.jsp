<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<!-- sweet alert 추가 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<body>
	<div>
		  <div class="container-fluid mt-5">
            <div class="row">
                <div class="col-md-3 mb-3">
                    <form action="/system/employeeList" method="get" class="form-inline mt-3">
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
                    </form>
                </div>
            </div>
        </div>
		
		<div class="d-grid gap-2 d-md-flex justify-content-md-end"
			style="margin-right: 10px; padding: 10px;">
			<button class="btn btn-primary" type="button"
				onclick="showRegisterModal()">등록</button>
			<button class="btn btn-primary" type="button" id="updateEmp">수정</button>
			<button class="btn btn-primary" type="button" id="deleteEmp">삭제</button>
		</div>
	</div>
	<table class="table table-hover">
      <thead>
      	<tr>
         <th scope="col"> 
            <div class="form-check">
           	   <input class="form-check-input" type="checkbox" value="" id="selectAll" onclick = "toggleCheckboxes(this)"> 
            </div>
         </th>
	         <th scope="col">사용자ID</th>
	         <th scope="col">사용자명</th>
	         <th scope="col">비밀번호</th>
	         <th scope="col">직책</th>
	         <th scope="col">E-MAIL</th>
	         <th scope="col">전화번호</th>
      	</tr>
      </thead>
      <tbody>
			<c:forEach var="emptbl" items="${employeeList }">
				<tr>
					<td>
				  		<div class="form-check">
                  			<input class="form-check-input itemCheckbox" type="checkbox"> 
               			</div>
               		</td>
               		<td>${emptbl.username }</td>
               		<td>${emptbl.user_per_name}</td>
               		<td>${emptbl.password }</td>
               		<td>${emptbl.user_pos}</td>
               		<td>${emptbl.user_email  }</td>
               		<td>${emptbl.user_phone }</td>
               		<td></td>
				</tr>	
			</c:forEach>

		</tbody>
		
   </table>
	
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
						<div class="col-12 d-flex justify-content-end" style="margin-bottom: 10px;">
							<button class="btn btn-primary" type="submit" id="submitBtn" name="submitBtn">저장</button>
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
            </div>
        </form>
    </div>
</div>
	
	
	
    <!-- addEmp.js 연결 -->   
    <script src="../resources/js/addEmp.js"></script>
    
<%@ include file="../include/footer.jsp" %>
</body>
</html>