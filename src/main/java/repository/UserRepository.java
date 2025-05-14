package repository;

import connect.DatabaseConnection;
import model.User;
import repository.iplm.IUserRepository;

import java.sql.*;


public class UserRepository implements IUserRepository {

    private static final String SELECT_USER_BY_USERNAME = "SELECT username, password FROM user WHERE username = ?;";
    private static final String INSERT_USER_SQL = "INSERT INTO user (username, password) VALUES (?, ?);";

    @Override
    public User findByUsername(String username) throws SQLException {
        User user = null;
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_USERNAME)) {

            preparedStatement.setString(1, username);
            System.out.println("Executing: " + preparedStatement);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    String foundUsername = rs.getString("username");
                    String foundPassword = rs.getString("password");
                    user = new User(foundUsername, foundPassword);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi truy vấn user: " + e.getMessage());
            throw e;
        }
        return user;
    }
    @Override
    public void save(User user) throws SQLException {
        System.out.println("Executing INSERT User: " + INSERT_USER_SQL);
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = DatabaseConnection.getConnection();
            ps = connection.prepareStatement(INSERT_USER_SQL);

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());

            System.out.println("Executing PreparedStatement: " + ps);
            ps.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Lỗi SQL khi thêm user: " + e.getMessage() + " (Error Code: " + e.getErrorCode() + ")");
            throw e;
        } finally {
            closeResources(null, ps, connection);
        }
    }

    private void closeResources(ResultSet rs, PreparedStatement ps, Connection conn) {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
}