<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="fw-bold text-gradient">✨ Product Management</h2>
    <a href="/admin/product/create" class="btn btn-primary btn-glow"><i class="fas fa-plus me-2"></i>Thêm Sản Phẩm</a>
</div>

<div class="glass-card">
    <div class="table-responsive">
        <table class="table table-hover table-borderless align-middle mb-0 text-white">
            <thead class="glass-header">
                <tr>
                    <th class="py-3 px-4 rounded-start">ID</th>
                    <th class="py-3 px-4">Ảnh</th>
                    <th class="py-3 px-4">Tên sản phẩm</th>
                    <th class="py-3 px-4">Danh mục</th>
                    <th class="py-3 px-4">Giá</th>
                    <th class="py-3 px-4 text-end rounded-end">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${products}" var="product">
                    <tr class="glass-row">
                        <td class="px-4 fw-bold">#${product.id}</td>
                        <td class="px-4">
                            <img src="${not empty product.imageUrl ? product.imageUrl : 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?q=80&w=150&auto=format&fit=crop'}" 
                                 class="rounded-circle shadow-sm" style="width: 45px; height: 45px; object-fit: cover;" alt="Img">
                        </td>
                        <td class="px-4 fw-medium">${product.name}</td>
                        <td class="px-4">
                            <span class="badge glass-badge">${not empty product.category ? product.category.name : 'N/A'}</span>
                        </td>
                        <td class="px-4 text-accent fw-bold">
                            <fmt:formatNumber value="${product.price}" pattern="#,###"/> VNĐ
                        </td>
                        <td class="px-4 text-end">
                            <a href="/admin/product/edit/${product.id}" class="btn btn-sm btn-glass me-2"><i class="fas fa-pen-to-square"></i> Sửa</a>
                            <a href="/admin/product/delete/${product.id}" class="btn btn-sm btn-glass-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')"><i class="fas fa-trash"></i> Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty products}">
                    <tr>
                        <td colspan="6" class="text-center py-5 text-muted">Không có sản phẩm nào.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
