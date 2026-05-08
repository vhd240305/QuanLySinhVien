<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
request.setAttribute("pageTitle", "Quản lý sinh viên");
request.setAttribute("activeMenu", "students");
%>
<%@ include file="/view/admin/partials/admin-layout-top.jsp"%>

<style>
.search-bar {
	display: flex;
	flex-wrap: wrap;
	gap: 0.75rem;
	align-items: center;
}

.search-bar .form-control {
	flex: 1 1 320px;
	min-width: 220px;
}

.student-table {
	width: 100%;
	min-width: 1400px;
}

.student-table th, .student-table td {
	padding: 0.75rem;
	vertical-align: middle;
	white-space: nowrap;
}

.student-table .col-email {
	min-width: 260px;
}

.student-table .col-actions {
	min-width: 120px;
}

.student-table .action-group {
	display: flex;
	justify-content: center;
	gap: 0.5rem;
	flex-wrap: nowrap;
}

@media ( max-width : 991.98px) {
	.search-bar {
		gap: 0.5rem;
	}
	.search-bar .form-control {
		flex-basis: 100%;
		min-width: 0;
	}
	.student-table th, .student-table td {
		padding: 0.6rem;
	}
}
</style>


<h2 class="page-title">Quản lý sinh viên</h2>

<div class="toolbar">
	<div class="d-flex gap-2">
		<a href="students?action=add" class="btn btn-success"> <i
			class="fas fa-plus me-2"></i>Thêm sinh viên
		</a>
		<button type="button" class="btn btn-outline-primary"
			onclick="exportTableToExcel('studentTable','danh-sach-sinh-vien.xls')">
			<i class="fas fa-file-excel me-2"></i>Xuất Excel
		</button>
	</div>
</div>

<form method="get" action="<%=request.getContextPath()%>/admin/students"
	class="mb-3">
	<div class="search-bar">
		<input type="text" name="keyword" value="${keyword}"
			class="form-control" placeholder="🔍 Tìm theo tên hoặc email...">
		<button class="btn btn-primary">
			<i class="fas fa-search me-1"></i>Tìm kiếm
		</button>
		<a href="<%=request.getContextPath()%>/admin/students"
			class="btn btn-secondary"> <i class="fas fa-redo me-1"></i>Đặt
			lại
		</a>
	</div>
</form>

<div class="table-responsive">
	<table id="studentTable" class="table table-hover student-table">
		<thead>
			<tr>
				<th>STT</th>
				<th>Mã SV</th>
				<th>Họ tên</th>
				<th class="col-email">Email</th>
				<th>Điện thoại</th>
				<th>Giới tính</th>
				<th>Ngày sinh</th>
				<th>Địa chỉ</th>
				<th>Lớp học</th>
				<th>Ảnh</th>
				<th class="col-actions text-end">Thao tác</th>
			</tr>
		</thead>
		<tbody>

			<%
			List<Map<String, Object>> list = (List<Map<String, Object>>) request.getAttribute("list");
			int stt = 0;

			if (list != null) {
				for (Map<String, Object> s : list) {
			%>

			<tr>
				<td><%=++stt%></td>
				<td><strong><%=("SV000" + s.get("id"))%></strong></td>
				<td><%=s.get("name")%></td>
				<td class="col-email" title="<%=s.get("email")%>"><%=s.get("email")%></td>
				<td><%=s.get("phone")%></td>
				<td><%="Male".equals(s.get("gender")) ? "Nam" : "Nữ"%></td>
				<td><%=s.get("dob")%></td>
				<td><%=s.get("address")%></td>
				<td><%=s.get("classes") != null ? s.get("classes") : "<span class='text-no-data'>Chưa có lớp</span>"%>
				</td>
				<td><img
					src="<%=request.getContextPath()%>/uploads/<%=s.get("avatar")%>"
					class="avatar-table" alt="Ảnh đại diện"></td>

				<td class="col-actions">
					<div class="action-group">
						<a
							href="<%=request.getContextPath()%>/admin/students?action=detail&id=<%=s.get("id")%>"
							class="btn btn-primary btn-sm" title="Xem chi tiết"> <i
							class="fas fa-eye"></i>
						</a> <a
							href="<%=request.getContextPath()%>/admin/students?action=edit&id=<%=s.get("id")%>"
							class="btn btn-warning btn-sm" title="Sửa"> <i
							class="fas fa-edit"></i>
						</a> <a
							href="<%=request.getContextPath()%>/admin/students?action=delete&id=<%=s.get("id")%>"
							class="btn btn-danger btn-sm"
							onclick="return confirm('Bạn có chắc chắn muốn xóa sinh viên này?');"
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