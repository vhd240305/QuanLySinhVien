<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="model.Classroom"%>
<%@ page import="model.Teacher"%>
<%@ page import="model.Student"%>
<%
request.setAttribute("pageTitle", "Chi tiết lớp học");
request.setAttribute("activeMenu", "classrooms");

Classroom classroom = (Classroom) request.getAttribute("classroom");
Teacher teacher = (Teacher) request.getAttribute("teacher");
List<Student> students = (List<Student>) request.getAttribute("students");
%>
<%@ include file="/view/admin/partials/admin-layout-top.jsp"%>

<style>
.classroom-info .info-item {
	margin-bottom: 0.75rem;
	line-height: 1.5;
}

.students-table {
	table-layout: fixed;
	width: 100%;
}

.students-table th, .students-table td {
	vertical-align: middle;
	padding: 0.75rem;
}

.students-table td {
	word-break: break-word;
}

.students-table .col-email {
	min-width: 220px;
}

.students-table td:last-child, .students-table th:last-child {
	width: 90px;
	white-space: nowrap;
}

@media ( max-width : 991.98px) {
	.students-table {
		table-layout: auto;
	}
	.students-table th, .students-table td {
		white-space: normal;
	}
}
</style>

<div class="d-flex justify-content-between align-items-center mb-3">
	<h2 class="page-title mb-0">Chi tiết lớp học</h2>
	<div class="d-flex gap-2">
		<a href="<%=request.getContextPath()%>/admin/classrooms"
			class="btn btn-secondary"> <i class="fas fa-arrow-left me-1"></i>Quay
			lại
		</a> <a
			href="<%=request.getContextPath()%>/admin/classrooms?action=edit&id=<%=classroom.getId()%>"
			class="btn btn-warning"> <i class="fas fa-edit me-1"></i>Sửa
		</a>
	</div>
</div>

<div class="card shadow-sm mb-3">
	<div class="card-body">
		<div class="row classroom-info">
			<div class="col-md-6 info-item">
				<strong>Mã lớp:</strong>
				<%=("HP000" + classroom.getId())%></div>
			<div class="col-md-6 info-item">
				<strong>Tên lớp:</strong>
				<%=classroom.getName()%></div>
			<div class="col-md-6 info-item">
				<strong>Phòng:</strong>
				<%=classroom.getRoom()%></div>
			<div class="col-12 info-item">
				<strong>Mô tả:</strong>
				<%=classroom.getDescription()%></div>
			<div class="col-12 info-item">
				<strong>Giảng viên phụ trách:</strong>
				<%
				if (teacher == null) {
				%>
				<span class="text-no-data">Chưa phân công</span>
				<%
				} else {
				%>
				<a
					href="<%=request.getContextPath()%>/admin/teachers?action=detail&id=<%=teacher.getId()%>">
					<%=teacher.getTeacherCode() != null ? teacher.getTeacherCode() + " - " : ""%><%=teacher.getName()%>
				</a>
				<%
				}
				%>
			</div>
		</div>
	</div>
</div>

<div class="card shadow-sm">
	<div class="card-body">
		<h5 class="mb-3">Danh sách sinh viên trong lớp</h5>
		<div class="table-responsive">
			<table class="table table-hover students-table">
				<thead>
					<tr>
						<th>STT</th>
						<th>Mã SV</th>
						<th>Họ tên</th>
						<th class="col-email">Email</th>
						<th>Điện thoại</th>
						<th>Giới tính</th>
						<th>Thao tác</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (students == null || students.isEmpty()) {
					%>
					<tr>
						<td colspan="7" class="text-muted">Chưa có sinh viên trong
							lớp.</td>
					</tr>
					<%
					} else {
					int stt = 0;
					for (Student s : students) {
					%>
					<tr>
						<td><%=++stt%></td>
						<td><strong><%=s.getStudentCode() != null ? s.getStudentCode() : ("SV" + s.getId())%></strong></td>
						<td><%=s.getName()%></td>
						<td class="col-email" title="<%=s.getEmail()%>"><%=s.getEmail()%></td>
						<td><%=s.getPhone()%></td>
						<td><%="Male".equals(s.getGender()) ? "Nam" : "Nữ"%></td>
						<td class="text-end"><a
							class="btn btn-sm btn-outline-primary"
							href="<%=request.getContextPath()%>/admin/students?action=detail&id=<%=s.getId()%>">
								<i class="fas fa-eye"></i>
						</a></td>
					</tr>
					<%
					}
					}
					%>
				</tbody>
			</table>
		</div>
	</div>
</div>

<%@ include file="/view/admin/partials/admin-layout-bottom.jsp"%>

