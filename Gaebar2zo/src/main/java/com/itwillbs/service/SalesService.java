package com.itwillbs.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.TransactionVO;

@Service
public interface SalesService {
	
	// 수주 리스트
	public List<TransactionVO> SalesOrderList(Criteria cri) throws Exception;
	
	// 수주 리스트 개수 세기
	public int getTotalSalesOrderCount() throws Exception;

	// 수주 등록
	public void SalesOrderAdd(TransactionVO tvo) throws Exception;
	
	// 수주 정보
	public List<TransactionVO> SalesOrderInfo(String tran_num) throws Exception;
	
	// 수주 정보 수정
	public void salesOrderUpdate(TransactionVO tvo) throws Exception;
	
	// 발주 리스트
	public List<TransactionVO> PurchaseOrderList(Criteria cri) throws Exception;

	// 발주 리스트 개수 세기
	public int getTotalPurchaseOrderCount() throws Exception;
	
	// 발주 등록
	public void PurchaseOrderAdd(TransactionVO tvo) throws Exception;
	
	// 발주 정보
	public List<TransactionVO> PurchaseOrderInfo(String tran_num) throws Exception;
	
	// 발주 정보 수정
	public void PurchaseOrderUpdate(TransactionVO tvo) throws Exception;

	// 출하 리스트 개수 세기
	public int getTotalShipmentCount() throws Exception;

	// 출하 리스트 
	public List<TransactionVO> shipmentList(Criteria cri) throws Exception; 



}
