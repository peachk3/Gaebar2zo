/**
 * 시스템 등록 - 등록, 수정,삭제
 */
function showRegisterModal() {
    $('#registerModal').modal('show');
}

// '전체 선택' 체크박스가 클릭될 때 호출되는 함수
function toggleCheckboxes(source) {
    const checkboxes = document.querySelectorAll('input[type="checkbox"].form-check-input');
    checkboxes.forEach(checkbox => checkbox.checked = source.checked);
}

$(document).ready(function() {
    // CSRF 토큰을 가져오는 부분 
    const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");
    const name = $("#userName").val();

    // 사용자 삭제 버튼 클릭 이벤트
    $("#deleteEmp").click(function() {
        const checkedCheckboxes = $('input[type="checkbox"].form-check-input:checked');
        console.log("선택된 체크박스 수:", checkedCheckboxes.length);
        const usernames = [];

        checkedCheckboxes.each(function() {
            const username = $(this).closest('tr').find('td:eq(1)').text(); 
            if (username) {  
                console.log("추출된 username:", username);
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

    // 여기서부터 문제발생~!
    // 폼 제출 시 모든 유효성 검사 및 중복 체크 확인
    $('#registerForm').on('submit', function(event) {
        event.preventDefault(); // 폼 제출 막음

        if (!validateForm()) {
            return; // 유효성 검사 실패시 제출 중단
        }
        var formData = $(this).serialize(); // 폼 데이터 직렬화
//        console.log(formData); // 직렬화된 폼 데이터를 콘솔에 출력하여 확인
        
        $.ajax({
            url: '/system/addEmp',
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
            },
            type: 'POST',
            dataType: 'json',
            data: formData, // 직렬화된 폼 데이터 전송
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
        var user_phone = $('#inputTel').val();
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
	
	
				