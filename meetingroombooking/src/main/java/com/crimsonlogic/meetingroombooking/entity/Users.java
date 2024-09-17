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
@Table(name = "users")
@Data
@NoArgsConstructor
public class Users {

	@Id
	@Column(name = "user_id")
	private String userId;

	@Column(name = "user_fullname")
	private String userFullname;

	@Column(name = "user_password")
	private String userPassword;

	@Column(name = "user_email")
	private String userEmail;

	@Column(name = "user_mobile_no")
	private String userMobileNo;

	@Column(name = "user_designation")
	private String userDesignation;

	@Column(name = "user_under_manager")
	private String userUnderManager;
	
	@Column(name="user_active")
	private Boolean userActive;
	
	@PrePersist
    public void generateId() {
        this.userId = "USR" + IdGenerator.generateRandomID();
    }

}
