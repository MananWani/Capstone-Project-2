package com.crimsonlogic.meetingroombooking.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.crimsonlogic.meetingroombooking.entity.Users;

/**
 * @author abdulmanan
 *
 */
@Repository
public interface UsersRepository extends JpaRepository<Users, String> {

	/**
	 * Finds a user by either their full name or email address.
	 *
	 * @param fullname the full name of the user
	 * @param email    the email address of the user
	 * @return the Users object that matches the given full name or email address,
	 *         or null if not found
	 */
	Users findByUserFullnameOrUserEmail(String fullname, String email);

	/**
	 * Finds a user by their full name.
	 *
	 * @param userUnderManager the full name of the user
	 * @return the Users object with the given full name, or null if not found
	 */
	Users findByUserFullname(String userUnderManager);

	/**
	 * Finds a list of users by their designations.
	 *
	 * @param designations a list of designations to filter users by
	 * @return a list of Users objects with any of the specified designations
	 */
	List<Users> findByUserDesignation(List<String> designations);

	/**
	 * Finds distinct user designations from the Users table.
	 *
	 * @return a list of distinct user designations
	 */
	@Query("SELECT DISTINCT u.userDesignation FROM Users u")
	List<String> findByDistinctUserDesignation();

	/**
	 * Finds a user by their mobile number.
	 *
	 * @param userMobileNo the mobile number of the user
	 * @return the Users object with the given mobile number, or null if not found
	 */
	Users findByUserMobileNo(String userMobileNo);

	/**
	 * Finds a user by their email address.
	 *
	 * @param userEmail the email address of the user
	 * @return the Users object with the given email address, or null if not found
	 */
	Users findByUserEmail(String userEmail);

	/**
	 * Finds a list of users who report to a specific manager.
	 *
	 * @param userUnderManager the full name of the manager
	 * @return a list of Users objects who report to the specified manager
	 */
	List<Users> findByUserUnderManager(String userUnderManager);

}
