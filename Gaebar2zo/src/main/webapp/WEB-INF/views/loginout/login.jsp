<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CoreUI Bootstrap Admin Template</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <meta name="description" content="CoreUI - Bootstrap Admin Template">
    <meta name="author" content="Łukasz Holeczek">
    <meta name="keyword" content="Bootstrap,Admin,Template,SCSS,HTML,RWD,Dashboard">
    <link rel="apple-touch-icon" sizes="57x57" href="assets/favicon/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="assets/favicon/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="assets/favicon/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="assets/favicon/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="assets/favicon/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="assets/favicon/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="assets/favicon/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="assets/favicon/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="assets/favicon/apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="192x192" href="assets/favicon/android-icon-192x192.png">
    <link rel="icon" type="image/png" sizes="32x32" href="assets/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96" href="assets/favicon/favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16" href="assets/favicon/favicon-16x16.png">
    <link rel="manifest" href="assets/favicon/manifest.json">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="assets/favicon/ms-icon-144x144.png">
    <meta name="theme-color" content="#ffffff">
    <!-- Vendors styles-->
    <link rel="stylesheet" href="vendors/simplebar/css/simplebar.css">
    <!-- Main styles for this application-->
    <link href="css/style.css" rel="stylesheet">
    <!-- We use those styles to show code examples, you should remove them in your application.-->
    <link href="css/examples.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/@coreui/coreui@5.0.2/dist/css/coreui.min.css"
        rel="stylesheet"
        integrity="sha384-39e9UaGkm/+yp6spIsVfzcs3j7ac7G2cg0hzmDvtG11pT1d7YMnOC26w4wMPhzsL"
        crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@coreui/coreui@5.0.2/dist/js/coreui.bundle.min.js"
        integrity="sha384-/lLdeDXcg75fFKvNaXc6K+P80Jk8U+1mKJUYqkLSxqr18HIUvJYVN42+m23Zbw4b"
        crossorigin="anonymous">
    </script>
    <script src="js/config.js"></script>
    
    <script src="js/color-modes.js"></script>
    
   
</head>
<style>
.segoe-font {
    font: 'Noto Sans';
}

</style>

<body>
    <div class="min-vh-100 d-flex flex-row align-items-center">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card-group d-block d-md-flex row">
                        <div class="card col-md-7 p-4 mb-0">
                            <div class="card-body">
                                <h1>Login</h1>
                                <p class="text-body-secondary">Sign In to your account</p>
                                <form action="/login" method="post">
                                    <div class="input-group mb-3">
                                        <span class="input-group-text">
                                            <svg class="icon">
                                                <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-user"></use>
                                            </svg>
                                        </span>
                                        <input class="form-control" type="text" id="username" name="username" placeholder="Username" required="required">
                                        <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
                                    </div>
                                    <div class="input-group mb-4">
                                        <span class="input-group-text">
                                            <svg class="icon">
                                                <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-lock-locked"></use>
                                            </svg>
                                        </span>
                                        <input class="form-control" type="password" id="password" name="password" placeholder="Password" required="required">
                                    </div>
                                    <div class="input-checkbox">
									    <input type="checkbox" id="saveId" name="saveId" style="margin-right:10px;">
									    <label for="saveId" class="segoe-font">아이디 저장</label>
									</div>
                                    <div class="row">
                                        <div class="col-6">
                                            <button type="submit" id="submitBtn" class="btn btn-primary px-4" style="margin-top:15px;" disabled>Login</button>
                                        </div>
                                        <div class="col-6 text-end">
                                            <button class="btn btn-link px-0" type="button">Forgot password?</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="card col-md-5 text-white bg-primary py-5">
                            <div class="card-body text-center">
                                <div>
                                    <h2 style="text-align: center">Styleboso</h2> 
                                   <!--  <p>"스타일보소! 도매로 싸게 퍼주니께, 요거 안 가져가믄 후회할끼라!"</p>  -->
<!--                                     <button class="btn btn-lg btn-outline-light mt-3" type="button">Register Now!</button> -->
                                </div>
                            </div>
                        </div><!-- card col-md-5 text-white bg-primary py-5 끝 -->
                    </div><!-- "card-group d-block d-md-flex row" 끝 -->
                </div><!-- col-lg-8 끝 -->
            </div><!-- row justify-content-center -->
        </div>
    </div><!--min-vh-100 d-flex flex-row align-items-center  -->
  
   
    <!-- CoreUI and necessary plugins-->
    <script src="vendors/@coreui/coreui-pro/js/coreui.bundle.min.js"></script>
    <script src="vendors/simplebar/js/simplebar.min.js"></script>
    <script src="vendors/i18next/js/i18next.min.js"></script>
    <script src="vendors/i18next-http-backend/js/i18nextHttpBackend.js"></script>
    <script src="vendors/i18next-browser-languagedetector/js/i18nextBrowserLanguageDetector.js"></script>
    <script src="js/i18next.js"></script>

	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="/resources/js/login.js"></script>
</body>

<script type="text/javascript">
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
    	console.log("로그인 버튼 클릭됨");
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


</script>
</html>
