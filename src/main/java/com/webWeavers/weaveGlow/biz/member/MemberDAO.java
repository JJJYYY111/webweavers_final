package com.webWeavers.weaveGlow.biz.member;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository("memberDAO")
public class MemberDAO {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	// 관리자페이지 회원현황출력
	private static final String SELECTALL = "SELECT M.MEMBER_ID, M.MEMBER_NAME, G.GRADE_NAME, M.MEMBER_BIRTH, M.MEMBER_REGDATE, M.MEMBER_MARKETING "
												+" FROM MEMBER M JOIN GRADE G ON (M.GRADE_PK = G.GRADE_PK) " ;
	// 관리자페이지 회원현황검색
	private static final String SELECTALL_USERSEARCH = "SELECT  M.MEMBER_ID, M.MEMBER_NAME, G.GRADE_NAME, M.MEMBER_BIRTH, M.MEMBER_REGDATE, M.MEMBER_MARKETING "
														+ " FROM MEMBER M JOIN GRADE G ON (M.GRADE_PK = G.GRADE_PK) "
														+ " WHERE G.GRADE_NAME LIKE CONCAT('%',?,'%') AND M.MEMBER_NAME LIKE CONCAT('%',?,'%') AND M.MEMBER_ID LIKE CONCAT('%',?,'%') ";
	// 회원 로그인
	private static final String SELECTONE_LOGIN = "SELECT MEMBER_ID, MEMBER_PASSWORD, MEMBER_NAME, MEMBER_BIRTH, MEMBER_PHONE, MEMBER_NICKNAME, MEMBER_EMAIL, "
														+ " MEMBER_MARKETING, GRADE_PK FROM MEMBER WHERE MEMBER_ID=? AND MEMBER_PASSWORD=?";
	// 회원 닉네임 중복체크
	private static final String SELECTONE_MEMBER_NICKNAMECHECK = "SELECT MEMBER_ID, MEMBER_PASSWORD, MEMBER_NAME, MEMBER_BIRTH, MEMBER_PHONE, MEMBER_NICKNAME, "
														+ " MEMBER_EMAIL, MEMBER_MARKETING, GRADE_PK FROM MEMBER WHERE MEMBER_NICKNAME=?";
	// 전체 회원 수 (탈퇴, 관리자)
	private static final String SELECTONE_TOTALMEMBER = "SELECT COUNT(MEMBER_ID) AS TOTALMEMBER FROM MEMBER WHERE GRADE_PK >= 3";
	// 회원정보 조회
	private static final String SELECTONE_MEMBERINFO = "SELECT M.MEMBER_ID, M.MEMBER_PASSWORD, M.MEMBER_NAME, M.MEMBER_BIRTH, M.MEMBER_PHONE, M.MEMBER_NICKNAME, "
														+ " M.MEMBER_EMAIL, M.MEMBER_MARKETING, M.GRADE_PK,  G.GRADE_NAME" + " FROM MEMBER M JOIN GRADE G "
														+ "   ON (M.GRADE_PK = G.GRADE_PK) WHERE M.MEMBER_ID=?";
	// 회원ID 중복체크
	private static final String SELECTONE_IDCHECK = "SELECT MEMBER_ID, MEMBER_PASSWORD, MEMBER_NAME, MEMBER_BIRTH, MEMBER_PHONE, MEMBER_NICKNAME, MEMBER_EMAIL, "
														+ " MEMBER_MARKETING, GRADE_PK FROM MEMBER WHERE MEMBER_ID=?";
	// 회원ID 찾기_SMS
	private static final String SELECTONE_IDFINDSMS = "SELECT MEMBER_ID, MEMBER_PHONE FROM MEMBER WHERE MEMBER_NAME=? AND MEMBER_PHONE=? ";
	// 회원PW 찾기_SMS
	private static final String SELECTONE_PWFINDSMS = "SELECT MEMBER_ID, MEMBER_PHONE FROM MEMBER WHERE MEMBER_ID=? AND MEMBER_PHONE=? ";
	// 회원ID 찾기_Email
	private static final String SELECTONE_IDFINDEMAIL = "SELECT MEMBER_ID, MEMBER_EMAIL FROM MEMBER WHERE MEMBER_NAME=? AND MEMBER_EMAIL=? ";
	// 회원PW 찾기_Email
	private static final String SELECTONE_PWFINDEMAIL = "SELECT MEMBER_ID, MEMBER_EMAIL FROM MEMBER WHERE MEMBER_ID=? AND MEMBER_EMAIL=? ";	
	// 회원 가입
	private static final String INSERT = "INSERT INTO MEMBER (MEMBER_ID, MEMBER_PASSWORD, MEMBER_NAME, MEMBER_BIRTH, MEMBER_PHONE, MEMBER_NICKNAME, MEMBER_EMAIL, MEMBER_MARKETING)"
														+ " VALUES (?,?,?,?,?,?,?,?)";
	// 회원 정보수정(사용자)
	private static final String UPDATE = "UPDATE MEMBER SET MEMBER_EMAIL=?, MEMBER_NICKNAME=?, MEMBER_PHONE=?, MEMBER_PASSWORD=? WHERE MEMBER_ID=?";
	// 회원 정보수정(관리자)
	private static final String UPDATE_ADMIN = "UPDATE MEMBER SET MEMBER_PASSWORD=?, MEMBER_NAME=?, MEMBER_BIRTH=?, MEMBER_PHONE=?, MEMBER_NICKNAME=?, "
														+ " MEMBER_EMAIL=?, GRADE_PK=? WHERE MEMBER_ID=?";
	// 회원 휴면상태(탈퇴)
	private static final String UPDATE_UNREGISTER = "UPDATE MEMBER SET GRADE_PK=5 WHERE MEMBER_ID=?";
	// 회원 비밀번호수정(사용자_비밀번호찾기 > 비밀번호변경)
	private static final String UPDATE_PASSWORD = "UPDATE MEMBER SET MEMBER_PASSWORD=? WHERE MEMBER_ID=?";
	private static final String DELETE = "";

