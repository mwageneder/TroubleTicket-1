<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Deal with IT | Tickets</title>

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
						<li><a href="createSupport">  <i class="entypo-user-add"></i>
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
						<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_SUPPORT')">
							<a href="supportHome" class="btn btn-primary "> <i
								class="entypo-left"></i></a>
						</sec:authorize>
						<sec:authorize access="hasRole('ROLE_USER')">
							<a href="userHome" class="btn btn-primary"> <i
								class="entypo-left"></i></a>
						</sec:authorize>
					</div>
					<ul class="user-info pull-left pull-none-xsm">
						<!-- Profile Info -->
						
						<li class="profile-info dropdown">
							
							<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <img
								src="${user.picture}" alt="" class="img-circle" width="50" /><span class="currentUser">${user.username}</span>
								
						</a>

							<ul class="dropdown-menu">
								<!-- Reverse Caret -->
								<li class="caret"></li>
								<!-- Edit Profile link -->
								<li><a href="editUser">
										<i class="entypo-pencil"></i></i> Edit Profile
								</a></li>
								<li><a href="editPicture"> <i class="entypo-pencil"></i></i>
										Edit Picture
								</a></li>
							</ul>

						</li>
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
			<br><br><br><br>
			<h3>&nbsp;Tickets</h3>
			<br>

			<script type="text/javascript">
				jQuery(window).load(
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
							$table2.find("tbody input[type=checkbox]").each(
									function(i, el) {
										var $this = $(el), $p = $this
												.closest('tr');

										$(el).on(
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
							$table2.find(".pagination a").click(function(ev) {
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



			<!-- ####################################################################################################### -->

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

			<div id="table-4_wrapper" class="dataTables_wrapper">

				<table class="table table-bordered datatable dataTable" id="table-4"
					role="grid" aria-describedby="table-4_info">

					<thead>

						<tr>
							<th>ID</th>
							<th>Subject</th>
							<th>Category</th>
							<th>Date Created</th>
							<th>Date Modified</th>
							<th>Description</th>
							<th>Priority</th>
							<th>Status</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${troubleTickets}" var="troubleTicket">
							<tr>

								<td>${troubleTicket.id}</td>
								<td>${troubleTicket.subject}</td>
								<td>${troubleTicket.category.name}</td>


								<td><fmt:formatDate type="both" dateStyle="short"
										timeStyle="short" value="${troubleTicket.datecreated}" /></td>
								<td><fmt:formatDate type="both" dateStyle="short"
										timeStyle="short" value="${troubleTicket.datemodified}" /></td>
								<td>${troubleTicket.description}</td>
								<td>${troubleTicket.priority}</td>
								<td>${troubleTicket.status}</td>
								<td>
								
								
								<a href="showComments?id=${troubleTicket.id}"
									class="btn btn-info btn-lg"> <i
										class="entypo-info-circled"></i>
								</a> 
								
								<c:set var="owner" scope="request" value="${troubleTicket.owner.username}" />
								<c:set var="support" scope="request" value="${troubleTicket.support.username}" />
								<c:set var="current" scope="request" value="${user.username}" />
								<c:choose>
								<c:when test="${owner == current || support == current}">
									<a href="editTicket?id=${troubleTicket.id}"
									class="btn btn-orange btn-lg"> <i
									class="entypo-pencil"></i>
								</a> 
								</c:when>
								</c:choose>
								
								<!-- Security --> <sec:authorize
										access="hasAnyRole('ROLE_ADMIN', 'ROLE_SUPPORT')">
										<!-- Security -->

										<!-- toggling the modal -->
										<c:set var="checkStatus" scope="session" value="${troubleTicket.status}" />
										<c:set var="support" scope="request" value="${troubleTicket.support.username}" />
										<c:set var="current" scope="request" value="${user.username}" />
										<c:choose>
											<c:when test="${checkStatus == 'Managed' && support == current}">
											<a class="btn btn-red btn-lg"
													data-toggle="modal" href="#modal-${troubleTicket.id}"><i
													class="entypo-lock"></i></a>
											</c:when>
										</c:choose>
										
										<!-- toggling the modal -->

										<!-- START_Modal -->
										<div class="modal fade" id="modal-${troubleTicket.id}"
											style="display: none;">
											<div class="modal-dialog">
												<div class="modal-content">
													<div class="modal-header">
														<h4 class="modal-title">Close Ticket ID:
															${troubleTicket.id}</h4>
													</div>

													<form role="form"
														class="form-horizontal form-groups-bordered" method="post"
														action="closeTicket">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}" />
														<div class="modal-body">

															<div class="row">
																<div class="col-md-12">
																	<div class="col-md-12">
																		<div class="form-group">
																			<label for="field-1" class="modal-subtitle">Ticket-ID</label>																	
																				<input class="form-control" name="id" readonly
																					value="<c:out value="${troubleTicket.id}"/>">
																		</div>
																		<div class="form-group">
																			<label for="field-1" class="modal-subtitle">Reason</label>
																			<textarea class="form-control" name="closingReason"
																				placeholder="Please state a reason for closing the Ticket..."
																				rows="8" required></textarea>
																		</div>
																	</div>
																</div>
															</div>
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-lg btn-orange"
																data-dismiss="modal">
																<i class="entypo-cancel"></i>
															</button>
															
															<c:set var="support" scope="request" value="${troubleTicket.support.username}" />
															<c:set var="current" scope="request" value="${user.username}" />
															<c:choose>
															<c:when test="${support == current}">
															<button type="submit"
																class="btn btn-lg btn-red">
																<i class="entypo-lock"></i>
															</button>
															</c:when>
															</c:choose>
														</div>
													</form>
												</div>
											</div>
										</div>
										<!-- END_Modal -->



									</sec:authorize></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>


			<!-- Modal script -->
			<script>
				$(document).ready(function() {
					$("#myBtn").click(function() {
						$("#modal-${troubleTicket.id}").modal({
							backdrop : true
						});
					});
				});
			</script>
			<!-- Modal script -->
			<!-- OLD 
			<a class="btn btn-red btn-sm btn-icon icon-left"
				data-toggle="modal" href="modal${troubleTicket.id}"><i
				class="entypo-lock"></i>Close</a>
			-->
			<br />
			<div>
				<a href="createTicket" class="btn btn-primary"> <i class="entypo-plus-circled"></i>&nbsp;&nbsp;<strong>Create Ticket</strong>
				</a>

				<c:if test="${not empty message}">
					<hr>
					<div class="alert alert-danger">
						<strong>Warning!</strong> ${message}
					</div>
				</c:if>

				<c:if test="${not empty successMessage}">
					<hr>
					<div class="alert alert-success">
						<strong>Great!</strong>${successMessage}</div>
				</c:if>

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