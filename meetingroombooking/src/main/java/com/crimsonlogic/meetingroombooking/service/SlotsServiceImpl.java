package com.crimsonlogic.meetingroombooking.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crimsonlogic.meetingroombooking.entity.Slots;
import com.crimsonlogic.meetingroombooking.repository.SlotsRepository;

/**
 * @author abdulmanan
 *
 */
@Service
public class SlotsServiceImpl implements SlotsService {

	@Autowired
	SlotsRepository slotsRepository;

	@Override
	public List<Slots> getAllSlots() {
		// Fetch and return all slots from the repository
		return slotsRepository.findAll();
	}

}
