<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="icon" type="image/png" href="<c:url value='/resources/images/meetup.png'/>">

<link href="https://fonts.googleapis.com/css2?family=Rubik&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Handjet:wght@100..900&family=Nerko+One&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link href="<c:url value="/resources/css/footer.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/navbar.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/index.css" />"
	rel="stylesheet">
<title>Welcome</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg"
	style="height: 70px !important; position: relative; position: sticky; top: 0; z-index: 1000; background-color: #fff; border-bottom: 1px solid #e1e1e1;">
	<div class="container">
		<div class="d-flex justify-content-center w-100">
			<a href="${pageContext.request.contextPath}/user/index" class="navbar-brand mb-0 d-flex align-items-center" style="font-size: 3rem !important; margin: 0; text-decoration: none; color: inherit;">
				<img src="<c:url value='/resources/images/meetup.png' />" alt="Logo" class="navlogo" style="width: 60px; height: 60px;">
				eetup
			</a>
		</div>
	</div>
</nav>
<!-- End Of Navbar -->



	<%-- <div class="d-none d-lg-block">
                <a class="btn0" href="${pageContext.request.contextPath}/user/login">Login</a>
            </div> --%>

	<%
    String loggedOut = (String) request.getAttribute("loggedOut");
    if (loggedOut != null && !loggedOut.isEmpty()) {
        // Print to the server console
        System.out.println("Logged out message: " + loggedOut);
    }
%>
	<c:if test="${not empty loggedOut}">
		<div class="alert alert-success mt-3 text-center">${loggedOut}</div>
	</c:if>
	<section class="main"
    style="background-image: linear-gradient(rgba(0,0,0,0.75),rgba(0,0,0,0.75)),url('<c:url value="/resources/images/bg.jpg" />');">
    <div class="welcome-message">
        <h1>Welcome to Meetup.</h1>
        <p>Your go-to platform for booking meeting rooms seamlessly.</p>
        <a class="btn2" href="${pageContext.request.contextPath}/user/login">Login</a>
    </div>
</section>
	<jsp:include page="/footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


</body>
</html>
