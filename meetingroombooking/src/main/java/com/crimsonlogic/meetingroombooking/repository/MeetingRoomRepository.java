package com.crimsonlogic.meetingroombooking.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.crimsonlogic.meetingroombooking.entity.MeetingRoom;

/**
 * @author abdulmanan
 *
 */
@Repository
public interface MeetingRoomRepository extends JpaRepository<MeetingRoom, String> {

	/**
	 * Finds a MeetingRoom by its room name.
	 *
	 * @param roomName the name of the room to find
	 * @return the MeetingRoom object with the given room name, or null if not found
	 */
	MeetingRoom findByRoomName(String roomName);

	/**
	 * Finds a MeetingRoom by its room ID.
	 *
	 * @param id the ID of the room to find
	 * @return the MeetingRoom object with the given ID, or null if not found
	 */
	MeetingRoom findByRoomId(String roomId);

}
