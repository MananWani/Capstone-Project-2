package com.crimsonlogic.meetingroombooking.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.crimsonlogic.meetingroombooking.entity.Meeting;
import com.crimsonlogic.meetingroombooking.entity.MeetingParticipants;

/**
 * @author abdulmanan
 *
 */
@Repository
public interface MeetingParticipantsRepository extends JpaRepository<MeetingParticipants, String> {

	/**
	 * Finds a list of MeetingParticipants by the participant's full name.
	 *
	 * @param fullName the full name of the participant
	 * @return a list of MeetingParticipants with the given full name
	 */
	List<MeetingParticipants> findByParticipantFullname(String fullName);

	/**
	 * Finds a list of MeetingParticipants associated with a specific meeting.
	 *
	 * @param meetingId the Meeting object for which to find participants
	 * @return a list of MeetingParticipants associated with the given meeting
	 */
	List<MeetingParticipants> findByParticipantForMeeting(Meeting meetingId);

	/**
	 * Deletes all MeetingParticipants associated with a specific meeting.
	 *
	 * @param meeting the Meeting object whose participants should be deleted
	 */
	void deleteByParticipantForMeeting(Meeting meeting);
}
