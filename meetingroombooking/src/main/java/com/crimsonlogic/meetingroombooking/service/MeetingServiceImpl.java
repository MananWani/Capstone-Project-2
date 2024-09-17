package com.crimsonlogic.meetingroombooking.service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.crimsonlogic.meetingroombooking.dto.FilteredDataDto;
import com.crimsonlogic.meetingroombooking.dto.MeetingDto;
import com.crimsonlogic.meetingroombooking.entity.Meeting;
import com.crimsonlogic.meetingroombooking.entity.MeetingParticipants;
import com.crimsonlogic.meetingroombooking.entity.MeetingRoom;
import com.crimsonlogic.meetingroombooking.entity.Slots;
import com.crimsonlogic.meetingroombooking.entity.Users;
import com.crimsonlogic.meetingroombooking.exception.SlotConflictException;
import com.crimsonlogic.meetingroombooking.repository.MeetingParticipantsRepository;
import com.crimsonlogic.meetingroombooking.repository.MeetingRepository;
import com.crimsonlogic.meetingroombooking.repository.MeetingRoomRepository;
import com.crimsonlogic.meetingroombooking.repository.SlotsRepository;
import com.crimsonlogic.meetingroombooking.repository.UsersRepository;

/**
 * @author abdulmanan
 *
 */
@Service
public class MeetingServiceImpl implements MeetingService {

	private static final Logger logger = LoggerFactory.getLogger(MeetingServiceImpl.class);

	private static final String COMPLETED = "Completed";

	@Autowired
	MeetingParticipantsService meetingParticipantsService;

	@Autowired
	MeetingRoomService meetingRoomService;

	@Autowired
	UsersService usersService;

	@Autowired
	MeetingService meetingService;

	@Autowired
	MeetingRepository meetingRepository;

	@Autowired
	UsersRepository usersRepository;

	@Autowired
	MeetingRoomRepository meetingRoomRepository;

	@Autowired
	MeetingParticipantsRepository meetingParticipantsRepository;

	@Autowired
	SlotsRepository slotsRepository;

	// Helper method to convert meeting start and end times to Timestamp
	private Timestamp formatter(String meetingStartTime) {
		String dateTimeString = meetingStartTime;
		DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
		LocalDateTime localDateTime = LocalDateTime.parse(dateTimeString, inputFormatter);
		return Timestamp.valueOf(localDateTime);
	}

	@Override
	public List<Meeting> getAllMeeting() {
		// Retrieve and return all meetings from the repository
		return meetingRepository.findAll();
	}

	@Override
	@Transactional
	public void scheduleMeetingWithParticipantsAndSlot(MeetingDto meetingDto, List<String> participants,
			String nameString) {
		try {
			// Format start and end times for the meeting
			Timestamp formattedStart = formatter(meetingDto.getMeetingStartTime());
			Timestamp formattedEnd = formatter(meetingDto.getMeetingEndTime());
			// Retrieve user and room details from the repository
			Users user = usersRepository.findByUserFullname(meetingDto.getMeetingByUser());
			MeetingRoom room = meetingRoomRepository.findByRoomId(meetingDto.getMeetingInRoom());

			// Create and save a new meeting
			Meeting meeting = new Meeting();
			meeting.setMeetingStartTime(formattedStart);
			meeting.setMeetingEndTime(formattedEnd);
			meeting.setMeetingPurpose(meetingDto.getMeetingPurpose());
			meeting.setMeetingStatus(meetingDto.getMeetingStatus());
			meeting.setMeetingByUser(user);
			meeting.setMeetingInRoom(room);
			Meeting newMeeting = meetingRepository.save(meeting);

			// Save participants for the new meeting
			for (String participant : participants) {
				MeetingParticipants meetingParticipants = new MeetingParticipants();
				meetingParticipants.setParticipantFullname(participant);
				if (nameString.equalsIgnoreCase(participant)) {
					meetingParticipants.setParticipantResponse("Accepted");
				} else {
					meetingParticipants.setParticipantResponse("Pending");
				}
				meetingParticipants.setParticipantForMeeting(newMeeting);
				meetingParticipantsRepository.save(meetingParticipants);
			}

			// Create and check for slot conflicts
			Slots newSlot = new Slots();
			newSlot.setSlotStartTime(newMeeting.getMeetingStartTime());
			newSlot.setSlotEndTime(newMeeting.getMeetingEndTime());
			newSlot.setSlotInRoom(newMeeting.getMeetingInRoom());
			newSlot.setSlotForMeeting(newMeeting);
			newSlot.setSlotStatus("Booked");

			// Check if the slot overlaps with existing slots
			if (isSlotOverlapping(newSlot)) {
				throw new SlotConflictException("The slot overlaps with an existing meeting.");
			}

			// Save the new slot
			slotsRepository.save(newSlot);

		} catch (Exception e) {
			// Log and throw runtime exception in case of error
			throw new RuntimeException(e.getMessage(), e);
		}
	}

