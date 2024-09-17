package com.crimsonlogic.meetingroombooking.service;

import java.util.List;

import com.crimsonlogic.meetingroombooking.dto.FilteredDataDto;
import com.crimsonlogic.meetingroombooking.dto.MeetingDto;
import com.crimsonlogic.meetingroombooking.entity.Meeting;

/**
 * @author abdulmanan
 *
 */
public interface MeetingService {

	/**
	 * Retrieves a list of all meetings.
	 *
	 * @return a list of all Meeting objects
	 */
	List<Meeting> getAllMeeting();

	/**
	 * Retrieves a list of meetings organized by a specific user identified by their
	 * full name.
	 *
	 * @param fullName the full name of the user whose meetings are to be retrieved
	 * @return a list of Meeting objects organized by the user with the given full
	 *         name
	 */
	List<Meeting> getMeetingsByUserFullName(String fullName);

	/**
	 * Schedules a new meeting with participants and assigns it to a time slot.
	 *
	 * @param meetingDto   a data transfer object containing information about the
	 *                     meeting to be scheduled
	 * @param participants a list of participants for the meeting
	 * @param nameString   a string representing the name of the meeting slot or
	 *                     time
	 */
	void scheduleMeetingWithParticipantsAndSlot(MeetingDto meetingDto, List<String> participants, String nameString);

	/**
	 * Updates the status of a specific meeting.
	 *
	 * @param meetingId the ID of the meeting to be updated
	 * @param status    the new status to set for the meeting
	 * @return true if the status was successfully updated, false otherwise
	 */
	Boolean updateStatus(String meetingId, String status);

	/**
	 * Retrieves filtered meeting and participant information for a specific user.
	 *
	 * @param userFullName the full name of the user for whom to filter meetings and
	 *                     participants
	 * @return a FilteredDataDto object containing filtered meeting and participant
	 *         data for the specified user
	 */
	FilteredDataDto getFilteredMeetingsAndParticipants(String userFullName);

	/**
	 * Retrieves filtered information about meeting rooms and users.
	 *
	 * @return a FilteredDataDto object containing details of meeting rooms and
	 *         users
	 */
	FilteredDataDto getMeetingRoomAndUsers();

	/**
	 * Retrieves a specific meeting by its ID.
	 *
	 * @param meetingId the ID of the meeting to retrieve
	 * @return the Meeting object with the given ID, or null if not found
	 */
	Meeting getMeetingById(String meetingId);

	/**
	 * Retrieves filtered information about a meeting room, users, and participants
	 * for a specific meeting.
	 *
	 * @param meeting the Meeting object for which to retrieve filtered data
	 * @return a FilteredDataDto object containing details of the meeting room,
	 *         users, and participants for the given meeting
	 */
	FilteredDataDto getMeetingRoomAndUsersAndParticipants(Meeting meeting);

	/**
	 * Updates an existing meeting and its participants.
	 *
	 * @param meetingDto   a data transfer object containing updated information
	 *                     about the meeting
	 * @param participants a list of updated participants for the meeting
	 */
	void updateMeeting(MeetingDto meetingDto, List<String> participants);

	/**
	 * Updates the status of a list of meetings.
	 *
	 * @param allMeetings a list of Meeting objects whose statuses are to be updated
	 */
	void updateMeetingStatus(List<Meeting> allMeetings);

	/**
	 * Deletes an existing time slot associated with a specific meeting.
	 *
	 * @param meeting the Meeting object for which the time slot should be deleted
	 */
	void deleteExistingSlot(Meeting meeting);

}
