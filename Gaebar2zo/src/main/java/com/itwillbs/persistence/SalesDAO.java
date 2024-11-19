package com.itwillbs.persistence;

import java.util.List;

import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.TransactionGoodsVO;
import com.itwillbs.domain.TransactionVO;

public interface SalesDAO {

	// 수주 리스트
	public List<TransactionVO> salesOrderList(Criteria cri) throws Exception;
	
	// 수주 리스트 개수 세기
	public int getTotalSalesOrderCount() throws Exception;

	// 수주 등록_TransactionVO
	public void salesOrderAdd_TransactionVO(TransactionVO tvo) throws Exception;

	// 수주 등록_TransactionGoodsVO
	public void salesOrderAdd_TransactionGoodsVO(TransactionGoodsVO newTgvo) throws Exception;
	
	// 수주 정보
	public List<TransactionVO> salesOrderInfo(String tran_num) throws Exception;
	
	// 수주 정보 수정_TransactionVO
	public void salesOrderUpdate_TransactionVO(TransactionVO tvo) throws Exception;
	
	// 수주 정보 수정_TransactionGoodsVO
	public void salesOrderUpdate_TransactionGoodsVO(TransactionGoodsVO newTgvo) throws Exception;

	
	// 발주 리스트
	public List<TransactionVO> purchaseOrderList(Criteria cri) throws Exception;

	// 발주 리스트 개수 세기
	public int getTotalPurchaseOrderCount() throws Exception;
	
	// 발주 등록_TransactionVO
	public void purchaseOrderAdd_TransactionVO(TransactionVO tvo) throws Exception;
	
	// 발주 등록_TransactionGoodsVO
	public void purchaseOrderAdd_TransactionGoodsVO(TransactionGoodsVO newTgvo) throws Exception;
	
	// 발주 정보
	public List<TransactionVO> purchaseOrderInfo(String tran_num) throws Exception;
	
	// 발주 정보 수정_TransactionVO
	public void purchaseOrderUpdate_TransactionVO(TransactionVO tvo) throws Exception;
	
	// 발주 정보 수정_TransactionGoodsVO
	public void purchaseOrderUpdate_TransactionGoodsVO(TransactionGoodsVO newTgvo) throws Exception;

	// GetTranNum 추출
	public String GetTranNum(TransactionVO tvo) throws Exception;

	// 출하 리스트 총 개수
	public int getTotalShipmentCount() throws Exception;

	// 출하 리스트 
	public List<TransactionVO> shipmentList(Criteria cri) throws Exception;





}