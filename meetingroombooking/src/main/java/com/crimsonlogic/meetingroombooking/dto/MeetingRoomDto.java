package com.crimsonlogic.meetingroombooking.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author abdulmanan
 *
 */
@Data
@NoArgsConstructor
public class MeetingRoomDto {
	
	private String roomId;

	private String roomName;

	private Integer roomCapacity;
}
