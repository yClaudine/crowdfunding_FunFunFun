package kr.or.fund.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.coupon.model.vo.Coupon;
import kr.or.coupon.model.vo.MemberCoupon;
import kr.or.fund.model.vo.Fund;
import kr.or.fund.model.vo.FundLike;
import kr.or.fund.model.vo.FundPay;
import kr.or.fund.model.vo.Reward;
import kr.or.member.vo.Seller;

@Repository
public class FundListDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	//펀딩 리스트 메인페이지
	public ArrayList<Fund> selectFundList(HashMap<String, Object> map){
		List list = sqlSession.selectList("fundList.selectFundList",map);
		return (ArrayList<Fund>)list;
	}
	
	//펀딩 상세 - 프로젝트 조회
	public Fund selectOneFund(int fundNo) {
		Fund f = sqlSession.selectOne("fundList.selectOneFund",fundNo);
		return f;
	}
	//펀딩 상세 - 리워드 조회
	public ArrayList<Reward> selectRewardList(int fundNo) {
		List list = sqlSession.selectList("fundReward.selectRewardList",fundNo);
		return (ArrayList<Reward>) list;
	}
	//펀딩 상세 - 셀러 조회
 	public Seller selectOneSeller(int fundNo) {
 		Seller s = sqlSession.selectOne("fundSeller.selectOneSeller",fundNo);
		return s;
	}
	//펀딩 상세 - 해당 펀딩 좋아요 total
	public FundLike selectFundTotal(int fundNo) {
		FundLike fl = sqlSession.selectOne("fundLike.selectFundTotal",fundNo);
		return fl;
	}
//-------------------------------------
	//펀딩 신고
	public int updateReportCount(int fundNo) {
		int result = sqlSession.update("fundList.updateReportCount",fundNo);
		return result;
	}
	/* 좋아요 ajax
	public FundLike selectOneFundlike(HashMap<String, Object> map) {
		FundLike fl = sqlSession.selectOne("fundLike.selectOneFundlike",map);
		return fl;
	}
	
	*/
	//좋아요 insert
	public int insertFundlike(FundLike fl) {
		int result = sqlSession.update("fundLike.insertFundlike",fl);
		return result;
	}
	//좋아요 delete
	public int deleteFundlike(int fundNo) {
		int result = sqlSession.delete("fundLike.deleteFundlike",fundNo);
		return result;
	}
	//좋아요 체크
	public FundLike fundCheck(HashMap<String, Object> map) {
		FundLike fc = sqlSession.selectOne("fundLike.fundCheck",map);
		return fc;
	}


	//조건별 쿠폰 리스트 최종쿼리
	public ArrayList<Coupon> selectCouponList(HashMap<String, Object> map) {
		List list = sqlSession.selectList("fundPay.selectCouponList",map);
		return (ArrayList<Coupon>)list;
	}
	
	//결제 정보 인서트
	public int insertPay(HashMap<String, Object> map) {
		int result = sqlSession.insert("fundPay.insertPay",map);
		return result;
	}
	
	//결제 정보 하나 조회
	public FundPay selectOnePay(int fundNo, String memberId, int fpayFinalpay) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("fundNo",fundNo);
		map.put("memberId",memberId);
		map.put("fpayFinalpay",fpayFinalpay);
		FundPay fp = sqlSession.selectOne("fundPay.selectOnePay",map);
		return fp;
	}

	//모든 결제 정보 조회
	public ArrayList<FundPay> selectPayList(int fundNo) {
		List plist = sqlSession.selectList("fundPay.selectPayList",fundNo);
		return (ArrayList<FundPay>)plist;
	}


	
	/*리워드 카트 인서트
	public int insertCart(HashMap<String, Object> map) {
		int result = sqlSession.insert("fundPay.insertCart",map);
		return result;
	}
	//리워드 카트 삭제
	public int deleteCart(HashMap<String, Object> map) {
		int result = sqlSession.delete("fundPay.deleteCart",map);
		return result;
	}*/

	/*array 리워드 카트 인서트
	public int insertReward(HashMap<String, Object> map) {
		int result = sqlSession.insert("fundPay.insertReward",map);
		return result;
	}*/
	



	
	
}
