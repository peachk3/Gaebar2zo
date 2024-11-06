package com.itwillbs.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.ClientVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.InventoryVO;
import com.itwillbs.domain.ItemVO;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.WarehouseCodeVO;
import com.itwillbs.domain.WarehouseVO;
import com.itwillbs.service.BasicInfoService;
import com.mysql.cj.xdevapi.Client;


@RequestMapping(value="/basicInfo/*")
@Controller
public class BasicInfoController {

	private static final Logger logger = LoggerFactory.getLogger(BasicInfoController.class);
	
	@Inject
	private BasicInfoService bService;
	
	// 품목 관리
	//http://localhost:8088/basicInfo/itemList
	@RequestMapping(value="/itemList", method=RequestMethod.GET)
	public String itemList_GET(Criteria cri, Model model,
	                           @RequestParam(value="searchType", required = false) String searchType,
	                           @RequestParam(value="keyword", required = false) String keyword) throws Exception {
	    logger.debug(" itemList_GET() 실행 ");
	    logger.debug(" cri " + cri);

	    // 검색 기능
	    if(searchType != null && keyword != null && !keyword.trim().isEmpty()) {
	        cri.setSearchType(searchType);
	        cri.setKeyword(keyword);
	    }

	    List<ItemVO> itemList = bService.itemListAll(cri);
	    logger.debug(" size : " + itemList.size());
	    logger.debug(" itemList : " + itemList);

	    // 하단 페이징처리 정보객체 생성
	    PageVO pageVO = new PageVO();
	    pageVO.setCri(cri);
	    int totalCount = bService.getTotalItemCount(cri);
	    pageVO.setTotalCount(totalCount);
	    
	    logger.debug(" cri " + pageVO.getCri());
	    logger.debug(" page : " + pageVO.getTotalCount());
	    logger.debug(" pageVO " + pageVO);

	    // 연결된 뷰페이지로 정보 전달
	    model.addAttribute("itemList", itemList);
	    model.addAttribute("pageVO", pageVO);
	    model.addAttribute("searchType", searchType);
	    model.addAttribute("keyword", keyword);

	    return "/basicInfo/itemList";
	}
	

	// 품목 추가 페이지
	@RequestMapping(value="/itemAdd",method=RequestMethod.GET)
	public void itemAdd_GET() throws Exception{
		logger.debug(" itemAdd_GET() 실행 ");

	}
	
	// 품목 추가 - 등록
	@ResponseBody
	@RequestMapping(value = "/itemInsert", method = RequestMethod.POST)
	public void itemInsert_POST(ItemVO itemvo) throws Exception {
		logger.debug(" itemInsert_POST() 실행 ");
		
		bService.insertItem(itemvo);
		logger.debug("itemvo : " + itemvo);
	}
	
