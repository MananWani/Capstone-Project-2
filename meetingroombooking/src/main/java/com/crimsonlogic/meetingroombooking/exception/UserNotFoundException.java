package com.crimsonlogic.meetingroombooking.exception;

/**
 * @author abdulmanan
 *
 */
public class UserNotFoundException extends Exception{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public UserNotFoundException(String msg) {
		super(msg);
	}
}
