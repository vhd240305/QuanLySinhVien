<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%
request.setAttribute("pageTitle", "Thêm lớp học");
request.setAttribute("activeMenu", "classrooms");
%>
<%@ include file="/view/admin/partials/admin-layout-top.jsp"%>
<h2 class="page-title">Thêm lớp học mới</h2>
<form action="<%=request.getContextPath()%>/admin/classrooms"
	method="post">

	<input type="hidden" name="action" value="insert">

	<div class="row">
		<div class="col-md-6">
			<div class="mb-3">
				<label class="form-label">Tên lớp <span class="required-dot">*</span></label>
				<input name="name" placeholder="Nhập tên lớp học"
					class="form-control" required maxlength="120">
			</div>
		</div>
		<div class="col-md-6">
			<div class="mb-3">
				<label class="form-label">Phòng học <span
					class="required-dot">*</span></label> <input name="room"
					placeholder="VD: P.201" class="form-control" required
					maxlength="50">
			</div>
		</div>
		<div class="col-md-12">
			<div class="mb-3">
				<label class="form-label">Mô tả</label>
				<textarea name="description" class="form-control" maxlength="255"
					rows="3" placeholder="Nhập mô tả lớp học (không bắt buộc)"></textarea>
			</div>
		</div>
		<div class="col-md-6">
			<div class="mb-3">
				<label class="form-label">Giảng viên phụ trách</label> <select
					name="teacher_id" class="form-control">
					<%
					List<model.Teacher> teachers = (List<model.Teacher>) request.getAttribute("teacherList");
					if (teachers != null) {
						for (model.Teacher t : teachers) {
					%>
					<option value="<%=t.getId()%>"><%=t.getTeacherCode() != null ? t.getTeacherCode() + " - " : ""%><%=t.getName()%></option>
					<%
					}
					}
					%>
				</select>
			</div>
		</div>
	</div>

	<div class="d-flex gap-2 mt-2">
		<button class="btn btn-success">
			<i class="fas fa-save me-2"></i>Lưu lớp học
		</button>
		<a href="<%=request.getContextPath()%>/admin/classrooms"
			class="btn btn-secondary"><i class="fas fa-arrow-left me-2"></i>Hủy</a>
	</div>

</form>
<%@ include file="/view/admin/partials/admin-layout-bottom.jsp"%>