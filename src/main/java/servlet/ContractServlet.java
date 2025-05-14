package servlet;

import common.ValidationUtil;
import model.Contract;
import model.Customer;
import model.Employee;
import model.Service;
import repository.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "ContractServlet", urlPatterns = "/contract")
public class ContractServlet extends HttpServlet {

    private ContractRepository contractRepository = new ContractRepository();
    private CustomerRepository customerRepository = new CustomerRepository();
    private EmployeeRepositoryImpl employeeRepository = new EmployeeRepositoryImpl();
    private ServiceRepository serviceRepository = new ServiceRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "create":
                    showNewContractForm(request, response);
                    break;
                case "list":
                    listContracts(request, response);
                    break;
                default:
                    listContracts(request, response);
                    break;
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in ContractServlet doGet: " + e.getMessage());
            throw new ServletException("Database error occurred.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            listContractsWithError(request, response, "Hành động không hợp lệ.");
            return;
        }

        try {
            switch (action) {
                case "create":
                    insertContract(request, response);
                    break;
                default:
                    listContractsWithError(request, response, "Hành động không hợp lệ.");
                    break;
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in ContractServlet doPost: " + e.getMessage());
            List<String> errors = new ArrayList<>();
            errors.add("Lỗi hệ thống CSDL, không thể thực hiện thao tác.");
            if ("create".equals(action)) {
                try {
                    forwardToFormWithError(request, response, errors, null);
                } catch (SQLException ex) {
                    throw new RuntimeException(ex);
                }
            } else {
                listContractsWithError(request, response, "Lỗi hệ thống CSDL.");
            }
        } catch (Exception e) {
            System.err.println("Unexpected Error in ContractServlet doPost: " + e.getMessage());
            throw new ServletException("Lỗi hệ thống không mong muốn.", e);
        }
    }

    private void listContracts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Contract> contractList = contractRepository.findAll();
        request.setAttribute("contractList", contractList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/contract/list_contract.jsp");
        dispatcher.forward(request, response);
    }

