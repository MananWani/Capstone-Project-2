package com.crimsonlogic.meetingroombooking.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.crimsonlogic.meetingroombooking.entity.Equipment;
import com.crimsonlogic.meetingroombooking.entity.MeetingRoom;

/**
 * @author abdulmanan
 *
 */
@Repository
public interface EquipmentRepository extends JpaRepository<Equipment, String> {

	/**
	 * Finds a list of equipment associated with a specific meeting room.
	 *
	 * @param room the MeetingRoom object for which to find equipment
	 * @return a list of Equipment objects associated with the given meeting room
	 */
	List<Equipment> findByEquipmentForRoom(MeetingRoom room);

	/**
	 * Deletes all equipment associated with a specific meeting room.
	 *
	 * @param meetingRoom the MeetingRoom object whose associated equipment should
	 *                    be deleted
	 */
	void deleteByEquipmentForRoom(MeetingRoom meetingRoom);
}
