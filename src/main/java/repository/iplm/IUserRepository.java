
package repository.iplm;

import model.User;
import java.sql.SQLException;

public interface IUserRepository {

    User findByUsername(String username) throws SQLException;

    void save(User user) throws SQLException;
}
