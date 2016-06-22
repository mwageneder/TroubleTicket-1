<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http:
//www.w3.org/TR/html4/loose.dtd">
<html>
<html lang="en">
<head>

<link rel="icon" href="resources/images/favicon.ico">

<title>Deal with IT | View Ticket</title>

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
<script src="resources/js/jquery-1.11.3.min.js"></script>


</head>
<body class="page-body" data-url="http://neon.dev">

	<div class="page-container">
		<!-- add class "sidebar-collapsed" to close sidebar by default, "chat-visible" to make chat appear always -->


		<div class="sidebar-menu">
			<div class="sidebar-menu-inner">

				<header class="logo-env"> <!-- logo -->
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
					<div class="col-md-2" style="padding: 1%">
						<a href="dashboard" class="btn btn-primary "> <i
							class="entypo-left"></i></a>
					</div>
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
					jQuery(document).ready(
							function($) {
								var $table4 = jQuery("#table-4");
								$table4.DataTable({
									dom : 'Bfrtip',
									buttons : [ 'copyHtml5', 'excelHtml5',
											'csvHtml5', 'pdfHtml5' ]
								});
							});
				</script>



				<!-- ####################################################################################################### -->
				<br>
				<div class="panel panel-default panel-shadow" data-collapsed="0">
					<!-- setting the attribute data-collapsed="1" will collapse the panel -->
					<!-- panel head -->
					<div class="panel-heading">
						<div class="panel-title">
							<h3>${ticket.subject}</h3>
						</div>
						<div class="panel-options">
							<a href="#" data-rel="collapse"><i class="entypo-down-open"></i></a>
						</div>
					</div>
					<!-- panel body -->
					<div class="panel-body">
						<div class="slimScrollDiv"
							style="position: relative; overflow: hidden; width: auto; height: auto;">
							<div class="scrollable" data-height="200"
								data-scroll-position="right" data-rail-color="#fff"
								data-rail-opacity=".9" data-rail-width="8" data-rail-radius="10"
								data-autohide="0"
								style="overflow: hidden; width: auto; height: auto;">
								<div class="col-sm-5 col-md-5">
									<blockquote class="blockquote-default">
										<p>
											<strong>Description</strong>
										</p>
										<p>
											<small>${ticket.description}</small>
										</p>
									</blockquote>

									<c:set var="reason" scope="session"
										value="${ticket.closingReason}" />
									<c:choose>
										<c:when test="${reason != null }">
											<blockquote class="blockquote-default">
												<p>
													<strong>Reason for Closing</strong>
												</p>
												<p>
													<small>${ticket.closingReason}</small>
												</p>
											</blockquote>
										</c:when>
										<c:otherwise></c:otherwise>
									</c:choose>

								</div>
								<div class="col-sm-5 col-md-3">
									<table class="table table-bordered responsive">

										<tbody>
											<tr>
												<td>Owner</td>
												<th>${ticket.owner.username}</th>
											</tr>
											<tr>
												<td>Category</td>
												<th>${ticket.category.name}</th>
											</tr>
											<tr>
												<td>Priority</td>
												<th>${ticket.priority}</th>
											</tr>
											<tr>
												<td>Status</td>
												<th>${ticket.status}</th>
											</tr>

										</tbody>
									</table>
									
									<sec:authorize access="hasRole('ROLE_SUPPORT')">
										<c:set var="status" scope="request" value="${ticket.status}" />
										<c:set var="support" scope="request" value="${ticket.support.username}" />
										<c:set var="ticketCat" scope="request" value="${ticket.category.name}" />
										<c:set var="currSupport" scope="request" value="${user.username}" />
										<c:set var="supportCat" scope="request" value="${supportCat.name}" />
										<c:choose>
											<c:when test="${status == 'Open' && ticketCat == supportCat}">
												<a href="manageTicket?id=${ticket.id}"
													class="btn btn-block btn-info btn-icon icon-left"> <i
													class="entypo-check"></i> Manage
												</a>
											</c:when>
											<c:when test="${status == 'Managed' && currSupport == support}">
												<a href="unmanageTicket?id=${ticket.id}"
													class="btn btn-block btn-info btn-icon icon-left"> <i
													class="entypo-ccw"></i> Unmanage
												</a>
											</c:when>
										</c:choose>
									</sec:authorize>
								</div>
								<div class="col-sm-5 col-md-4">
									<table class="table table-bordered responsive">
										<tbody>
											<tr>
												<td>Date created</td>
												<th>${ticket.datecreated}</th>
											</tr>
											<tr>
												<td>Date modified</td>
												<th>${ticket.datemodified}</th>
											</tr>
											<tr>
												<td>Date closed</td>
												<th>${ticket.dateclosed}</th>
											</tr>
											<tr>
												<td>Managed by</td>
												<th>${ticket.support.username}</th>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="slimScrollBar"
								style="width: 8px; position: absolute; top: 0px; opacity: 0.9; display: block; border-radius: 10px; z-index: 99; right: 1px; height: 49.505px; background: rgb(255, 255, 255);"></div>
							<div class="slimScrollRail"
								style="width: 8px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; opacity: 0.2; z-index: 90; right: 1px; background: rgb(51, 51, 51);"></div>
						</div>
					</div>
				</div>
				<br> <br>
				<div>
					<a href="commentTicket?id=${ticket.id}" class="btn btn-primary">
						<i class="entypo-plus-circled"></i>&nbsp;&nbsp;<strong>Create
							Comment</strong>
					</a>
				</div>
				<br>
				<section class="comments-env">
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-primary">

							<div class="panel-body no-padding">
								<ul class="comments-list">

									<c:forEach items="${comments}" var="comment">
										<li>
											<div class="comment-details">

												<div class="comment-head">
													<p>
														<strong>${comment.author.username}</strong> has commented:
													</p>
												</div>

												<p class="comment-text">${comment.content}</p>

												<div class="comment-footer">
													<c:choose>
														<c:when test="${comment.document.filename != ''}">
															<a href="download?documentId=${comment.document.id}"
																target="_blank"><i class="entypo-attach"></i>&nbsp;<i>${comment.document.filename}</i></a>
														</c:when>
														<c:when test="${comment.document.filename == ''}">
														<i class="entypo-block"></i>&nbsp;no file attached
														</c:when>
													</c:choose>
													<div class="comment-time">${comment.date}</div>
												</div>
											</div>
										</li>
									</c:forEach>
								</ul>
							</div>
							
						</div>
					</div>
				</section>
				<footer class="main"><strong>Projekt der FH-Joanneum - SWENGA</strong>&nbsp;| by Thomas Ortmann, Nina Spalek, Max Wageneder</footer>


				<!-- IMPORTS -->

				<script src="resources/js/gsap/TweenMax.min.js"></script>
				<script
					src="resources/js/jquery-ui/js/jquery-ui-1.10.3.minimal.min.js"></script>
				<script src="resources/js/bootstrap.js"></script>
				<script src="resources/js/joinable.js"></script>
				<script src="resources/js/resizeable.js"></script>
				<script src="resources/js/neon-api.js"></script>
				<script src="resources/js/datatables/datatables.js"></script>
				<script src="resources/js/select2/select2.min.js"></script>
				<script src="resources/js/neon-chat.js"></script>
				<script src="resources/js/neon-custom.js"></script>
				<script src="resources/js/neon-demo.js"></script>
				<script src="resources/js/jx.js"></script>
</body>
</html>
