<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>

<title>Deal with IT | Login</title>

<script src="resources/js/jquery-1.11.3.min.js"></script>

<link rel="stylesheet" href="resources/css/bootstrap.css">
<link rel="stylesheet" href="resources/css/neon-core.css">
<link rel="stylesheet" href="resources/css/neon-theme.css">
<link rel="stylesheet" href="resources/css/neon-forms.css">
<link rel="stylesheet" href="resources/css/custom.css">
<link rel="stylesheet" href="resources/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css">
<link rel="stylesheet" href="resources/css/font-icons/entypo/css/entypo.css">
<link rel="stylesheet" href="//fonts.googleapis.com/css?family=Noto+Sans:400,700,400italic">
<link rel="icon" href="resources/images/favicon.ico">

<script src="http://www.google-analytics.com/ga.js" async="" type="text/javascript"></script>

</head>
<body class="page-body login-page login-form-fall" data-url="http://neon.dev">

	<div class="login-container">

		<div class="login-header login-caret">
			<img class="image-responsive center-block" src="resources/images/DealWithIT_Logo.png" alt="DealWithIT Logo"/>
		</div>


		<div class="login-form">
		
			<div class="login-content">
			
				<div class="message-box">
					<p>
						<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION.message}">
							<div class="errmessage">${SPRING_SECURITY_LAST_EXCEPTION.message}</div>
						</c:if>
						
						<c:if test="${not empty message}">
							<div class="errmessage">${message}</div>
						</c:if>
					</p>
				</div>


				<c:url value="/login" var="loginUrl" />
				<form action="${loginUrl}" method="post" id="form-login" class="validate">
				
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
								<i class="entypo-user"></i>
							</div>

							<input type="text" class="form-control" name="username"
								id="username" placeholder="Username" autocomplete="off" data-validate="required"
								data-message-required="Username is required" />
						</div>
					</div>


					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
								<i class="entypo-key"></i>
							</div>
							
							<input type="password" class="form-control" name="password"
								id="password" placeholder="Password" autocomplete="off" data-validate="required"
								data-message-required="Password is required" />
						</div>
					</div>


					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-block btn-login">
							<i class="entypo-login"></i> Login
						</button>
					</div>

				</form>
				
				<br><br>
				<div class="form-group">
					<a href="signUp">
						<button type="button" class="btn btn-orange btn-lg btn-block">
							Sign up</button>
					</a>
				</div>
				
			</div>
		</div>
	</div>


	<!-- Bottom scripts (common) -->
	<script src="resources/js/gsap/TweenMax.min.js"></script>
	<script src="resources/js/jquery-ui/js/jquery-ui-1.10.3.minimal.min.js"></script>
	<script src="resources/js/bootstrap.js"></script>
	<script src="resources/js/joinable.js"></script>
	<script src="resources/js/resizeable.js"></script>
	<script src="resources/js/neon-api.js"></script>
	<script src="resources/js/jquery.validate.min.js"></script>
	<script src="resources/js/neon-login.js"></script>
	<script src="http://demo.neontheme.com/assets/js/cookies.min.js" id="script-resource-7"></script>

	<!-- JavaScripts initializations and stuff -->
	<script src="resources/js/neon-custom.js"></script>

	<!-- Demo Settings -->
	<script src="resources/js/neon-demo.js"></script>

</body>
</html>