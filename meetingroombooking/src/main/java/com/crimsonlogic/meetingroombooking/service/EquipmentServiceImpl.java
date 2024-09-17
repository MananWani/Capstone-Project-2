package com.crimsonlogic.meetingroombooking.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crimsonlogic.meetingroombooking.entity.Equipment;
import com.crimsonlogic.meetingroombooking.entity.MeetingRoom;
import com.crimsonlogic.meetingroombooking.repository.EquipmentRepository;

/**
 * @author abdulmanan
 *
 */
@Service
public class EquipmentServiceImpl implements EquipmentService {

	@Autowired
	EquipmentRepository equipmentRepository;

	@Override
	public List<Equipment> getAllEquipment() {
		// Retrieve and return a list of all equipment from the repository
		return equipmentRepository.findAll();
	}

	@Override
	public void addEquipment(MeetingRoom isAdded, List<String> selectedEquipments) {
		// Iterate over the list of selected equipment names
		for (String equipmentName : selectedEquipments) {
			// Create a new Equipment object for each equipment name
			Equipment equipment = new Equipment();
			equipment.setEquipmentName(equipmentName);
			equipment.setEquipmentForRoom(isAdded); // Associate the equipment with the given meeting room
			// Save the new Equipment object to the repository
			equipmentRepository.save(equipment);
		}
	}

	@Override
	public List<Equipment> getEquipmentByRoom(MeetingRoom room) {
		// Retrieve and return a list of equipment associated with the specified meeting
		// room
		return equipmentRepository.findByEquipmentForRoom(room);
	}
}
