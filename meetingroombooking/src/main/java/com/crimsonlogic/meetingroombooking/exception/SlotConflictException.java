package com.crimsonlogic.meetingroombooking.exception;

/**
 * @author abdulmanan
 *
 */
public class SlotConflictException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public SlotConflictException(String msg) {
		super(msg);
	}

	public SlotConflictException(String message, Exception e) {
		super(message);
	}

}
