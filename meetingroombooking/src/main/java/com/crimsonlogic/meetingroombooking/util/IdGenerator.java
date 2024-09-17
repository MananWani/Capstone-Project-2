package com.crimsonlogic.meetingroombooking.util;

import java.util.Random;

/**
 * @author abdulmanan
 *
 */
public class IdGenerator {
	private IdGenerator() {

	}

	// Define the lower and upper bounds for the random ID range
	private static final int LOWER_BOUND = 100000; // Minimum value for the ID
	private static final int UPPER_BOUND = 999999; // Maximum value for the ID

	// Create a single instance of Random to be reused
	private static final Random RANDOM = new Random();

	// Method to generate a random ID within the specified range
	public static int generateRandomID() {
		return RANDOM.nextInt(UPPER_BOUND - LOWER_BOUND) + LOWER_BOUND;
	}
}
