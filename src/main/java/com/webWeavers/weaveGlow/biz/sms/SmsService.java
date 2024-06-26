package com.webWeavers.weaveGlow.biz.sms;

import java.security.SecureRandom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webWeavers.weaveGlow.biz.member.MemberDTO;
import com.webWeavers.weaveGlow.biz.member.MemberService;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Service("smsService")
public class SmsService {
	
	@Autowired
	MemberService memberService;
	
	public int sendMessage(MemberDTO memberDTO) {		
		System.out.println("[로그] 문자인증 서비스");
		
		// initialize("API 키 입력", "API 시크릿 키 입력", "주소")
		DefaultMessageService messageService =  NurigoApp.INSTANCE.initialize("NCSBXXQF0TAAOOLN", "I58EYW5XFVYACID2PCAKVCCNCOCHHMSD", "https://api.coolsms.co.kr");
		
		Message message = new Message();

		message.setFrom("01062360548");
		message.setTo(memberDTO.getMemberPhone());
		
		int randNum = -1;
		// 회원가입 문자인증 : 문자내용 > 랜덤번호
		if(memberDTO.getSearchCondition().equals("certification")) {
			// 인증번호 5자리 랜덤 생성 > messageText에 저장
			randNum = (int)(Math.random() * (99999 - 10000 + 1)) + 10000;
			message.setText("[WeaveGlow 인증번호] " + randNum);
		}
		// 아이디 찾기 : 문자내용 > 회원 ID
		else if(memberDTO.getSearchCondition().equals("sendID")) {
			message.setText("[WeaveGlow ID] " + memberDTO.getMemberID());
		}
		// 비밀번호 찾기 : 문자내용 > 임시 비밀번호
		else if(memberDTO.getSearchCondition().equals("sendPW")) {
			// 임시 비밀번호 10자리 생성 > messageText에 저장
			String randPW = getRandomPassword(10);
			message.setText("[WeaveGlow 임시 비밀번호] " + randPW);
			
			// 임시 비밀번호 발급 전, 회원 비밀번호 update
			memberDTO.setMemberPassword(randPW);
			memberDTO.setSearchCondition("updatePW");			
			if(!memberService.update(memberDTO)) {
				return -1;
			}
		}

		try {
		  // send 메서드로 문자 전송
		  messageService.send(message);
		  
		  // 회원가입 문자인증
		  if(memberDTO.getSearchCondition().equals("certification")) {
			  // 최소한의 보안을 위해 인증번호 * 7777
			  return randNum * 7777;
		  }
		  // 아이디찾기, 비밀번호찾기
		  else {
			  return 1;
		  }
		  
		} catch (NurigoMessageNotReceivedException exception) {
		  // 발송에 실패한 메시지 목록을 확인
		  System.out.println(exception.getFailedMessageList());
		  System.out.println(exception.getMessage());
		  return -1;
		} catch (Exception exception) {
		  System.out.println(exception.getMessage());
		  return -1;
		}
	}
	
	// 임시 비밀번호를 생성하기 위한 문자후보목록
	private static final char[] CharArray = new char[]{
	        // 숫자
	        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
	        // 대문자
	        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
	        'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
	        // 소문자
	        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
	        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
	        // 특수기호
	        '@', '$', '!', '%', '*', '?', '&'
	};
	
	// 매개변수로 받은 수의 길이만큼 임시 비밀번호 생성하는 메서드
	public String getRandomPassword(int length) {
		// 보안을 강화하기 위해 SecureRandom 사용
	    SecureRandom random = new SecureRandom();
	    StringBuilder stringBuilder = new StringBuilder();
	    
	    // 랜덤문자배열 변수에 저장 (반복문 실행될 때마다 .length 호출 방지)
	    int charArrayLength = CharArray.length;
	    for (int i = 0; i < length; i++) {
	    	// 랜덤 인덱스로 랜덤 문자 선택 > stringBuilder 객체에 문자 추가
	        stringBuilder.append(CharArray[random.nextInt(charArrayLength)]);
	    }
	    
	    // StringBuilder > String 객체로 변환 후 반환
	    return stringBuilder.toString();
	}
}
