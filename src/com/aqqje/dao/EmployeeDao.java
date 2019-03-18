package com.aqqje.dao;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import com.aqqje.pojo.Employee;
import com.aqqje.util.DBUtil;

public class EmployeeDao {

	QueryRunner qr = new QueryRunner(DBUtil.getDataSource());
	
	// 更新
	public boolean update(Employee emp, String type) {
		boolean result = false;
		int i = 0;
		try {
			if(type.equals("insert")) {	// 新增
				i = qr.update("INSERT INTO emp VALUES (?,?,?,?,?,?,?,?)", 
						emp.getEmpno(), emp.getEname(), emp.getJob(), 
						emp.getMgr(), emp.getHiredate(), emp.getSal(), 
						emp.getComm(), emp.getDeptno());
			}else if(type.equals("update")) { // 修改
            	i = qr.update("UPDATE emp SET ename=?, job=?, mgr=?, sal=?, comm=?, deptno=? WHERE empno=?", emp.getEname(), emp.getJob(), 
						emp.getMgr(), emp.getSal(), 
						emp.getComm(), emp.getDeptno(), emp.getEmpno());
			}else if(type.equals("delete")) { // 删除
				i = qr.update("DELETE FROM emp WHERE empno=?",  emp.getEmpno());
			}
			if (i >= 1) {
				result = true;
			}
		} catch (Exception e) {
			System.out.println("employee: update error!");
			e.printStackTrace();
		}
		return result;
	}
	
	// 查询所有
	public List<Employee> queryAll(){
		List<Employee> emps = null;
		try {
			emps = qr.query("SELECT * FROM emp", new BeanListHandler<Employee>(Employee.class));
		} catch (Exception e) {
			System.out.println("dept: queryAll error!");
		}
		return emps;
	}
	
	// 条件查询
	public List<Employee> queryOr(Employee emp){
		List<Employee> emps = null;
		try {
			// 使用 like 查询
			emps = qr.query("SELECT * FROM emp WHERE ename like ? or job like ?", new BeanListHandler<Employee>(Employee.class), 
					"%"+emp.getEname()+"%", "%"+emp.getJob()+"%");
		} catch (Exception e) {
			System.out.println("employee: queryByDnameOrLoc error!");
		}
		return emps;
	}
}
