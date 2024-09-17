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
@Table(name = "meeting_participants")
@Data
@NoArgsConstructor
public class MeetingParticipants {
	@Id
	@Column(name = "participant_id")
	private String participantId;

	@Column(name = "participant_fullname")
	private String participantFullname;

	@Column(name = "participant_response")
	private String participantResponse;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "participant_for_meeting", referencedColumnName = "meeting_id")
	private Meeting participantForMeeting;
	
	@PrePersist
    public void generateId() {
        this.participantId = "PTP" + IdGenerator.generateRandomID();
    }
}
