package com.itwillbs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.domain.ClientVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.PageVO;
import com.itwillbs.domain.TransactionGoodsVO;
import com.itwillbs.domain.TransactionVO;
import com.itwillbs.service.SalesService;

@RequestMapping(value="/sales/*")
@Controller
public class SalesController {

	private static final Logger logger = LoggerFactory.getLogger(SalesController.class);

	// 서비스 객체 주입
	@Inject
	private SalesService sService;

	// 수주 관리
	@RequestMapping(value="/salesOrderList",method=RequestMethod.GET)
	public void salesOrderList_GET(Criteria cri ,Model model) throws Exception{
		logger.debug(" salesOrderList_GET() 실행 ");
		
		// 하단 페이징처리 정보객체 생성
	    PageVO pageVO = new PageVO();
	    pageVO.setCri(cri);
	    pageVO.setTotalCount(sService.getTotalSalesOrderCount());
	    logger.debug(" cri " + pageVO.getCri());
	    model.addAttribute("pageVO", pageVO);
		
		List<TransactionVO> so = sService.SalesOrderList(cri);
		logger.debug("size : "+ so.size());
		logger.debug("so : "+ so);
	    model.addAttribute("so", so);

	}

	// 수주 추가
	@RequestMapping(value="/salesOrderAdd",method=RequestMethod.GET)
	public void salesOrderAdd_GET() throws Exception{
		logger.debug(" salesOrderAdd_GET() 실행 ");

	}
	
	// 수주 추가
	@RequestMapping(value="/salesOrderAdd",method=RequestMethod.POST)
	@ResponseBody
	public void salesOrderAdd_POST(@RequestBody Map<String, String> requestData) throws Exception {
		logger.debug(" salesOrderAdd_POST() 실행 ");
		
	    ObjectMapper mapper = new ObjectMapper();
	    
	    TransactionVO tvo = mapper.readValue(requestData.get("tvo"), TransactionVO.class);
	    List<TransactionGoodsVO> tgvo = mapper.readValue(requestData.get("tgvo"), 
                						new TypeReference<List<TransactionGoodsVO>>(){});
	    
	    tvo.setTgvo(tgvo);
	    
	    logger.debug("tvo : " + tvo);
	    logger.debug("tgvo : " + tgvo);
	    
	    sService.SalesOrderAdd(tvo);
	}
	
