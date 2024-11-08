package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.ClientVO;
import com.itwillbs.domain.Criteria;
import com.itwillbs.domain.InventoryVO;
import com.itwillbs.domain.ItemVO;
import com.itwillbs.domain.WarehouseCodeVO;
import com.itwillbs.domain.WarehouseVO;
import com.itwillbs.persistence.BasicInfoDAO;

@Service
public class BasicInfoServiceImpl implements BasicInfoService{
	
	private static final Logger logger = LoggerFactory.getLogger(BasicInfoServiceImpl.class);

	@Inject
	private BasicInfoDAO bidao;

	// 창고코드 리스트 출력
	@Override
	public List<WarehouseCodeVO> listAll() throws Exception {
		logger.debug("창고 리스트 조회");
		
		return bidao.listAll();
	}

	// 거래처 리스트 출력
	@Override
	public List<ClientVO> cliListAll(Criteria cri) throws Exception {
		logger.debug("고객사 리스트 조회");
		
		return bidao.cliListAll(cri);
	}
 
	@Override
	public int getTotalClientCount(Criteria cri) throws Exception {
		logger.debug(" getTotalClientCount() 실행 ");
		
		return bidao.getTotalClientCount(cri);
	}

	// 품목 리스트 출력
	@Override
	public List<ItemVO> itemListAll(Criteria cri) throws Exception {
		logger.debug(" 품목 리스트 조회 ");
		return bidao.itemListAll(cri);
	}
	
	@Override
	public int getTotalItemCount(Criteria cri) throws Exception {
		logger.debug(" getTotalItemCount() 실행 ");
		
		return bidao.getTotalItemCount(cri);
	}

	// 사업자 번호 중복 조회
	@Override
	public boolean isCliCrnDuplicate(String cli_crn) throws Exception {
		logger.debug(" 사업자 번호 중복 조회 ");
		int count = bidao.cliCrnDup(cli_crn);
		
		return count > 0;
	}

	// 거래처 등록
	@Override
	public void cliInsert(ClientVO vo) throws Exception {
		logger.debug(" 거래처 등록 ");
		
		bidao.cliInsert(vo);
	}

	@Override
	public List<ClientVO> clientDetailsList(String cli_num) throws Exception {
		logger.debug(" 거래처 상세보기 ");
		
		return bidao.clientDetailsList(cli_num);
	}

	@Override
	public void updateClient(ClientVO cvo) throws Exception {
		logger.debug(" 거래처 수정 ");
		
		bidao.updateClient(cvo);
	}

	@Override
	public void deleteClients(List<String> cliNums) throws Exception {
		logger.debug(" 거래처 삭제 ");
		
		bidao.deleteClients(cliNums);
	}

	@Override
	public void insertItem(ItemVO itemvo) throws Exception {
		logger.debug(" 품목 등록 ");
		
		bidao.itemInsert(itemvo);
	}

	@Override
	public void deleteItems(List<String> itemNums) throws Exception {
		logger.debug(" 품목 삭제 ");
		
		bidao.itemDelete(itemNums);
	}

	@Override
	public List<ItemVO> itemDetailsList(String item_num) throws Exception {
		logger.debug(" 품목 상세보기 ");
		
		return bidao.itemDetailsList(item_num);
	}

	@Override
	public int updateItem(ItemVO ivo) throws Exception {
		logger.debug(" 품목 수정 ");
		
		return bidao.updateItem(ivo);
	}

	@Override
	public void insertWarehouse(WarehouseCodeVO wcvo) throws Exception {
		logger.debug(" 창고 등록 ");
		
		bidao.warehouseInsert(wcvo);
	}
	
	@Override
	public void createZone(String whCode, String whName) throws Exception {
		logger.debug(" 창고 등록 + zone 추가");
		
		bidao.createZone(whCode, whName);
	}

	@Override
	public void deleteWarehouse(List<String> whNums) throws Exception {
		logger.debug(" 창고 삭제");
		
		bidao.warehouseDelete(whNums);
	}

	@Override
	public void deleteWareCode(List<String> whNums) throws Exception {
		logger.debug(" 창고 내부 렉 구역 삭제");
		
		bidao.warehouseCodeDelete(whNums);
	}
	
	@Override
	public List<WarehouseCodeVO> warehouseDetailsList(String s_cate_wh_code) throws Exception {
		logger.debug(" 창고 상세보기 ");
		
		return bidao.warehouseDetailsList(s_cate_wh_code);
	}

	@Override
	public void updateWhCode(WarehouseCodeVO whcvo) throws Exception {
		logger.debug(" 창고 정보 수정 ");
		
		bidao.updateWhCode(whcvo);
	}
	
	 // 창고 zone 불러오기
	@Override
	public List<String> getZones(String wh_code) throws Exception {
		logger.debug(" 창고 존 ");
		return bidao.getzones(wh_code);
	}

	// 창고 rack 불러오기
	@Override
	public List<String> getRacks(String wh_code, String wh_zone) throws Exception {
		logger.debug(" 창고 렉 ");
		
		return bidao.getRacks(wh_code, wh_zone);
	}

	// 창고 열 불러오기
    @Override
    public List<String> getColumns(String wh_code, String wh_zone, String wh_rack) throws Exception {
       logger.debug(" 창고 열 ");
    	return bidao.getColumns(wh_code, wh_zone, wh_rack);
    }

    // 창고 행 불러오기
    @Override
    public List<String> getRows(String wh_code, String wh_zone, String wh_rack) throws Exception {
        logger.debug(" 창고 행 ");
        
    	return bidao.getRows(wh_code, wh_zone, wh_rack);
    }

    // 창고 -> 재고 불러오기
	@Override
	public List<InventoryVO> getInventory(String wh_num) throws Exception {
		logger.debug(" getInventory() 실행 ");
		return bidao.getInventory(wh_num);
	}

	// 창고 -> zone 추가
	@Override
	public String addZone(String wh_code, String wh_name) throws Exception {
		logger.debug(" addZone() 실행 ");
		
		return bidao.addZone(wh_code, wh_name);
	}
	
	// 창고 -> rack 추가
	@Override
	public String addRack(String wh_code, String wh_zone, String wh_name) throws Exception {
		logger.debug(" addRack() 실행 ");
		
		
		return bidao.addRack(wh_code, wh_zone, wh_name);
	}

	
}
