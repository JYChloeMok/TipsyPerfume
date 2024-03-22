package com.kh.ttp.user.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class UserDTO {

	private int userNo;
	private String userEmail;
	private String userPwd;
	private String userName;
	private String nickName;
	private String birthDate;
	private String status;
	
	private String memberType;
	private String businessReg;
	private String adultStatus;
	private Date enrollDate;
	private String userProfile;
	
	private String receiverName;
	private String phone;
	private String address;
	private String addressDetail;
	private int postalCode;
	
	
	


	
	
	
	
}
