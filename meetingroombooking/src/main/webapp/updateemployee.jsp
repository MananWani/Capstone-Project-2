<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link href="<c:url value="/resources/css/updateemployee.css" />"
	rel="stylesheet">
<script src="<c:url value="/resources/js/updateemployee.js" />"></script>

<title>Update Employee</title>
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

	<section class="py-3 py-md-5"
		style="background: linear-gradient(rgba(0,0,0,0.75),rgba(0,0,0,0.75)),url('<c:url value="/resources/images/bg.jpg" />') no-repeat center center; 
           background-size: cover; 
           min-height: 100vh; 
           display: flex; 
           align-items: center; 
           justify-content: center;">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5 col-xxl-4">
					<div class="card rounded-3 shadow-sm"
						style="background: rgba(255, 255, 255, 0.3);width:500px;">
						<div class="card-body p-3 p-md-4 p-xl-5">
							<div class="text-center mb-3" style="margin-top: -30px;">
								<img src="<c:url value='/resources/images/meetup.png' />"
									alt="Logo" class="logo">
							</div>
							<h4 class="text-center mb-4"
								style="color: white; margin-bottom: 10px; font-family: 'Rubik', cursive;">Update</h4>
							<!-- Error message display -->
							<c:if test="${not empty alreadyExists}">
								<div class="alert alert-danger text-center" role="alert"
									style="color: black;">${alreadyExists}</div>
							</c:if>

							<form id="registerForm"
								action="${pageContext.request.contextPath}/user/updateuser"
								method="post">
								<div class="row gy-2 overflow-hidden">
									<div class="col-12">
										<div class="form-floating mb-3">
											<input type="text" class="form-control" name="userFullname"
												id="userFullname" style="color: black;"
												value="${user.userFullname}" readonly> <label
												for="userFullname" class="form-label"
												style="color: black; font-family: 'Rubik', cursive;">
												Fullname<span class="required-asterisk">*</span>
											</label>
										</div>
										<div id="nameError" class="text-danger"></div>
									</div>
									<div class="col-12">
										<div class="form-floating mb-3">
											<input type="text" class="form-control" name="userMobileNo"
												id="userMobileNo" style="color: black;"
												value="${user.userMobileNo }" oninput="validateMobile()"
												required> <label for="userMobileNo"
												class="form-label"
												style="color: black; font-family: 'Rubik', cursive;">Mobile
												Number<span class="required-asterisk">*</span>
											</label>
										</div>
										<div id="mobileError" class="text-danger"style="font-weight: bold;background: white;
										border-radius: 4px;"></div>
									</div>
									<div class="col-12">
										<div class="form-floating mb-3">
											<select class="form-select" name="userDesignation"
												id="userDesignation"
												style="color: black; font-family: 'Rubik', cursive;"
												onchange="validateDesignation()" required>
												<option value="">Select a designation</option>
												<c:forEach var="designation" items="${designationList}">
													<option value="${designation}"
														${user.userDesignation eq designation ? 'selected' : ''}>
														${designation}</option>
												</c:forEach>
											</select> <label for="userDesignation" class="form-label"
												style="color: black; font-family: 'Rubik', cursive;">
												Designation<span class="required-asterisk">*</span>
											</label>
										</div>
										<div id="designationError" class="text-danger"style="font-weight: bold;background: white;
										border-radius: 4px;"></div>
									</div>

									<div class="col-12">
										<div class="form-floating mb-3">
											<select class="form-select" name="userUnderManager"
												id="userUnderManager"
												style="color: black; font-family: 'Rubik', cursive;"
												onchange="validateManager()" required>
												<option value="">Select a manager</option>
												<c:forEach var="manager" items="${managerList}">
													<option value="${manager.userFullname}"
														${user.userUnderManager eq manager.userFullname ? 'selected' : ''}>
														${manager.userFullname}</option>
												</c:forEach>
											</select> <label for="userUnderManager" class="form-label"
												style="color: black; font-family: 'Rubik', cursive;">
												Under Manager<span class="required-asterisk">*</span>
											</label>
										</div>
										<div id="managerError" class="text-danger"style="font-weight: bold;background: white;
										border-radius: 4px;"></div>
									</div>

									<div class="col-12">
										<div class="form-check mb-3">
											<input type="checkbox" class="form-check-input"
												name="userActive" id="userActive" value="true"
												${user.userActive ? 'checked' : ''}> <label
												for="userActive" class="form-check-label"
												style="color: white; font-family: 'Rubik', cursive;">
												Active </label>
										</div>
									</div>


									<div class="col-12">
										<div class="d-grid my-3">
											<button class="btn1" type="submit" id="registerButton"
												style="background-color: crimson; border-color: crimson; 
												margin-left: 28px; white; font-family: 'Rubik', cursive;">
												Update</button>
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

</body>
</html>