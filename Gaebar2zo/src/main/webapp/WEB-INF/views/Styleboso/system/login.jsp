<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>login.jsp</h1>
	
	
	<h1> 아이티윌 로그인 </h1>
	
	<fieldset>
		<legend>로그인</legend>
		<form action="/login" method="post">
			아이디 : <input type="text" name="username"> <br>
			비밀번호 : <input type="password" name="password"> <br>
			
		<!-- 히든 토큰 정보를 가지고 있어야만 로그인 가능 -->
		<!-- 서버(시큐리티)에서 토큰 여부를 체크 -->
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<input type="submit" value="로그인">	
		</form>
	
	
	</fieldset>
	
	
	
	
	
</body>
</html>