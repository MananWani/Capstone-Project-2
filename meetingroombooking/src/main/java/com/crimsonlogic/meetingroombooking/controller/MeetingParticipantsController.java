package com.crimsonlogic.meetingroombooking.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.crimsonlogic.meetingroombooking.service.MeetingParticipantsService;

/**
 * @author abdulmanan
 *
 */
@Controller
@RequestMapping("/participant")
public class MeetingParticipantsController {

	@Autowired
	MeetingParticipantsService meetingParticipantsService;

	/**
	 * Updates the response of a meeting participant. Redirects to the meeting list
	 * with a success or failure message.
	 * 
	 * @param response      The response from the participant (e.g., "Accepted",
	 *                      "Rejected").
	 * @param participantId The ID of the participant whose response is being
	 *                      updated.
	 * @return Redirect URL to the list of all meetings with a message indicating
	 *         success or failure.
	 */
	@PostMapping("/updateresponse")
	public String updateResponse(@RequestParam("response") String response,
			@RequestParam("participantId") String participantId) {
		Boolean updateStatus = meetingParticipantsService.updateParticipantResponse(response, participantId);
		if (Boolean.TRUE.equals(updateStatus))
			return "redirect:/meeting/getallmeetings?message=Responded successfully!";
		else {
			return "redirect:/meeting/getallmeetings?notupdated=Response not changed, Please try again!";
		}
	}
}
