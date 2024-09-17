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
<script src="<c:url value="/resources/js/updatepassword.js" />"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
.logo {
	display: block;
	margin: 10px auto;
	width: 120px;
	height: 100px;
}

.password-container {
	position: relative;
	align-items: center;
}

.password-container input {
	padding-right: 30px;
}

.password-container .toggle-eye {
	position: absolute;
	right: 10px;
	top: 50%;
	transform: translateY(-50%);
	cursor: pointer;
}
</style>
<title>Update Password</title>
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
           justify-content: center;font-family: 'Rubik', cursive">

		<div class="container py-3">
			<div class="row">
				<div class="col-lg-6 mx-auto">

					<div class="card" style="background: rgba(255, 255, 255, 0.3);">
						<div class="card-body">
							<div class="text-center mb-3" style="margin-top: -10px;">
								<img src="<c:url value='/resources/images/meetup.png' />"
									alt="Logo" class="logo">
							</div>
							<h3 style="color: white;" class="text-center mb-4">Change
								Password</h3>

							<form method="post"
								action="${pageContext.request.contextPath}/user/updatepassword"
								onsubmit="return validate();">
								<!-- Error message display -->

								<div class="form-floating mb-3">
									<input type="text" class="form-control" id="userFullname"
										name="userFullname" value="${user.userFullname}" readonly>
									<label for="userFullname" class="form-label"
										style="color: black;">Username</label>
								</div>

								<div class="col-12">
									<div class="form-floating mb-3 password-container"
										id="passwordContainer">

										<input type="password" class="form-control" id="userPassword"
											name="userPassword"><label for="userPassword"
											class="form-label" style="color: black;">Current
											Password</label> <i class="toggle-eye fas fa-eye"
											onclick="togglePasswordVisibility('userPassword', this)"></i>
									</div>
									<div id="userPasswordError" class="text-danger"
										style="margin-bottom: 10px;font-weight: bold;background: white;
										border-radius: 4px;"></div>
								</div>
								<div class="col-12">
									<div class="form-floating mb-3 password-container"
										id="passwordContainer">
										<input type="password" class="form-control" id="newPassword"
											name="newPassword"> <label for="newPassword"
											class="form-label" style="color: black;">New Password</label><i
											class="toggle-eye fas fa-eye"
											onclick="togglePasswordVisibility('newPassword', this)"></i>
									</div>
									<div id="newPasswordError" class="text-danger"
										style="margin-bottom: 10px;font-weight: bold;background: white;
										border-radius: 4px;"></div>

								</div>

								<div class="col-12">
									<div class="form-floating mb-3 password-container">
										<input type="password" class="form-control"
											id="confirmPassword" name="confirmPassword"><label
											for="confirmPassword" class="form-label"
											style="color: black;">Confirm New Password</label> <i
											class="toggle-eye fas fa-eye"
											onclick="togglePasswordVisibility('confirmPassword', this)"></i>
									</div>
									<div id="confirmPasswordError" class="text-danger"
										style="margin-bottom: 10px;font-weight: bold;background: white;
										border-radius: 4px;"></div>

								</div>

								<button type="submit" class="btn btn-primary"
									style="background-color: crimson;margin-left:180px; border: none;">Change
									Password</button>
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
		function togglePasswordVisibility(inputId, icon) {
			const input = document.getElementById(inputId);
			if (input.type === "password") {
				input.type = "text";
				icon.classList.remove('fa-eye');
				icon.classList.add('fa-eye-slash');
			} else {
				input.type = "password";
				icon.classList.remove('fa-eye-slash');
				icon.classList.add('fa-eye');
			}
		}
	</script>
</body>
</html>