package com.webWeavers.weaveGlow.biz.subcategory;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository("subcategoryDAO")
public class SubCategoryDAO {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	// 관리자 페이지 상품상세 카테고리출력
	private static final String SELECTALL = "SELECT S.SUBCATEGORY_PK, S.SUBCATEGORY_NAME, C.CATEGORY_PK, C.CATEGORY_NAME FROM SUBCATEGORY S JOIN CATEGORY C ON S.CATEGORY_PK = C.CATEGORY_PK";
	// 관리자 페이지 상품상세 카테고리선택 
	private static final String SELECTONE = "SELECT SUBCATEGORY_PK, SUBCATEGORY_NAME FROM SUBCATEGORY WHERE SUBCATEGORY_PK = ?";

	private static final String INSERT = "";
	private static final String UPDATE = "";
	private static final String DELETE = "";

	public List<SubCategoryDTO> selectAll(SubCategoryDTO SubCategoryDTO) {
		try {
			return (List<SubCategoryDTO>) jdbcTemplate.query(SELECTALL, new SubCategoryRowMapper());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public SubCategoryDTO selectOne(SubCategoryDTO subCategoryDTO) {
		Object[] args = { subCategoryDTO.getSubCategoryPK(), subCategoryDTO.getSubCategoryName() };
		try {
			return jdbcTemplate.queryForObject(SELECTONE, args, new SubCategoryRowMapper());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	public boolean insert(SubCategoryDTO subCategoryDTO) {
		return false;
	}

	public boolean update(SubCategoryDTO subCategoryDTO) {
		return false;
	}

	public boolean delete(SubCategoryDTO subCategoryDTO) {
		return false;
	}

}

// selectAll, selectOne
class SubCategoryRowMapper implements RowMapper<SubCategoryDTO> {
	@Override
	public SubCategoryDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
		SubCategoryDTO data = new SubCategoryDTO();
		data.setSubCategoryPK(rs.getInt("SUBCATEGORY_PK"));
		data.setSubCategoryName(rs.getString("SUBCATEGORY_NAME"));
		data.setCategoryPK(rs.getInt("CATEGORY_PK"));
		data.setCategoryName(rs.getString("CATEGORY_NAME"));
		return data;
	}
}
