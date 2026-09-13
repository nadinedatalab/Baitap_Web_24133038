<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="fw-bold text-gradient">✨ ${category.id == null ? 'Thêm Danh Mục Mới' : 'Cập Nhật Danh Mục'}</h2>
    <a href="/admin/category" class="btn btn-outline-light btn-glass"><i class="fas fa-arrow-left me-2"></i>Quay Lại</a>
</div>

<div class="row justify-content-center">
    <div class="col-lg-6">
        <div class="glass-card p-5">
            <form action="${category.id == null ? '/admin/category/create' : '/admin/category/edit/'.concat(category.id)}" method="post">
                <div class="mb-4">
                    <label class="form-label fw-bold">Tên Danh Mục <span class="text-danger">*</span></label>
                    <input type="text" name="name" class="form-control glass-input" value="${category.name}" required placeholder="Nhập tên danh mục...">
                </div>

                <div class="d-flex gap-3">
                    <button type="submit" class="btn btn-primary btn-glow px-4 py-2">
                        <i class="fas fa-save me-2"></i> LƯU DANH MỤC
                    </button>
                    <button type="reset" class="btn btn-outline-light btn-glass px-4 py-2">
                        <i class="fas fa-undo me-2"></i> LÀM LẠI
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
