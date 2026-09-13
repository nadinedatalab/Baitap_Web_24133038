<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="fw-bold text-gradient">✨ Category Management</h2>
    <a href="/admin/category/create" class="btn btn-primary btn-glow"><i class="fas fa-plus me-2"></i>Thêm Danh Mục</a>
</div>

<div class="glass-card mb-4 p-4">
    <form action="/admin/category" method="get" class="d-flex gap-2">
        <input type="text" name="keyword" class="form-control glass-input flex-grow-1" placeholder="Tìm kiếm danh mục..." value="${keyword}">
        <button type="submit" class="btn btn-primary btn-glow px-4"><i class="fas fa-search me-2"></i>Tìm</button>
    </form>
</div>

<div class="glass-card">
    <div class="table-responsive">
        <table class="table table-hover table-borderless align-middle mb-0 text-white">
            <thead class="glass-header">
                <tr>
                    <th class="py-3 px-4 rounded-start">ID</th>
                    <th class="py-3 px-4">Tên Danh Mục</th>
                    <th class="py-3 px-4 text-end rounded-end">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${categories}" var="cat">
                    <tr class="glass-row">
                        <td class="px-4 fw-bold">#${cat.id}</td>
                        <td class="px-4 fw-medium text-accent">${cat.name}</td>
                        <td class="px-4 text-end">
                            <a href="/admin/category/edit/${cat.id}" class="btn btn-sm btn-glass me-2"><i class="fas fa-pen-to-square"></i> Sửa</a>
                            <a href="/admin/category/delete/${cat.id}" class="btn btn-sm btn-glass-danger" onclick="return confirm('Xóa danh mục này?')"><i class="fas fa-trash"></i> Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty categories}">
                    <tr>
                        <td colspan="3" class="text-center py-5 text-muted">Không có danh mục nào.</td>
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
                    <a class="page-link glass-input" href="/admin/category?page=${i}&keyword=${keyword}">${i}</a>
                </li>
            </c:forEach>
        </ul>
    </nav>
</c:if>