	public List<MemberDTO> selectAll(MemberDTO memberDTO) {
		try {
			
			if (memberDTO.getSearchCondition().equals("allMemberInfo")) {
				return jdbcTemplate.query(SELECTALL, new MemberRowMapper3());
			} else if (memberDTO.getSearchCondition().equals("userSearch")) {
				Object[] args = { memberDTO.getGradeName(), memberDTO.getMemberName(),memberDTO.getMemberID() };
				return jdbcTemplate.query(SELECTALL_USERSEARCH, args, new MemberRowMapper3());
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}

	public MemberDTO selectOne(MemberDTO memberDTO) {
		try {
			if (memberDTO.getSearchCondition().equals("login")) {
				Object[] args = { memberDTO.getMemberID(), memberDTO.getMemberPassword() };
				return jdbcTemplate.queryForObject(SELECTONE_LOGIN, args, new MemberRowMapper2());
			} else if (memberDTO.getSearchCondition().equals("memberNickNameCheck")) {
				Object[] args = { memberDTO.getMemberNickname() };
				return jdbcTemplate.queryForObject(SELECTONE_MEMBER_NICKNAMECHECK, args, new MemberRowMapper2());
			} else if (memberDTO.getSearchCondition().equals("memberInfo")) {
				Object[] args = { memberDTO.getMemberID() };
				return jdbcTemplate.queryForObject(SELECTONE_MEMBERINFO, args, new MemberRowMapper1());
			} else if (memberDTO.getSearchCondition().equals("idCheck")) {
				Object[] args = { memberDTO.getMemberID() };
				return jdbcTemplate.queryForObject(SELECTONE_IDCHECK, args, new MemberRowMapper2());
			} else if (memberDTO.getSearchCondition().equals("idFindSms")) {
				Object[] args = { memberDTO.getMemberName(), memberDTO.getMemberPhone() };
				return jdbcTemplate.queryForObject(SELECTONE_IDFINDSMS, args, new MemberSmsRowMapper());
			} else if (memberDTO.getSearchCondition().equals("pwFindSms")) {
				Object[] args = { memberDTO.getMemberID(), memberDTO.getMemberPhone() };
				return jdbcTemplate.queryForObject(SELECTONE_PWFINDSMS, args, new MemberSmsRowMapper());
			} else if (memberDTO.getSearchCondition().equals("idFindEmail")) {
				Object[] args = { memberDTO.getMemberName(), memberDTO.getMemberEmail() };
				return jdbcTemplate.queryForObject(SELECTONE_IDFINDEMAIL, args, new MemberEmailRowMapper());				
			} else if (memberDTO.getSearchCondition().equals("pwFindEmail")) {
				Object[] args = { memberDTO.getMemberID(), memberDTO.getMemberEmail() };
				return jdbcTemplate.queryForObject(SELECTONE_PWFINDEMAIL, args, new MemberEmailRowMapper());						
			} else if (memberDTO.getSearchCondition().equals("totalMember")) {
				return jdbcTemplate.queryForObject(SELECTONE_TOTALMEMBER, new TotalMemberRowMapper());
			}
		} catch (Exception e) {
			System.out.println("[로그1] 데이터가 없습니다.");
			return null;
		}
		return null;
	}

	public boolean insert(MemberDTO memberDTO) {
		int result = jdbcTemplate.update(INSERT, memberDTO.getMemberID(), memberDTO.getMemberPassword(),
				memberDTO.getMemberName(), memberDTO.getMemberBirth(), memberDTO.getMemberPhone(),
				memberDTO.getMemberNickname(), memberDTO.getMemberEmail(), memberDTO.getMemberMarketing());
		if (result <= 0) {
			return false;
		}
		return true;
	}

	public boolean update(MemberDTO memberDTO) {
		int result;
		if (memberDTO.getSearchCondition().equals("updateInfo")) {
			result = jdbcTemplate.update(UPDATE,  memberDTO.getMemberEmail(), memberDTO.getMemberNickname(), memberDTO.getMemberPhone(), memberDTO.getMemberPassword(), memberDTO.getMemberID());
 			if (result <= 0) {
				return false;
			}
		} else if (memberDTO.getSearchCondition().equals("unregisterUpdateInfo")) {
			result = jdbcTemplate.update(UPDATE_UNREGISTER, memberDTO.getMemberID());
			if (result <= 0) {
				return false;
			}
		} else if (memberDTO.getSearchCondition().equals("adminUpdateMember")) {
			System.out.println("adminUpdateMember진입");
			result = jdbcTemplate.update(UPDATE_ADMIN, memberDTO.getMemberPassword(), memberDTO.getMemberName(), 
										memberDTO.getMemberBirth(), memberDTO.getMemberPhone(), memberDTO.getMemberNickname(),
										memberDTO.getMemberEmail(), memberDTO.getGradePK(), memberDTO.getMemberID());
			if (result <= 0) {
				return false;
			}
		} else if (memberDTO.getSearchCondition().equals("updatePW")) {
			result = jdbcTemplate.update(UPDATE_PASSWORD, memberDTO.getMemberPassword(),memberDTO.getMemberID());
			if (result <= 0) {
				return false;
			}
		}
		return true;
	}

	private boolean delete(MemberDTO memberDTO) {

		return false;
	}

	// RowMapper 인터페이스 사용

	// selectOne 회원정보
	class MemberRowMapper1 implements RowMapper<MemberDTO> {
		@Override
		public MemberDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
			MemberDTO data = new MemberDTO();
			data.setMemberID(rs.getString("MEMBER_ID"));
			data.setMemberPassword(rs.getString("MEMBER_PASSWORD"));
			data.setMemberName(rs.getString("MEMBER_NAME"));
			data.setMemberBirth(rs.getDate("MEMBER_BIRTH"));
			data.setMemberPhone(rs.getString("MEMBER_PHONE"));
			data.setMemberNickname(rs.getString("MEMBER_NICKNAME"));
			data.setMemberEmail(rs.getString("MEMBER_EMAIL"));
			data.setMemberMarketing(rs.getString("MEMBER_MARKETING"));
			data.setGradePK(rs.getInt("GRADE_PK"));
			data.setGradeName(rs.getString("GRADE_NAME"));
			return data;
		}
	}
	// selectOne 로그인, 회원 닉네임, ID 중복체크
	class MemberRowMapper2 implements RowMapper<MemberDTO> {
		@Override
		public MemberDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
			MemberDTO data = new MemberDTO();
			data.setMemberID(rs.getString("MEMBER_ID"));
			data.setMemberPassword(rs.getString("MEMBER_PASSWORD"));
			data.setMemberName(rs.getString("MEMBER_NAME"));
			data.setMemberBirth(rs.getDate("MEMBER_BIRTH"));
			data.setMemberPhone(rs.getString("MEMBER_PHONE"));
			data.setMemberNickname(rs.getString("MEMBER_NICKNAME"));
			data.setMemberEmail(rs.getString("MEMBER_EMAIL"));
			data.setMemberMarketing(rs.getString("MEMBER_MARKETING"));
			data.setGradePK(rs.getInt("GRADE_PK"));
			return data;
		}
	}
	
