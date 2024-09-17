package com.crimsonlogic.meetingroombooking.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.crimsonlogic.meetingroombooking.dto.FilteredDataDto;
import com.crimsonlogic.meetingroombooking.dto.UsersDto;
import com.crimsonlogic.meetingroombooking.entity.Users;
import com.crimsonlogic.meetingroombooking.exception.UserExistsException;
import com.crimsonlogic.meetingroombooking.repository.UsersRepository;

/**
 * @author abdulmanan
 *
 */
@Service
public class UsersServiceImpl implements UsersService {

	private static final Logger logger = LoggerFactory.getLogger(UsersServiceImpl.class);

	@Autowired
	UsersRepository usersRepository;

	@Autowired
	MeetingRoomService meetingRoomService;

	@Autowired
	SlotsService slotsService;

	@Override
	@Transactional
	public void addUser(UsersDto usersDto) throws UserExistsException {
		// Check if a user with the same username or email already exists
		Users existingUser = usersRepository.findByUserFullnameOrUserEmail(usersDto.getUserFullname(),
				usersDto.getUserEmail());
		if (existingUser != null) {
			throw new UserExistsException("Username or email already exists!");
		}

		// Check if a user with the same mobile number already exists
		Users existingMobile = usersRepository.findByUserMobileNo(usersDto.getUserMobileNo());
		if (existingMobile != null) {
			throw new UserExistsException("Mobile number already exists!");
		}

		// Create a new user and set its properties
		Users user = new Users();
		user.setUserFullname(usersDto.getUserFullname());
		user.setUserEmail(usersDto.getUserEmail());
		user.setUserMobileNo(usersDto.getUserMobileNo());
		user.setUserDesignation(usersDto.getUserDesignation());
		user.setUserUnderManager(usersDto.getUserUnderManager());
		user.setUserPassword(hashPassword(usersDto.getUserPassword()));
		if (usersDto.getUserActive() == null)
			user.setUserActive(false);
		else
			user.setUserActive(usersDto.getUserActive());

		// Save the new user to the repository
		usersRepository.save(user);
	}

	/**
	 * Hashes the password using BCrypt.
	 *
	 * @param password the password to hash
	 * @return the hashed password
	 */
	private String hashPassword(String password) {
		return BCrypt.hashpw(password, BCrypt.gensalt());
	}

	@Override
	public List<Users> getAllUsers() {
		// Retrieve and return a list of all users from the repository
		return usersRepository.findAll();
	}

	@Override
	public Users getUserByName(String name) {
		// Retrieve and return a user by their full name from the repository
		return usersRepository.findByUserFullname(name);
	}

	@Override
	public Boolean updateUser(UsersDto usersDto) {
		try {
			// Find the existing user by full name
			Users u = usersRepository.findByUserFullname(usersDto.getUserFullname());
			// Update the user's details
			u.setUserDesignation(usersDto.getUserDesignation());
			u.setUserUnderManager(usersDto.getUserUnderManager());
			u.setUserMobileNo(usersDto.getUserMobileNo());
			if (usersDto.getUserActive() == null)
				u.setUserActive(false);
			else
				u.setUserActive(usersDto.getUserActive());
			// Save the updated user to the repository
			usersRepository.save(u);
			return true;
		} catch (Exception e) {
			// Log the exception and return false if the update failed
			logger.info(e.getMessage());
			return false;
		}
	}

	@Override
	public Users authenticateUser(String userEmail, String userPassword) {
		// Retrieve user by email
		Users user = usersRepository.findByUserEmail(userEmail);
		// Check if the password matches
		if (user != null && BCrypt.checkpw(userPassword, user.getUserPassword()))
			return user;
		// Return null if authentication fails
		return null;
	}

	@Override
	public List<Users> getUsersWithManagerDesignations() {
		// Retrieve all users
		List<Users> userList = usersRepository.findAll();
		List<Users> returnList = new ArrayList<>();
		// Filter users with manager designations
		for (Users user : userList) {
			if (user.getUserDesignation().equalsIgnoreCase("General Manager")
					|| user.getUserDesignation().equalsIgnoreCase("Manager")
					|| user.getUserDesignation().equalsIgnoreCase("Manager HR")) {
				returnList.add(user);
			}
		}
		return returnList;
	}

	@Override
	public List<String> getdesignations() {
		// Retrieve and return a list of distinct user designations
		return usersRepository.findByDistinctUserDesignation();
	}

	@Override
	public List<Users> getUserTeamByManager(String userUnderManager) {
		// Retrieve and return a list of users reporting to the specified manager
		return usersRepository.findByUserUnderManager(userUnderManager);
	}

	@Override
	public Users getUserById(String userId) {
		// Retrieve user by ID from the repository
		Optional<Users> userOpt = usersRepository.findById(userId);
		if (userOpt.isPresent()) {
			return userOpt.get();
		}
		return null;
	}

	@Override
	public boolean updatePassword(String userFullname, String currentPassword, String newPassword) {
		// Retrieve user by full name
		Users user = usersRepository.findByUserFullname(userFullname);
		// Check if the current password matches
		if (user != null && BCrypt.checkpw(currentPassword, user.getUserPassword())) {
			// Update password and save the user
			user.setUserPassword(hashPassword(newPassword));
			usersRepository.save(user);
			return true;
		}
		return false;
	}

	@Override
	public FilteredDataDto meetingRoomAndSlots() {
		// Create and populate FilteredDataDto with meeting rooms and slots
		FilteredDataDto dto = new FilteredDataDto();
		dto.setMeetingRooms(meetingRoomService.getAllMeetingRoom());
		dto.setSlots(slotsService.getAllSlots());
		return dto;
	}

}
