package com.webWeavers.weaveGlow.biz.category;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository("categoryDAO")
public class CategoryDAO {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	// 조인을 위한 테이블
	private static final String SELECTALL = "SELECT CATEGORY_PK, CATEGORY_NAME FROM CATEGORY";
	private static final String SELECTONE = "SELECT CATEGORY_PK, CATEGORY_NAME FROM CATEGORY WHERE CATEGORY_PK = ?";

	private static final String INSERT = "";
	private static final String UPDATE = "";
	private static final String DELETE = "";

	public List<CategoryDTO> selectAll(CategoryDTO categoryDTO) {
		try {
			return jdbcTemplate.query(SELECTALL, new CategoryRowMapper());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public CategoryDTO selectOne(CategoryDTO categoryDTO) {
		Object[] args = { categoryDTO.getCategoryPK(), categoryDTO.getCategoryName() };
		try {
			return jdbcTemplate.queryForObject(SELECTONE, args, new CategoryRowMapper());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	public boolean insert(CategoryDTO categoryDTO) {
		return false;
	}

	public boolean update(CategoryDTO categoryDTO) {
		return false;
	}

	public boolean delete(CategoryDTO categoryDTO) {
		return false;
	}

}

class CategoryRowMapper implements RowMapper<CategoryDTO> {
	@Override
	public CategoryDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
		CategoryDTO data = new CategoryDTO();
		data.setCategoryPK(rs.getInt("CATEGORY_PK"));
		data.setCategoryName(rs.getString("CATEGORY_NAME"));
		return data;
	}
}
