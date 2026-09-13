<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="fw-bold text-gradient">✨ ${userObj.id == null ? 'Thêm Người Dùng' : 'Cập Nhật Người Dùng'}</h2>
    <a href="/admin/user" class="btn btn-outline-light btn-glass"><i class="fas fa-arrow-left me-2"></i>Quay Lại</a>
</div>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="glass-card p-5">
            <form action="${userObj.id == null ? '/admin/user/create' : '/admin/user/edit/'.concat(userObj.id)}" method="post">
                <div class="row mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Họ và Tên <span class="text-danger">*</span></label>
                        <input type="text" name="fullName" class="form-control glass-input" value="${userObj.fullName}" required placeholder="Nguyễn Văn A">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Email <span class="text-danger">*</span></label>
                        <input type="email" name="email" class="form-control glass-input" value="${userObj.email}" required placeholder="email@example.com">
                    </div>
                </div>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Số điện thoại</label>
                        <input type="text" name="phone" class="form-control glass-input" value="${userObj.phone}" placeholder="0987654321">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold">Quyền hạn (Role)</label>
                        <select name="role" class="form-select glass-input">
                            <option value="USER" ${userObj.role == 'USER' ? 'selected' : ''}>USER (Khách hàng)</option>
                            <option value="ADMIN" ${userObj.role == 'ADMIN' ? 'selected' : ''}>ADMIN (Quản trị viên)</option>
                        </select>
                    </div>
                </div>
                
                <c:if test="${userObj.id == null}">
                    <div class="mb-4">
                        <label class="form-label fw-bold">Mật khẩu <span class="text-danger">*</span></label>
                        <input type="password" name="password" class="form-control glass-input" required placeholder="********">
                    </div>
                </c:if>

                <div class="mb-5">
                    <div class="form-check form-switch mt-2">
                        <input type="hidden" name="_active" value="on"/>
                        <input class="form-check-input" type="checkbox" name="active" id="activeCheck" value="true" ${userObj.active ? 'checked' : ''} style="width: 2.5em; height: 1.2em;">
                        <label class="form-check-label ms-2 mt-1 fw-bold text-accent" for="activeCheck">Tài khoản Hoạt Động (Kích hoạt)</label>
                    </div>
                </div>

                <div class="d-flex gap-3">
                    <button type="submit" class="btn btn-primary btn-glow px-4 py-2">
                        <i class="fas fa-save me-2"></i> LƯU NGƯỜI DÙNG
                    </button>
                    <button type="reset" class="btn btn-outline-light btn-glass px-4 py-2">
                        <i class="fas fa-undo me-2"></i> LÀM LẠI
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
