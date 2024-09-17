package com.crimsonlogic.meetingroombooking.dto;

import java.util.List;

import com.crimsonlogic.meetingroombooking.entity.Equipment;
import com.crimsonlogic.meetingroombooking.entity.Meeting;
import com.crimsonlogic.meetingroombooking.entity.MeetingParticipants;
import com.crimsonlogic.meetingroombooking.entity.MeetingRoom;
import com.crimsonlogic.meetingroombooking.entity.Slots;
import com.crimsonlogic.meetingroombooking.entity.Users;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author abdulmanan
 *
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class FilteredDataDto {
	private List<Meeting> meetings;
	private List<MeetingParticipants> participants;
	private List<Users> users;
	private List<MeetingRoom> meetingRooms;
	private List<Equipment> equipments;
	private List<Slots> slots;
}
