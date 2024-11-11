$(document).ready(function() {
    // 로그인 버튼 활성화/비활성화
    function toggleSubmitButton() {
        if ($("#username").val() && $("#password").val()) {
            $("button[type='submit']").addClass("active");
        } else {
            $("button[type='submit']").removeClass("active");
        }
    }

    // 아이디와 비밀번호 입력 시 버튼 활성화/비활성화
    $("#username, #password").on("keyup change", toggleSubmitButton);

    // 쿠키에서 아이디 불러오기
    var key = getCookie("key");
    $("#username").val(key);

    if ($("#username").val() != "") {
        $("#saveId").attr("checked", true);
    }

    // 아이디 저장 체크박스 동작
    $("#saveId").change(function() {
        if ($("#saveId").is(":checked")) {
            setCookie("key", $("#username").val(), 7);
        } else {
            deleteCookie("key");
        }
    });

    // 아이디 입력 시 쿠키 업데이트
    $("#username").keyup(function() {
        if ($("#saveId").is(":checked")) {
            setCookie("key", $("#username").val(), 7);
        }
    });

    // 로그인 버튼 클릭 시 - 실패/성공
    $("#submitBtn").click(function() {
        var data = {
            username: $("#username").val(),
            password: $("#password").val()
        };

        $.ajax({
            url: '/loginout/login',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token); // CSRF 토큰 설정
            },
            success: function(response) {
                // 로그인 성공
                Swal.fire({
                    title: '로그인 성공',
                    text: '환영합니다!',
                    icon: 'success',
                    confirmButtonText: '확인'
                }).then(() => {
                    window.location.href = 'system/loginout/main'; // 로그인 후 이동할 페이지로 변경
                });
            },
            error: function(xhr, status, error) {
                // 로그인 실패
                Swal.fire({
                    title: '로그인 실패',
                    text: '아이디 또는 비밀번호를 확인하세요.',
                    icon: 'error',
                    confirmButtonText: '확인'
                });
            }
        });
    });
});

// 쿠키 설정 함수
function setCookie(cookieName, value, exdays) {
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}

// 쿠키 삭제 함수
function deleteCookie(cookieName) {
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}

// 쿠키 가져오기 함수
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if (start != -1) {
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if (end == -1) end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}

// 로그인 버튼 활성화/비활성화 (DOM Content Loaded 이벤트)
document.addEventListener('DOMContentLoaded', function() {
    const usernameInput = document.getElementById('username');
    const passwordInput = document.getElementById('password');
    const loginButton = document.querySelector('button[type="submit"]');

    function toggleButtonState() {
        const username = usernameInput.value.trim();
        const password = passwordInput.value.trim();
        const isActive = username && password;

        loginButton.disabled = !isActive;

        if (isActive) {
            loginButton.classList.add('btn-active');
        } else {
            loginButton.classList.remove('btn-active');
        }
    }

    // 초기 상태 설정
    toggleButtonState();

    // 입력 필드 변화 감지
    usernameInput.addEventListener('input', toggleButtonState);
    passwordInput.addEventListener('input', toggleButtonState);
});
