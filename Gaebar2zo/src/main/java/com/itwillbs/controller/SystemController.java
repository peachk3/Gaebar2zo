package com.itwillbs.controller;


import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.AuthoritiesVO;
import com.itwillbs.domain.CodeVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.ItemCodeVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.UsersVO;
import com.itwillbs.service.SystemService;


@RequestMapping(value = "/system/*")
@Controller
public class SystemController {

	@Inject
	private SystemService sService;

	private static final Logger logger = LoggerFactory.getLogger(SystemController.class);

	// http://localhost:8088/logout/login
	// 로그인
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void login() throws Exception {
		logger.debug(" login() 실행 ");

	}

	// -------------------------------------------------------------------------------------------
	// 로그인 - 1) 입력받은 아이디, 비밀번호 확인 2) 권한 - 운영자, 관리자, 사원
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login_POST(HttpSession session, UsersVO uvo, @RequestParam(required = false) String redirect) throws Exception {
		
		logger.info("/loginPage -> loginPOST() 호출");
		logger.info("로그인 정보"+ uvo );
		
		return "redirect:/system/main";
		
	}
	


	// -------------------------------------------------------------------------------------------
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public String logout_POST(HttpSession session) throws Exception {

		logger.debug("/logout -> logoutPOST() 호출");
		session.invalidate(); // 세션 무효화

		return "redirect:/loginout/login";
	}
	// -------------------------------------------------------------------------------------------
	//이메일 중복 체크 
	@RequestMapping(value = "/emailCheck", method = RequestMethod.GET)
	@ResponseBody
	public int emailCheck(@RequestParam("user_email")String user_email ) throws Exception {
		
		int result = sService.emailCheck(user_email);
		
		logger.info(" 결과값 :" + result);
		
		return result;
	}
	
	
	// -------------------------------------------------------------------------------------------
	//전화번호 중복 
	@RequestMapping(value = "/phoneCheck", method = RequestMethod.GET)
	@ResponseBody
	public int phoneCheck(@RequestParam("user_phone")String user_phone) throws Exception {
		logger.debug("user_phone"+ user_phone); // 0: 사용 가능, 1: 중복됨
		
		int result = sService.phoneCheck(user_phone);
		
		logger.debug("결과값 : " + result);
		
		return result;
	}
	
	// -------------------------------------------------------------------------------------------
	// http://localhost:8088/system/main
	// 대시보드 ( 메인 페이지 )
	@RequestMapping(value="/main",method=RequestMethod.GET)

	public void main_GET() throws Exception {
		logger.debug(" main_GET() 실행 ");


	}

	// -------------------------------------------------------------------------------------------
	// http://localhost:8088/system/employeeList
	// 사용자 관리 - 사용자 전체 리스트 출력
	@RequestMapping(value = "/employeeList", method = RequestMethod.GET)
	public void employeeList_GET(Criteria cri,Model model, 
			@RequestParam(value="searchType", required = false) String searchType,
            @RequestParam(value="keyword", required = false) String keyword) throws Exception {
		logger.debug(" employeeList_GET() 실행 ");
		logger.debug(" cri : " + cri);
		
	    // 검색 기능
	    if(searchType != null && keyword != null && !keyword.trim().isEmpty()) {
	        cri.setSearchType(searchType);
	        cri.setKeyword(keyword);
	    }

		// 전체리스트
		List<UsersVO> employeeList = sService.employeeListAll(cri);
	    logger.debug(" size : " + employeeList.size());
	    logger.debug(" itemList : " + employeeList);

	    // 하단 페이징처리 정보객체 생성
	    PageVO pageVO = new PageVO();
	    pageVO.setCri(cri);
	    int totalCount = sService.getTotalUserCount(cri);
	    pageVO.setTotalCount(totalCount);
	    
	    logger.debug(" cri " + pageVO.getCri());
	    logger.debug(" page : " + pageVO.getTotalCount());
	    logger.debug(" pageVO " + pageVO);
	    
		model.addAttribute("employeeList", employeeList);
	    model.addAttribute("pageVO", pageVO);
	    model.addAttribute("searchType", searchType);
	    model.addAttribute("keyword", keyword);

	}

	
	//사용자 등록
		@ResponseBody
		@RequestMapping(value = "/addEmp", method = RequestMethod.POST, produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
		public ResponseEntity<?> addEmp(@RequestBody UsersVO usersVo) throws Exception {
			logger.info("controller ->(사용자 등록 실행)");
			
			
			AuthoritiesVO authVo = new AuthoritiesVO();
			authVo.setUsername(usersVo.getUsername());
			
			if(usersVo.getUser_pos().equals("운영자")) {
				authVo.setAuthority("ROLE_ADMIN");
				logger.info("운영자");
			}else if(usersVo.getUser_pos().equals("관리자")) {
				authVo.setAuthority("ROLE_MANAGER");
				logger.info("관리자");
			}else if(usersVo.getUser_pos().equals("사원")) {
				authVo.setAuthority("ROLE_MEMBER");
				logger.info("사원");
			}
			
			
			usersVo.setAuthList(authVo);
			
			int result = sService.addEmp(usersVo);

		    if (result > 0) {
		        logger.info("사용자 등록 성공!!!!!!");
		        return ResponseEntity.ok().body(Collections.singletonMap("status", "success"));
		    } else {
		        logger.info("사용자 등록 실패~~~");
		        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Collections.singletonMap("status", "failure"));
		    }
		}
	
