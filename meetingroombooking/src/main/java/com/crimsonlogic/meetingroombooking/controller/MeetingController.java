package com.crimsonlogic.meetingroombooking.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.crimsonlogic.meetingroombooking.dto.FilteredDataDto;
import com.crimsonlogic.meetingroombooking.dto.MeetingDto;
import com.crimsonlogic.meetingroombooking.entity.Meeting;
import com.crimsonlogic.meetingroombooking.service.MeetingService;

/**
 * @author abdulmanan
 *
 */
@Controller
@RequestMapping("/meeting")
public class MeetingController {

	private static final String FULLNAME = "fullname";
	private static final Logger logger = LoggerFactory.getLogger(MeetingController.class);

	@Autowired
	MeetingService meetingService;

	/**
	 * Displays the form to add a new meeting. Prepares lists of meeting rooms and
	 * users.
	 * 
	 * @param model   The model to pass attributes to the view.
	 * @param session The HTTP session to retrieve the current user's designation.
	 * @return The name of the JSP file to display based on user designation.
	 */
	@GetMapping("/addmeeting")
	public String showMeetingForm(Model model, HttpSession session) {
		String designation = (String) session.getAttribute("designation");
		FilteredDataDto responseDataDto = meetingService.getMeetingRoomAndUsers();
		model.addAttribute("meeting", new Meeting());
		model.addAttribute("roomList", responseDataDto.getMeetingRooms());
		model.addAttribute("userList", responseDataDto.getUsers());
		if ("HR".equalsIgnoreCase(designation))
			return "addmeeting";
		else {
			return "employeeaddmeeting";
		}
	}

	/**
	 * Handles the submission of a new meeting. Attempts to schedule the meeting
	 * with the provided details and participants.
	 * 
	 * @param meetingDto   The DTO containing meeting details.
	 * @param participants List of participant IDs.
	 * @param model        The model to pass attributes to the view.
	 * @param session      The HTTP session to retrieve the current user's full
	 *                     name.
	 * @return Redirect URL or view name based on the outcome of the scheduling.
	 */
	@PostMapping("/addmeeting")
	public String addMeeting(@ModelAttribute MeetingDto meetingDto, @RequestParam List<String> participants,
			Model model, HttpSession session) {
		try {
			String nameString = (String) session.getAttribute(FULLNAME);
			meetingService.scheduleMeetingWithParticipantsAndSlot(meetingDto, participants, nameString);
			return "redirect:/meeting/getallmeetings?message=Meeting scheduled successfully!";
		} catch (RuntimeException e) {
			logger.info(e.getMessage());
			model.addAttribute("notAdded", e.getMessage());
			return "addmeeting";
		}
	}

	/**
	 * Updates the status of an existing meeting.
	 * 
	 * @param meetingId The ID of the meeting whose status is to be updated.
	 * @param status    The new status to set.
	 * @return Redirect URL to the list of all meetings with a message indicating
	 *         success or failure.
	 */
	@PostMapping("/updatestatus")
	public String updateStatus(@RequestParam("meetingId") String meetingId, @RequestParam("status") String status) {
		Boolean updateStatus = meetingService.updateStatus(meetingId, status);
		if (Boolean.TRUE.equals(updateStatus))
			return "redirect:/meeting/getallmeetings?message=Status changed successfully!";
		else {
			return "redirect:/meeting/getallmeetings?notupdated=Status not changed, Please try again!";
		}
	}

	/**
	 * Displays a list of all meetings based on the current user's full name. 
	 * Includes an optional message.
	 * 
	 * @param message Optional message indicating a recent action, like scheduling
	 *                or updating a meeting.
	 * @param model   The model to pass attributes to the view.
	 * @param session The HTTP session to retrieve the current user's full name and
	 *                designation.
	 * @return The name of the JSP file to display based on user designation.
	 */
	@GetMapping("/getallmeetings")
	public String getAllMeetings(Model model, @RequestParam(value = "message", required = false) String message,
			HttpSession session) {

		String userFullName = (String) session.getAttribute(FULLNAME);
		String designation = (String) session.getAttribute("designation");

		FilteredDataDto response = meetingService.getFilteredMeetingsAndParticipants(userFullName);

		model.addAttribute("meetingList", response.getMeetings());
		model.addAttribute("participantList", response.getParticipants());

		if (message != null) {
			model.addAttribute("message", message);
		}

		if ("HR".equalsIgnoreCase(designation)) {
			return "meetinglist";
		} else {
			return "employeemeetinglist";
		}
	}

	/**
	 * Displays the form to update details of a specific meeting. Prepares lists of
	 * participants, meeting rooms, and users.
	 * 
	 * @param meetingId The ID of the meeting to be updated.
	 * @param model     The model to pass attributes to the view.
	 * @return The name of the JSP file to display.
	 */
	@GetMapping("/updatemeeting")
	public String showUpdateForm(@RequestParam("meetingId") String meetingId, Model model) {
		Meeting meeting = meetingService.getMeetingById(meetingId);
		FilteredDataDto response = meetingService.getMeetingRoomAndUsersAndParticipants(meeting);
		model.addAttribute("meeting", meeting);
		model.addAttribute("participantsList", response.getParticipants());

		model.addAttribute("roomList", response.getMeetingRooms());
		model.addAttribute("userList", response.getUsers());
		return "updatemeeting";
	}

	/**
	 * Handles the submission of updated meeting details. Attempts to update the
	 * meeting with new details and participants.
	 * 
	 * @param meetingDto   The DTO containing updated meeting details.
	 * @param participants List of updated participant IDs.
	 * @param model        The model to pass attributes to the view.
	 * @return Redirect URL or view name based on the outcome of the update.
	 */
	@PostMapping("/updatemeeting")
	public String updateMeeting(@ModelAttribute MeetingDto meetingDto, @RequestParam List<String> participants,
			Model model) {

		try {
			logger.info("=================Inside method==================================");

			meetingService.updateMeeting(meetingDto, participants);

			return "redirect:/meeting/getallmeetings?message=Meeting updated successfully!";
		} catch (RuntimeException e) {
			logger.info(e.getMessage());
			model.addAttribute("notAdded", "The slot overlaps with an existing meeting.");
			return "updatemeeting";
		}

	}

	/**
	 * Displays a calendar view of the user's meetings.
	 * 
	 * @param session The HTTP session to retrieve the current user's full name.
	 * @param model   The model to pass attributes to the view.
	 * @return The name of the JSP file to display.
	 */
	@GetMapping("/calendar")
	public String showCalendar(HttpSession session, Model model) {
		String userFullName = (String) session.getAttribute(FULLNAME);

		FilteredDataDto response = meetingService.getFilteredMeetingsAndParticipants(userFullName);
		model.addAttribute("meetingList", response.getMeetings());
		return "calendar";
	}
}
