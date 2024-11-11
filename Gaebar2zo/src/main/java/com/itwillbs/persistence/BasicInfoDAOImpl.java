package com.itwillbs.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.ClientVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.InventoryVO;
import com.itwillbs.domain.ItemVO;
import com.itwillbs.domain.WarehouseCodeVO;
import com.itwillbs.domain.WarehouseVO;

@Repository
public class BasicInfoDAOImpl implements BasicInfoDAO {

	private static final Logger logger = LoggerFactory.getLogger(BasicInfoDAOImpl.class);

	@Inject
	public SqlSession sqlSession;

	public static final String NAMESPACE = "com.itwillbs.mapper.basicInfoMapper.";

	// 창고코드 리스트 출력
	@Override
	public List<WarehouseCodeVO> listAll() throws Exception {
		logger.debug(" listAll() 실행 ");

		return sqlSession.selectList(NAMESPACE + "listALL");
	}

	// 거래처 리스트 출력
	@Override
	public List<ClientVO> cliListAll(Criteria cri) throws Exception {
		logger.debug(" cliListAll() 실행 ");

		return sqlSession.selectList(NAMESPACE + "cliListALL", cri);
	}
	

	@Override
	public int getTotalClientCount(Criteria cri) throws Exception {
		logger.debug(" getTotalClientCount() 실행 ");
		
		return sqlSession.selectOne(NAMESPACE+"totalClientCount", cri);
	}

	// 품목 리스트 출력
	@Override
	public List<ItemVO> itemListAll(Criteria cri) throws Exception {
		logger.debug(" itemListAll() 실행 ");

		return sqlSession.selectList(NAMESPACE + "itemListALL", cri);
	}

	@Override
	public int getTotalItemCount(Criteria cri) throws Exception {
		logger.debug(" getTotalItemCount() 실행 ");
		
		return sqlSession.selectOne(NAMESPACE+"totalItemCount", cri);
	}

	// 거래처 사업자 번호 중복 확인
	@Override
	public int cliCrnDup(String cli_crn) throws Exception {
		logger.debug(" cliCrnDup() 실행 ");

		Integer result = sqlSession.selectOne(NAMESPACE + "cliCrnDup", cli_crn);

		return result;
	}

	// 거래처 등록
	@Override
	public void cliInsert(ClientVO vo) throws Exception {
		logger.debug(" cliInsert() 실행 ");

		sqlSession.insert(NAMESPACE + "cliUpdate", vo);
	}

	// 거래처 정보 상세보기
	@Override
	public List<ClientVO> clientDetailsList(String cli_num) throws Exception {
		logger.debug(" clientDetailsList() 실행 ");

		return sqlSession.selectList(NAMESPACE + "cliDetials", cli_num);
	}

	// 거래처 정보 수정
	@Override
	public void updateClient(ClientVO cvo) throws Exception {
		logger.debug(" updateClient() 실행 ");

		sqlSession.update(NAMESPACE + "updateClient", cvo);
	}

	// 거래처 삭제
	@Override
	public void deleteClients(List<String> cliNums) throws Exception {
		logger.debug("deleteClients() 실행 ");

		sqlSession.delete(NAMESPACE + "deleteClient", cliNums);
	}

	// 품목 등록
	@Override
	public void itemInsert(ItemVO itemvo) throws Exception {
		logger.debug(" itemInsert() 실행 ");

		sqlSession.insert(NAMESPACE + "insertItem", itemvo);
	}

	// 품목 삭제
	@Override
	public void itemDelete(List<String> itemNums) throws Exception {
		logger.debug(" itemDelete() 실행");

		sqlSession.delete(NAMESPACE + "deleteItem", itemNums);
	}

	// 품목 상세보기
	@Override
	public List<ItemVO> itemDetailsList(String item_num) throws Exception {
		logger.debug(" itemDetailsList() 실행 ");

		return sqlSession.selectList(NAMESPACE + "itemDetailsList", item_num);
	}

	// 품목 수정
	@Override
	public int updateItem(ItemVO ivo) throws Exception {
		logger.debug(" updateItem() 실행 ");

		return sqlSession.update(NAMESPACE + "updateItem", ivo);
	}

	// 창고 등록
	@Override
	public void warehouseInsert(WarehouseCodeVO wcvo) throws Exception {
		logger.debug(" warehouseInsert() 실행");

		sqlSession.insert(NAMESPACE + "insertWarehouse", wcvo);
	}

	@Override
	public void createZone(String whCode, String whName) throws Exception {
		logger.debug("createZone() 실행");
		
		
		sqlSession.insert(NAMESPACE + "createZone", Map.of("wh_code", whCode, "wh-name",whName));
	}

