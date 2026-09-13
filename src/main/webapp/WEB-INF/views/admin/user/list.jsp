<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="fw-bold text-gradient">✨ User Management</h2>
    <a href="/admin/user/create" class="btn btn-primary btn-glow"><i class="fas fa-plus me-2"></i>Thêm Người Dùng</a>
</div>

<div class="glass-card mb-4 p-4">
    <form action="/admin/user" method="get" class="d-flex gap-2">
        <input type="text" name="keyword" class="form-control glass-input flex-grow-1" placeholder="Tìm kiếm người dùng..." value="${keyword}">
        <button type="submit" class="btn btn-primary btn-glow px-4"><i class="fas fa-search me-2"></i>Tìm</button>
    </form>
</div>

<div class="glass-card">
    <div class="table-responsive">
        <table class="table table-hover table-borderless align-middle mb-0 text-white">
            <thead class="glass-header">
                <tr>
                    <th class="py-3 px-4 rounded-start">ID</th>
                    <th class="py-3 px-4">Ảnh</th>
                    <th class="py-3 px-4">Tên / Email</th>
                    <th class="py-3 px-4">Quyền</th>
                    <th class="py-3 px-4">Trạng thái</th>
                    <th class="py-3 px-4 text-end rounded-end">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${users}" var="u">
                    <tr class="glass-row">
                        <td class="px-4 fw-bold">#${u.id}</td>
                        <td class="px-4">
                            <img src="${not empty u.avatarUrl ? u.avatarUrl : 'https://ui-avatars.com/api/?name='.concat(u.fullName).concat('&background=6366f1&color=fff')}" 
                                 class="rounded-circle shadow-sm" style="width: 45px; height: 45px; object-fit: cover;" alt="Avatar">
                        </td>
                        <td class="px-4">
                            <div class="fw-bold text-accent">${u.fullName}</div>
                            <small class="text-muted">${u.email}</small>
                        </td>
                        <td class="px-4">
                            <c:choose>
                                <c:when test="${u.role == 'ADMIN'}"><span class="badge bg-danger glass-badge">ADMIN</span></c:when>
                                <c:otherwise><span class="badge bg-primary glass-badge">USER</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="px-4">
                            <c:choose>
                                <c:when test="${u.active}"><span class="badge bg-success glass-badge text-success" style="background: rgba(16, 185, 129, 0.2) !important; border-color: rgba(16, 185, 129, 0.4);">Hoạt động</span></c:when>
                                <c:otherwise><span class="badge bg-secondary glass-badge text-muted" style="background: rgba(255, 255, 255, 0.1) !important; border-color: rgba(255, 255, 255, 0.2);">Khóa</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="px-4 text-end">
                            <a href="/admin/user/edit/${u.id}" class="btn btn-sm btn-glass me-2"><i class="fas fa-pen-to-square"></i> Sửa</a>
                            <a href="/admin/user/delete/${u.id}" class="btn btn-sm btn-glass-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa tài khoản này?')"><i class="fas fa-trash"></i> Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty users}">
                    <tr>
                        <td colspan="6" class="text-center py-5 text-muted">Không có người dùng nào.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<c:if test="${totalPages > 1}">
    <nav class="mt-4 d-flex justify-content-center">
        <ul class="pagination pagination-sm">
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${currentPage == i ? 'active' : ''}">
                    <a class="page-link glass-input" href="/admin/user?page=${i}&keyword=${keyword}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>
</c:if>
