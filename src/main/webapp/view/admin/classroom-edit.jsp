<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*, model.Teacher, model.Classroom"%>

<%
Classroom classroom = (Classroom) request.getAttribute("classroom");
List<Teacher> teachers = (List<Teacher>) request.getAttribute("teacherList");
%>
<%
request.setAttribute("pageTitle", "Cập nhật lớp học");
request.setAttribute("activeMenu", "classrooms");
%>
<%@ include file="/view/admin/partials/admin-layout-top.jsp"%>
<h2 class="page-title">Cập nhật thông tin lớp học</h2>

<form action="<%=request.getContextPath()%>/admin/classrooms"
	method="post">

	<input type="hidden" name="action" value="update"> <input
		type="hidden" name="id" value="<%=classroom.getId()%>">

	<div class="row">
		<div class="col-md-6">
			<div class="mb-3">
				<label class="form-label">Tên lớp <span class="required-dot">*</span></label>
				<input name="name" value="<%=classroom.getName()%>"
					class="form-control" required maxlength="120">
			</div>
		</div>
		<div class="col-md-6">
			<div class="mb-3">
				<label class="form-label">Phòng học <span
					class="required-dot">*</span></label> <input name="room"
					value="<%=classroom.getRoom()%>" class="form-control" required
					maxlength="50">
			</div>
		</div>
		<div class="col-md-12">
			<div class="mb-3">
				<label class="form-label">Mô tả</label>
				<textarea name="description" class="form-control" maxlength="255"
					rows="3"><%=classroom.getDescription()%></textarea>
			</div>
		</div>
		<div class="col-md-6">
			<div class="mb-3">
				<label class="form-label">Giảng viên phụ trách</label> <select
					name="teacher_id" class="form-control">
					<%
					if (teachers != null) {
						for (Teacher t : teachers) {
					%>
					<option value="<%=t.getId()%>"
						<%=t.getId() == classroom.getTeacherId() ? "selected" : ""%>>
						<%=t.getTeacherCode() != null ? t.getTeacherCode() + " - " : ""%><%=t.getName()%>
					</option>
					<%
					}
					}
					%>
				</select>
			</div>
		</div>
	</div>

	<div class="d-flex gap-2 mt-2">
		<button class="btn btn-primary">
			<i class="fas fa-save me-2"></i>Cập nhật
		</button>
		<a href="<%=request.getContextPath()%>/admin/classrooms"
			class="btn btn-secondary"><i class="fas fa-arrow-left me-2"></i>Hủy</a>
	</div>

</form>
<%@ include file="/view/admin/partials/admin-layout-bottom.jsp"%>