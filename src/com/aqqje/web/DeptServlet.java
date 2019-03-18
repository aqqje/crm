package com.aqqje.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aqqje.dao.DeptDao;
import com.aqqje.pojo.Dept;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class DeptServlet
 */
@WebServlet("/dept")
public class DeptServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeptServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		
		PrintWriter out = response.getWriter();
		
		JsonObject json = new JsonObject();
		DeptDao dao = new DeptDao();
		
		String flag = request.getParameter("action");
		if(flag.equals("query")) {
			List<Dept> depts = dao.queryAll();
			out.write(new Gson().toJson(depts));;
		}else if(flag.equals("insert") || flag.equals("update") || flag.equals("delete")) {
			Dept dept = null;
			if(flag.equals("delete")) {
				dept = new Dept();
				dept.setDeptno(Integer.parseInt(request.getParameter("deptno")));
			}else {
				dept = new Dept(Integer.parseInt(request.getParameter("deptno")), request.getParameter("dname"),request.getParameter("loc"));
			}
			if(dao.update(dept, flag)) {
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
