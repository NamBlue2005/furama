<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/">
      <i class="bi bi-building me-2"></i>Furama Resort
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link ${empty currentPage || currentPage == 'home' ? 'active' : ''}" aria-current="page" href="${pageContext.request.contextPath}/">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${currentPage == 'employee' ? 'active' : ''}" href="${pageContext.request.contextPath}/employee">Employee</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${currentPage == 'customer' ? 'active' : ''}" href="${pageContext.request.contextPath}/customer">Customer</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${currentPage == 'service' ? 'active' : ''}" href="${pageContext.request.contextPath}/service">Service</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${currentPage == 'contract' ? 'active' : ''}" href="${pageContext.request.contextPath}/contract">Contract</a>
        </li>
      </ul>

      <form class="d-flex me-3" role="search" action="${pageContext.request.contextPath}/search" method="get">
        <input class="form-control me-2" type="search" name="query" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>

      <ul class="navbar-nav">
        <c:choose>
          <c:when test="${not empty sessionScope.loggedInUser}">
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarUserDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="bi bi-person-circle me-1"></i>
                <c:out value="${sessionScope.loggedInUser.username}"/>
              </a>
              <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarUserDropdown">
                <li><a class="dropdown-item" href="#">Thông tin tài khoản</a></li>
                <li><hr class="dropdown-divider"></li>
                <li>
                  <form action="${pageContext.request.contextPath}/logout" method="post" class="d-flex">
                    <button type="submit" class="dropdown-item" style="background: none; border: none; padding: 0.25rem 1rem; width: 100%; text-align: left;">
                      <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                    </button>
                  </form>
                </li>
              </ul>
            </li>
          </c:when>
          <c:otherwise>
            <li class="nav-item">
              <a class="nav-link" href="${pageContext.request.contextPath}/login">
                <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
              </a>
            </li>
          </c:otherwise>
        </c:choose>
      </ul>
    </div>
  </div>
</nav>