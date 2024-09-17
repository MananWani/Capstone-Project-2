<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<c:url value='/resources/images/meetup.png'/>">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Rubik&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Handjet:wght@100..900&family=Nerko+One&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link href="<c:url value="/resources/css/footer.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/navbar.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/profile.css" />"
	rel="stylesheet">

<title>Profile</title>
</head>
<body>
	<%
	String designation = (String) session.getAttribute("designation");
	if ("HR".equals(designation)) {
	%>
	<nav class="navbar navbar-expand-lg" style="height: 70px !important;position: sticky ;
	top: 0;
	z-index: 1000;
	background-color: #fff;
	border-bottom: 1px solid #e1e1e1;">
		<div class="container">
			<p class="navbar-brand"
				style="margin-top: 16px; font-size: 3rem !important; display: flex; align-items: center;">
				<img src="<c:url value='/resources/images/meetup.png' />" alt="Logo"
					class="navlogo"
					style="width: 60px; height: 60px; margin-bottom: 4px;"> eetup
			</p>
			<div class="collapse navbar-collapse" id="navbarScroll">
				<ul class="navbar-nav m-auto my-2 my-lg-0">
					<li class="nav-item"><a class="nav-link active"
						href="${pageContext.request.contextPath}/user/hrhome">Home</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle active" href="#"
						id="employeeDropdown" role="button" data-bs-toggle="dropdown"
						aria-expanded="false"> Employees </a>
						<ul class="dropdown-menu" aria-labelledby="employeeDropdown">
							<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/user/register">Add
									Employee</a></li>

							<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/user/getallusers">View
									Employees</a></li>
						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle active" href="#"
						id="meetingRoomDropdown" role="button" data-bs-toggle="dropdown"
						aria-expanded="false"> Meeting Rooms </a>
						<ul class="dropdown-menu" aria-labelledby="meetingRoomDropdown">
							<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/meetingroom/addroom">Add
									Room</a></li>
							<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/meetingroom/getallrooms">View
									Rooms</a></li>

						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle active" href="#"
						id="meetingRoomDropdown" role="button" data-bs-toggle="dropdown"
						aria-expanded="false"> Meeting</a>
						<ul class="dropdown-menu" aria-labelledby="meetingRoomDropdown">
							<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/meeting/addmeeting">Schedule
									Meeting</a></li>
							<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/meeting/getallmeetings">View
									Meetings</a></li>
							<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/meeting/calendar">
									Calendar</a></li>		

						</ul></li>
					<li class="nav-item"><a class="nav-link active"
						href="${pageContext.request.contextPath}/user/profile">Profile</a></li>
				</ul>
				<a class="btn0"
					href="${pageContext.request.contextPath}/user/logout">Logout</a>
			</div>
		</div>
	</nav>
	<!-- End Of Navbar -->
	<%
	} else {
	%>
	<nav class="navbar navbar-expand-lg" style="height: 70px !important;position: sticky ;
	top: 0;
	z-index: 1000;
	background-color: #fff;
	border-bottom: 1px solid #e1e1e1;">
		<div class="container">
			<p class="navbar-brand"
				style="margin-top: 16px; font-size: 3rem !important; display: flex; align-items: center;">
				<img src="<c:url value='/resources/images/meetup.png' />" alt="Logo"
					class="navlogo"
					style="width: 60px; height: 60px; margin-bottom: 4px;"> eetup
			</p>
			<div class="collapse navbar-collapse" id="navbarScroll">
				<ul class="navbar-nav m-auto my-2 my-lg-0">
					<li class="nav-item"><a class="nav-link active"
						href="${pageContext.request.contextPath}/user/home">Home</a> <li class="nav-item"><a class="nav-link active"
						href="${pageContext.request.contextPath}/user/getallusers">
							Employees</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="${pageContext.request.contextPath}/meetingroom/getallrooms">
							Meeting Rooms</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle active" href="#"
						id="meetingRoomDropdown" role="button" data-bs-toggle="dropdown"
						aria-expanded="false"> Meeting</a>
						<ul class="dropdown-menu" aria-labelledby="meetingRoomDropdown">
						<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/meeting/addmeeting">Schedule
									Meeting</a></li>
							<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/meeting/getallmeetings">View
									Meetings</a></li>
							
						</ul></li>
						<li class="nav-item"><a class="nav-link active"
						href="${pageContext.request.contextPath}/user/profile">Profile</a></li>
				</ul>
				<a class="btn0"
					href="${pageContext.request.contextPath}/user/logout">Logout</a>
			</div>
		</div>
	</nav>
	<!--End Of Navbar -->
<%
}
%> <c:if test="${not empty error}">
		<div class="alert alert-danger text-center" role="alert"
								style="color: black;">${error}</div>
	</c:if>
	<c:if test="${not empty updated}">
		<div class="alert alert-success mt-3 text-center">${updated}</div>
	</c:if>
	<section class="profile" id="profile">
		<div class="container py-3">
			<div class="row">
				<div class="col-lg-8 mx-auto">
					<h2 class="text-center mb-4" style="font-family: 'Rubik', cursive">User
						Profile</h2>
					<div class="card">
						<div class="card-body">

							<div class="card" style="font-family: 'Rubik', cursive">
								<div class="card-header" style="background-color: white;">
									<h4 class="card-title text-center">User Information</h4>
								</div>
								<div class="card-body">
									<table class="table table-bordered">
										<tbody>
											<tr>
												<th>Full Name</th>
												<td>${user.userFullname}</td>
											</tr>
											<tr>
												<th scope="row">Email Address</th>
												<td>${user.userEmail}</td>
											</tr>
											<tr>
												<th scope="row">Mobile Number</th>
												<td>${user.userMobileNo}</td>
											</tr>
											<tr>
												<th scope="row">Designation</th>
												<td>${user.userDesignation}</td>
											</tr>
											<tr>
												<th scope="row">Manager</th>
												<td>${user.userUnderManager}</td>
											</tr>
											<tr>
												<th scope="row">Organization</th>
												<td><button type="button" class="btn1"
																			onclick="openModal('userTeamModal')">View</button></td>
											</tr>
										</tbody>
									</table>

									<!-- Single Modal Structure for User Team -->
									<div id="userTeamModal" class="modal">
										<div class="modal-content">
											<span class="close" onclick="closeModal('userTeamModal')">&times;</span>
											<h3 class="text-center">Organization</h3>
											<div id="hierarchy">
												<!-- General Manager -->
												<c:forEach var="gm" items="${userTeam}">
													<c:if test="${gm.userDesignation == 'General Manager'}">
														<div class="tier general-manager">
															<h4 class="text-center">${gm.userFullname}-
																${gm.userDesignation}</h4>
															<!-- Managers under General Manager -->
															<div class="managers-container">
																<c:forEach var="manager" items="${userTeam}">
																	<c:if
																							test="${manager.userUnderManager == gm.userFullname}">
																		<div class="manager-card">
																			<h5>${manager.userFullname}-
																				${manager.userDesignation}</h5>
																			<!-- Employees under Managers -->
																			<div class="employee-list">
																				<c:forEach var="employee" items="${userTeam}">
																					<c:if
																											test="${employee.userUnderManager == manager.userFullname}">
																						<p>${employee.userFullname}-
																							${employee.userDesignation}</p>
																					</c:if>
																				</c:forEach>
																			</div>
																		</div>
																	</c:if>
																</c:forEach>
															</div>
														</div>
													</c:if>
												</c:forEach>
											</div>
										</div>
									</div>

									<c:url var="updateLink" value="updatepassword">
										<c:param name="userId" value="${user.userId}" />
									</c:url>
									<a href="${updateLink}" class="btn btn-success"
															style="border: none; background: crimson;">Change Password</a>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End Of Main -->

	<jsp:include page="/footer.jsp" />
	<script
							src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		function openModal(modalId) {
			document.getElementById(modalId).style.display = 'block';
		}

		function closeModal(modalId) {
			document.getElementById(modalId).style.display = 'none';
		}

		// Close the modal if the user clicks outside of it
		window.onclick = function(event) {
			var modals = document.getElementsByClassName('modal');
			for (var i = 0; i < modals.length; i++) {
				if (event.target == modals[i]) {
					modals[i].style.display = "none";
				}
			}
		}
	</script>

					</body>
</html>