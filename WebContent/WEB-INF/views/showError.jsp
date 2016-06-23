<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>

<title>Deal with IT | Error ${pageContext.errorData.statusCode}</title>

<script src="resources/js/jquery-1.11.3.min.js"></script>

<link rel="stylesheet" href="resources/css/bootstrap.css">
<link rel="stylesheet" href="resources/css/neon-core.css">
<link rel="stylesheet" href="resources/css/neon-theme.css">
<link rel="stylesheet" href="resources/css/neon-forms.css">
<link rel="stylesheet" href="resources/css/custom.css">
<link rel="stylesheet"
	href="resources/js/jquery-ui/css/no-theme/jquery-ui-1.10.3.custom.min.css">
<link rel="stylesheet"
	href="resources/css/font-icons/entypo/css/entypo.css">
<link rel="stylesheet"
	href="//fonts.googleapis.com/css?family=Noto+Sans:400,700,400italic">
<link rel="icon" href="resources/images/favicon.ico">

<script src="http://www.google-analytics.com/ga.js" async=""
	type="text/javascript"></script>

</head>
<body class="page-body-error">


	<div class="main-content-error">
		<br><br>
		<br> <img class="image-responsive center-block"
			src="resources/images/DealWithIT_Logo.png" alt="DealWithIT Logo" />
		<br>
		<div class="page-error-404">
			<hr><br>
			<div class="error-symbol-inv">
				<i class="entypo-attention"></i>
			</div>
			<div class="error-text">
				<h2><strong>${pageContext.errorData.statusCode}</strong></h2><br>
				<p>Oops, something went wrong !</p>
				<p>Please create a ticket so we can deal with IT!</p>
				<br><br>
				<h10>Stop trying to insert scripts into our forms ;)</h10>
				
			</div>
			<hr>
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
	<script src="http://demo.neontheme.com/assets/js/cookies.min.js"
		id="script-resource-7"></script>

	<!-- JavaScripts initializations and stuff -->
	<script src="resources/js/neon-custom.js"></script>

	<!-- Demo Settings -->
	<script src="resources/js/neon-demo.js"></script>

</body>
</html>
