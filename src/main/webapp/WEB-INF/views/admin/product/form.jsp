<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="fw-bold text-gradient">✨ ${product.id == null ? 'Thêm Sản Phẩm Mới' : 'Cập Nhật Sản Phẩm'}</h2>
    <a href="/admin/product" class="btn btn-outline-light btn-glass"><i class="fas fa-arrow-left me-2"></i>Quay Lại</a>
</div>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="glass-card p-5">
            <form action="${product.id == null ? '/admin/product/create' : '/admin/product/edit/'.concat(product.id)}" method="post">
                <div class="row mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Tên Sản Phẩm <span class="text-danger">*</span></label>
                        <input type="text" name="name" class="form-control glass-input" value="${product.name}" required placeholder="Nhập tên sản phẩm...">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Giá (VNĐ) <span class="text-danger">*</span></label>
                        <input type="number" name="price" class="form-control glass-input" value="${product.price}" required placeholder="Ví dụ: 1500000">
                    </div>
                </div>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Danh Mục <span class="text-danger">*</span></label>
                        <select name="category.id" class="form-select glass-input" required>
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach items="${categories}" var="cat">
                                <option value="${cat.id}" ${product.category != null && product.category.id == cat.id ? 'selected' : ''}>${cat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Link Ảnh (URL)</label>
                        <input type="text" name="imageUrl" class="form-control glass-input" value="${product.imageUrl}" placeholder="https://example.com/image.jpg">
                    </div>
                </div>

                <div class="mb-5">
                    <label class="form-label fw-bold">Mô Tả Sản Phẩm</label>
                    <textarea name="description" class="form-control glass-input" rows="4" placeholder="Mô tả chi tiết sản phẩm...">${product.description}</textarea>
                </div>

                <div class="d-flex gap-3">
                    <button type="submit" class="btn btn-primary btn-glow px-4 py-2">
                        <i class="fas fa-save me-2"></i> LƯU SẢN PHẨM
                    </button>
                    <button type="reset" class="btn btn-outline-light btn-glass px-4 py-2">
                        <i class="fas fa-undo me-2"></i> LÀM LẠI
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
