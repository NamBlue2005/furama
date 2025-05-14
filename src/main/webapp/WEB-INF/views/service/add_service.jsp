<%@ page import="model.ServiceType" %>
<%@ page import="model.RentType" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Dịch Vụ Mới - Furama Resort</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .error-messages { list-style-type: none; padding-left: 0; color: red; font-size: 0.9em; }
        label .text-danger { font-size: 0.8em; }
        .specific-fields { display: none; }
        .specific-fields.active { display: block; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container mt-4 mb-5">
    <h2 class="mb-3">Thêm Dịch Vụ Mới</h2>
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

    <form action="${pageContext.request.contextPath}/service?action=create" method="POST" class="needs-validation" novalidate>
        <div class="row g-3">
            <div class="col-md-6">
                <label for="serviceName" class="form-label">Tên Dịch Vụ <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="serviceName" name="serviceName" value="<c:out value='${serviceNameValue}'/>" required>
            </div>

            <div class="col-md-6">
                <label for="serviceTypeId" class="form-label">Loại Dịch Vụ <span class="text-danger">*</span></label>
                <select class="form-select" id="serviceTypeId" name="serviceTypeId" required onchange="toggleSpecificFields()">
                    <option value="">-- Chọn loại dịch vụ --</option>
                    <c:if test="${not empty serviceTypeList}">
                        <c:forEach var="type" items="${serviceTypeList}">
                            <option value="${type.serviceTypeId}"
                                ${type.serviceTypeId == selectedServiceTypeId ? 'selected' : ''}
                                    data-type-name="<c:out value='${type.serviceTypeName.toLowerCase()}'/>">
                                <c:out value="${type.serviceTypeName}"/>
                            </option>
                        </c:forEach>
                    </c:if>
                </select>
            </div>

            <div class="col-md-4">
                <label for="serviceArea" class="form-label">Diện tích sử dụng (m²) <span class="text-danger">*</span></label>
                <input type="number" min="1" class="form-control" id="serviceArea" name="serviceArea" value="<c:out value='${serviceAreaValue}'/>" required>
            </div>

            <div class="col-md-4">
                <label for="serviceCost" class="form-label">Chi phí thuê ($) <span class="text-danger">*</span></label>
                <input type="number" step="any" min="0.01" class="form-control" id="serviceCost" name="serviceCost" value="<c:out value='${serviceCostValue}'/>" required>
            </div>

            <div class="col-md-4">
                <label for="serviceMaxPeople" class="form-label">Số người tối đa <span class="text-danger">*</span></label>
                <input type="number" min="1" class="form-control" id="serviceMaxPeople" name="serviceMaxPeople" value="<c:out value='${serviceMaxPeopleValue}'/>" required>
            </div>

            <div class="col-md-6">
                <label for="rentTypeId" class="form-label">Kiểu thuê <span class="text-danger">*</span></label>
                <select class="form-select" id="rentTypeId" name="rentTypeId" required>
                    <option value="">-- Chọn kiểu thuê --</option>
                    <c:if test="${not empty rentTypeList}">
                        <c:forEach var="type" items="${rentTypeList}">
                            <option value="${type.rentTypeId}" ${type.rentTypeId == selectedRentTypeId ? 'selected' : ''}>
                                <c:out value="${type.rentTypeName}"/>
                            </option>
                        </c:forEach>
                    </c:if>
                </select>
            </div>

            <div class="col-md-6 specific-fields villa-fields house-fields">
                <label for="standardRoom" class="form-label">Tiêu chuẩn phòng</label>
                <input type="text" class="form-control" id="standardRoom" name="standardRoom" value="<c:out value='${standardRoomValue}'/>">
            </div>
            <div class="col-md-12 specific-fields villa-fields house-fields">
                <label for="descriptionOtherConvenience" class="form-label">Mô tả tiện nghi khác</label>
                <textarea class="form-control" id="descriptionOtherConvenience" name="descriptionOtherConvenience" rows="2"><c:out value='${descriptionValue}'/></textarea>
            </div>

            <div class="col-md-6 specific-fields villa-fields">
                <label for="poolArea" class="form-label">Diện tích hồ bơi (m²)</label>
                <input type="number" step="any" min="0.01" class="form-control" id="poolArea" name="poolArea" value="<c:out value='${poolAreaValue}'/>">
            </div>

            <div class="col-md-6 specific-fields villa-fields house-fields">
                <label for="numberOfFloors" class="form-label">Số tầng</label>
                <input type="number" min="1" class="form-control" id="numberOfFloors" name="numberOfFloors" value="<c:out value='${numberOfFloorsValue}'/>">
            </div>

            <div class="col-md-12 specific-fields room-fields">
                <label for="freeServiceIncluded" class="form-label">Dịch vụ miễn phí đi kèm</label>
                <textarea class="form-control" id="freeServiceIncluded" name="freeServiceIncluded" rows="2"><c:out value='${freeServiceValue}'/></textarea>
            </div>
        </div>

        <hr class="my-4">

        <button class="btn btn-primary btn-lg" type="submit">Thêm Dịch Vụ</button>
        <a href="${pageContext.request.contextPath}/service" class="btn btn-secondary btn-lg">Hủy</a>
    </form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleSpecificFields() {
        const serviceTypeSelect = document.getElementById('serviceTypeId');
        if (!serviceTypeSelect || serviceTypeSelect.value === "") {
            document.querySelectorAll('.specific-fields').forEach(field => field.classList.remove('active'));
            return;
        }

        const selectedOption = serviceTypeSelect.options[serviceTypeSelect.selectedIndex];
        if (!selectedOption || !selectedOption.hasAttribute('data-type-name')) return;
        const selectedTypeName = selectedOption.getAttribute('data-type-name');

        const allSpecificFields = document.querySelectorAll('.specific-fields');
        allSpecificFields.forEach(field => field.classList.remove('active'));

        if (selectedTypeName === 'villa') {
            document.querySelectorAll('.villa-fields').forEach(field => field.classList.add('active'));
            document.querySelectorAll('.house-fields').forEach(field => field.classList.add('active'));
        } else if (selectedTypeName === 'house') {
            document.querySelectorAll('.house-fields').forEach(field => field.classList.add('active'));
        } else if (selectedTypeName === 'room') {
            document.querySelectorAll('.room-fields').forEach(field => field.classList.add('active'));
        }
    }
    document.addEventListener('DOMContentLoaded', toggleSpecificFields);
</script>
</body>
</html>