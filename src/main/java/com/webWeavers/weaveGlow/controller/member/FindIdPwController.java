package com.webWeavers.weaveGlow.controller.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.webWeavers.weaveGlow.biz.member.MemberDTO;
import com.webWeavers.weaveGlow.biz.member.MemberService;
import com.webWeavers.weaveGlow.biz.sms.SmsService;

@Controller
public class FindIdPwController {

	@Autowired
	MemberService memberService;
	@Autowired
	SmsService smsService;
	
	@RequestMapping("/async/smsSendID")
	public @ResponseBody int smsSendID(MemberDTO memberDTO) {	
		
		// selectOne 검색조건 저장
		memberDTO.setSearchCondition("idForgot");
		memberDTO = memberService.selectOne(memberDTO);
		
		// 일치하는 회원이 없으면 실패
		if(memberDTO == null) {
			return -1;
		}
		
		// sendMessage 검색조건 저장
		memberDTO.setSearchCondition("sendID");
		// 서비스 이용 후 return (성공:1, 실패:-1)
		return smsService.sendMessage(memberDTO);
		
	}
	
	@RequestMapping("/async/successSmsSendID")
	public String login() {
		return "user/login";
	}
	
}
