package com.crimsonlogic.meetingroombooking.service;

import java.util.List;

import com.crimsonlogic.meetingroombooking.dto.FilteredDataDto;
import com.crimsonlogic.meetingroombooking.dto.UsersDto;
import com.crimsonlogic.meetingroombooking.entity.Users;
import com.crimsonlogic.meetingroombooking.exception.UserExistsException;

/**
 * @author abdulmanan
 *
 */
public interface UsersService {

	/**
	 * Adds a new user based on the provided user details.
	 *
	 * @param usersDto a data transfer object containing information about the user
	 *                 to be added
	 * @throws UserExistsException if a user with the same email or username already
	 *                             exists
	 */
	void addUser(UsersDto usersDto) throws UserExistsException;

	/**
	 * Retrieves a list of all users.
	 *
	 * @return a list of all Users objects
	 */
	List<Users> getAllUsers();

	/**
	 * Retrieves a user by their full name.
	 *
	 * @param name the full name of the user to retrieve
	 * @return the Users object with the given name, or null if not found
	 */
	Users getUserByName(String name);

	/**
	 * Updates an existing user's details.
	 *
	 * @param usersDto a data transfer object containing updated information about
	 *                 the user
	 * @return true if the update was successful, false otherwise
	 */
	Boolean updateUser(UsersDto usersDto);

	/**
	 * Authenticates a user based on their email and password.
	 *
	 * @param userEmail    the email of the user attempting to authenticate
	 * @param userPassword the password of the user attempting to authenticate
	 * @return the authenticated Users object if authentication is successful, or
	 *         null if not
	 */
	Users authenticateUser(String userEmail, String userPassword);

	/**
	 * Retrieves a list of users who have manager designations.
	 *
	 * @return a list of Users objects with manager designations
	 */
	List<Users> getUsersWithManagerDesignations();

	/**
	 * Retrieves a list of all designations.
	 *
	 * @return a list of all designation names
	 */
	List<String> getdesignations();

	/**
	 * Retrieves a list of users who report to a specific manager.
	 *
	 * @param userUnderManager the full name of the manager whose team is to be
	 *                         retrieved
	 * @return a list of Users objects who report to the specified manager
	 */
	List<Users> getUserTeamByManager(String userUnderManager);

	/**
	 * Retrieves a user by their ID.
	 *
	 * @param userId the ID of the user to retrieve
	 * @return the Users object with the given ID, or null if not found
	 */
	Users getUserById(String userId);

	/**
	 * Updates a user's password.
	 *
	 * @param userFullname    the full name of the user whose password is to be
	 *                        updated
	 * @param currentPassword the current password of the user
	 * @param newPassword     the new password to set
	 * @return true if the password update was successful, false otherwise
	 */
	boolean updatePassword(String userFullname, String currentPassword, String newPassword);

	/**
	 * Retrieves filtered meeting room and slot information.
	 *
	 * @return a FilteredDataDto object containing details of meeting rooms and
	 *         available slots
	 */
	FilteredDataDto meetingRoomAndSlots();

}
