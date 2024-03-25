package com.kh.ttp.productSale.billing.payment.model.vo;

import org.springframework.web.reactive.function.client.WebClient;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class PortOneApiDTO {
	
	private final String PORT_ONE_BASE_URL = "api.iamport.kr";
	private final WebClient webClient; // 일단 이렇게(생성 시 필드 있음)

	private PaymentDTO payment;
	
	public PortOneApiDTO(String urlPath) {
		this.webClient = WebClient.create(PORT_ONE_BASE_URL + urlPath);
	}
	
	public PortOneApiDTO(String urlPath, PaymentDTO payment) {
		this.payment = payment;
		this.webClient = WebClient.create(PORT_ONE_BASE_URL + urlPath);
	}
	
}
