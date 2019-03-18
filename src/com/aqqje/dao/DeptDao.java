package com.aqqje.dao;

import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.aqqje.pojo.Dept;
import com.aqqje.util.DBUtil;

public class DeptDao {

	private static QueryRunner qr = new QueryRunner(DBUtil.getDataSource());
	
	// 更新查询
	public boolean update(Dept dept, String type) {
		boolean result = false;
		int i = 0;
		try {
			// 新增
			if(type.equals("insert")) {
				i = qr.update("INSERT INTO dept VALUES (?,?,?)", dept.getDeptno(), dept.getDname(), dept.getLoc());
			}
			// 更新
            if(type.equals("update")) {
            	i = qr.update("UPDATE dept SET dname=?, loc=? WHERE deptno=?", dept.getDname(), dept.getLoc(),
    					dept.getDeptno());
			}
            // 删除
            if(type.equals("delete")) {
				i = qr.update("DELETE FROM dept WHERE deptno = ?", dept.getDeptno());
			}
			if (i >= 1) {
				result = true;
			}
		} catch (Exception e) {
			System.out.println("dept: update error!");
			e.printStackTrace();
		}
		return result;
	}
	
	// 查询所有信息
	public List<Dept> queryAll() {
		List<Dept> depts = null;
		try {
			depts = qr.query("SELECT * FROM dept", new BeanListHandler<Dept>(Dept.class));
		} catch (Exception e) {
			System.out.println("dept: queryAll error!");
		}
		return depts;
	}

	// 查询信息根据 dname or loc
	public List<Dept> queryByDnameOrLoc(String dname, String loc){
		List<Dept> depts = null;
		try {
			// 使用 like 查询
			depts = qr.query("SELECT * FROM dept WHERE dname like ? or loc like ?", new BeanListHandler<Dept>(Dept.class), "%"+dname+"%", "%"+loc+"%");
		} catch (Exception e) {
			System.out.println("dept: queryByDnameOrLoc error!");
		}
		return depts;
	}
}
