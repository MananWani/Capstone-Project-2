package com.crimsonlogic.meetingroombooking.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.crimsonlogic.meetingroombooking.entity.Meeting;
import com.crimsonlogic.meetingroombooking.entity.Users;

/**
 * @author abdulmanan
 *
 */
@Repository
public interface MeetingRepository extends JpaRepository<Meeting, String> {

	/**
	 * Finds a list of meetings organized by a specific user.
	 *
	 * @param user the Users object representing the organizer
	 * @return a list of Meeting objects organized by the given user
	 */
	List<Meeting> findByMeetingByUser(Users user);

}
