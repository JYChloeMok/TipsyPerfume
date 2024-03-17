package com.kh.ttp.user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.ttp.productSale.receiver.model.service.ReceiverService;
import com.kh.ttp.user.model.service.UserService;
import com.kh.ttp.user.model.vo.AuthVO;
import com.kh.ttp.user.model.vo.User;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class UserController {
	
	private final UserService userService;
	
	private final BCryptPasswordEncoder bcrypt;

	//private final JavaMailSender sender;
	
	private final ReceiverService receiverService;
	
	@GetMapping("loginForm.me")
	public String loginUser(Model model, HttpServletRequest request) {
		
		String referer = request.getHeader("Referer");
		referer = (referer == null) ? "/" : referer.substring(referer.lastIndexOf("/"));
		model.addAttribute("referer", referer);
		return "member/LoginForm";
	}
	
	
	//로그인 + 중복이메일체크
	@RequestMapping("login.me")
	public ModelAndView loginUser(User u,
								  HttpSession session,
								  ModelAndView mv,
								  @RequestParam(value="referer", defaultValue="/") String referer) {
		
		User loginUser = userService.loginUser(u);
		if(loginUser != null && bcrypt.matches(u.getUserPwd(), loginUser.getUserPwd())) {
			session.setAttribute("loginUser", loginUser);
			mv.setViewName("redirect:" + referer);
		} else {
			mv.addObject("alertMsg", "로그인에 실패했습니다.");
			mv.setViewName("member/LoginForm");
		}
			return mv;
	}

	
		//로그아웃
		@RequestMapping("logout.me")
		public String logoutUser(HttpSession session) {
			session.invalidate();
			return "redirect:/";
		}
	
		
		//회원가입폼 보내기
		@RequestMapping("enrollForm.me")
		public String enrollForm() {
			return "member/memberEnrollForm";
		}
	
		
		//회원가입
		
		@RequestMapping("insert.me")
		public String insertUser(User u, Model model, HttpSession session) {
			
			String encPwd = bcrypt.encode(u.getUserPwd());
			u.setUserPwd(encPwd);
			u.setUserNo(u.getUserNo());
			
			if(userService.insertUser(u) > 0) { 
				return "member/LoginForm";
			} else { 
				model.addAttribute("errorMsg", "회원가입 실패");
				return "common/errorPage";
			}
		}
		
	
		//마이페이지 보내기
		@RequestMapping("myPageForm.me")
		public String myPageForm() {
			return "member/myPage";
		}	
	
		
		@RequestMapping("myPage.me")
		public ModelAndView myPage(ModelAndView mv, HttpSession session) {
			//System.out.println("1");
			int userNo = ((User)session.getAttribute("loginUser")).getUserNo();
			//서비스에서 넘버를 주고 거기서 리시버를 셀렉트 
			//System.out.println(rc);
			mv.addObject("rc", receiverService.selectReceiver(userNo)).setViewName("member/myPage");
			return mv;
		} 
	
	//마이페이지에서 receiver데이터 삭제 추가하는 기능!! 해야됨 ㅁㅊ 이거가능한거임?어케함?ㅠㅠ>>나중에!
	
	
		//유저 정보 업데이트 기능
		@RequestMapping("update.me")
		public String updateMember(User u, Model model, HttpSession session) {
			
			if(userService.updateUser(u) > 0) {
				session.setAttribute("loginUser", userService.loginUser(u));
				session.setAttribute("alertMsg", "정보 수정에 성공하였습니다.");
				return "redirect:myPage.me";
			} else {
				model.addAttribute("errorMsg", "정보 수정에 실패했습니다.");
				return "common/errorPage";
			}
		}
	
	
		@RequestMapping("delete.me")
		public String deleteUser(String userPwd, HttpSession session) {
			
			User loginUser = ((User)session.getAttribute("loginUser"));
			String encPwd = loginUser.getUserPwd();
			
			if(bcrypt.matches(userPwd, encPwd)) {
				String userEmail = loginUser.getUserEmail();
				
				if(userService.deleteUser(userEmail) > 0) {
					session.removeAttribute("loginUser");
					session.setAttribute("alertMsg", "탈퇴되었습니다.");
					return "redirect:/";
				} else {
					session.setAttribute("errorMsg", "탈퇴 처리 실패되었습니다.");
					return "common/errorPage";
				}
			} else {
			session.setAttribute("alertMsg", "비밀번호가 틀렸습니다.");
			return "redirect:myPage.me";
			}	
		}
	
		
		
		
		//이메일 사용 가능한지 확인(중복 확인)
		@ResponseBody
		@RequestMapping("emailCheck.me")
		public String emailCheck(String checkEmail) {
			return userService.emailCheck(checkEmail) > 0 ? "NNNNNNNNNNNNNNN" : "NNNNNNNNNNNNNNY";
		}
		
		
		/*
		//이메일 발송
		@PostMapping(value="mail", produces="text/html; charset=UTF-8")
		@ResponseBody
			public String ajaxMail(String userEmail, HttpServletRequest request) throws MessagingException{ 
				MimeMessage message = sender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
					
				String ip = request.getRemoteAddr();
					
				Random r = new Random();
				int i = r.nextInt(100000);
				Format f = new DecimalFormat("000000");
				String authCode = f.format(i);
				
				AuthVO authVo = AuthVO.builder()
									.authEmail(ip)
									.authCode(authCode)
									.build();
					helper.setTo(userEmail);
					helper.setSubject("인증번호 보내드립니다");
					helper.setText("인증번호 : " + authCode);
					sender.send(message);
					
					return Integer.toString(userService.sendMail(authVo));
		}
		*/
		// 잠시 OFF
		
		
		
		
		
	
		
			@ResponseBody
			@PostMapping(value="check", produces="text/html; charset=UTF-8")
			public String checkCode(String authCode, HttpServletRequest request) {
		
				AuthVO authVo = AuthVO.builder()
									.authEmail(request.getRemoteAddr())
									.authCode(authCode)
									.build();
				boolean result = userService.validate(authVo);
				
				return Boolean.toString(result);
			}
		
	
	}