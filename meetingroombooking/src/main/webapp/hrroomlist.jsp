<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/png" href="<c:url value='/resources/images/meetup.png'/>">

<link href="<c:url value="/resources/css/navbar.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/footer.css" />"
	rel="stylesheet">
<title>Room List</title>
<style type="text/css">
.scrollable-container::-webkit-scrollbar {
        display: none; /* Hide scrollbar for WebKit browsers (Chrome, Safari) */
    }</style>
</head>
<body>

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
	<c:if test="${not empty roomAdded}">
		<div class="alert alert-success mt-3 text-center">${roomAdded}</div>
	</c:if>
	<section class="rooms" id="rooms">
		<div class="container py-4">
			<h2 class="text-center mb-4"style="font-family: 'Rubik', cursive;">Meeting Room List</h2>
			<c:if test="${not empty roomList}">
				<div class="row">
					<div class="col-lg-8	 mx-auto">
						<div class="card">
							<div class="card-body">
								<div class="scrollable-container"
									style="max-height: 400px; overflow-y: auto; overflow-x: auto;">
									<!-- Table to display orders -->
									<table class="table table-bordered">
										<thead>
											<tr style="font-family: 'Rubik', cursive;">
												<th style="width: 130px;">Room Name</th>
												<th style="width: 120px;">Room Capacity</th>
												<th style="width: 170px;">Equipment Present</th>
												<!-- New column for equipment -->
												<th style="width: 20px;">Actions</th>
												<!-- Column for actions -->
											</tr>
										</thead>
										<tbody>
											<c:forEach var="room" items="${roomList}">
												<!-- Construct an "update" link with room id -->
												<c:url var="updateLink" value="updateroom">
													<c:param name="roomId" value="${room.roomId}" />
												</c:url>
												<tr style="font-family: 'Rubik', cursive;">
													<td style="width: 130px;">${room.roomName}</td>
													<td style="width: 120px;">${room.roomCapacity}</td>

													<td style="width: 170px;"><c:forEach var="equipment"
															items="${equipmentList}">
															<c:if
																test="${equipment.equipmentForRoom.roomId == room.roomId}">
    															${equipment.equipmentName}<br />
															</c:if>

														</c:forEach></td>

													<td style="width: 20px;"><a href="${updateLink}"
														class="btn0">Edit</a> <!-- Edit button --></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${empty roomList}">
				<p style="font-family: 'Rubik', cursive;" class="text-center">No
					room found.</p>
			</c:if>
		</div>
	</section>
	<jsp:include page="/footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>