package com.crimsonlogic.meetingroombooking.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import com.crimsonlogic.meetingroombooking.util.IdGenerator;

import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "slots")
@Data
@NoArgsConstructor
public class Slots {

	@Id
	@Column(name = "slot_id")
	private String slotId;

	@Column(name = "slot_start_time")
	private Timestamp slotStartTime;

	@Column(name = "slot_end_time")
	private Timestamp slotEndTime;

	@Column(name = "slot_status")
	private String slotStatus;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "slot_in_room", referencedColumnName = "room_id")
	private MeetingRoom slotInRoom;

	@OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "slot_for_meeting", referencedColumnName = "meeting_id")
    private Meeting slotForMeeting;
	
	@PrePersist
	public void generateId() {
		this.slotId = "SLOT" + IdGenerator.generateRandomID();
	}
}
