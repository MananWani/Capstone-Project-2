package com.crimsonlogic.meetingroombooking.service;

import java.util.List;

import com.crimsonlogic.meetingroombooking.dto.FilteredDataDto;
import com.crimsonlogic.meetingroombooking.dto.MeetingRoomDto;
import com.crimsonlogic.meetingroombooking.entity.MeetingRoom;

/**
 * @author abdulmanan
 *
 */
public interface MeetingRoomService {

	/**
	 * Retrieves a list of all meeting rooms.
	 *
	 * @return a list of all MeetingRoom objects
	 */
	List<MeetingRoom> getAllMeetingRoom();

	/**
	 * Finds a meeting room by its name.
	 *
	 * @param meetingInRoom the name of the meeting room to find
	 * @return the MeetingRoom object with the given name, or null if not found
	 */
	MeetingRoom findByRoomName(String meetingInRoom);

	/**
	 * Adds a new meeting room and associates it with selected equipment.
	 *
	 * @param meetingRoomDto     a data transfer object containing information about
	 *                           the meeting room to be added
	 * @param selectedEquipments a list of equipment names or identifiers to be
	 *                           associated with the new meeting room
	 */
	void addMeetingRoomAndEquipment(MeetingRoomDto meetingRoomDto, List<String> selectedEquipments);

	/**
	 * Retrieves a meeting room by its ID.
	 *
	 * @param id the ID of the meeting room to find
	 * @return the MeetingRoom object with the given ID, or null if not found
	 */
	MeetingRoom getRoomById(String id);

	/**
	 * Updates an existing meeting room and its associated equipment.
	 *
	 * @param meetingRoomDto     a data transfer object containing updated
	 *                           information about the meeting room
	 * @param selectedEquipments a list of equipment names or identifiers to be
	 *                           associated with the updated meeting room
	 */
	void updateMeetingRoomAndEquipment(MeetingRoomDto meetingRoomDto, List<String> selectedEquipments);

	/**
	 * Retrieves a filtered list of equipment associated with a specific meeting
	 * room.
	 *
	 * @param room the MeetingRoom object for which to find associated equipment
	 * @return a FilteredDataDto object containing equipment details for the given
	 *         meeting room
	 */
	FilteredDataDto getEquipmentByRoom(MeetingRoom room);

	/**
	 * Retrieves a filtered list of all available equipment.
	 *
	 * @return a FilteredDataDto object containing details of all available
	 *         equipment
	 */
	FilteredDataDto getAllEquipments();

}
