<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png"
	href="<c:url value='/resources/images/meetup.png'/>">
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login</title>
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

<link href="<c:url value="/resources/css/navbar.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/footer.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/login.css" />" rel="stylesheet">

<script src="<c:url value="/resources/js/login.js" />"></script>
</head>
<body>
<body>
	<nav class="navbar navbar-expand-lg"
		style="height: 70px !important; position: sticky; top: 0; z-index: 1000; background-color: #fff; border-bottom: 1px solid #e1e1e1;">
		<div class="container">
			<div class="d-flex w-100 align-items-center justify-content-between">
				<!-- Button to return to the landing page -->

				<!-- Navbar brand -->
				<div
					class="d-flex justify-content-center align-items-center mx-auto">
					<a href="${pageContext.request.contextPath}/user/index"
						class="navbar-brand mb-0"
						style="font-size: 3rem !important; display: flex; align-items: center;">
						<img src="<c:url value='/resources/images/meetup.png' />"
						alt="Logo" class="navlogo" style="width: 60px; height: 60px;">
						eetup
					</a>
				</div>

			</div>
		</div>
	</nav>



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
						style="background: rgba(255, 255, 255, 0.3);">
						<div class="card-body p-3 p-md-4 p-xl-5">
							<div class="text-center mb-3" style="margin-top: -30px;">
								<img src="<c:url value="/resources/images/meetup.png" />"
									alt="Logo" class="logo">
							</div>
							<h4 class="text-center mb-4"
								style="color: white; margin-bottom: 10px; font-family: 'Rubrik', cursive;">Sign
								In</h4>
							<c:if test="${not empty invalidUser}">
								<div class="alert alert-danger text-center" role="alert"
									style="color: black;">${invalidUser}</div>
							</c:if>

							<form action="${pageContext.request.contextPath}/user/login"
								method="post">
								<div class="row gy-2 overflow-hidden">
									<div class="col-12">
										<div class="form-floating mb-3">
											<input type="email" class="form-control" name="userEmail"
												id="userEmail" style="color: black;" required> <label
												for="userEmail" class="form-label"
												style="color: black; font-family: 'Rubrik', cursive;">
												Email<span style="color: red; margin-left: 5px;"
												class="required-asterisk">*</span>
											</label>
										</div>

									</div>
									<div class="col-12">
										<div class="form-floating mb-3 password-container">
											<input type="password" class="form-control"
												name="userPassword" id="userPassword" style="color: black;"
												required> <label for="userPassword"
												class="form-label"
												style="color: black; font-family: 'Rubrik', cursive;">Password<span
												style="color: red; margin-left: 5px;"
												class="required-asterisk">*</span></label> <i
												class="fas fa-eye eye-icon" id="togglePassword"></i>
										</div>
									</div>

									<div class="col-12">
										<div class="form-floating ">
											<button class="btn1" type="submit" id="loginButton">Login</button>
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
		src="https://unpkg.com/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


</body>
</html>