	// Check if the new slot overlaps with any existing slots
	public boolean isSlotOverlapping(Slots newSlot) {
		List<Slots> existingSlots = slotsRepository.findAll();
		for (Slots slot : existingSlots) {
			logger.info("=====================================slot==================================================");
			// Check for overlap conditions
			if (newSlot.getSlotEndTime().after(slot.getSlotStartTime())
					&& newSlot.getSlotStartTime().before(slot.getSlotEndTime())
					&& newSlot.getSlotInRoom().equals(slot.getSlotInRoom())) {
				return true;
			}
		}
		return false;
	}

	@Override
	public List<Meeting> getMeetingsByUserFullName(String fullName) {
		// Retrieve user by full name
		Users user = usersRepository.findByUserFullname(fullName);
		if (user == null) {
			return Collections.emptyList(); // Return empty list if user is not found
		}
		// Retrieve and return meetings by user
		return meetingRepository.findByMeetingByUser(user);
	}

	@Override
	@Transactional
	public void updateMeetingStatus(List<Meeting> allMeetings) {
		Timestamp now = new Timestamp(System.currentTimeMillis());

		for (Meeting meeting : allMeetings) {
			Timestamp startTime = meeting.getMeetingStartTime();
			Timestamp endTime = meeting.getMeetingEndTime();
			String status = meeting.getMeetingStatus();
			logger.info("=============================Meeting Status========================================");

			// Delete slots if meeting is cancelled or completed
			if (status.equals("Cancelled") || status.equals(COMPLETED)) {
				logger.info("=====================meeting========================");
				slotsRepository.deleteBySlotForMeeting(meeting);
				logger.info("=============================Deleted slots for meeting================================");
				continue; // Skip further processing for this meeting
			}

			// Update status to 'Completed' if end time has passed
			if (endTime.before(now) && !status.equals(COMPLETED)) {
				meeting.setMeetingStatus(COMPLETED);
				meetingRepository.save(meeting);
				logger.info(
						"=============================================Meeting marked as Completed=================================");
			}

			// Update status to 'In Progress' if current time is within meeting time
			if (now.after(startTime) && now.before(endTime) && !status.equals("In Progress")) {
				meeting.setMeetingStatus("In Progress");
				meetingRepository.save(meeting);
				logger.info(
						"=============================================Meeting marked as In Progress=================================");
			}
		}
	}

	@Override
	@Transactional
	public Boolean updateStatus(String meetingId, String status) {
		Optional<Meeting> meeting = meetingRepository.findById(meetingId);
		if (meeting.isPresent()) {
			Meeting meet = meeting.get();
			meet.setMeetingStatus(status);
			logger.info("======================================CANCELLED===============================");
			meetingRepository.save(meet);
			return true;
		} else {
			return false;
		}
	}

	@Override
	@Transactional
	public FilteredDataDto getFilteredMeetingsAndParticipants(String userFullName) {
		List<Meeting> allMeetings = getAllMeeting();
		meetingService.updateMeetingStatus(allMeetings);

		List<Meeting> filteredMeetings = new ArrayList<>();
		List<MeetingParticipants> filteredParticipants = new ArrayList<>();

		for (Meeting meeting : allMeetings) {
			boolean isOrganizer = meeting.getMeetingByUser().getUserFullname().equals(userFullName);

			if (isOrganizer) {
				filteredMeetings.add(meeting);
				List<MeetingParticipants> participants = meetingParticipantsService
						.getMeetingParticipantsByMeeting(meeting);
				filteredParticipants.addAll(participants);
			} else {
				List<MeetingParticipants> participants = meetingParticipantsService
						.getMeetingParticipantsByMeeting(meeting);
				for (MeetingParticipants participant : participants) {
					if (participant.getParticipantFullname().equals(userFullName)) {
						filteredMeetings.add(meeting);
						filteredParticipants.add(participant);
						break;
					}
				}
			}
		}
		FilteredDataDto dto = new FilteredDataDto();
		dto.setMeetings(filteredMeetings);
		dto.setParticipants(filteredParticipants);
		return dto;
	}

