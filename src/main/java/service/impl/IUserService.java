
package service.impl;

import model.User;
import java.sql.SQLException; // Import SQLException

public interface IUserService {

    User checkLogin(String username, String password) throws SQLException;
    void addUser(User user) throws SQLException;
    User findUserByUsername(String username) throws SQLException;
}
