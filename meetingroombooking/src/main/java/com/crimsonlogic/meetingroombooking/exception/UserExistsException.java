package com.crimsonlogic.meetingroombooking.exception;

/**
 * @author abdulmanan
 *
 */
public class UserExistsException extends Exception{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public UserExistsException(String msg) {
		super(msg);
	}

	public UserExistsException(String message, UserExistsException e) {
		super(message, e);
	}

	
}
