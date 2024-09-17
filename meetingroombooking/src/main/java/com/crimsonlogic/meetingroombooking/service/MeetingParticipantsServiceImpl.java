package com.crimsonlogic.meetingroombooking.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crimsonlogic.meetingroombooking.entity.Meeting;
import com.crimsonlogic.meetingroombooking.entity.MeetingParticipants;
import com.crimsonlogic.meetingroombooking.repository.MeetingParticipantsRepository;

/**
 * @author abdulmanan
 *
 */
@Service
public class MeetingParticipantsServiceImpl implements MeetingParticipantsService {

	@Autowired
	MeetingParticipantsRepository meetingParticipantsRepository;

	@Override
	public List<MeetingParticipants> getMeetingParticipantsByMeeting(Meeting meetingId) {
		// Retrieve and return a list of participants for a given meeting
		return meetingParticipantsRepository.findByParticipantForMeeting(meetingId);
	}

	@Override
	public Boolean updateParticipantResponse(String response, String participantId) {
		// Find the participant by their ID
		Optional<MeetingParticipants> participantOpt = meetingParticipantsRepository.findById(participantId);
		if (participantOpt.isPresent()) {
			// If participant exists, update their response and save changes
			MeetingParticipants participant = participantOpt.get();
			participant.setParticipantResponse(response);
			meetingParticipantsRepository.save(participant);
			return true; // Return true indicating the update was successful
		}
		return false; // Return false if the participant was not found
	}
}
