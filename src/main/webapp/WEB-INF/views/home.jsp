<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bảng Điều Khiển - Furama Resort</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css"> <%-- Đảm bảo file này tồn tại hoặc xóa nếu không dùng --%>
  <style>
    body { display: flex; flex-direction: column; min-height: 100vh; }
    main { flex: 1; }
    .sidebar { background-color: #f8f9fa; padding-top: 1rem }
    .sidebar .nav-link { color: #333; }
    .sidebar .nav-link.active { color: #0d6efd; font-weight: bold; }
    .sidebar .nav-link:hover { color: #0a58ca; }
    .card-title-icon { font-size: 2.5rem; }
  </style>
</head>
<body>

<jsp:include page="common/header.jsp" />

<div class="container-fluid">
  <div class="row">
    <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse bg-light" id="sidebarMenu">
      <div class="position-sticky pt-3">
        <ul class="nav flex-column">
          <li class="nav-item">
            <a class="nav-link ${empty param.view || param.view == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/">
              <i class="bi bi-house-door-fill me-2"></i>
              Bảng điều khiển
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">
              <i class="bi bi-file-earmark-text-fill me-2"></i>
              Báo cáo
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">
              <i class="bi bi-gear-fill me-2"></i>
              Cài đặt
            </a>
          </li>
        </ul>
      </div>
    </nav>

    <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 pt-3">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2">Bảng điều khiển</h1>
      </div>

      <div class="row">
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-left-primary shadow h-100 py-2">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Khách đang thuê</div>
                  <div class="h5 mb-0 font-weight-bold text-gray-800">${numberOfActiveContracts != null ? numberOfActiveContracts : 'N/A'}</div>
                </div>
                <div class="col-auto">
                  <i class="bi bi-people-fill card-title-icon text-gray-300" style="opacity: 0.7;"></i>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-left-success shadow h-100 py-2">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Dịch vụ sẵn có</div>
                  <div class="h5 mb-0 font-weight-bold text-gray-800">${totalServices != null ? totalServices : 'N/A'}</div>
                </div>
                <div class="col-auto">
                  <i class="bi bi-grid-1x2-fill card-title-icon text-gray-300" style="opacity: 0.7;"></i>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-left-info shadow h-100 py-2">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Nhân viên</div>
                  <div class="h5 mb-0 font-weight-bold text-gray-800">${totalEmployees != null ? totalEmployees : 'N/A'}</div>
                </div>
                <div class="col-auto">
                  <i class="bi bi-person-badge-fill card-title-icon text-gray-300" style="opacity: 0.7;"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
          <div class="card border-left-warning shadow h-100 py-2">
            <div class="card-body">
              <div class="row no-gutters align-items-center">
                <div class="col mr-2">
                  <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                    Doanh thu (Tháng này)</div>
                  <div class="h5 mb-0 font-weight-bold text-gray-800">$0</div>
                </div>
                <div class="col-auto">
                  <i class="bi bi-currency-dollar card-title-icon text-gray-300" style="opacity: 0.7;"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <h2 class="h4 mt-4 mb-3">Truy cập nhanh</h2>
      <div class="d-flex flex-wrap gap-2">
        <a href="${pageContext.request.contextPath}/customer?action=create" class="btn btn-lg btn-outline-primary">
          <i class="bi bi-person-plus-fill me-1"></i> Thêm Khách Hàng
        </a>
        <a href="${pageContext.request.contextPath}/contract?action=create" class="btn btn-lg btn-outline-secondary">
          <i class="bi bi-file-earmark-plus-fill me-1"></i> Tạo Hợp Đồng
        </a>
        <a href="${pageContext.request.contextPath}/employee?action=create" class="btn btn-lg btn-outline-info">
          <i class="bi bi-person-badge me-1"></i> Thêm Nhân Viên
        </a>
      </div>

    </main>
  </div>
</div>

<jsp:include page="common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/static/js/script.js"></script>
</body>
</html>