<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Account"%>
<%@ page import="dao.StudentDAO"%>
<%@ page import="dao.TeacherDAO"%>
<%@ page import="dao.ClassroomDAO"%>

<%
Account acc = (Account) session.getAttribute("account");

if (acc == null || !acc.getRole().equals("admin")) {
	response.sendRedirect("../auth/login.jsp");
	return;
}

// lấy thống kê
StudentDAO dao = new StudentDAO();
int totalStudents = dao.getAll().size();
TeacherDAO teacherDAO = new TeacherDAO();
int totalTeachers = teacherDAO.getAll().size();
ClassroomDAO classroomDAO = new ClassroomDAO();
int totalClassrooms = classroomDAO.getAll().size();
request.setAttribute("pageTitle", "Tổng quan hệ thống");
request.setAttribute("activeMenu", "dashboard");
%>
<%@ include file="/view/admin/partials/admin-layout-top.jsp"%>

<h2 class="page-title">Tổng quan hệ thống</h2>

<div class="row g-4 mt-1">
	<div class="col-md-4">
		<div class="stat-card stat-students">
			<div class="stat-icon">
				<i class="fas fa-user-graduate"></i>
			</div>
			<div class="stat-label">Tổng sinh viên</div>
			<div class="stat-value"><%=totalStudents%></div>
		</div>
	</div>

	<div class="col-md-4">
		<div class="stat-card stat-teachers">
			<div class="stat-icon">
				<i class="fas fa-chalkboard-teacher"></i>
			</div>
			<div class="stat-label">Tổng giảng viên</div>
			<div class="stat-value"><%=totalTeachers%></div>
		</div>
	</div>

	<div class="col-md-4">
		<div class="stat-card stat-classrooms">
			<div class="stat-icon">
				<i class="fas fa-school"></i>
			</div>
			<div class="stat-label">Tổng lớp học</div>
			<div class="stat-value"><%=totalClassrooms%></div>
		</div>
	</div>
</div>

<h5 class="mt-4 mb-3" style="font-weight: 600; color: #64748b;">
	<i class="fas fa-bolt me-2"></i>Truy cập nhanh
</h5>
<div class="d-flex gap-2 flex-wrap">
	<a href="<%=request.getContextPath()%>/admin/students"
		class="btn btn-primary"> <i class="fas fa-user-graduate me-2"></i>Quản
		lý sinh viên
	</a> <a href="<%=request.getContextPath()%>/admin/teachers"
		class="btn btn-success"> <i class="fas fa-chalkboard-teacher me-2"></i>Quản
		lý giảng viên
	</a> <a href="<%=request.getContextPath()%>/admin/classrooms"
		class="btn btn-info text-white"> <i class="fas fa-school me-2"></i>Quản
		lý lớp học
	</a> <a href="<%=request.getContextPath()%>/admin/accounts"
		class="btn btn-dark"> <i class="fas fa-users-cog me-2"></i>Quản lý
		tài khoản
	</a>
</div>

<%@ include file="/view/admin/partials/admin-layout-bottom.jsp"%>