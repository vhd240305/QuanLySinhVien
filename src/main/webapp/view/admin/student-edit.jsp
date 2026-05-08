<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
request.setAttribute("pageTitle", "Cập nhật sinh viên");
request.setAttribute("activeMenu", "students");
%>
<%@ include file="/view/admin/partials/admin-layout-top.jsp"%>
<h2 class="page-title">Cập nhật thông tin sinh viên</h2>
<%
if (request.getAttribute("error") != null) {
%>
<div class="alert alert-danger">
	<i class="fas fa-exclamation-circle me-2"></i><%=request.getAttribute("error")%></div>
<%
}
%>
<form action="students" method="post" enctype="multipart/form-data">

	<input type="hidden" name="action" value="update"> <input
		type="hidden" name="id" value="${student.id}">

	<div class="row">
		<div class="col-md-6">
			<div class="mb-3">
				<label class="form-label">Họ tên <span class="required-dot">*</span></label>
				<input name="name" value="${student.name}" class="form-control"
					required maxlength="120">
			</div>
		</div>
		<div class="col-md-6">
			<div class="mb-3">
				<label class="form-label">Email <span class="required-dot">*</span></label>
				<input name="email" value="${student.email}" class="form-control"
					required type="email" maxlength="120">
			</div>
		</div>
		<div class="col-md-6">
			<div class="mb-3">
				<label class="form-label">Số điện thoại <span
					class="required-dot">*</span></label> <input name="phone"
					value="${student.phone}" class="form-control" required
					pattern="0[0-9]{9}" maxlength="10"
					title="Số điện thoại gồm 10 số, bắt đầu bằng 0">
			</div>
		</div>
		<div class="col-md-6">
			<div class="mb-3">
				<label class="form-label">Giới tính</label> <select name="gender"
					class="form-control">
					<option value="Male" ${student.gender == 'Male' ? 'selected' : ''}>Nam</option>
					<option value="Female"
						${student.gender == 'Female' ? 'selected' : ''}>Nữ</option>
				</select>
			</div>
		</div>
		<div class="col-md-6">
			<div class="mb-3">
				<label class="form-label">Ngày sinh <span
					class="required-dot">*</span></label> <input type="date" name="dob"
					value="${student.dob}" class="form-control" required>
			</div>
		</div>
		<div class="col-md-6">
			<div class="mb-3">
				<label class="form-label">Địa chỉ <span class="required-dot">*</span></label>
				<input name="address" value="${student.address}"
					class="form-control" required maxlength="255">
			</div>
		</div>
		<div class="col-md-6">
			<div class="mb-3">
				<label class="form-label">Ảnh đại diện</label> <input type="file"
					name="avatar" class="form-control">
			</div>
		</div>
		<div class="col-md-6">
			<div class="mb-3">
				<label class="form-label">Chọn lớp học</label>
				<%
				List<Integer> selected = (List<Integer>) request.getAttribute("selectedClasses");
				%>
				<%
				List<model.Classroom> cl = (List<model.Classroom>) request.getAttribute("classList");

				if (cl != null) {
					for (model.Classroom c : cl) {
						boolean checked = selected != null && selected.contains(c.getId());
				%>
				<div class="form-check-custom">
					<input type="checkbox" name="classroomIds" id="cls_<%=c.getId()%>"
						value="<%=c.getId()%>" <%=checked ? "checked" : ""%>> <label
						for="cls_<%=c.getId()%>"><%=c.getClassroomCode() != null ? c.getClassroomCode() : "HP" + c.getId()%>
						- <%=c.getName()%></label>
				</div>
				<%
				}
				}
				%>
			</div>
		</div>
	</div>

	<div class="d-flex gap-2 mt-2">
		<button class="btn btn-primary">
			<i class="fas fa-save me-2"></i>Cập nhật
		</button>
		<a href="<%=request.getContextPath()%>/admin/students"
			class="btn btn-secondary"><i class="fas fa-arrow-left me-2"></i>Hủy</a>
	</div>

</form>
<%@ include file="/view/admin/partials/admin-layout-bottom.jsp"%>