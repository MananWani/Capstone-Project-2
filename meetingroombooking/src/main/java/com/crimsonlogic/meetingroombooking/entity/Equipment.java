package com.crimsonlogic.meetingroombooking.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import com.crimsonlogic.meetingroombooking.util.IdGenerator;

import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "equipment")
@Data
@NoArgsConstructor
public class Equipment {
	@Id
	@Column(name = "equipment_id")
	private String equipmentId;

	@Column(name = "equipment_name")
	private String equipmentName;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "equipment_for_room", referencedColumnName = "room_id")
	private MeetingRoom equipmentForRoom;
	
	@PrePersist
    public void generateId() {
        this.equipmentId = "EQP" + IdGenerator.generateRandomID();
    }
}
