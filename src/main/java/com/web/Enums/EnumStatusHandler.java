package com.web.Enums;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.TypeHandler;

import org.apache.ibatis.type.JdbcType;

public class EnumStatusHandler implements TypeHandler<StatusEnum> {

	@Override
	public void setParameter(PreparedStatement ps, int i, StatusEnum parameter, JdbcType jdbcType) throws SQLException {
		// TODO Auto-generated method stub
		ps.setInt(i, parameter.getId());
	}

	@Override
	public StatusEnum getResult(ResultSet rs, String columnName) throws SQLException {
		// TODO Auto-generated method stub
		int id = rs.getInt(columnName);
		return StatusEnum.getStatus(id);
	}

	@Override
	public StatusEnum getResult(ResultSet rs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		int id = rs.getInt(columnIndex);
		return StatusEnum.getStatus(id);
	}

	@Override
	public StatusEnum getResult(CallableStatement cs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		int id = cs.getInt(columnIndex);
		return StatusEnum.getStatus(id);
	}

	
}
