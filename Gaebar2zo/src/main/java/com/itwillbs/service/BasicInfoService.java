package com.itwillbs.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.ClientVO;
import com.itwillbs.domain.ItemVO;
import com.itwillbs.domain.WarehouseCodeVO;
import com.itwillbs.domain.WarehouseVO;

@Service
public interface BasicInfoService {
	
	// 창고코드 리스트 출력
	public List<WarehouseCodeVO> listAll();

	// 거래처 리스트 출력
	public List<ClientVO> cliListAll();

	// 품목 리스트 출력
	public List<ItemVO> itemListAll();

	// 거래처 사업자 번호 중복 확인
	public boolean isCliCrnDuplicate(String cli_crn) throws Exception;

	public void cliInsert(ClientVO vo) throws Exception;

	// 거래처 리스트 상세 보기
	public List<ClientVO> clientDetailsList(String cli_num) throws Exception;

	// 거래처 수정
	public void updateClient(ClientVO cvo) throws Exception;

	// 거래처 삭제
	public void deleteClients(List<String> cliNums) throws Exception;

	// 품목 추가
	public void insertItem(ItemVO itemvo) throws Exception;

	// 품목 삭제
	public void deleteItems(List<String> itemNums) throws Exception;

	// 품목 상세보기 
	public List<ItemVO> itemDetailsList(String item_num) throws Exception;

	// 품목 수정
	public int updateItem(ItemVO ivo) throws Exception;

	// 창고 등록
	public void insertWarehouse(WarehouseCodeVO wcvo) throws Exception;

	// 창고 삭제
	public void deleteWarehouse(List<String> whNums) throws Exception;

	// 창고 내부 삭제
	public void deleteWareCode(List<String> whNums) throws Exception;

	// 창고 상세보기
	public List<WarehouseCodeVO> warehouseDetailsList(String s_cate_wh_code) throws Exception;

	// 창고 수정
	public void updateWhCode(WarehouseCodeVO whcvo) throws Exception;



}