	@Override
	public FilteredDataDto getMeetingRoomAndUsers() {
		FilteredDataDto dto = new FilteredDataDto();
		dto.setMeetingRooms(meetingRoomService.getAllMeetingRoom());
		dto.setUsers(usersService.getAllUsers());
		return dto;
	}

	@Override
	public Meeting getMeetingById(String meetingId) {
		Optional<Meeting> meetingOpt = meetingRepository.findById(meetingId);
		if (meetingOpt.isPresent()) {
			return meetingOpt.get();
		}
		return null; // Return null if meeting not found
	}

	@Override
	public FilteredDataDto getMeetingRoomAndUsersAndParticipants(Meeting meeting) {
		FilteredDataDto dto = new FilteredDataDto();
		dto.setMeetingRooms(meetingRoomService.getAllMeetingRoom());
		dto.setUsers(usersService.getAllUsers());
		dto.setParticipants(meetingParticipantsService.getMeetingParticipantsByMeeting(meeting));
		return dto;
	}

	@Override
	@Transactional
	public void updateMeeting(MeetingDto meetingDto, List<String> participants) {
		try {
			logger.info("===========================Inside update=====================================");

			// Format new meeting times
			Timestamp formattedStart = formatter(meetingDto.getMeetingStartTime());
			Timestamp formattedEnd = formatter(meetingDto.getMeetingEndTime());
			Users user = usersRepository.findByUserFullname(meetingDto.getMeetingByUser());
			MeetingRoom room = meetingRoomRepository.findByRoomId(meetingDto.getMeetingInRoom());

			// Retrieve the meeting to update
			Optional<Meeting> meetingOpt = meetingRepository.findById(meetingDto.getMeetingId());
			if (meetingOpt.isPresent()) {
				Meeting meeting = meetingOpt.get();
				meetingService.deleteExistingSlot(meeting); // Remove existing slot
				meeting.setMeetingStartTime(formattedStart);
				meeting.setMeetingEndTime(formattedEnd);
				meeting.setMeetingPurpose(meetingDto.getMeetingPurpose());
				meeting.setMeetingStatus(meetingDto.getMeetingStatus());
				meeting.setMeetingInRoom(room);
				meetingRepository.save(meeting);
				logger.info("=====================================Meeting saved=====================================");

				// Update participants
				meetingParticipantsRepository.deleteByParticipantForMeeting(meeting);
				logger.info(
						"=====================================Participants deleted=====================================");

				for (String participant : participants) {
					MeetingParticipants meetingParticipants = new MeetingParticipants();
					meetingParticipants.setParticipantFullname(participant);
					if (user.getUserFullname().equalsIgnoreCase(participant)) {
						meetingParticipants.setParticipantResponse("Accepted");
					} else {
						meetingParticipants.setParticipantResponse("Pending");
					}
					meetingParticipants.setParticipantForMeeting(meeting);
					meetingParticipantsRepository.save(meetingParticipants);
					logger.info(
							"====================================Participants saved=====================================");
				}

				// Create and check new slot
				Slots newSlot = new Slots();
				newSlot.setSlotStartTime(meeting.getMeetingStartTime());
				newSlot.setSlotEndTime(meeting.getMeetingEndTime());
				newSlot.setSlotInRoom(meeting.getMeetingInRoom());
				newSlot.setSlotForMeeting(meeting);
				newSlot.setSlotStatus("Booked");

				if (isSlotOverlapping(newSlot)) {
					throw new SlotConflictException("The slot overlaps with an existing meeting.");
				}

				slotsRepository.save(newSlot);
			}
		} catch (Exception e) {
			// Log and throw runtime exception in case of error
			throw new RuntimeException(e.getMessage(), e);
		}
	}

	@Transactional
	public void deleteExistingSlot(Meeting meeting) {
		logger.info("=============================Inside delete=====================================");
		// Delete slots associated with the given meeting
		slotsRepository.deleteBySlotForMeeting(meeting);
	}
}
