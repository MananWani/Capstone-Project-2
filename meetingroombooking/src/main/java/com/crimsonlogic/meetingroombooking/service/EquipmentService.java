package com.crimsonlogic.meetingroombooking.service;

import java.util.List;

import com.crimsonlogic.meetingroombooking.entity.Equipment;
import com.crimsonlogic.meetingroombooking.entity.MeetingRoom;

/**
 * @author abdulmanan
 *
 */
public interface EquipmentService {

	/**
	 * Retrieves a list of all equipment available.
	 *
	 * @return a list of all Equipment objects
	 */
	List<Equipment> getAllEquipment();

	/**
	 * Adds equipment to a specific meeting room.
	 *
	 * @param isAdded            the MeetingRoom object to which equipment should be
	 *                           added
	 * @param selectedEquipments a list of equipment names or identifiers to be
	 *                           added to the meeting room
	 */
	void addEquipment(MeetingRoom isAdded, List<String> selectedEquipments);

	/**
	 * Retrieves a list of equipment associated with a specific meeting room.
	 *
	 * @param room the MeetingRoom object for which to find associated equipment
	 * @return a list of Equipment objects associated with the given meeting room
	 */
	List<Equipment> getEquipmentByRoom(MeetingRoom room);

}
