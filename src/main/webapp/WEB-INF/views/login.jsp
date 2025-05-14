<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Furama Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            background-color: #f0f2f5;
        }
        .login-container {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 1.5rem;
        }
        .login-card {
            max-width: 450px;
            width: 100%;
            border: none;
            border-radius: 0.75rem;
        }
        .login-card .card-body {
            padding: 2.5rem;
        }
        .login-logo img {
            max-width: 100px;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="card shadow-lg login-card">
        <div class="card-body">
            <div class="text-center login-logo">

                <img src="${pageContext.request.contextPath}/static/images/furama_logo_placeholder.png" alt="Furama Resort Logo">
            </div>
            <h3 class="card-title text-center mb-4">Đăng Nhập Hệ Thống</h3>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> <c:out value="${errorMessage}"/>
                </div>
            </c:if>
            <c:if test="${param.logout == 'success'}">
                <div class="alert alert-success" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i> Bạn đã đăng xuất thành công.
                </div>
            </c:if>


            <form action="${pageContext.request.contextPath}/login" method="POST">
                <div class="mb-3">
                    <label for="username" class="form-label">Tên đăng nhập:</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                        <input type="text" class="form-control form-control-lg" id="username" name="username" placeholder="Nhập tên đăng nhập"
                               value="<c:out value='${cookieUsername}'/>" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Mật khẩu:</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                        <input type="password" class="form-control form-control-lg" id="password" name="password" placeholder="Nhập mật khẩu" required>
                    </div>
                </div>

                <div class="form-check mb-4">
                    <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe"
                           value="true" ${not empty cookieRememberMe && cookieRememberMe ? 'checked' : ''}>
                    <label class="form-check-label" for="rememberMe">
                        Ghi nhớ đăng nhập
                    </label>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary btn-lg">Đăng Nhập</button>
                </div>
            </form>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>