<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Admin Portal</title>
    
    <!-- Google Fonts: Outfit -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --bg-deep: #0B0F19;
            --primary: #6366f1;
            --secondary: #ec4899;
            --accent: #8b5cf6;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --glass-bg: rgba(17, 24, 39, 0.7);
            --glass-border: rgba(255, 255, 255, 0.08);
            --glass-highlight: rgba(255, 255, 255, 0.15);
        }

        body {
            font-family: 'Outfit', sans-serif;
            background-color: var(--bg-deep);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(99, 102, 241, 0.15), transparent 30%),
                radial-gradient(circle at 90% 80%, rgba(236, 72, 153, 0.12), transparent 30%),
                radial-gradient(circle at 50% 50%, rgba(139, 92, 246, 0.1), transparent 40%);
            background-attachment: fixed;
            margin: 0;
            overflow-x: hidden;
        }

        /* Navbar Glass */
        .navbar-custom {
            background: rgba(11, 15, 25, 0.8);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--glass-border);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 1030;
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.5rem;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            letter-spacing: -0.5px;
        }

        .nav-link {
            color: var(--text-muted) !important;
            font-weight: 500;
            padding: 0.5rem 1.2rem !important;
            border-radius: 8px;
            transition: all 0.3s ease;
            position: relative;
        }

        .nav-link:hover, .nav-link.active {
            color: var(--text-main) !important;
            background: var(--glass-highlight);
        }

        /* Glassmorphism Cards */
        .glass-card {
            background: var(--glass-bg);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            transition: transform 0.3s ease, box-shadow 0.3s ease, border-color 0.3s ease;
            overflow: hidden;
        }

        .glass-card:hover {
            border-color: rgba(99, 102, 241, 0.3);
            box-shadow: 0 15px 50px rgba(99, 102, 241, 0.15);
        }

        /* Inputs & Forms */
        .glass-input {
            background: rgba(0, 0, 0, 0.2) !important;
            border: 1px solid var(--glass-border) !important;
            color: var(--text-main) !important;
            border-radius: 12px;
            padding: 0.75rem 1.2rem;
            transition: all 0.3s ease;
        }

        .glass-input:focus {
            background: rgba(0, 0, 0, 0.4) !important;
            border-color: var(--primary) !important;
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.2) !important;
        }

        .glass-input::placeholder {
            color: rgba(255,255,255,0.3);
        }
        
        .form-select.glass-input option {
            background: var(--bg-deep);
            color: var(--text-main);
        }

        /* Buttons */
        .btn-glow {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border: none;
            color: white;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .btn-glow::before {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(135deg, var(--secondary), var(--accent));
            opacity: 0;
            z-index: -1;
            transition: opacity 0.3s ease;
        }

        .btn-glow:hover::before {
            opacity: 1;
        }

        .btn-glow:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(236, 72, 153, 0.4);
            color: white;
        }

        .btn-glass {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--glass-border);
            color: var(--text-main);
            border-radius: 8px;
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        .btn-glass:hover {
            background: rgba(255, 255, 255, 0.15);
            color: white;
            border-color: rgba(255, 255, 255, 0.3);
            transform: translateY(-1px);
        }

        .btn-glass-danger {
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: #fca5a5;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-glass-danger:hover {
            background: rgba(239, 68, 68, 0.8);
            color: white;
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.4);
        }

        /* Tables */
        .table {
            color: var(--text-main);
        }
        
        .table-hover tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.03);
            color: var(--text-main);
        }

        .glass-header th {
            background: rgba(0, 0, 0, 0.3);
            color: var(--text-muted);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1px;
            border-bottom: 1px solid var(--glass-border);
        }

        .glass-row td {
            border-bottom: 1px solid rgba(255,255,255,0.05);
        }
        
        .glass-badge {
            background: rgba(99, 102, 241, 0.2);
            color: #a5b4fc;
            border: 1px solid rgba(99, 102, 241, 0.3);
            padding: 0.4em 0.8em;
            border-radius: 30px;
            font-weight: 500;
        }

        .text-gradient {
            background: linear-gradient(135deg, #fff, #94a3b8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .text-accent {
            color: #34d399; /* Emerald */
        }

        /* Profile Dropdown */
        .profile-avatar {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--primary);
            padding: 2px;
        }

        .dropdown-menu-glass {
            background: rgba(15, 23, 42, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            padding: 0.5rem;
        }

        .dropdown-menu-glass .dropdown-item {
            color: var(--text-main);
            border-radius: 8px;
            transition: all 0.2s;
        }

        .dropdown-menu-glass .dropdown-item:hover {
            background: rgba(239, 68, 68, 0.2);
            color: #fca5a5;
        }

        /* Footer */
        footer {
            margin-top: auto;
            border-top: 1px solid var(--glass-border);
            padding: 1.5rem 0;
            background: rgba(11, 15, 25, 0.5);
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-custom mb-5">
        <div class="container-fluid px-4 px-lg-5">
            <a class="navbar-brand d-flex align-items-center gap-2" href="/">
                <div style="background: linear-gradient(135deg, var(--primary), var(--secondary)); border-radius: 8px; width: 32px; height: 32px; display: flex; align-items: center; justify-content: center;">
                    <i class="fas fa-layer-group text-white fs-6"></i>
                </div>
                NexusShop
            </a>
            
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <i class="fas fa-bars text-white"></i>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mx-auto gap-1">
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/category"><i class="fas fa-tags me-2 opacity-75"></i>Danh Mục</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/product"><i class="fas fa-box-open me-2 opacity-75"></i>Sản Phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/user"><i class="fas fa-users me-2 opacity-75"></i>Người Dùng</a>
                    </li>
                </ul>
                
                <ul class="navbar-nav">
                    <c:if test="${sessionScope.user == null}">
                        <li class="nav-item"><a class="nav-link" href="/login">Đăng nhập</a></li>
                    </c:if>
                    <c:if test="${sessionScope.user != null}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center gap-2" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.avatarUrl}">
                                        <img src="${sessionScope.user.avatarUrl}" class="profile-avatar" alt="Avatar">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-user-circle fs-4 text-primary"></i>
                                    </c:otherwise>
                                </c:choose>
                                <span class="fw-bold">${sessionScope.user.fullName}</span>
                                <span class="badge bg-primary rounded-pill ms-1" style="font-size: 0.65em;">ADMIN</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-glass mt-2">
                                <li>
                                    <a class="dropdown-item py-2 d-flex align-items-center" href="/logout">
                                        <i class="fas fa-sign-out-alt me-2 w-20px text-center"></i>Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container-fluid px-4 px-lg-5 mb-5" style="flex: 1;">
        <!-- Alerts -->
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show glass-card border-success text-success mb-4 py-3" style="background: rgba(16, 185, 129, 0.1);" role="alert">
                <i class="fas fa-check-circle me-2"></i>${message}
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show glass-card border-danger text-danger mb-4 py-3" style="background: rgba(239, 68, 68, 0.1);" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>${error}
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Sitemesh Body Injection -->
        <sitemesh:write property='body'/>
    </div>

    <!-- Footer -->
    <footer>
        <div class="container text-center">
            <p class="mb-0 text-muted" style="font-size: 0.9rem;">
                © 2026 NexusShop Admin Portal. Designed with <i class="fas fa-heart text-danger mx-1"></i> by Minh Ly.
            </p>
        </div>
    </footer>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.min.js"></script>
    <script>
        // Active Nav Link Highlighting
        document.addEventListener('DOMContentLoaded', () => {
            const path = window.location.pathname;
            document.querySelectorAll('.nav-link').forEach(link => {
                if(link.getAttribute('href') && path.startsWith(link.getAttribute('href')) && link.getAttribute('href') !== '/') {
                    link.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>
