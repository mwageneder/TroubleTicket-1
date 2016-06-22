<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>

<title>Deal with IT | Sign Up</title>

<script src="resources/js/jquery-1.11.3.min.js"></script>

<link rel="stylesheet"
	href="resources/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css">
<link rel="stylesheet"
	href="resources/css/font-icons/entypo/css/entypo.css">
<link rel="stylesheet"
	href="//fonts.googleapis.com/css?family=Noto+Sans:400,700,400italic">
<link rel="stylesheet" href="resources/css/bootstrap.css">
<link rel="stylesheet" href="resources/css/neon-core.css">
<link rel="stylesheet" href="resources/css/neon-theme.css">
<link rel="stylesheet" href="resources/css/neon-forms.css">
<link rel="stylesheet" href="resources/css/custom.css">
<link rel="icon" href="resources/images/favicon.ico">

<script src="http://www.google-analytics.com/ga.js" async=""
	type="text/javascript"></script>

</head>
<body class="page-body login-page login-form-fall"
	data-url="http://neon.dev">

	<div class="login-container">

		<div class="login-header login-caret">
			<img class="image-responsive center-block"
				src="resources/images/DealWithIT_Logo.png" alt="DealWithIT Logo" />
		</div>


		<div class="login-form">

			<div class="login-content">

				<form method="post" role="form" id="form_User" action="registerUser"
					class="validate" onsubmit="return passVal()">

					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />

					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
								<i class="entypo-user"></i>
							</div>

							<input type="text" class="form-control" name="username"
								id="username" placeholder="Username" autocomplete="off"
								data-validate="maxlength[30]" required />
						</div>
					</div>


					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
								<i class="entypo-vcard"></i>
							</div>

							<input type="text" class="form-control" name="firstName"
								id="firstName" placeholder="Firstname" autocomplete="off"
								data-validate="maxlength[30]" required />
						</div>
					</div>


					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
								<i class="entypo-vcard"></i>
							</div>

							<input type="text" class="form-control" name="lastName"
								id="lastName" placeholder="Lastname" autocomplete="off"
								data-validate="maxlength[30]" required />
						</div>
					</div>


					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
								<i class="entypo-mail"></i>
							</div>

							<input type="email" class="form-control" name="email" id="email"
								placeholder="E-Mail" autocomplete="off"
								data-validate="maxlength[80]" required />
						</div>
					</div>


					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
								<i class="entypo-key"></i>
							</div>

							<input type="password" class="form-control" name="password"
								id="password" placeholder="Enter a secure password" autocomplete="off" required />
						</div>
						<input readonly id="message"
							value="Password must contain 8-16 characters, including at least one upper- and lowercase letter, number and special character!"
							style="display: none; text-align: center; width: 220%; height: 200%; margin-left: -50%; background-color: #303641; border-style: none; color: #ff9600; padding-top: 2%;" />
					</div>


					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-block btn-login">
							<i class="entypo-login"></i> Sign up
						</button>
						<br> <br> <br> <a href="login">
							<button type="button" class="btn btn-orange btn-lg btn-block">
								<i class="entypo-cancel"></i>&nbsp;Cancel
							</button>
						</a>
					</div>

				</form>

			</div>
		</div>
	</div>

	<script type="text/javascript">
		function checkPassword(str) {
			var re = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,16}$/;
			return re.test(str);
		}

		function passVal() {
			var password = document.getElementById("password").value;
			message = document.getElementById("message");

			if (password != "") {
				if (!checkPassword(password)) {
					message.style.display = "block";
					return false;
				}
			}
			return true;
		}
	</script>

	<!-- Bottom scripts (common) -->
	<script src="resources/js/gsap/TweenMax.min.js"></script>
	<script src="resources/js/jquery-ui/js/jquery-ui-1.10.3.minimal.min.js"></script>
	<script src="resources/js/bootstrap.js"></script>
	<script src="resources/js/joinable.js"></script>
	<script src="resources/js/resizeable.js"></script>
	<script src="resources/js/neon-api.js"></script>
	<script src="resources/js/jquery.validate.min.js"></script>
	<script src="resources/js/neon-login.js"></script>
	<script src="http://demo.neontheme.com/assets/js/cookies.min.js"></script>


	<!-- JavaScripts initializations and stuff -->
	<script src="resources/js/neon-custom.js"></script>


	<!-- Demo Settings -->
	<script src="resources/js/neon-demo.js"></script>

</body>
</html>