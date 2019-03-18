package com.aqqje.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class DBUtil {
	
	// 创建 c3p0 连接池对象
	private static ComboPooledDataSource ds = new ComboPooledDataSource();
	
	// 获取数据库连接对象
	public static Connection getConnection() {
		Connection conn = null;
		try {
			conn = ds.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("数据库连接失败！");
		}
		return conn;
	}
	
	// 获取数据源
	public static DataSource getDataSource() {
		return ds;
	}
	
	// 关闭资源
	public static void close(ResultSet rs, Statement stmt, Connection conn) {
		try {
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
			if(conn != null) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
