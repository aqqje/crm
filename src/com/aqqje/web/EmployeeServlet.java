package com.aqqje.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aqqje.dao.EmployeeDao;
import com.aqqje.pojo.Employee;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class EmployeeServlet
 */
@WebServlet("/emp")
public class EmployeeServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf8");
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		EmployeeDao dao = new EmployeeDao();
		
		JsonObject json = new JsonObject();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String flag = request.getParameter("action");
		System.out.println("action:" + flag);
		if(flag.equals("query")) {
			List<Employee> emp = dao.queryAll();
			out.write(new Gson().toJson(emp));
		}else if(flag.equals("insert") || flag.equals("update") || flag.equals("delete")) {
			Employee emp = null;
			if(flag.equals("delete")) {
				emp = new Employee();
				emp.setEmpno(Integer.parseInt(request.getParameter("empno")));
			}else {
				try {
					emp = new Employee(
							Integer.parseInt(request.getParameter("empno")), 
							request.getParameter("ename"), 
							request.getParameter("job"), 
							Integer.parseInt(request.getParameter("mgr")), 
							sdf.parse(request.getParameter("hiredate")), 
							Double.parseDouble(request.getParameter("sal")), 
							Double.parseDouble(request.getParameter("comm")), 
							Integer.parseInt(request.getParameter("deptno")));
				} catch (Exception e) {
					e.printStackTrace();
				} 
			}
			
			if(dao.update(emp, flag)) {
				json.addProperty("success", true);
				json.addProperty("message", "操作成功！");
			}else {
				json.addProperty("success", false);
				json.addProperty("message", "操作失败！");
			}
			out.write(json.toString());
		}
	}
}
