<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page
	import="com.crimsonlogic.meetingroombooking.entity.Meeting,java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png"
	href="<c:url value='/resources/images/meetup.png'/>">

<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Rubik&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Handjet:wght@100..900&family=Nerko+One&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
<title>Calendar</title>
<link href="<c:url value='/resources/css/navbar.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/footer.css' />"
	rel="stylesheet">
<link href="<c:url value='/resources/css/calendar.css' />"
	rel="stylesheet">


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

	<!-- Full-screen background section -->
	<section id="background-section"
		style="background: linear-gradient(rgba(0,0,0,0.75),rgba(0,0,0,0.75)),url('<c:url value="/resources/images/bg.jpg" />') no-repeat center center; 
           background-size: cover; 
           min-height: 100vh; 
           display: flex; 
          ">
		<div id="calendar-container">
			<div id="calendar"></div>
		</div>
	</section>
	<!-- The Modal -->
	<div id="meetingModal" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<h2 class="text-center mb-4" id="meetingTitle"></h2>
			<p>
				<strong>Start Time:</strong> <span id="meetingStartTime"></span>
			</p>
			<p>
				<strong>End Time:</strong> <span id="meetingEndTime"></span>
			</p>
			<p>
				<strong>Status:</strong> <span id="meetingStatus"></span>
			</p>
			<p>
				<strong>Meeting Room:</strong> <span id="meetingRoom"></span>
			</p>

		</div>
	</div>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>
	<script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            events: [
                <%for (Meeting meeting : (List<Meeting>) request.getAttribute("meetingList")) {%>
                {
                    id: "<%=meeting.getMeetingId()%>",
                    title: "<%=meeting.getMeetingPurpose()%>", 
                    start: "<%=meeting.getMeetingStartTime()%>",
                    end: "<%=meeting.getMeetingEndTime()%>",

                    className: 'event-organized',
                    extendedProps: {
                        startTime: "<%=meeting.getMeetingStartTime()%>",
                        endTime: "<%=meeting.getMeetingEndTime()%>",
                        status: "<%=meeting.getMeetingStatus()%>",
                        room: "<%=meeting.getMeetingInRoom().getRoomName()%>",

                    }
                },
                <%}%>
            ],
            eventDidMount: function(info) {
                // Optionally, customize the event appearance further here
                var eventEl = info.el;
                eventEl.style.fontSize = '0.9em'; // Adjust font size
                eventEl.style.padding = '4px'; // Adjust padding
            },
            eventClick: function(info) {
                // Format date using moment.js
                function formatDate(dateString) {
                    return moment(dateString).format('DD/MM/YYYY h:mm A');
                }

                // Populate modal with formatted meeting details
                document.getElementById('meetingTitle').textContent = info.event.title;
                document.getElementById('meetingStartTime').textContent = formatDate(info.event.extendedProps.startTime);
                document.getElementById('meetingEndTime').textContent = formatDate(info.event.extendedProps.endTime);
                document.getElementById('meetingStatus').textContent = info.event.extendedProps.status;
                document.getElementById('meetingRoom').textContent = info.event.extendedProps.room;

                // Show the modal
                var modal = document.getElementById('meetingModal');
                modal.style.display = "flex"; // Use flex to center the modal
            }
        });
        calendar.render();

        // Modal functionality
        var modal = document.getElementById('meetingModal');
        var span = document.getElementsByClassName('close')[0];
        span.onclick = function() {
            modal.style.display = "none";
        }
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    });


    </script>
	<jsp:include page="/footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
