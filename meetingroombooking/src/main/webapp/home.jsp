<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.Timestamp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/png"
	href="<c:url value='/resources/images/meetup.png'/>">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Rubik&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Handjet:wght@100..900&family=Nerko+One&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<title>Home</title>
<link href="<c:url value="/resources/css/navbar.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/footer.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/home.css" />" rel="stylesheet">

</head>
<body>
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
	<c:if test="${not empty loginSuccess}">
		<div class="alert alert-success mt-3 text-center">${loginSuccess}</div>
	</c:if>
	<section class="main"
		style=" background-image: linear-gradient(rgba(0,0,0,0.75),rgba(0,0,0,0.75)),url('<c:url value="/resources/images/bg.jpg" />');">
		<div class="welcome-message"
			style="background: rgba(255, 255, 255, 0.3);">
			<h1>
				Welcome,
				<%=session.getAttribute("fullname")%>!
			</h1>

			<h5>Welcome to Meetup.</h5>
			<p>Your go-to platform for booking meeting rooms seamlessly.</p>
		</div>
	</section>
	<section class="section">
		<div class="container">
			<div class="cover">
				<h3 style="font-family: 'Rubik', cursive; font-weight: bold;">Meeting
					Rooms</h3>
				<div class="rooms new-position">
					<%
					Timestamp timestamp = new Timestamp(System.currentTimeMillis());
					pageContext.setAttribute("currentTimeStamp", timestamp);
					%>

					<c:set var="currentTime" value="${currentTimeStamp}" />

					<!-- Iterate over the roomList -->
					<c:forEach var="room" items="${roomList}">
						<c:set var="roomName" value="${room.roomName}" />
						<c:set var="isAssigned" value="false" />
						<c:set var="assignedSlot" value="" />

						<!-- Check if the room is booked in any slot -->
						<c:forEach var="slot" items="${slotList}">
							<c:if test="${slot.slotInRoom.roomName == roomName}">
								<!-- Ensure slot times are in Timestamp format -->
								<c:set var="slotStartTime" value="${slot.slotStartTime}" />
								<c:set var="slotEndTime" value="${slot.slotEndTime}" />

								<!-- Check if the current time is within the booking period -->
								<c:choose>
									<c:when
										test="${slotStartTime.before(currentTime) && slotEndTime.after(currentTime)}">
										<c:set var="isAssigned" value="true" />
										<c:set var="assignedSlot" value="${slot}" />
									</c:when>
								</c:choose>
							</c:if>
						</c:forEach>

						<div class="chair-container">
							<c:choose>
								<c:when test="${isAssigned}">
									<div class="room assigned">
										<i class="fa-solid fa-house-laptop"
											onclick="openModal('${room.roomId}')"></i>

									</div>
								</c:when>
								<c:otherwise>
									<div class="room available">
										<i class="fa-solid fa-house-laptop"
											onclick="openModal('${room.roomId}')"></i>

									</div>
								</c:otherwise>
							</c:choose>
							<h1 style="font-family: 'Rubik', cursive; font-weight: bold;"
								class="room-name">${roomName}</h1>
						</div>
					</c:forEach>
				</div>
			</div>
			<!-- Modal Structure -->
			<c:forEach var="room" items="${roomList}">
				<div id="modal-${room.roomId}" class="modal">
					<div class="modal-content">
						<span class="close" onclick="closeModal('${room.roomId}')">&times;</span>
						<h3>Booked Slots</h3>
						<table class="table table-bordered"
							style="font-family: 'Rubik', cursive;">
							<thead>
								<tr>
									<th>Room Name</th>
									<th>Start Time</th>
									<th>End Time</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="hasSlots" value="false" />
								<c:forEach var="slot" items="${slotList}">
									<c:if test="${slot.slotInRoom.roomName == room.roomName}">
										<c:set var="hasSlots" value="true" />
										<tr>
											<td>${slot.slotInRoom.roomName}</td>
											<td><fmt:formatDate value="${slot.slotStartTime}"
													type="both" pattern="dd-MM-yyyy h:mm a" /></td>
											<td><fmt:formatDate value="${slot.slotEndTime}"
													type="both" pattern="dd-MM-yyyy h:mm a" /></td>
										</tr>
									</c:if>
								</c:forEach>

								<c:if test="${!hasSlots}">
									<tr>
										<td colspan="3">All slots are free</td>
									</tr>
								</c:if>
							</tbody>
						</table>
						<!-- Schedule Meeting Button -->
						<div class="modal-footer">
							<form
								action="${pageContext.request.contextPath}/meeting/addmeeting"
								method="get">
								<button type="submit" class="btn0"
									style="margin-right: 260px; width: 200px;">Schedule
									Meeting</button>
							</form>
						</div>
					</div>
				</div>
			</c:forEach>

		</div>
	</section>



	<jsp:include page="/footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
		function openModal(meetingId) {
			document.getElementById('modal-' + meetingId).style.display = 'block';
		}

		function closeModal(meetingId) {
			document.getElementById('modal-' + meetingId).style.display = 'none';
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