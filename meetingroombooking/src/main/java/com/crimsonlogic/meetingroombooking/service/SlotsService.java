package com.crimsonlogic.meetingroombooking.service;

import java.util.List;

import com.crimsonlogic.meetingroombooking.entity.Slots;

/**
 * @author abdulmanan
 *
 */
public interface SlotsService {

	/**
	 * Retrieves a list of all available time slots.
	 *
	 * @return a list of all Slots objects
	 */
	List<Slots> getAllSlots();

}
