package com.crimsonlogic.meetingroombooking.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.crimsonlogic.meetingroombooking.dto.FilteredDataDto;
import com.crimsonlogic.meetingroombooking.dto.MeetingRoomDto;
import com.crimsonlogic.meetingroombooking.entity.MeetingRoom;
import com.crimsonlogic.meetingroombooking.service.MeetingRoomService;

/**
 * @author abdulmanan
 *
 */
@Controller
@RequestMapping("/meetingroom")
public class MeetingRoomController {

	@Autowired
	MeetingRoomService meetingRoomService;

	/**
	 * Displays the form to add a new meeting room.
	 * 
	 * @param model The model to pass attributes to the view.
	 * @return The name of the JSP file to display.
	 */
	@GetMapping("/addroom")
	public String addRoomForm(Model model) {
		model.addAttribute("meetingroom", new MeetingRoom());
		return "addroom"; // JSP file name
	}

	/**
	 * Handles the submission of a new meeting room. Attempts to add the meeting
	 * room with the provided details and equipment.
	 * 
	 * @param meetingRoomDto     The DTO containing meeting room details.
	 * @param selectedEquipments List of selected equipment for the meeting room.
	 * @param model              The model to pass attributes to the view.
	 * @return Redirect URL or view name based on the outcome of the addition.
	 */
	@PostMapping("/addroom")
	public String addRoom(@ModelAttribute MeetingRoomDto meetingRoomDto, @RequestParam List<String> selectedEquipments,
			Model model) {
		try {
			meetingRoomService.addMeetingRoomAndEquipment(meetingRoomDto, selectedEquipments);
			return "redirect:/meetingroom/getallrooms?roomAdded=Room added successfully!";
		} catch (RuntimeException e) {
			model.addAttribute("alreadyExists", e.getMessage());
			return "addroom";
		}
	}

	/**
	 * Displays the form to update details of a specific meeting room. Prepares
	 * lists of equipment associated with the room.
	 * 
	 * @param roomId The ID of the meeting room to be updated.
	 * @param model  The model to pass attributes to the view.
	 * @return The name of the JSP file to display.
	 */
	@GetMapping("/updateroom")
	public String showUpdateForm(@RequestParam("roomId") String roomId, Model model) {
		MeetingRoom room = meetingRoomService.getRoomById(roomId);
		FilteredDataDto response = meetingRoomService.getEquipmentByRoom(room);

		model.addAttribute("room", room);
		model.addAttribute("equipments", response.getEquipments());
		return "updateroom";
	}

	/**
	 * Handles the submission of updated meeting room details. Attempts to update
	 * the meeting room with the provided details and equipment.
	 * 
	 * @param meetingRoomDto     The DTO containing updated meeting room details.
	 * @param selectedEquipments List of selected equipment for the meeting room.
	 * @param model              The model to pass attributes to the view.
	 * @return Redirect URL or view name based on the outcome of the update.
	 */
	@PostMapping("/updateroom")
	public String updateRoom(@ModelAttribute MeetingRoomDto meetingRoomDto,
			@RequestParam List<String> selectedEquipments, Model model) {
		try {
			meetingRoomService.updateMeetingRoomAndEquipment(meetingRoomDto, selectedEquipments);
			return "redirect:/meetingroom/getallrooms?roomAdded=Room updated successfully!";
		} catch (RuntimeException e) {
			model.addAttribute("alreadyExists", e.getMessage());
			return "updateroom";
		}
	}

	/**
	 * Displays a list of all meeting rooms. Includes optional messages and
	 * different views based on user designation.
	 * 
	 * @param roomAdded Optional message indicating a recent action, like adding or
	 *                  updating a room.
	 * @param model     The model to pass attributes to the view.
	 * @param request   The HTTP request used to get the current session.
	 * @return The name of the JSP file to display based on user designation.
	 */
	@GetMapping("/getallrooms")
	public String getAllRooms(Model model, @RequestParam(value = "roomAdded", required = false) String roomAdded,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		String designation = (String) session.getAttribute("designation");
		List<MeetingRoom> roomList = meetingRoomService.getAllMeetingRoom();

		FilteredDataDto response = meetingRoomService.getAllEquipments();
		model.addAttribute("roomList", roomList);
		model.addAttribute("equipmentList", response.getEquipments());
		if (roomAdded != null) {
			model.addAttribute("roomAdded", roomAdded);
		}
		if ("HR".equalsIgnoreCase(designation))
			return "hrroomlist";
		else {
			return "roomlist";
		}
	}
}
