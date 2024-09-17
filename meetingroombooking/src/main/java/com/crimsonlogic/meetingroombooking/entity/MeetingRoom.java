package com.crimsonlogic.meetingroombooking.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import com.crimsonlogic.meetingroombooking.util.IdGenerator;

import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "meeting_rooms")
@Data
@NoArgsConstructor
public class MeetingRoom {
	@Id
	@Column(name = "room_id")
	private String roomId;

	@Column(name = "room_name")
	private String roomName;

	@Column(name = "room_capacity")
	private Integer roomCapacity;

	@PrePersist
	public void generateId() {
		this.roomId = "RM" + IdGenerator.generateRandomID();
	}
}
