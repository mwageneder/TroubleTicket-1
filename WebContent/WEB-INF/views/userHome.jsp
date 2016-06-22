<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<html lang="en">
<head>

<title>Deal with IT | Home</title>

<script src="resources/js/jquery-1.11.3.min.js"></script>

<link rel="icon" href="resources/images/favicon.ico">
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
<link rel="stylesheet" href="resources/js/datatables/datatables.css">
<link rel="stylesheet" href="resources/js/select2/select2-bootstrap.css">
<link rel="stylesheet" href="resources/js/select2/select2.css">

</head>
<body class="page-body" data-url="http://neon.dev">

	<div class="page-container">

		<div class="sidebar-menu">

			<div class="sidebar-menu-inner">

				<header class="logo-env">
				<div class="logo">
					<img src="resources/images/DealWithIT_Logo.png" width="200" alt="" />
				</div>

				<div class="sidebar-mobile-menu visible-xs">
					<a href="#" class="with-animation"> <!-- add class "with-animation" to support animation -->
						<i class="entypo-menu"></i>
					</a>
				</div>
				</header>

				<ul id="main-menu" class="main-menu">
					<!-- add class "multiple-expanded" to allow multiple submenus to open -->
					<!-- class "auto-inherit-active-class" will automatically add "active" class for parent elements who are marked already with class "active" -->

					<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_SUPPORT')">
						<li><a href="supportHome"> <i class="entypo-home"></i> <span
								class="title"><strong>Home</strong></span>
						</a></li>
					</sec:authorize>

					<sec:authorize access="hasRole('ROLE_USER')">
						<li><a href="userHome"> <i class="entypo-home"></i> <span
								class="title"><strong>Home</strong></span>
						</a></li>
					</sec:authorize>

					<li><a href="dashboard"> <i class="entypo-docs"></i> <span
							class="title"><strong>Tickets</strong></span>
					</a></li>

					<li><a href="createTicket"> <i class="entypo-plus-circled"></i>
							<span class="title"><strong>Create Ticket</strong></span>
					</a></li>

					<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_SUPPORT')">
						<li><a href="createUser"> <i class="entypo-user-add"></i>
								<span class="title"><strong>Create User</strong></span>
						</a></li>
					</sec:authorize>

					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<li><a href="createSupport"> <i class="entypo-user-add"></i>
								<span class="title"><strong>Create Support</strong></span>
						</a></li>
					</sec:authorize>
				</ul>
			</div>
		</div>


		<div class="main-content">


			<div class="row">

				<!-- Profile Info and Notifications -->
				<div class="col-md-6 col-sm-8 clearfix">
					<ul class="user-info pull-left pull-none-xsm">
						<!-- Profile Info -->

						<li class="profile-info dropdown"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <img
								src="${user.picture}" alt="" class="img-circle" width="50" /><span
								class="currentUser">${user.username}</span>

						</a>
							<ul class="dropdown-menu">
								<!-- Reverse Caret -->
								<li class="caret"></li>
								<!-- Edit Profile link -->
								<li><a href="editUser"> <i class="entypo-pencil"></i></i>
										Edit Profile
								</a></li>
								<li><a href="editPicture"> <i class="entypo-pencil"></i></i>
										Edit Picture
								</a></li>
							</ul></li>
					</ul>

				</div>
				<div style="float: right;">
					<c:url value="/logout" var="logoutUrl" />
					<form action="${logoutUrl }" method="post">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
						<button type="submit" class="btn btn-primary">
							<i class="entypo-logout"></i> Logout
						</button>
					</form>
				</div>
				<br> <br> <br> <br>

				<script type="text/javascript">
					jQuery(window)
							.load(
									function() {
										var $table2 = jQuery("#table-2");

										// Initialize DataTable
										$table2.DataTable({
											"sDom" : "tip",
											"bStateSave" : false,
											"iDisplayLength" : 8,
											"aoColumns" : [ {
												"bSortable" : false
											}, null, null, null, null ],
											"bStateSave" : true
										});

										// Highlighted rows
										$table2
												.find(
														"tbody input[type=checkbox]")
												.each(
														function(i, el) {
															var $this = $(el), $p = $this
																	.closest('tr');

															$(el)
																	.on(
																			'change',
																			function() {
																				var is_checked = $this
																						.is(':checked');

																				$p[is_checked ? 'addClass'
																						: 'removeClass']
																						('highlight');
																			});
														});

										// Replace Checboxes
										$table2.find(".pagination a").click(
												function(ev) {
													replaceCheckboxes();
												});
									});

					// Sample Function to add new row
					var giCount = 1;

					function fnClickAddRow() {
						jQuery('#table-2')
								.dataTable()
								.fnAddData(
										[
												'<div class="checkbox checkbox-replace"><input type="checkbox" /></div>',
												giCount + ".1", giCount + ".2",
												giCount + ".3", giCount + ".4" ]);
						replaceCheckboxes(); // because there is checkbox, replace it
						giCount++;
					}
				</script>

				<div class="login-header login-caret">
					<hr>
					<br>
					<h1>
						Welcome <strong>${user.username}</strong>&nbsp;!
					</h1>
					<h5>Please create a ticket so you we can deal with IT!</h5>
					<img class="image-responsive center-block"
						src="resources/images/DealWithIT_Logo.png" alt="DealWithIT Logo" />
					<hr>
				</div>
				<br>
				<div class="col-md-12">
					<div class="tile-stats tile-white tile-white-orange col-md-12">
						<div class="icon">
							<i class="entypo-lock-open"></i> <i class="entypo-docs"></i>
						</div>
						<c:set var="value" scope="session" value="${openTT}" />
						<c:choose>
							<c:when test="${value == null}">
								<div class="num">0</div>
							</c:when>
							<c:when test="${value == 0}">
								<div class="num">0</div>
							</c:when>
							<c:when test="${value != null }">
								<div class="num" data-start="0" data-end="${openTT}"
									data-prefix="" data-postfix="" data-duration="1500"
									data-delay="0"></div>
							</c:when>
						</c:choose>
						<h3>My Open Tickets</h3>
					</div>
					<div class="tile-stats tile-white tile-white-orange col-md-12">
						<div class="icon">
							<i class="entypo-check"></i><i class="entypo-docs"></i>
						</div>
						<c:set var="value" scope="session" value="${managedTT}" />
						<c:choose>
							<c:when test="${value == null}">
								<div class="num">0</div>
							</c:when>
							<c:when test="${value == 0}">
								<div class="num">0</div>
							</c:when>
							<c:when test="${value != null }">
								<div class="num" data-start="0" data-end="${managedTT}"
									data-prefix="" data-postfix="" data-duration="1500"
									data-delay="0"></div>
							</c:when>
						</c:choose>
						<h3>My Managed Tickets</h3>
					</div>
					<div class="tile-stats tile-white tile-white-orange col-md-12">
						<div class="icon">
							<i class="entypo-lock"></i><i class="entypo-docs"></i>
						</div>
						<c:set var="value" scope="session" value="${closedTT}" />
						<c:choose>
							<c:when test="${value == null}">
								<div class="num">0</div>
							</c:when>
							<c:when test="${value == 0}">
								<div class="num">0</div>
							</c:when>
							<c:when test="${value != null }">
								<div class="num" data-start="0" data-end="${closedTT}"
									data-prefix="" data-postfix="" data-duration="1500"
									data-delay="0"></div>
							</c:when>
						</c:choose>
						<h3>My Closed Tickets</h3>
					</div>
					<div class="tile-stats tile-white tile-white-orange col-md-12">
						<div class="icon">
							<i class="entypo-chat"></i> <i class="entypo-docs"></i>
						</div>
						<c:set var="value" scope="session" value="${comments}" />
						<c:choose>
							<c:when test="${value == null}">
								<div class="num">0</div>
							</c:when>
							<c:when test="${value == 0}">
								<div class="num">0</div>
							</c:when>
							<c:when test="${value != null }">
								<div class="num" data-start="0" data-end="${comments}"
									data-prefix="" data-postfix="" data-duration="1500"
									data-delay="0"></div>
							</c:when>
						</c:choose>
						<h3>Comments on My Tickets</h3>
					</div>
				</div>
				<br> <br> <br> <br>
				<div class="col-md-12">
					<div class="tile-stats tile-white tile-white-orange col-md-12">
						<div class="icon">
							<i class="entypo-info-circled"></i> <i class="entypo-users"></i>
						</div>
						<c:set var="value" scope="session" value="${supportUsers}" />
						<c:choose>
							<c:when test="${value == null}">
								<div class="num">0</div>
							</c:when>
							<c:when test="${value == 0}">
								<div class="num">0</div>
							</c:when>
							<c:when test="${value != null }">
								<div class="num" data-start="0" data-end="${supportUsers}"
									data-prefix="" data-postfix="" data-duration="1500"
									data-delay="0"></div>
							</c:when>
						</c:choose>
						<h3>Supports available</h3>
					</div>
					<div class="tile-stats tile-white tile-white-orange col-md-12">
						<div class="icon">
							<i class="entypo-users"></i> <i class="entypo-users"></i> <i
								class="entypo-users"></i>
						</div>
						<c:set var="value" scope="session" value="${users}" />
						<c:choose>
							<c:when test="${value == null}">
								<div class="num">0</div>
							</c:when>
							<c:when test="${value == 0}">
								<div class="num">0</div>
							</c:when>
							<c:when test="${value != null }">
								<div class="num" data-start="0" data-end="${users}"
									data-prefix="" data-postfix="" data-duration="1500"
									data-delay="0"></div>
							</c:when>
						</c:choose>
						<h3>Registered Users</h3>
					</div>
				</div>
			</div>
			<footer class="main"><strong>Projekt der FH-Joanneum - SWENGA</strong>&nbsp;| by Thomas Ortmann, Nina Spalek, Max Wageneder</footer>
		</div>
	</div>





	<!-- IMPORTS -->
	<script src="resources/js/gsap/TweenMax.min.js"></script>
	<script src="resources/js/jquery-ui/js/jquery-ui-1.10.3.minimal.min.js"></script>
	<script src="resources/js/bootstrap.js"></script>
	<script src="resources/js/joinable.js"></script>
	<script src="resources/js/resizeable.js"></script>
	<script src="resources/js/neon-api.js"></script>
	<script src="resources/js/datatables/datatables.js"></script>
	<script src="resources/js/select2/select2.min.js"></script>
	<script src="resources/js/neon-chat.js"></script>
	<script src="resources/js/neon-custom.js"></script>
	<script src="resources/js/neon-demo.js"></script>
</body>
</html>