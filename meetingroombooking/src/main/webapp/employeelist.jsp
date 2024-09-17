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
<link href="<c:url value="/resources/css/navbar.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/footer.css" />"
	rel="stylesheet">
<title>Employee List</title>
<style>
body {
	font-family: 'Rubik', cursive;
}
.scrollable-container::-webkit-scrollbar {
        display: none; /* Hide scrollbar for WebKit browsers (Chrome, Safari) */
    }
</style>
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
	<c:if test="${not empty userAdded}">
		<div class="alert alert-success mt-3 text-center">${userAdded}</div>
	</c:if>
	<section class="employees" id="employees"
		style="font-family: 'Rubik', cursive;">
		<div class="container py-4">
			<h2 class="text-center mb-4"style="font-family: 'Rubik', cursive;">Employee List</h2>
			<c:if test="${not empty userList}">
				<div class="row">
					<div class="col-lg-10 mx-auto">
						<div class="card">
							<div class="card-body">
								<!-- Search input -->
								<div class="col-md-6 mb-3">
									<div class="form-floating col-md-10">
										<input type="text" class="form-control" id="searchInput"
											onkeyup="searchTable()" style="width: 100%;"> <label
											for="search" class="form-label">Search employee</label>
									</div>
								</div>
								<!-- Container for scrollable table -->
								<div class="scrollable-container"
									style="max-height: 450px; overflow-y: auto; overflow-x: auto;">
									<!-- Table to display orders -->
									<table class="table table-bordered">
										<thead>
											<tr>
												<th style="width: 200px;">Full Name</th>
												<th>Designation</th>
												<th>Email</th>
												<th>Working Under Manager</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="user" items="${userList}">
												<c:if test="${user.userActive}">
													<tr>
														<td style="width: 200px;">${user.userFullname}</td>
														<td>${user.userDesignation}</td>
														<td>${user.userEmail}</td>
														<td>${user.userUnderManager}</td>
													</tr>
												</c:if>
											</c:forEach>
										</tbody>
									</table>
								</div>

							</div>
						</div>

					</div>
				</div>
			</c:if>
			<c:if test="${empty userList}">
				<p style="font-family: 'Rubik', cursive;" class="text-center">No
					employee found.</p>
			</c:if>
		</div>
	</section>
	<jsp:include page="/footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<script>
		function searchTable() {
			var input, filter, table, tr, td, i, txtValue;
			input = document.getElementById("searchInput");
			filter = input.value.toUpperCase();
			table = document.querySelector(".table");
			tr = table.getElementsByTagName("tr");

			// Loop through all table rows, except the header
			for (i = 1; i < tr.length; i++) {
				td = tr[i].getElementsByTagName("td")[0]; // Search in the first column (Full Name)
				if (td) {
					txtValue = td.textContent || td.innerText;
					if (txtValue.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else {
						tr[i].style.display = "none";
					}
				}
			}
		}
	</script>
</body>
</html>