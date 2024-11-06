/**
 * 시스템 등록 - 등록, 수정,삭제
 */
    
function showRegisterModal() {
    $('#registerModal').modal('show');
}

// '전체 선택' 체크박스가 클릭될 때 호출되는 함수
function toggleCheckboxes(source) {
    const checkedCheckboxes = document.querySelectorAll('input[type="checkbox"].form-check-input');
    checkedCheckboxes.forEach(checkbox => checkbox.checked = source.checked);
}

$(document).ready(function() {
    // CSRF 토큰을 가져오는 부분 
    const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");
    const name = $("#userName").val();

    // 사용자 삭제 버튼 클릭 이벤트
    $("#deleteEmp").click(function() {
        const checkedCheckboxes = $('input[type="checkbox"].form-check-input:checked');
//        console.log("선택된 체크박스 수:", checkedCheckboxes.length);
        const usernames = [];

        checkedCheckboxes.each(function() {
            const username = $(this).closest('tr').find('td:eq(1)').text(); 
            if (username) {  
//                console.log("추출된 username:", username);
                usernames.push(username);
            }
        });

        // selectedCodes 배열에 저장된 값을 콘솔에 출력하여 확인
        console.log("usernames:", usernames);
        
        if (usernames.length === 0) {
            Swal.fire('Error', '삭제할 사용자를 선택해주세요.', 'error');
            return;
        }

        Swal.fire({
            title: "삭제 확인",
            text: "선택한 항목 " + usernames.length + "개를 삭제하시겠습니까?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: "예, 삭제합니다.",
            cancelButtonText: "아니요, 취소합니다."
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '/system/deleteEmp',  // 서버 측 컨트롤러 매핑 URL
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(usernames),
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader(header, token);  // CSRF 토큰 설정
                    },
                    success: function(response) {
                        Swal.fire('Deleted!', '사용자를 삭제되었습니다.', 'success').then(() => {
                            location.reload();  // 페이지 새로고침
                        });
                    },
                    error: function(error) {
                        console.log("AJAX Error:", error); // 오류 정보를 콘솔에 출력
                        Swal.fire('Error', '삭제 중 오류가 발생했습니다.', 'error');
                    }
                });
            }
        });
    });
    
    //사용자 수정(업데이트)-------------------------------------- 
    
    let originalData = {}; //초기
    
    $("#updateEmp").click(function() {
    	
    	 const checkedCheckboxes = $('input.itemCheckbox:checked');
    	
        // 선택된 체크박스의 수를 콘솔에 출력
        console.log("선택된 체크박스 수:", checkedCheckboxes.length);
        
     // 선택된 체크박스의 각 요소를 콘솔에 출력하여 확인
        checkedCheckboxes.each(function(index, checkbox) {
            console.log("선택된 체크박스", index + 1, ":", checkbox);
        });
        
        
    	if (checkedCheckboxes.length !== 1) {
            Swal.fire('알림', '수정할 항목을 하나만 선택하세요.', 'warning');
            return;
        }
    	
    	//체크박스가 속한 테이블 행에서 특정 데이터 가져오기
    	var selectedRow = $(checkedCheckboxes[0]).closest('tr'); // jQuery 객체로 변환
        
    	 const username = selectedRow.find('td:eq(1)').text().trim();  // 사용자ID
    	    const userName = selectedRow.find('td:eq(2)').text().trim();  // 사용자명
    	    const userPassword = selectedRow.find('td:eq(3)').text().trim();  // 비밀번호
    	    const userPos = selectedRow.find('td:eq(4)').text().trim();  // 직책
    	    const userEmail = selectedRow.find('td:eq(5)').text().trim();  // 이메일
    	    const userPhone = selectedRow.find('td:eq(6)').text().trim();  // 전화번호
        
//        console.log("선택된 행의 데이터:", {
//            username: username,
//            userName: userName,
//            userEmail: userEmail,
//            userPhone: userPhone,
//            userPos: userPos
//        });
//        
        $("#edit_username").val(username);
        $("#edit_user_per_name").val(userName);
        $("#edit_user_email").val(userEmail);
        $("#edit_user_phone").val(userPhone);
        $("#edit_user_pos").val(userPos);

        // 초기 데이터 저장
        originalData = {
            username: username,
            userName: userName,
            userEmail: userEmail,
            userPhone: userPhone,
            userPos: userPos
        };
        
        //모달 폼 
        $("#updateEmpModal").modal('show');
    });

    // 저장 버튼 클릭 시
    $("#saveEditedEmp").click(function() {
        var data = {
            username: $("#edit_username").val(),
            user_per_name: $("#edit_user_per_name").val(),
            user_email: $("#edit_user_email").val(),
            user_phone: $("#edit_user_phone").val(),
            user_pos: $("#edit_user_pos").val()
        };

     
     $.ajax({
            url: '/system/updateEmp', // 실제 서버 측 URL로 변경해야 합니다.
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token); // CSRF 토큰 설정
            },
            success: function(response) {
                Swal.fire('저장 완료', '사용자 정보가 저장되었습니다.', 'success').then(() => {
                    $('#updateEmpModal').modal('hide');
                    location.reload();
                });
            },
            error: function(xhr, status, error) {
                // 400 에러 시 오류 정보를 콘솔에 출력
                console.log("Error status:", status);
                console.log("Error details:", error);
                console.log("Server response:", xhr.responseText);
                Swal.fire('Error', '저장 중 오류가 발생했습니다.', 'error');
            }
        });
    });
    
	 // 취소 버튼 클릭 시
		$('#cancelEditEmp').click(function(){
			 
			// 초기값으로 되돌리기
			$("#edit_username").val(originalData.username);
			$("#edit_user_per_name").val(originalData.userName);
			$("#edit_user_email").val(originalData.userEmail);
			$("#edit_user_phone").val(originalData.userPhone);
			$("#edit_user_pos").val(originalData.userPos);
		    
		});
		   
    
    
    // 유효성 검사 함수들
    function regMemberName(user_per_name) {
        var regExp = /^[가-힣]{1,10}$/;
        return regExp.test(user_per_name);
    }

    function regMemberPassword(password) {
        var regExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;
        return regExp.test(password);
    }

    function regMemberEmail(user_email) {
        var regExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return regExp.test(user_email);
    }

    function regMemberPhone(user_phone) {
        var regExp = /^010-\d{4}-\d{4}$/;
        return regExp.test(user_phone);
    }

    // 유효성 검사 로직
    $('#user_per_name').on('input', function() {
        checkName();
    });

    $('#password, #passwordCheck').on('input', function() {
        validatePassword();
        validatePasswordMatch();
    });

    $('#user_email').on('input', function() {
        validateEmail();
    });

    $('#user_phone').on('input', function() {
        validateCheckPhone();
    });

    // 폼 제출 시 모든 유효성 검사 및 중복 체크 확인
    $('#registerForm').on('submit', function(event) {
        event.preventDefault(); // 폼 제출 막음

        if (!validateForm()) {
            return; // 유효성 검사 실패시 제출 중단
        }
        var formDataArray = $(this).serializeArray(); // 폼 데이터 직렬화
        var formData = {};
        formDataArray.forEach(function(item) {
            formData[item.name] = item.value;
        });
        
        console.log("Collected formData:", formData); // 직렬화된 폼 데이터를 콘솔에 출력하여 확인
        
        $.ajax({
            url: '/system/addEmp',
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
            },
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(formData), // 직렬화된 폼 데이터 전송
            success: function(response){
                console.log(response);
                if(response.status === "success"){
                    Swal.fire('성공', '사용자 등록 완료', 'success').then(function() {
                        location.reload(); // 페이지 새로고침
                    });
                } else {
                    Swal.fire('실패', response.message || '사용자 등록에 실패했습니다.', 'error');
                }
            },
            error: function(xhr, status, error) {
                Swal.fire('실패', '서버에 문제가 발생했습니다. 다시 시도해 주세요.', 'error');
                console.error('register AJAX Error: ', status, error);
            }
        });
    });

    // 모든 유효성 검사 및 중복 체크 확인
    function validateForm() {
        checkName();
        validatePassword();
        validatePasswordMatch();
        validateEmail();
        validateCheckPhone();
    
        if ($('#nameError').is(':visible') ||
            $('#pwError').is(':visible') ||
            $('#pwMatchError').is(':visible') ||
            $('#emailError').is(':visible') ||
            $('#emailExists').is(':visible') ||
            $('#telError').is(':visible') ||
            $('#telExists').is(':visible')) {
            return false; // 유효성 검사 실패 시 폼 제출 중단
        }
    
        return true; // 모든 검사를 통과한 경우
    }

    // 유효성 검사 함수들
    function checkName() {
        var user_name = $('#user_per_name').val();
        var nameError = $('#nameError');
        var nameSuccess = $('#nameSuccess');

        if (!regMemberName(user_name)) {
            nameError.show();
            nameSuccess.hide();
        } else {
            nameError.hide();
            nameSuccess.show();
        }
    }

    function validatePassword() {
        var upwd = $('#password').val();
        var passwordError = $('#pwError');

        if (regMemberPassword(upwd)) {
            passwordError.hide();
        } else {
            passwordError.show();
        }
    }

    function validatePasswordMatch() {
        var upwd = $('#password').val();
        var cpwd = $('#passwordCheck').val();
        var pwMatchSuccess = $('#pwMatchSuccess');
        var pwMatchError = $('#pwMatchError');

        if (upwd === cpwd && upwd !== '' && cpwd !== '') {
            pwMatchSuccess.show();
            pwMatchError.hide();
        } else {
            pwMatchSuccess.hide();
            pwMatchError.show();
        }
    }

    function validateEmail() {
        var email = $('#user_email').val();
        var emailError = $('#emailError');
        var emailExists = $('#emailExists');
        var emailAvailable = $('#emailAvailable');

        if (!regMemberEmail(email)) {
            emailError.show();
            emailExists.hide();
            emailAvailable.hide();
            return;
        } else {
            emailError.hide();
        }

        // 이메일 중복 체크를 위한 Ajax 요청
        $.ajax({
            url: '/system/emailCheck',
            type : 'GET',
            dataType: 'json',
            data: { user_email: email },
            success: function(response) {
                if (response === 1) { 
                    emailExists.show();
                    emailAvailable.hide();
                } else {
                    emailExists.hide();
                    emailAvailable.show();
                }
            },
            error: function(xhr, status, error) {
                console.error('이메일 AJAX Error: ', status, error);
            }
        });
    }

    function validateCheckPhone() {
        var user_phone = $('#user_phone').val();
        var telError = $('#telError');
        var telSuccess = $('#telSuccess');
        var telExists = $('#telExists');

        if (!regMemberPhone(user_phone)) {
            telError.show();
            telSuccess.hide();
            telExists.hide();
        } else {
            telError.hide();
            
            // 전화번호 중복 체크를 위한 Ajax 요청
            $.ajax({
                url: '/system/phoneCheck',
                type: 'GET',
                dataType: 'json',
                data: { user_phone: user_phone },
                success: function(response) {
                    console.log("AJAX 전화번호 응답:", response);
                    if (response === 1) { 
                        telExists.show();
                        telSuccess.hide();
                    } else {
                        telExists.hide();
                        telSuccess.show();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('전화번호 ajax Error: ', status, error);
                }
            });
        }
    }
});
	
//=======================================
	//모달 닫기
	$('#modalCloseBtn').on('click', function() {
	    $('#registerModal').modal('hide');
	    $('#registerModal form')[0].reset(); // 폼 초기화
	    
	    // span 태그 초기화
	    $('#registerModal span.text-danger').hide(); // 에러 메시지 숨기기
	    $('#registerModal span.text-success').hide(); // 성공 메시지 숨기기
	});
	
	//수정&상세 모달 닫기
	$('#updateEmpModalCloseBtn').on('click', function(){
		$('#updateEmpModal').modal('hide');
		$('#updateEmpForm')[0].reset();//폼 초기화
	});
				