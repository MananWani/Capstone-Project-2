package com.crimsonlogic.meetingroombooking.exception;

/**
 * @author abdulmanan
 *
 */
public class MeetingRoomExistsException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public MeetingRoomExistsException(String msg) {
		super(msg);
	}
}