    private void listContractsWithError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        try {
            List<Contract> contractList = contractRepository.findAll();
            request.setAttribute("contractList", contractList);
            request.setAttribute("errorMessage", message);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/contract/list_contract.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e){
            throw new ServletException("Không thể lấy danh sách hợp đồng", e);
        }
    }

    private void showNewContractForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Customer> customerList = customerRepository.findAll();
        List<Employee> employeeList = employeeRepository.findAll();
        List<Service> allServiceList = serviceRepository.findAll();

        List<Service> filteredServiceList = allServiceList.stream()
                .filter(s -> s.getServiceTypeId() == 2 || s.getServiceTypeId() == 3)
                .collect(Collectors.toList());

        request.setAttribute("customerList", customerList);
        request.setAttribute("employeeList", employeeList);
        request.setAttribute("serviceList", filteredServiceList);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/contract/add_contract.jsp");
        dispatcher.forward(request, response);
    }

    private void insertContract(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String startDateStr = request.getParameter("contractStartDate");
        String endDateStr = request.getParameter("contractEndDate");
        String depositStr = request.getParameter("contractDeposit");
        String totalMoneyStr = request.getParameter("contractTotalMoney");
        String employeeIdStr = request.getParameter("employeeId");
        String customerIdStr = request.getParameter("customerId");
        String serviceIdStr = request.getParameter("serviceId");

        List<String> errors = new ArrayList<>();
        LocalDateTime startDate = null;
        LocalDateTime endDate = null;
        double deposit = 0;
        double totalMoney = 0;
        int employeeId = -1;
        int customerId = -1;
        int serviceId = -1;

        DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
        try {
            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = LocalDateTime.parse(startDateStr, formatter);
            } else {
                errors.add("Ngày bắt đầu không được để trống.");
            }
        } catch (DateTimeParseException e) {
            errors.add("Định dạng ngày bắt đầu không hợp lệ.");
        }
        try {
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = LocalDateTime.parse(endDateStr, formatter);
            } else {
                errors.add("Ngày kết thúc không được để trống.");
            }
        } catch (DateTimeParseException e) {
            errors.add("Định dạng ngày kết thúc không hợp lệ.");
        }

        if (startDate != null && endDate != null && endDate.isBefore(startDate)) {
            errors.add("Ngày kết thúc phải sau hoặc bằng ngày bắt đầu.");
        }

        if (depositStr != null && !depositStr.trim().isEmpty()) {
            if (!ValidationUtil.isPositiveDouble(depositStr)) errors.add("Tiền đặt cọc phải là số không âm."); else deposit = Double.parseDouble(depositStr);
        }
        if (totalMoneyStr != null && !totalMoneyStr.trim().isEmpty()) {
            if (!ValidationUtil.isPositiveDouble(totalMoneyStr)) errors.add("Tổng tiền phải là số không âm."); else totalMoney = Double.parseDouble(totalMoneyStr);
        }

        try { employeeId = Integer.parseInt(employeeIdStr); if(employeeId <= 0) errors.add("Vui lòng chọn nhân viên."); } catch (NumberFormatException | NullPointerException e) { errors.add("Nhân viên không hợp lệ."); }
        try { customerId = Integer.parseInt(customerIdStr); if(customerId <= 0) errors.add("Vui lòng chọn khách hàng."); } catch (NumberFormatException | NullPointerException e) { errors.add("Khách hàng không hợp lệ."); }
        try { serviceId = Integer.parseInt(serviceIdStr); if(serviceId <= 0) errors.add("Vui lòng chọn dịch vụ."); } catch (NumberFormatException | NullPointerException e) { errors.add("Dịch vụ không hợp lệ."); }

        if (!errors.isEmpty()) {
            forwardToFormWithError(request, response, errors, null);
        } else {
            Contract newContract = new Contract();
            newContract.setContractStartDate(startDate);
            newContract.setContractEndDate(endDate);
            newContract.setContractDeposit(deposit);
            newContract.setContractTotalMoney(totalMoney);
            newContract.setEmployeeId(employeeId);
            newContract.setCustomerId(customerId);
            newContract.setServiceId(serviceId);

            try {
                contractRepository.save(newContract);
                response.sendRedirect(request.getContextPath() + "/contract?action=list&message=add_success");
            } catch (SQLException e) {
                System.err.println("SQL Error during contract insert: " + e.getMessage());
                errors.add("Lỗi hệ thống khi lưu hợp đồng. Vui lòng kiểm tra lại thông tin Khách hàng, Nhân viên, Dịch vụ.");
                forwardToFormWithError(request, response, errors, newContract);
            }
        }
    }

    private void forwardToFormWithError(HttpServletRequest request, HttpServletResponse response, List<String> errors, Contract contract)
            throws ServletException, IOException, SQLException {
        request.setAttribute("errors", errors);
        request.setAttribute("customerList", customerRepository.findAll());
        request.setAttribute("employeeList", employeeRepository.findAll());
        List<Service> allServiceList = serviceRepository.findAll();
        List<Service> filteredServiceList = allServiceList.stream()
                .filter(s -> s.getServiceTypeId() == 2 || s.getServiceTypeId() == 3)
                .collect(Collectors.toList());
        request.setAttribute("serviceList", filteredServiceList);

        if (contract != null) {
            request.setAttribute("contractValue", contract);
        } else {
            request.setAttribute("startDateValue", request.getParameter("contractStartDate"));
            request.setAttribute("endDateValue", request.getParameter("contractEndDate"));
            request.setAttribute("depositValue", request.getParameter("contractDeposit"));
            request.setAttribute("totalMoneyValue", request.getParameter("contractTotalMoney"));
            request.setAttribute("employeeIdValue", request.getParameter("employeeId"));
            request.setAttribute("customerIdValue", request.getParameter("customerId"));
            request.setAttribute("serviceIdValue", request.getParameter("serviceId"));
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/contract/add_contract.jsp");
        dispatcher.forward(request, response);
    }
}