	// 품목 삭제
	@ResponseBody
	@RequestMapping(value = "/deleteItem", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> deleteItem_POST(@RequestBody Map<String, Object> payload) throws Exception {
		logger.debug(" deleteItem_POST() 실행 ");
		
		@SuppressWarnings("unchecked")
        List<String> itemNums = (List<String>) payload.get("item_nums");

        if (itemNums == null || itemNums.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                                 .body(Map.of("status", "error", "message", "No clients selected"));
        }
        logger.debug("@@@@item_num " + itemNums);

        try {
            bService.deleteItems(itemNums);
            return ResponseEntity.ok(Map.of("status", "success"));
        } catch (Exception e) {
            logger.error(" @@@@@@@@Error deleting clients", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("status", "error", "message", e.getMessage()));
        }
		
	}
	
	// 품목 상세보기
	@ResponseBody
	@RequestMapping(value = "/itemDetails", method = RequestMethod.GET)
	public ResponseEntity<List<ItemVO>> itemDetailsList(@RequestParam("item_num") String item_num, Model model) throws Exception {
		logger.debug(" itemDetailsList() 실행 ");
		
		List<ItemVO> itemDetailsList = bService.itemDetailsList(item_num);
		
		model.addAttribute("itemDetailsList",itemDetailsList);
		
		logger.debug(" @@@ 리스트 : " + itemDetailsList);
		logger.debug("@@ item_num : " + item_num);
		
		return new ResponseEntity<>(itemDetailsList, HttpStatus.OK);
	}
	
	// 품목 수정
	@ResponseBody
	@RequestMapping(value = "/updateItem", method = RequestMethod.POST)
	public ResponseEntity<Integer> updateItem(@RequestBody ItemVO ivo) throws Exception {
		logger.debug(" updateItem() 실행 ");
		
		int result = bService.updateItem(ivo);
		
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
	}

	// ----------------------------------거래처 관리------------------------------------------------
	//http://localhost:8088/basicInfo/clientList
	@RequestMapping(value="/clientList",method=RequestMethod.GET)
	public String clientList_GET(Criteria cri, Model model,
            @RequestParam(value="searchType", required = false) String searchType,
            @RequestParam(value="keyword", required = false) String keyword) throws Exception{
		logger.debug(" clientList_GET() 실행 ");
		logger.debug(" cri " + cri);
		
	    // 검색 기능
	    if(searchType != null && keyword != null && !keyword.trim().isEmpty()) {
	        cri.setSearchType(searchType);
	        cri.setKeyword(keyword);
	    }
		
		List<ClientVO> clientList = bService.cliListAll(cri);
	    logger.debug(" size : " + clientList.size());
	    
	    PageVO pageVO = new PageVO();
	    pageVO.setCri(cri);
	    
	    int totalCount = bService.getTotalClientCount(cri);
	    pageVO.setTotalCount(totalCount);
	    
	    logger.debug(" cri " + pageVO.getCri());

	    model.addAttribute("clientList", clientList);	
	    model.addAttribute("pageVO", pageVO);    
	    model.addAttribute("searchType", searchType);
	    model.addAttribute("keyword", keyword);
	    
	    return "/basicInfo/clientList";
	}

	// 거래처 추가 - 등록 페이지로 이동
	@RequestMapping(value="/clientAdd",method=RequestMethod.GET)
	public void clientAdd_GET() throws Exception{
		logger.debug(" clientAdd_GET() 실행 ");
	}
	
	// 거래처 추가 - 거래처 등록
	@ResponseBody
	@RequestMapping(value="/clientInsert", method = RequestMethod.POST)
	public void clientInsert_POST(ClientVO vo) throws Exception {
		logger.debug(" clientInsert_POST() 실행 ");

		bService.cliInsert(vo);
	}
	
	// 사업자 번호 중복 확인
	@RequestMapping(value="/check-crn", method = RequestMethod.GET)
	@ResponseBody
	public int clientCrnCheck(@RequestParam String cli_crn) throws Exception {
		logger.debug(" clientCrnCheck() 실행 ");
		
		boolean isDuplicate = bService.isCliCrnDuplicate(cli_crn);
	
		logger.debug(" 결과 : " + isDuplicate);
		
		return isDuplicate ? 1 : 0;
	}
	
	// 상세보기 페이지
	@ResponseBody
	@RequestMapping(value = "/clientDetails", method = RequestMethod.GET)
	public ResponseEntity<List<ClientVO>> clientDetailsList(@RequestParam("cli_num") String cli_num, Model model) throws Exception {
		logger.debug(" clientDetailsList() 실행");
		
		List<ClientVO> clientDetailsList = bService.clientDetailsList(cli_num);
		
		model.addAttribute("clientDetailsList", clientDetailsList);
		
		logger.debug("@@ 리스트 : " + clientDetailsList);
		logger.debug(" cli_num : " + cli_num);
		
		return new ResponseEntity<>(clientDetailsList, HttpStatus.OK);
	}
	
	// 거래처 수정
	@ResponseBody
	@RequestMapping(value = "/updateClient", method = RequestMethod.POST)
	public ResponseEntity<String> updateClient(@RequestBody ClientVO cvo) throws Exception {
		logger.debug(" updateClient() 실행 ");
		
		bService.updateClient(cvo);
		
		 try {
		        bService.updateClient(cvo);
		        return new ResponseEntity<>("Client updated successfully", HttpStatus.OK);
		    } catch (Exception e) {
		        logger.error("Error updating client", e);
		        return new ResponseEntity<>("Error updating client", HttpStatus.INTERNAL_SERVER_ERROR);
		    }
		
	}
	
	// 거래처 삭제
	@RequestMapping(value = "/deleteClient", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> deleteClient(@RequestBody Map<String, Object> payload) throws Exception{
		logger.debug(" deleteClient() 실행 ");
	
		@SuppressWarnings("unchecked")
        List<String> cliNums = (List<String>) payload.get("cli_nums");

        if (cliNums == null || cliNums.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                                 .body(Map.of("status", "error", "message", "No clients selected"));
        }
        logger.debug("@@@@cli_num " + cliNums);

        try {
            bService.deleteClients(cliNums);
            return ResponseEntity.ok(Map.of("status", "success"));
        } catch (Exception e) {
            logger.error(" @@@@@@@@Error deleting clients", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("status", "error", "message", e.getMessage()));
        }
	}
	
	// ------------------------------------------------거래처 관리------------------------------

	// -------------------------------------------------창고 관리-------------------------------
	//http://localhost:8088/system/login
	@RequestMapping(value="/warehouseList",method=RequestMethod.GET)
	public void warehouseList_GET(Model model) throws Exception{
		logger.debug(" warehouseList_GET() 실행 ");
		
		List<WarehouseCodeVO> whCodeList = bService.listAll();
		
		model.addAttribute("whCodeList",whCodeList);
	}

	// 창고 추가
	@RequestMapping(value="/warehouseAdd",method=RequestMethod.GET)
	public void warehouseAdd_GET() throws Exception{
		logger.debug(" warehouseAdd_GET() 실행 ");
	}

	// 창고 등록
	@ResponseBody
	@RequestMapping(value="/warehouseInsert", method = RequestMethod.POST)
	public void warehouseInsert_POST(WarehouseCodeVO wcvo) throws Exception {
		logger.debug(" warehouseInsert_POST() 실행 ");
		
		//List<WarehouseCodeVO> whCodeList =
		bService.insertWarehouse(wcvo);
		logger.debug("");
	}

	// 창고 삭제
	@RequestMapping(value = "/deleteWarehouse", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> deleteWarehouse(@RequestBody Map<String, Object> payload) throws Exception{
		logger.debug(" deleteClient() 실행 ");
	
		@SuppressWarnings("unchecked")
        List<String> whNums = (List<String>) payload.get("s_cate_wh_codes");
		logger.debug(" whNums : " + whNums);

        if (whNums == null || whNums.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                                 .body(Map.of("status", "error", "message", "No clients selected"));
        }
        logger.debug("@@@@whNums " + whNums);

        try {
        	bService.deleteWareCode(whNums); // 창고 내부 구역 삭제
            bService.deleteWarehouse(whNums); // 창고 삭제
            return ResponseEntity.ok(Map.of("status", "success"));
        } catch (Exception e) {
            logger.error(" @@@@@@@@Error", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("status", "error", "message", e.getMessage()));
        }
	}
	
	// 창고 상세보기
	@ResponseBody
	@RequestMapping(value = "/warehouseDetails", method = RequestMethod.GET)
	public ResponseEntity<List<WarehouseCodeVO>> warehouseDetailsList(@RequestParam("s_cate_wh_code") String s_cate_wh_code, Model model) throws Exception {
		logger.debug(" warehouseDetailsList() 실행");
		
		List<WarehouseCodeVO> warehouseDetailsList = bService.warehouseDetailsList(s_cate_wh_code);
		
		model.addAttribute("warehouseDetailsList", warehouseDetailsList);
		
		logger.debug("@@ 리스트 : " + warehouseDetailsList);
		logger.debug(" s_cate_wh_code : " + s_cate_wh_code);
		
		return new ResponseEntity<>(warehouseDetailsList, HttpStatus.OK);
	}
	
	// 창고 정보 수정
	@ResponseBody
	@RequestMapping(value = "/updateWhCode", method = RequestMethod.POST)
	public ResponseEntity<String> updateWhCode(@RequestBody WarehouseCodeVO whcvo) throws Exception {
		logger.debug(" updateWhCode() 실행 ");
		
		bService.updateWhCode(whcvo);
		
		 try {
		        bService.updateWhCode(whcvo);
		        return new ResponseEntity<>(" updated successfully", HttpStatus.OK);
		    } catch (Exception e) {
		        logger.error("Error updating", e);
		        return new ResponseEntity<>("Error updating", HttpStatus.INTERNAL_SERVER_ERROR);
		    }
	}
	
	// 창고 -> 재고 페이지
    @RequestMapping(value = "/warehouse", method = RequestMethod.GET)
    public void getWarehouse(Model model) throws Exception {
    	logger.debug("getWarehouse() 실행 ");
    		
		List<WarehouseCodeVO> whCodeList = bService.listAll();
		
		model.addAttribute("whCodeList",whCodeList);
    }
    
    // 창고 zone 불러오기
    @ResponseBody
    @RequestMapping(value = "/getZones", method = RequestMethod.POST)
    public List<String> getZones(@RequestParam String wh_code)throws Exception {
    	logger.debug(" getZones() 실행");
    	logger.debug(" wh_code : " + wh_code);
    	
    	List<String> zones = bService.getZones(wh_code);
    	logger.debug(" zones : " + zones);
    	return zones;
    	
    }
    
    // 창고 rack 불러오기
    @ResponseBody
    @RequestMapping(value = "/getRacks", method = RequestMethod.POST)
    public List<String> getRacks(@RequestParam String wh_code, @RequestParam String wh_zone) throws Exception{
    	
    	logger.debug(" getRacks() 실행 ");
    	logger.debug(" wh_zone : "+ wh_zone);
    	return bService.getRacks(wh_code, wh_zone);
    }
    
    // 창고 열/행 불러오기
    @ResponseBody
    @RequestMapping(value = "/getColumnRows", method = RequestMethod.POST)
    public Map<String, Object> getColumnRows(@RequestParam String wh_code, @RequestParam String wh_zone, @RequestParam String wh_rack) throws Exception{
    	logger.debug(" getColumnRows() 실행 ");
    	
    	Map<String, Object> response = new HashMap<>();
    	
    	List<String> columns = bService.getColumns(wh_code, wh_zone, wh_rack);
        List<String> rows = bService.getRows(wh_code, wh_zone, wh_rack);

        response.put("columns", columns);
        response.put("rows", rows);
        return response;
    }
    
    // 창고 -> 재고 불러오기
    @ResponseBody
    @RequestMapping(value="/getInventory", method = RequestMethod.POST)
	public List<InventoryVO> getInventory(@RequestParam String wh_num) throws Exception{
    	logger.debug(" getInventory() 실행  ");
    	logger.debug("wh_num : " + wh_num );
    	
		return bService.getInventory(wh_num);
    }
    
    // 창고 -> zone 추가
    @ResponseBody
    @RequestMapping(value = "/addZone", method = RequestMethod.POST)
    public ResponseEntity<?> addZone(@RequestParam String wh_code, @RequestParam String wh_name) throws Exception{
    	
    	logger.debug(" addZone() 실행 ");
    	
    	logger.debug(" wh_code :"+ wh_code);
    	logger.debug(" wh_name :" +wh_name);
    	
    	// 새로운 렉 코드 생성 및 반환
        String newZone = bService.addZone(wh_code, wh_name); // 실제 추가된 렉 코드를 반환받음
        logger.debug("newZone: " + newZone);

        if (newZone != null) {
            // 새로 추가된 렉 코드가 성공적으로 생성된 경우
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("newZone", newZone);
            return ResponseEntity.ok().body(response);

        } else {
            // 렉 추가에 실패한 경우
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "렉 추가 실패");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    
   // 창고 -> rack 추가
    @ResponseBody
    @RequestMapping(value = "/addRack", method = RequestMethod.POST)
    public ResponseEntity<?> addRack(@RequestParam String wh_code, @RequestParam String wh_zone, @RequestParam String wh_name ) throws Exception{
    	
    	logger.debug(" addRack() 실행 ");
    	
    	logger.debug(" wh_cdode :"+ wh_code);
    	logger.debug(" wh_zone:" +wh_zone);
    	logger.debug(" wh_ name :" +wh_name);
    	
    	// 새로운 렉 코드 생성 및 반환
        String newRack = bService.addRack(wh_code, wh_zone, wh_name); // 실제 추가된 렉 코드를 반환받음
        logger.debug("newRack: " + newRack);

        if (newRack != null) {
            // 새로 추가된 렉 코드가 성공적으로 생성된 경우
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("newRack", newRack);
            return ResponseEntity.ok().body(response);

        } else {
            // 렉 추가에 실패한 경우
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "렉 추가 실패");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
        
    }
    
}