	// 수주 정보
	@RequestMapping(value="/salesOrderInfo",method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<List<TransactionVO>> salesOrderInfo_POST(@RequestBody String tran_num) throws Exception {
		logger.debug(" salesOrderInfo_POST() 실행 ");
		
		List<TransactionVO> soInfo = sService.SalesOrderInfo(tran_num);
		
		return ResponseEntity.ok(soInfo);
	}
	
	// 수주 정보 수정
	@RequestMapping(value="/salesOrderUpdate",method=RequestMethod.POST)
	@ResponseBody
	public void salesOrderUpdate_POST(@RequestBody Map<String, String> requestData) throws Exception {
		logger.debug("salesOrderUpdate_POST() 실행 ");
		
	    ObjectMapper mapper = new ObjectMapper();
	    
	    TransactionVO tvo = mapper.readValue(requestData.get("tvo"), TransactionVO.class);
	    List<TransactionGoodsVO> tgvo = mapper.readValue(requestData.get("tgvo"), 
                						new TypeReference<List<TransactionGoodsVO>>(){});
	    
	    tvo.setTgvo(tgvo);
	    
	    logger.debug("tvo : " + tvo);
	    logger.debug("tgvo : " + tgvo);
	    
	    sService.salesOrderUpdate(tvo);
	}

	// 발주 관리
	@RequestMapping(value="/purchaseOrderList",method=RequestMethod.GET)
	public void puchaseOrderList_GET(Criteria cri ,Model model) throws Exception{
		logger.debug(" puchaseOrderList_GET() 실행 ");
		
		// 하단 페이징처리 정보객체 생성
	    PageVO pageVO = new PageVO();
	    pageVO.setCri(cri);
	    pageVO.setTotalCount(sService.getTotalPurchaseOrderCount());
	    logger.debug(" cri " + pageVO.getCri());
	    model.addAttribute("pageVO", pageVO);

		List<TransactionVO> po = sService.PurchaseOrderList(cri);
		logger.debug("size : "+ po.size());
		logger.debug("po : "+ po);
	    model.addAttribute("po", po);
	}

	// 발주 추가
	@RequestMapping(value="/purchaseOrderAdd",method=RequestMethod.GET)
	public void purchaseOrderAdd_GET() throws Exception{
		logger.debug(" puchaseOrderAdd_GET() 실행 ");

	}
	
	// 발주 추가
	@RequestMapping(value="/purchaseOrderAdd",method=RequestMethod.POST)
	@ResponseBody
	public void purchaseOrderAdd_POST(@RequestBody Map<String, String> requestData) throws Exception {
		logger.debug(" purchaseOrderAdd_POST() 실행 ");
		
		ObjectMapper mapper = new ObjectMapper();
		
		TransactionVO tvo = mapper.readValue(requestData.get("tvo"), TransactionVO.class);
		List<TransactionGoodsVO> tgvo = mapper.readValue(requestData.get("tgvo"), 
				new TypeReference<List<TransactionGoodsVO>>(){});
		
		tvo.setTgvo(tgvo);
		
		logger.debug("tvo : " + tvo);
		logger.debug("tgvo : " + tgvo);
		
		sService.PurchaseOrderAdd(tvo);
	}
	
	// 발주 정보
	@RequestMapping(value="/purchaseOrderInfo",method=RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<List<TransactionVO>> purchaseOrderInfo_POST(@RequestBody String tran_num) throws Exception {
		logger.debug(" salesOrderInfo_POST() 실행 ");
		
		List<TransactionVO> poInfo = sService.PurchaseOrderInfo(tran_num);
		
		return ResponseEntity.ok(poInfo);
	}
	
	// 발주 정보 수정
	@RequestMapping(value="/purchaseOrderUpdate",method=RequestMethod.POST)
	@ResponseBody
	public void purchaseOrderInfo_POST(@RequestBody Map<String, String> requestData) throws Exception {
		logger.debug("salesOrderUpdate_POST() 실행 ");
		
		ObjectMapper mapper = new ObjectMapper();
		
		TransactionVO tvo = mapper.readValue(requestData.get("tvo"), TransactionVO.class);
		List<TransactionGoodsVO> tgvo = mapper.readValue(requestData.get("tgvo"), 
				new TypeReference<List<TransactionGoodsVO>>(){});
		
		tvo.setTgvo(tgvo);
		
		logger.debug("tvo : " + tvo);
		logger.debug("tgvo : " + tgvo);
		
		sService.PurchaseOrderUpdate(tvo);
	}

	// 출하 관리
	@RequestMapping(value="/shipmentList",method=RequestMethod.GET)
	public void shipmentList_GET(Criteria cri ,Model model) throws Exception{
		logger.debug(" shipmentList_GET() 실행 ");
		
		// 하단 페이징처리 정보객체 생성
	    PageVO pageVO = new PageVO();
	    pageVO.setCri(cri);
	    pageVO.setTotalCount(sService.getTotalShipmentCount());
	    logger.debug(" cri " + pageVO.getCri());
	    model.addAttribute("pageVO", pageVO);

		List<TransactionVO> sl = sService.shipmentList(cri);
		logger.debug("size : "+ sl.size());
		logger.debug("sl : "+ sl);
	    model.addAttribute("sl", sl);
		

	}

	// 출하 추가
	@RequestMapping(value="/shipmentAdd",method=RequestMethod.GET)
	public void shipmentAdd_GET() throws Exception{
		logger.debug(" shipmentAdd_GET() 실행 ");

	}














}