	// 창고 삭제
	@Override
	public void warehouseDelete(List<String> whNums) throws Exception {
		logger.debug(" warehouseDelete() 실행 ");

		sqlSession.delete(NAMESPACE + "deleteWarehouse", whNums);
	}

	// 창고 내부 삭제
	 @Override 
	 public void warehouseCodeDelete(List<String> whNums) throws Exception { 
		 logger.debug(" warehouseCodeDelete() 실행 ");
	  
		 sqlSession.delete(NAMESPACE + "deleteWarehouseCode", whNums); 
	}

	// 창고 상세 보기
	 @Override
	 public List<WarehouseCodeVO> warehouseDetailsList(String s_cate_wh_code) throws Exception {
		 logger.debug(" warehouseDetailsList() 실행 ");
		 
		 return sqlSession.selectList(NAMESPACE + "warehouseDetailsList", s_cate_wh_code);
	 }
	  
	// 창고 수정
	@Override
	public void updateWhCode(WarehouseCodeVO whcvo) throws Exception {
		logger.debug(" updateWhCode() 실행 ");
		
		sqlSession.update(NAMESPACE+"updateWhCode", whcvo);
	}

	// 창고 zone 불러오기
	@Override
	public List<String> getzones(String wh_code) throws Exception {
		logger.debug("  getzones 실행");
		
		return sqlSession.selectList(NAMESPACE + "getZones", wh_code);
	}

	// 창고 rack 불러오기
	@Override
	public List<String> getRacks(String wh_code, String wh_zone) throws Exception {
		logger.debug(" getRacks() 실행 ");
		
		return sqlSession.selectList(NAMESPACE + "getRacks", Map.of("wh_code", wh_code, "wh_zone", wh_zone));
	}

	// 창고 열 불러오기
	@Override
	public List<String> getColumns(String wh_code, String wh_zone, String wh_rack) throws Exception{
		logger.debug(" getColumns() 실행");
		
		return sqlSession.selectList(NAMESPACE + "getColumns", Map.of("wh_code", wh_code, "wh_zone", wh_zone, "wh_rack", wh_rack));
	}

	// 창고 행 불러오기
	@Override
	public List<String> getRows(String wh_code, String wh_zone, String wh_rack) throws Exception{
		logger.debug(" getRows() 실행");
		
		return sqlSession.selectList(NAMESPACE + "getRows", Map.of("wh_code", wh_code, "wh_zone", wh_zone, "wh_rack", wh_rack));
	}
	
	// 창고 -> 재고 불러오기
	@Override
	public List<InventoryVO> getInventory(String wh_num) throws Exception {
		logger.debug(" getInventory() 실행 ");
		
		return sqlSession.selectList(NAMESPACE + "getInventory", wh_num) ;
	}

	// 창고 -> zone 추가
	@Override
	public String addZone(String wh_code, String wh_name) throws Exception {
		logger.debug(" addZone() 실행 ");
		// 현재 최대 렉 번호 가져오기
		
		Integer maxZoneNumber = sqlSession.selectOne(NAMESPACE + "getMaxZoneNumber", Map.of("wh_code", wh_code));
		int newZoneNumber = (maxZoneNumber != null ? maxZoneNumber : 0) + 1;
		logger.debug("@@ new zone : " + newZoneNumber);
		
		// 새로운 렉 추가
		Map<String, Object> params = Map.of(
				"wh_code", wh_code,
				"wh_name", wh_name,
				"newZone", newZoneNumber
				);
		
		int result = sqlSession.insert(NAMESPACE + "addZone", params);
		
		if (result > 0) {
			return String.valueOf(newZoneNumber);
		} else {
			return null; // 실패 시 null 반환
		}
		
	}
	
	// 창고 -> rack 추가
	@Override
	public String addRack(String wh_code, String wh_zone, String wh_name) throws Exception {
		logger.debug(" addRack() 실행");
		
		// 현재 최대 렉 번호 가져오기
	    Integer maxRackNumber = sqlSession.selectOne(NAMESPACE + "getMaxRackNumber", Map.of("wh_code", wh_code, "wh_zone", wh_zone));
	    int newRackNumber = (maxRackNumber != null ? maxRackNumber : 0) + 1;
	    logger.debug("@@ newRack : " + newRackNumber);

	    // 새로운 렉 추가
	    Map<String, Object> params = Map.of(
	        "wh_code", wh_code,
	        "wh_zone", wh_zone,
	        "wh_name", wh_name,
	        "newRack", newRackNumber
	    );
	    
	    int result = sqlSession.insert(NAMESPACE + "addRack", params);

	    // 추가 성공 여부에 따라 반환 값 설정
	    if (result > 0) {
	        return String.valueOf(newRackNumber); // 새로 추가된 렉의 번호를 문자열로 반환
	    } else {
	        return null; // 실패 시 null 반환
	    }
		
	}


}