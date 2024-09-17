package com.crimsonlogic.meetingroombooking.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.crimsonlogic.meetingroombooking.entity.Meeting;
import com.crimsonlogic.meetingroombooking.entity.Slots;

/**
 * @author abdulmanan
 *
 */
@Repository
public interface SlotsRepository extends JpaRepository<Slots, String> {

	/**
	 * Deletes all Slots associated with a specific meeting.
	 *
	 * @param meeting the Meeting object whose associated slots should be deleted
	 */
	void deleteBySlotForMeeting(Meeting meeting);

}
