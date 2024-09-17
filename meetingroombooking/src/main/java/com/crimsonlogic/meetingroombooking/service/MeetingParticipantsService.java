package com.crimsonlogic.meetingroombooking.service;

import java.util.List;

import com.crimsonlogic.meetingroombooking.entity.Meeting;
import com.crimsonlogic.meetingroombooking.entity.MeetingParticipants;

/**
 * @author abdulmanan
 *
 */
public interface MeetingParticipantsService {

	/**
	 * Retrieves a list of participants for a specific meeting.
	 *
	 * @param meeting the Meeting object for which to find participants
	 * @return a list of MeetingParticipants objects associated with the given
	 *         meeting
	 */
	List<MeetingParticipants> getMeetingParticipantsByMeeting(Meeting meeting);

	/**
	 * Updates the response status of a meeting participant.
	 *
	 * @param response      the new response status to set for the participant
	 * @param participantId the ID of the participant whose response is to be
	 *                      updated
	 * @return true if the response was successfully updated, false otherwise
	 */
	Boolean updateParticipantResponse(String response, String participantId);

}