	// selectAll 전체회원정보조회, 회원 검색
	class MemberRowMapper3 implements RowMapper<MemberDTO> {
		@Override
		public MemberDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
			MemberDTO data = new MemberDTO();
			data.setMemberID(rs.getString("MEMBER_ID"));
			data.setMemberName(rs.getString("MEMBER_NAME"));
			data.setGradeName(rs.getString("GRADE_NAME"));
			data.setMemberBirth(rs.getDate("MEMBER_BIRTH"));
			data.setMemberRegdate(rs.getDate("MEMBER_REGDATE"));
			data.setMemberMarketing(rs.getString("MEMBER_MARKETING"));
			return data;
		}
	}
	
	// selectOne 회원 ID찾기, PW찾기 할 때 문자인증
	class MemberSmsRowMapper implements RowMapper<MemberDTO> {
		@Override
		public MemberDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
			MemberDTO data = new MemberDTO();
			data.setMemberID(rs.getString("MEMBER_ID"));
			data.setMemberPhone(rs.getString("MEMBER_PHONE"));
			return data;
		}
	}
	
	// selectOne 회원 ID찾기, PW찾기 할 때 이메일인증
	class MemberEmailRowMapper implements RowMapper<MemberDTO> {
		@Override
		public MemberDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
			MemberDTO data = new MemberDTO();
			data.setMemberID(rs.getString("MEMBER_ID"));
			data.setMemberEmail(rs.getString("MEMBER_Email"));
			return data;
		}
	}
	
	// selectOne 탈퇴, 관리자 제외한 전체 회원수 조회
	class TotalMemberRowMapper implements RowMapper<MemberDTO> {
		@Override
		public MemberDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
			MemberDTO data = new MemberDTO();
			data.setTotalMember(rs.getInt("TOTALMEMBER"));
			return data;
		}
	}

}
