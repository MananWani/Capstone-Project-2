<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<link href="<c:url value="/resources/css/addmeeting.css" />"
	rel="stylesheet">
<script src="<c:url value="/resources/js/addmeeting.js" />"></script>

<title>Update Meeting</title>
</head>
<body>
	<%
	String designation = (String) session.getAttribute("designation");
	if ("HR".equals(designation)) {
	%>
	<nav class="navbar navbar-expand-lg"
		style="height: 70px !important; position: sticky; top: 0; z-index: 1000; background-color: #fff; border-bottom: 1px solid #e1e1e1;">
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
	<nav class="navbar navbar-expand-lg"
		style="height: 70px !important; position: sticky; top: 0; z-index: 1000; background-color: #fff; border-bottom: 1px solid #e1e1e1;">
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
						href="${pageContext.request.contextPath}/user/home">Home</a>
					<li class="nav-item"><a class="nav-link active"
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
	<!--End Of Navbar -->
	<%
	}
	%>

	<section class="py-3 py-md-5"
		style="background: linear-gradient(rgba(0,0,0,0.75),rgba(0,0,0,0.75)),url('<c:url value="/resources/images/bg.jpg" />') no-repeat center center; 
           background-size: cover; 
           min-height: 100vh; 
           display: flex; 
           align-items: center; 
           justify-content: center;">
		<div class="container" style="max-width: 1200px;">
			<div class="row justify-content-center">
				<div class="col-12 col-lg-10">
					<div class="card rounded-3 shadow-sm"
						style="background: rgba(255, 255, 255, 0.3);">
						<div class="card-body p-3 p-md-4 p-xl-5">
							<div class="text-center mb-3" style="margin-top: -30px;">
								<img src="<c:url value='/resources/images/meetup.png' />"
									alt="Logo" class="logo">
							</div>
							<h3 class="text-center mb-4"
								style="color: white; margin-bottom: 10px; font-family: 'Rubik', cursive;">Schedule
								Meeting</h3>
							<!-- Error message display -->

							<c:if test="${not empty notAdded}">
								<div class="alert alert-danger text-center" role="alert"
									style="color: black;">${notAdded}</div>
							</c:if>
							<form id="meetingForm"
								action="${pageContext.request.contextPath}/meeting/updatemeeting"
								method="post">

								<input type="hidden" name="meetingId"
									value="${meeting.meetingId}">

								<div class="row gy-2 overflow-hidden">
									<!-- Meeting By User (Read-Only) -->
									<div class="col-md-6">
										<div class="form-floating mb-3">
											<input type="text" class="form-control" name="meetingByUser"
												id="meetingByUser" style="color: black;"
												value="${meeting.meetingByUser.userFullname}" readonly>
											<label for="meetingByUser" class="form-label"
												style="color: black; font-family: 'Rubik', cursive;">Meeting
												By User</label>
										</div>
									</div>

									<!-- Meeting Start Time -->
									<div class="col-md-6">
										<div class="form-floating mb-3">
											<input type="datetime-local" class="form-control"
												name="meetingStartTime" id="meetingStartTime"
												style="color: black;" oninput="validateStartTime()" required>
											<label for="meetingStartTime" class="form-label"
												style="color: black; font-family: 'Rubik', cursive;">Start
												Time<span class="required-asterisk">*</span>
											</label>
										</div>
										<div id="startTimeError" class="text-danger"
											style="font-weight: bold; background: white; border-radius: 4px;"></div>
									</div>

									<!-- Meeting End Time -->
									<div class="col-md-6">
										<div class="form-floating mb-3">
											<input type="datetime-local" class="form-control"
												name="meetingEndTime" id="meetingEndTime"
												style="color: black;" oninput="validateEndTime()" required>
											<label for="meetingEndTime" class="form-label"
												style="color: black; font-family: 'Rubik', cursive;">End
												Time<span class="required-asterisk">*</span>
											</label>
										</div>
										<div id="endTimeError" class="text-danger"
											style="font-weight: bold; background: white; border-radius: 4px;"></div>
									</div>

									<!-- Meeting Purpose -->
									<div class="col-md-6">
										<div class="form-floating mb-3">
											<input class="form-control" name="meetingPurpose"
												id="meetingPurpose" value="${meeting.meetingPurpose }"
												style="color: black; font-family: 'Rubik', cursive;"
												oninput="validatePurpose()" required></input> <label
												for="meetingPurpose" class="form-label"
												style="color: black; font-family: 'Rubik', cursive;">Meeting
												Purpose<span class="required-asterisk">*</span>
											</label>
										</div>
										<div id="purposeError" class="text-danger"
											style="font-weight: bold; background: white; border-radius: 4px;"></div>
									</div>

									<!-- Meeting Status -->
									<div class="col-md-6">
										<div class="form-floating mb-3">
											<select class="form-select" name="meetingStatus"
												id="meetingStatus"
												style="color: black; font-family: 'Rubik', cursive;"
												onchange="validateStatus()" required>
												<option value="">Select a status</option>
												<option value="Scheduled" selected>Scheduled</option>
											</select> <label for="meetingStatus" class="form-label"
												style="color: black; font-family: 'Rubik', cursive;">Status<span
												class="required-asterisk">*</span></label>
										</div>
										<div id="statusError" class="text-danger"
											style="font-weight: bold; background: white; border-radius: 4px;"></div>
									</div>

									<!-- Meeting Room -->
									<div class="col-md-6">
										<div class="form-floating mb-3">
											<select class="form-select" name="meetingInRoom"
												id="meetingInRoom"
												style="color: black; font-family: 'Rubik', cursive;"
												onchange="validateRoom()" required>
												<option value="" selected>Select a room</option>
												<c:forEach var="room" items="${roomList}">
													<option value="${room.roomId}"
														${meeting.meetingInRoom.roomName eq room.roomName ? 'selected' : ''}>
														${room.roomName}</option>
												</c:forEach>
											</select> <label for="meetingInRoom" class="form-label"
												style="color: black; font-family: 'Rubik', cursive;">Meeting
												Room<span class="required-asterisk">*</span>
											</label>
										</div>
										<div id="roomError" class="text-danger"
											style="font-weight: bold; background: white; border-radius: 4px;"></div>
									</div>

									<!-- Meeting Participants -->
									<div class="col-12">
										<label for="participants" class="form-label"
											style="color: white; font-family: 'Rubik', cursive;">
											Participants<span class="required-asterisk">*</span>
										</label>
										<div class="form-floating mb-3">
											<div class="form-control-wrapper">
												<!-- Search Input -->
												<div class="form-floating col-md-12 mb-3">
													<input type="text" id="searchParticipants"
														class="form-control"
														style="font-family: 'Rubik', cursive;"><label
														for="searchParticipants" class="form-label"
														style="color: black;">Search Participants</label>
												</div>

												<!-- Select All Checkbox -->
												<div class="form-check">
													<input class="form-check-input" type="checkbox"
														id="selectAllParticipants"> <label
														class="form-check-label" for="selectAllParticipants"
														style="color: white; font-family: 'Rubik', cursive;">
														Select All </label>
												</div>

												<!-- Participants Checkboxes -->
												<div class="form-control" id="participants"
													style="height: 150px; overflow-y: auto;">
													<c:forEach var="users" items="${userList}">
														<c:set var="isChecked"
															value="${fn:contains(participantsList, fn:trim(users.userFullname))}" />

														<div class="form-check participant-item">
															<input class="form-check-input" type="checkbox"
																name="participants" id="${users.userFullname}"
																value="${users.userFullname}"
																<c:if test="${isChecked}">checked</c:if>> <label
																class="form-check-label" for="${users.userFullname}"
																style="color: black; font-family: 'Rubik', cursive;">
																${users.userFullname} </label>
														</div>
													</c:forEach>
												</div>
												<div id="participantsError" class="text-danger"
													style="font-weight: bold; background: white; border-radius: 4px; margin-top: 5px;"></div>

											</div>
										</div>
									</div>

									<div class="col-12">
										<div class="d-grid my-3">
											<button class="btn1" type="submit" id="saveButton"
												style="background-color: crimson; margin-left: 250px; border-color: crimson; color: white; font-family: 'Rubik', cursive;">Save
												Meeting</button>
										</div>
									</div>
								</div>
							</form>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<jsp:include page="/footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		document
				.getElementById('searchParticipants')
				.addEventListener(
						'input',
						function() {
							var searchQuery = this.value.toLowerCase();
							var participants = document
									.querySelectorAll('#participants .participant-item');

							participants.forEach(function(participant) {
								var participantName = participant
										.querySelector('label').textContent
										.toLowerCase();
								if (participantName.includes(searchQuery)) {
									participant.style.display = '';
								} else {
									participant.style.display = 'none';
								}
							});
						});
	</script>

</body>
</html>