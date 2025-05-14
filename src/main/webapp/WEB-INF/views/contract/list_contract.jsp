<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Danh Sách Hợp Đồng - Furama Resort</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <style>
    .action-buttons a, .action-buttons button { margin-right: 5px; }
    .table-responsive { overflow-x: auto; }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container mt-4">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h2>Danh Sách Hợp Đồng</h2>
    <div>
      <a href="${pageContext.request.contextPath}/contract?action=create" class="btn btn-primary">
        <i class="bi bi-file-earmark-plus-fill me-1"></i> Tạo Hợp Đồng Mới
      </a>
      <a href="${pageContext.request.contextPath}/contract-detail?action=create" class="btn btn-info">
        <i class="bi bi-plus-circle-fill me-1"></i> Thêm DV Đi Kèm
      </a>
    </div>
  </div>
  <hr>

  <c:if test="${not empty message}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
      <c:out value="${message}"/>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
  </c:if>
  <c:if test="${not empty errorMessage}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
      <c:out value="${errorMessage}"/>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
  </c:if>

  <div class="table-responsive">
    <table class="table table-bordered table-striped table-hover">
      <thead class="table-dark">
      <tr>
        <th>ID HĐ</th>
        <th>Ngày Bắt Đầu</th>
        <th>Ngày Kết Thúc</th>
        <th>Tiền Cọc</th>
        <th>Tổng Tiền</th>
        <th>Nhân Viên</th>
        <th>Khách Hàng</th>
        <th>Dịch Vụ</th>
        <th>Hành Động</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="contract" items="${contractList}">
        <tr>
          <td><c:out value="HD-${contract.contractId}"/></td>
          <td><fmt:formatDate value="${contract.contractStartDateAsDate}" pattern="dd/MM/yyyy HH:mm"/></td>
          <td><fmt:formatDate value="${contract.contractEndDateAsDate}" pattern="dd/MM/yyyy HH:mm"/></td>
          <td><fmt:formatNumber value="${contract.contractDeposit}" type="currency" currencyCode="USD" /></td>
          <td><fmt:formatNumber value="${contract.contractTotalMoney}" type="currency" currencyCode="USD" /></td>
          <td><c:out value="${employeeMap[contract.employeeId].employeeName}"/> (NV-${contract.employeeId})</td>
          <td><c:out value="${customerMap[contract.customerId].customerName}"/> (KH-${contract.customerId})</td>
          <td><c:out value="${serviceMap[contract.serviceId].serviceName}"/> (DV-${contract.serviceId})</td>
          <td class="action-buttons">
            <a href="${pageContext.request.contextPath}/contract?action=edit&id=${contract.contractId}" class="btn btn-warning btn-sm" title="Sửa">
              <i class="bi bi-pencil-square"></i>
            </a>
            <button class="btn btn-danger btn-sm" title="Xóa"
                    onclick="confirmDeleteContract('${contract.contractId}')">
              <i class="bi bi-trash3-fill"></i>
            </button>
          </td>
        </tr>
      </c:forEach>
      <c:if test="${empty contractList}">
        <tr>
          <td colspan="9" class="text-center">Không có dữ liệu hợp đồng.</td>
        </tr>
      </c:if>
      </tbody>
    </table>
  </div>

</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  function confirmDeleteContract(id) {
    if (confirm("Bạn có chắc chắn muốn xóa hợp đồng ID: " + id + " không? \n(Lưu ý: Đây chỉ là xóa hiển thị trên trình duyệt theo yêu cầu 3)")) {
      console.log("Đã xóa hiển thị dòng của hợp đồng ID: " + id);
    }
  }
</script>
</body>
</html>