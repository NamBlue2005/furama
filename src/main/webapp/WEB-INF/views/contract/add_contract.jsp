<%@ page import="model.Customer" %>
<%@ page import="model.Employee" %>
<%@ page import="model.Service" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tạo Hợp Đồng Mới - Furama Resort</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <style>
    .error-messages { list-style-type: none; padding-left: 0; color: red; font-size: 0.9em; }
    label .text-danger { font-size: 0.8em; }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container mt-4 mb-5">
  <h2 class="mb-3">Tạo Hợp Đồng Mới</h2>
  <hr>

  <c:if test="${not empty errors}">
    <div class="alert alert-danger" role="alert">
      <strong>Vui lòng sửa các lỗi sau:</strong>
      <ul class="error-messages mt-2 mb-0">
        <c:forEach var="error" items="${errors}">
          <li><c:out value="${error}"/></li>
        </c:forEach>
      </ul>
    </div>
  </c:if>

  <form action="${pageContext.request.contextPath}/contract?action=create" method="POST" class="needs-validation" novalidate>
    <div class="row g-3">
      <div class="col-md-6">
        <label for="contractStartDate" class="form-label">Ngày Giờ Bắt Đầu <span class="text-danger">*</span></label>
        <input type="datetime-local" class="form-control" id="contractStartDate" name="contractStartDate" value="<c:out value='${startDateValue}'/>" required>
      </div>

      <div class="col-md-6">
        <label for="contractEndDate" class="form-label">Ngày Giờ Kết Thúc <span class="text-danger">*</span></label>
        <input type="datetime-local" class="form-control" id="contractEndDate" name="contractEndDate" value="<c:out value='${endDateValue}'/>" required>
      </div>

      <div class="col-md-6">
        <label for="contractDeposit" class="form-label">Tiền Đặt Cọc ($)</label>
        <input type="number" step="any" min="0" class="form-control" id="contractDeposit" name="contractDeposit" value="${not empty depositValue ? depositValue : '0'}">
      </div>

      <div class="col-md-6">
        <label for="contractTotalMoney" class="form-label">Tổng Tiền ($)</label>
        <input type="number" step="any" min="0" class="form-control" id="contractTotalMoney" name="contractTotalMoney" value="${not empty totalMoneyValue ? totalMoneyValue : '0'}" >
      </div>

      <div class="col-md-4">
        <label for="employeeId" class="form-label">Nhân Viên Lập HĐ <span class="text-danger">*</span></label>
        <select class="form-select" id="employeeId" name="employeeId" required>
          <option value="">-- Chọn nhân viên --</option>
          <c:if test="${not empty employeeList}">
            <c:forEach var="emp" items="${employeeList}">
              <option value="${emp.employeeId}" ${emp.employeeId == selectedEmployeeId ? 'selected' : ''}>
                <c:out value="${emp.employeeName}"/> (ID: ${emp.employeeId})
              </option>
            </c:forEach>
          </c:if>
        </select>
      </div>

      <div class="col-md-4">
        <label for="customerId" class="form-label">Khách Hàng <span class="text-danger">*</span></label>
        <select class="form-select" id="customerId" name="customerId" required>
          <option value="">-- Chọn khách hàng --</option>
          <c:if test="${not empty customerList}">
            <c:forEach var="cus" items="${customerList}">
              <option value="${cus.customerId}" ${cus.customerId == selectedCustomerId ? 'selected' : ''}>
                <c:out value="${cus.customerName}"/> (ID: ${cus.customerId})
              </option>
            </c:forEach>
          </c:if>
        </select>
      </div>

      <div class="col-md-4">
        <label for="serviceId" class="form-label">Dịch Vụ (Villa/House) <span class="text-danger">*</span></label>
        <select class="form-select" id="serviceId" name="serviceId" required>
          <option value="">-- Chọn dịch vụ --</option>
          <c:if test="${not empty serviceList}">
            <c:forEach var="ser" items="${serviceList}">
              <option value="${ser.serviceId}" ${ser.serviceId == selectedServiceId ? 'selected' : ''}>
                <c:out value="${ser.serviceName}"/> (ID: ${ser.serviceId})
              </option>
            </c:forEach>
          </c:if>
        </select>
      </div>
    </div>

    <hr class="my-4">

    <button class="btn btn-primary btn-lg" type="submit">Tạo Hợp Đồng</button>
    <a href="${pageContext.request.contextPath}/contract" class="btn btn-secondary btn-lg">Hủy</a>
  </form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>