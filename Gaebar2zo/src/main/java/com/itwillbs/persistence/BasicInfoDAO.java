package com.itwillbs.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.ClientVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.InventoryVO;
import com.itwillbs.domain.ItemVO;
import com.itwillbs.domain.WarehouseCodeVO;
import com.itwillbs.domain.WarehouseVO;

public interface BasicInfoDAO {

	// 창고코드 리스트 출력
	List<WarehouseCodeVO> listAll() throws Exception;

	// 거래처 리스트 출력
	List<ClientVO> cliListAll(Criteria cri) throws Exception;
	int getTotalClientCount(Criteria cri) throws Exception;

	// 품목 리스트 출력
	List<ItemVO> itemListAll(Criteria cri) throws Exception;
	int getTotalItemCount(Criteria cri) throws Exception;

	// 거래처 번호 중복 확인
	public int cliCrnDup(String cli_crn) throws Exception;

	// 거래처 등록
	public void cliInsert(ClientVO vo) throws Exception;

	// 거래처 상세보기
	List<ClientVO> clientDetailsList(String cli_num) throws Exception;

	// 거래처 수정
	void updateClient(ClientVO cvo) throws Exception;

	// 거래처 삭제
	void deleteClients(List<String> cliNums) throws Exception;

	// 품목 추가
	void itemInsert(ItemVO itemvo) throws Exception;

	// 품목 삭제
	void itemDelete(List<String> itemNums) throws Exception;

	// 품목 상세보기 
	List<ItemVO> itemDetailsList(String item_num) throws Exception;

	// 품목 수정
	int updateItem(ItemVO ivo) throws Exception;

	// 창고 등록
	public void warehouseInsert(WarehouseCodeVO wcvo) throws Exception;
	
	// 창고 등록시 zone 추가
	public void createZone(String whCode, String whName) throws Exception;

	// 창고 삭제
	public void warehouseDelete(List<String> whNums) throws Exception;

	// 창고 내부 삭제
	public void warehouseCodeDelete(List<String> whNums) throws Exception;

	// 창고 상세보기
	public List<WarehouseCodeVO> warehouseDetailsList(String s_cate_wh_code) throws Exception;
	
	// 창고 수정
	public void updateWhCode(WarehouseCodeVO whcvo) throws Exception;

	// 창고 zone 불러오기
	public List<String> getzones(String wh_code) throws Exception;

	// 창고 rack 불러오기
	public List<String> getRacks(String wh_code, String wh_zone) throws Exception;

	// 창고 열 불러오기
	public List<String> getColumns(@Param ("wh_code")String wh_code, @Param ("wh_zone") String wh_zone, @Param ("wh_rack") String wh_rack) throws Exception;
	
	// 창고 열 불러오기
	public List<String> getRows(@Param ("wh_code")String wh_code, @Param ("wh_zone") String wh_zone, @Param ("wh_rack") String wh_rack) throws Exception;
	
	// 창고 -> 재고 불러오기
	public List<InventoryVO> getInventory(String wh_num) throws Exception;

	// 창고 -> zone 추가
	public String addZone(String wh_code, String wh_name) throws Exception;

	// 창고 -> rack 추가 
	public String addRack(String wh_code, String wh_zone, String wh_name) throws Exception;



	
}