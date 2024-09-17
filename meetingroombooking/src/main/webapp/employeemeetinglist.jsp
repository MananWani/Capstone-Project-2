<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/png" href="<c:url value='/resources/images/meetup.png'/>">

<link href="<c:url value="/resources/css/navbar.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/footer.css" />"
	rel="stylesheet">
<link href="<c:url value="/resources/css/meetinglist.css" />"
	rel="stylesheet">
<script src="<c:url value="/resources/js/meetinglist.js" />"></script>
<style type="text/css">
.scrollable-container::-webkit-scrollbar {
	display: none;
	/* Hide scrollbar for WebKit browsers (Chrome, Safari) */
}
</style>
<title>Meetings</title>
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
	<c:if test="${not empty invalidUser}">
		<div class="alert alert-danger text-center" role="alert"
			style="color: black;">${invalidUser}</div>
	</c:if>
	<c:if test="${not empty message}">
		<div class="alert alert-success mt-3 text-center">${message}</div>
	</c:if>
	<section class="employees" id="employees">
		<div class="container py-4">
			<h2 class="text-center mb-4" style="font-family: 'Rubik', cursive;">My
				Meetings</h2>
			<c:if test="${not empty meetingList}">
				<div class="row">
					<div class="col-lg-12 mx-auto">
						<div class="card">
							<div class="card-body">
								<div class="scrollable-container"
									style="max-height: 400px; overflow-y: auto; overflow-x: auto;">
									<!-- Table to display meetings -->
									<table class="table table-bordered">
										<thead>
											<tr style="font-family: 'Rubik', cursive;">
												<th style="width: 130px;">Start Time</th>
												<th style="width: 120px;">End Time</th>
												<th style="width: 150px;">Purpose</th>
												<th style="width: 160px;">Status</th>
												<th style="width: 160px;">Meeting Called By</th>
												<th style="width: 160px;">Meeting In Room</th>
												<th>Participants</th>
												<th>Actions</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="meeting" items="${meetingList}">
												<c:url var="updateLink" value="updatemeeting">
													<c:param name="meetingId" value="${meeting.meetingId}" />
												</c:url>
												<tr style="font-family: 'Rubik', cursive;">
													<td><fmt:formatDate
															value="${meeting.meetingStartTime}" type="both"
															pattern="dd-MM-yyyy h:mm a" /></td>
													<td><fmt:formatDate value="${meeting.meetingEndTime}"
															type="both" pattern="dd-MM-yyyy h:mm a" /></td>
													<td style="width: 150px;">${meeting.meetingPurpose}</td>
													<td style="width: 160px;"><c:choose>
															<c:when
																test="${meeting.meetingByUser.userFullname == sessionScope.fullname && meeting.meetingStatus != 'Cancelled' && meeting.meetingStatus != 'Completed' && meeting.meetingStatus != 'In Progress'}">
																<form
																	action="${pageContext.request.contextPath}/meeting/updatestatus"
																	method="post" style="margin: 0;">
																	<input type="hidden" name="meetingId"
																		value="${meeting.meetingId}" /> <select
																		class="form-select" name="status"
																		onchange="this.form.submit();">
																		<option value="Scheduled"
																			${meeting.meetingStatus == 'Scheduled' ? 'selected' : ''}>Scheduled</option>
																		<option value="Cancelled"
																			${meeting.meetingStatus == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
																	</select>
																</form>
															</c:when>
															<c:otherwise>
                                                        ${meeting.meetingStatus}
                                                    </c:otherwise>
														</c:choose></td>
													<td style="width: 160px;">${meeting.meetingByUser.userFullname}</td>
													<td style="width: 160px;">${meeting.meetingInRoom.roomName}</td>
													<td>
														<button type="button" class="btn0"
															onclick="openModal('${meeting.meetingId}')">View</button>
													</td>


													<c:if
														test="${meeting.meetingStatus eq 'Scheduled' && meeting.meetingByUser.userFullname == sessionScope.fullname}">
														<td style="width: 100px;"><a href="${updateLink}"
															class="btn0">Edit</a></td>
													</c:if>
													<c:if
														test="${meeting.meetingStatus eq 'Scheduled'&& !(meeting.meetingByUser.userFullname == sessionScope.fullname)}">
														<td style="width: 100px;">No action</td>
													</c:if>
													<c:if test="${meeting.meetingStatus ne 'Scheduled'}">
														<td style="width: 100px;">No action</td>
													</c:if>

												</tr>
											</c:forEach>
										</tbody>
									</table>

									<!-- Modal Structure -->
									<c:forEach var="meeting" items="${meetingList}">
										<div id="modal-${meeting.meetingId}" class="modal">
											<div class="modal-content"
												style="max-height: 70vh; overflow-y: auto;">
												<span class="close"
													onclick="closeModal('${meeting.meetingId}')">&times;</span>
												<h3>Participants for Meeting</h3>
												<table class="table table-bordered">
													<thead>
														<tr>
															<th>Participant</th>
															<th>Response</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="participant" items="${participantList}">
															<c:if
																test="${participant.participantForMeeting.meetingId == meeting.meetingId}">
																<tr>
																	<td>${participant.participantFullname}</td>
																	<td>${participant.participantResponse}</td>
																</tr>
															</c:if>
														</c:forEach>
													</tbody>
												</table>
												<!-- Response Buttons for Participants -->
												<c:if
													test="${meeting.meetingByUser.userFullname != sessionScope.fullname}">
													<!-- Check if meeting status is not 'Completed' or 'Cancelled' -->
													<c:choose>
														<c:when
															test="${meeting.meetingStatus != 'Completed' && meeting.meetingStatus != 'Cancelled'}">
															<c:forEach var="participant" items="${participantList}">
																<c:if
																	test="${participant.participantForMeeting.meetingId == meeting.meetingId && participant.participantFullname == sessionScope.fullname}">
																	<c:if
																		test="${participant.participantResponse == 'Pending'}">
																		<div class="response-buttons">
																			<form
																				action="${pageContext.request.contextPath}/participant/updateresponse"
																				method="post">
																				<input type="hidden" name="participantId"
																					value="${participant.participantId}" />
																				<button type="submit" name="response"
																					value="Accepted" class="btn btn-danger"
																					style="border: none; background: crimson;">Accept</button>
																				<button type="submit" name="response"
																					value="Rejected" class="btn btn-danger"
																					style="border: none; background: crimson;">Reject</button>
																			</form>
																		</div>
																	</c:if>
																</c:if>
															</c:forEach>
														</c:when>
													</c:choose>
												</c:if>

											</div>
										</div>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${empty meetingList}">
				<p style="font-family: 'Rubik', cursive;" class="text-center">No
					meeting found.</p>
			</c:if>
		</div>
	</section>




	<jsp:include page="/footer.jsp" />
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>



</body>
</html>