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
@Table(name = "meeting")
@Data
@NoArgsConstructor
public class Meeting {
	@Id
	@Column(name = "meeting_id")
    private String meetingId;
 
    @Column(name = "meeting_start_time")
    private Timestamp meetingStartTime;
 
    @Column(name = "meeting_end_time")
    private Timestamp meetingEndTime;
 
    @Column(name = "meeting_purpose")
    private String meetingPurpose;
 
    @Column(name = "meeting_status")
    private String meetingStatus;
 
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "meeting_by_user", referencedColumnName = "user_id")
    private Users meetingByUser;
 
    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "meeting_in_room", referencedColumnName = "room_id")
    private MeetingRoom meetingInRoom;
    
    @PrePersist
    public void generateId() {
        this.meetingId = "MTG" + IdGenerator.generateRandomID();
    }

}
