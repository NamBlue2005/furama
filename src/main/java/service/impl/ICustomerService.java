package service.impl;

import model.Customer;
import java.sql.SQLException; // Import SQLException
import java.util.List;

public interface ICustomerService {

    void addCustomer(Customer customer) throws SQLException;
    List<Customer> findAll();
    boolean isEmailTaken(String email) throws SQLException;
    boolean isPhoneTaken(String phone) throws SQLException;
    boolean isIdCardTaken(String idCard) throws SQLException;

}