	//사용자 수정 
	@ResponseBody
	@RequestMapping(value = "/updateEmp", method = RequestMethod.POST, produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<String>updateEmp(@RequestBody UsersVO usersVo) throws Exception{
		 logger.debug(" @@@ updateEmp() 실행");
		 
		// 권한 설정
		    AuthoritiesVO authVo = new AuthoritiesVO();
		    authVo.setUsername(usersVo.getUsername());
		    
		    switch (usersVo.getUser_pos()) {
		        case "운영자":
		            authVo.setAuthority("ROLE_ADMIN");
		            logger.info("운영자");
		            break;
		        case "관리자":
		            authVo.setAuthority("ROLE_MANAGER");
		            logger.info("관리자");
		            break;
		        case "사원":
		            authVo.setAuthority("ROLE_MEMBER");
		            logger.info("사원");
		            break;
		        default:
		            logger.warn("알 수 없는 사용자 권한");
		            break;
		    }
		    
		    // authVo를 리스트로 설정
		    List<AuthoritiesVO> authList = new ArrayList<>();
		    authList.add(authVo);
		    usersVo.setAuthList(authVo);
		    
		    // 서비스에서 사용자 정보 업데이트
		    sService.updateEmp(usersVo);
		    
		    logger.debug("controller => 사용자 업데이트 출력 성공: {}" + usersVo);
		    
//		    return ResponseEntity.ok("success");
		    return new ResponseEntity<>(HttpStatus.OK);
		}
	
	//사용자 삭제
	@ResponseBody
	@RequestMapping(value = "/deleteEmp", method = RequestMethod.POST)
	public ResponseEntity<String> deleteEmp(@RequestBody List<String> users) {
			try {
	            sService.deleteEmp(users);
	            return ResponseEntity.ok("사용자 리스트 삭제되었습니다.");
	        } catch (Exception e) {
	        	 e.printStackTrace(); // 콘솔에 예외 로그를 출력
	            return ResponseEntity.status(500).body("사용자 리스트 삭제 중 오류가 발생했습니다.");
	        }
	    }
	   
	
	// ==========================================================================
	// 공통 코드 관리
	@RequestMapping(value = "/code/common", method = RequestMethod.GET)
	public void code_common_GET(Model model) throws Exception {
		logger.debug(" code_common_GET() 실행 ");
		
		//공통코드 전체리스트
		List<CodeVO> codeList =sService.codeListAll();
		
		model.addAttribute("codeList", codeList);
		
	}
	
	//공통 코드 (등록)
	@ResponseBody
	 @RequestMapping(value = "/saveGroupCode", method = RequestMethod.POST)
	 public ResponseEntity<String> saveGroupCode(@RequestBody CodeVO codeVo){
		 
		 try {
			 sService.saveGroupCode(codeVo);
			 return ResponseEntity.ok("success");
		 }catch(Exception e) {
			 return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("failure");
		 }
	 }
	
	//공통 코드 (수정)
		 @ResponseBody
		@RequestMapping(value = "/updateCode", method = RequestMethod.POST)
		public ResponseEntity<String> updateCode(@RequestBody CodeVO codeVo) throws Exception {
			 logger.debug(" @@@ updateCode() 실행");
			 sService.updateCode(codeVo);
			 
			logger.debug("controller => 공통 코드 업데이트 출력 성공: {}" + codeVo);
			
			return new ResponseEntity<>(HttpStatus.OK);
		}
	
	
	
	//공통 코드 (삭제)
	@ResponseBody
	@RequestMapping(value = "/deleteCode", method = RequestMethod.POST)
	public ResponseEntity<String> deleteCode(@RequestBody List<String> Codes) {
			try {
	            sService.deleteCode(Codes);
	            return ResponseEntity.ok("삭제되었습니다.");
	        } catch (Exception e) {
	        	 e.printStackTrace(); // 콘솔에 예외 로그를 출력
	            return ResponseEntity.status(500).body("삭제 중 오류가 발생했습니다.");
	        }
	    }
	   
	
	
//========================================================================
	// 품목 분류 코드 관리
	
	 @RequestMapping(value = "/code/item", method = RequestMethod.GET) 
	 public void code_item_GET(@RequestParam("group_code") String group_code, Model model) throws Exception {
	 
	  logger.debug(" code_item_GET() 실행 ");
	  logger.debug("그룹코드 : " + group_code);
	  
	// 그룹 코드에 따라 품목 정보를 출력 
	  List<ItemCodeVO> itemCodeList = sService.itemCodeListAll(group_code);
	  model.addAttribute("itemCodeList", itemCodeList);
	  model.addAttribute("groupCode", group_code);
	  
	  logger.debug(" @@@@@@@itemCodeList : " + itemCodeList);
	  
     }
	 //그룹 -> 품목코드 (등록)
	 @ResponseBody
	 @RequestMapping(value = "/saveItemCode", method = RequestMethod.POST)
	 public ResponseEntity<String> saveItemCode(@RequestBody ItemCodeVO icVo){
		 
		 try {
			 sService.saveItemCode(icVo);
			 return ResponseEntity.ok("success");
		 }catch(Exception e) {
			 return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("failure");
		 }
	 }
	 
	// 그룹-> 품목코드 수정 
	 @ResponseBody
	@RequestMapping(value = "/updateItemCode", method = RequestMethod.POST)
	public ResponseEntity<String> updateItem(@RequestBody ItemCodeVO icVo) throws Exception {
		 logger.debug(" @@@ updateItem() 실행");
		 sService.updateItemCode(icVo);
		 
		logger.debug("공통 품목 코드 출력 성공: {}" + icVo);
		
		return new ResponseEntity<>(HttpStatus.OK);
	}
	 
	 //그룹 -> 품목코드(체크) 삭제
	 @ResponseBody
	 @RequestMapping(value = "/deleteItemCode", method = RequestMethod.POST)
	 public String deleteItemCode(@RequestParam("itemCodes")List<String>itemCodes) {
		 try {
	            sService.deleteItemCode(itemCodes);
	            return "success";
	        } catch (Exception e) {
	            e.printStackTrace();
	            return "error";
	        }
	 }
	 
	
		 
	 
	 // 공통 품목 코드 중복 검사
//	 @ResponseBody
//	 @RequestMapping(value = "/checkItemCode", method = RequestMethod.GET)
//	 public ResponseEntity<String>checkItemCode(@RequestBody ItemCodeVO icVo) throws Exception{
//		 boolean checkDuplicate = sService.checkItemCode(icVo.getS_cate_item_code());
//		 
//		 if(checkDuplicate){
//			 return ResponseEntity.ok("duplicate");
//		 }else {
//			 return ResponseEntity.ok("not_duplicate");
//		 }
//	 }
	// ==========================================================================

}