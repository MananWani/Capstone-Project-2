package com.crimsonlogic.meetingroombooking.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author abdulmanan
 *
 */
@Data
@NoArgsConstructor
public class UsersDto {

	private String userId;

	private String userFullname;

	private String userPassword;

	private String userEmail;

	private String userMobileNo;

	private String userDesignation;

	private String userUnderManager;

	private Boolean userActive;
}
