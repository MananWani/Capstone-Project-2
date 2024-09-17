package com.crimsonlogic.meetingroombooking.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author abdulmanan
 *
 */
@Data
@NoArgsConstructor
public class MeetingDto {
	private String meetingId;

	private String meetingStartTime;

	private String meetingEndTime;

	private String meetingPurpose;

	private String meetingStatus;

	private String meetingByUser;

	private String meetingInRoom;
	
}
