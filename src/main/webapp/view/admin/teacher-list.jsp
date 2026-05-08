<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
request.setAttribute("pageTitle", "Quản lý giảng viên");
request.setAttribute("activeMenu", "teachers");
%>
<%@ include file="/view/admin/partials/admin-layout-top.jsp"%>

<h2 class="page-title">Quản lý giảng viên</h2>

<div class="toolbar">
	<div class="d-flex gap-2">
		<a href="<%=request.getContextPath()%>/admin/teachers?action=add"
			class="btn btn-success"> <i class="fas fa-plus me-2"></i>Thêm
			giảng viên
		</a>
		<button type="button" class="btn btn-outline-primary"
			onclick="exportTableToExcel('teacherTable','danh-sach-giang-vien.xls')">
			<i class="fas fa-file-excel me-2"></i>Xuất Excel
		</button>
	</div>
</div>

<form method="get" action="<%=request.getContextPath()%>/admin/teachers"
	class="mb-3">
	<div class="search-bar">
		<input type="text" name="keyword" value="${keyword}"
			class="form-control" placeholder="🔍 Tìm theo tên giảng viên...">
		<button class="btn btn-primary">
			<i class="fas fa-search me-1"></i>Tìm kiếm
		</button>
		<a href="<%=request.getContextPath()%>/admin/teachers"
			class="btn btn-secondary"> <i class="fas fa-redo me-1"></i>Đặt
			lại
		</a>
	</div>
</form>

<div class="table-responsive">
	<table id="teacherTable" class="table table-hover">
		<thead>
			<tr>
				<th>STT</th>
				<th>Mã GV</th>
				<th>Họ tên</th>
				<th>Email</th>
				<th>Điện thoại</th>
				<th>Bộ môn/Khoa</th>
				<th>Lớp phụ trách</th>
				<th>Thao tác</th>
			</tr>
		</thead>
		<tbody>

			<%
			List<Map<String, Object>> list = (List<Map<String, Object>>) request.getAttribute("list");
			int stt = 0;

			if (list != null) {
				for (Map<String, Object> row : list) {
			%>

			<tr>
				<td><%=++stt%></td>
				<td><strong><%=("GV000" + row.get("id"))%></strong></td>
				<td><%=row.get("name")%></td>
				<td><%=row.get("email")%></td>
				<td><%=row.get("phone")%></td>
				<td><%=row.get("department")%></td>
				<td><%=row.get("classes") != null ? row.get("classes") : "<span class='text-no-data'>Chưa có lớp</span>"%>
				</td>
				<td>
					<div class="action-group">
						<a
							href="<%=request.getContextPath()%>/admin/teachers?action=detail&id=<%=row.get("id")%>"
							class="btn btn-info btn-sm" title="Chi tiết"> <i
							class="fas fa-eye"></i>
						</a> <a
							href="<%=request.getContextPath()%>/admin/teachers?action=edit&id=<%=row.get("id")%>"
							class="btn btn-warning btn-sm" title="Sửa"> <i
							class="fas fa-edit"></i>
						</a> <a
							href="<%=request.getContextPath()%>/admin/teachers?action=delete&id=<%=row.get("id")%>"
							class="btn btn-danger btn-sm"
							onclick="return confirm('Bạn có chắc chắn muốn xóa giảng viên này?')"
							title="Xóa"> <i class="fas fa-trash"></i>
						</a>
					</div>
				</td>
			</tr>

			<%
}
}
%>

		</tbody>
	</table>
</div>
<%@ include file="/view/admin/partials/admin-layout-bottom.jsp"%>