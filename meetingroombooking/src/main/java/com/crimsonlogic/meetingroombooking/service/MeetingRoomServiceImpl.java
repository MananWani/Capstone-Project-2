package com.crimsonlogic.meetingroombooking.service;

import java.util.List;

import javax.persistence.EntityNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.crimsonlogic.meetingroombooking.dto.FilteredDataDto;
import com.crimsonlogic.meetingroombooking.dto.MeetingRoomDto;
import com.crimsonlogic.meetingroombooking.entity.Equipment;
import com.crimsonlogic.meetingroombooking.entity.MeetingRoom;
import com.crimsonlogic.meetingroombooking.exception.MeetingRoomExistsException;
import com.crimsonlogic.meetingroombooking.repository.EquipmentRepository;
import com.crimsonlogic.meetingroombooking.repository.MeetingRoomRepository;

/**
 * @author abdulmanan
 *
 */
@Service
public class MeetingRoomServiceImpl implements MeetingRoomService {

	@Autowired
	MeetingRoomRepository meetingRoomRepository;

	@Autowired
	EquipmentRepository equipmentRepository;

	@Autowired
	EquipmentService equipmentService;

	@Override
	public List<MeetingRoom> getAllMeetingRoom() {
		// Retrieve and return all meeting rooms from the repository
		return meetingRoomRepository.findAll();
	}

	@Override
	public MeetingRoom findByRoomName(String meetingInRoom) {
		// Retrieve and return a meeting room by its name
		return meetingRoomRepository.findByRoomName(meetingInRoom);
	}

	@Override
	@Transactional
	public void addMeetingRoomAndEquipment(MeetingRoomDto meetingRoomDto, List<String> selectedEquipments) {
		try {
			// Check if a meeting room with the same name already exists
			MeetingRoom existingRoom = meetingRoomRepository.findByRoomName(meetingRoomDto.getRoomName());
			if (existingRoom != null) {
				throw new MeetingRoomExistsException("Room name already exists!"); // Throw exception if room exists
			} else {
				// Create and save a new meeting room
				MeetingRoom newMeetingRoom = new MeetingRoom();
				newMeetingRoom.setRoomName(meetingRoomDto.getRoomName());
				newMeetingRoom.setRoomCapacity(meetingRoomDto.getRoomCapacity());
				meetingRoomRepository.save(newMeetingRoom);

				// Save each selected equipment associated with the new meeting room
				for (String equipmentName : selectedEquipments) {
					Equipment equipment = new Equipment();
					equipment.setEquipmentName(equipmentName);
					equipment.setEquipmentForRoom(newMeetingRoom);
					equipmentRepository.save(equipment);
				}
			}
		} catch (Exception e) {
			// Log and throw runtime exception in case of error
			throw new RuntimeException(e.getMessage(), e);
		}
	}

	@Override
	public MeetingRoom getRoomById(String id) {
		// Retrieve and return a meeting room by its ID
		return meetingRoomRepository.findByRoomId(id);
	}

	@Override
	@Transactional
	public void updateMeetingRoomAndEquipment(MeetingRoomDto meetingRoomDto, List<String> selectedEquipments) {
		try {
			// Fetch the existing MeetingRoom from the database
			MeetingRoom existingRoom = meetingRoomRepository.findByRoomName(meetingRoomDto.getRoomName());

			if (existingRoom == null) {
				throw new EntityNotFoundException("Meeting room not found"); // Throw exception if room does not exist
			}

			// Update the details of the existing MeetingRoom
			existingRoom.setRoomName(meetingRoomDto.getRoomName());
			existingRoom.setRoomCapacity(meetingRoomDto.getRoomCapacity());

			// Save the updated MeetingRoom
			meetingRoomRepository.save(existingRoom);

			// Delete existing equipment associated with the room
			equipmentRepository.deleteByEquipmentForRoom(existingRoom);

			// Save each selected equipment associated with the updated meeting room
			for (String equipmentName : selectedEquipments) {
				Equipment equipment = new Equipment();
				equipment.setEquipmentName(equipmentName);
				equipment.setEquipmentForRoom(existingRoom);
				equipmentRepository.save(equipment);
			}
		} catch (Exception e) {
			// Log and throw runtime exception in case of error
			throw new RuntimeException(e.getMessage(), e);
		}
	}

	@Override
	public FilteredDataDto getEquipmentByRoom(MeetingRoom room) {
		// Create a DTO to hold the equipment for the specified meeting room
		FilteredDataDto dto = new FilteredDataDto();
		dto.setEquipments(equipmentService.getEquipmentByRoom(room));
		return dto;
	}

	@Override
	public FilteredDataDto getAllEquipments() {
		// Create a DTO to hold all equipment
		FilteredDataDto dto = new FilteredDataDto();
		dto.setEquipments(equipmentService.getAllEquipment());
		return dto;
	}
}
