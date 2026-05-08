package dao;

import model.Account;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AccountDAO {

	public Account login(String username, String password) {

		Account acc = null;

		try {

			Connection conn = DBConnection.getConnection();

			String sql = "SELECT * FROM account WHERE username=? AND password=?";

			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, username);
			ps.setString(2, password);

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {

				acc = new Account();

				acc.setId(rs.getInt("id"));
				acc.setUsername(rs.getString("username"));
				acc.setPassword(rs.getString("password"));
				acc.setRole(rs.getString("role"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return acc;
	}

	public int create(String username, String password, String role) {

		int id = 0;

		String sql = "INSERT INTO account(username,password,role) VALUES(?,?,?)";

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

			ps.setString(1, username);
			ps.setString(2, password);
			ps.setString(3, role);

			ps.executeUpdate();

			ResultSet rs = ps.getGeneratedKeys();

			if (rs.next()) {
				id = rs.getInt(1);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return id;
	}

	public boolean changePassword(int accountId, String oldPass, String newPass) {

		String checkSql = "SELECT * FROM account WHERE id=? AND password=?";
		String updateSql = "UPDATE account SET password=? WHERE id=?";

		try (Connection conn = DBConnection.getConnection()) {

			PreparedStatement check = conn.prepareStatement(checkSql);
			check.setInt(1, accountId);
			check.setString(2, oldPass);

			ResultSet rs = check.executeQuery();

			if (rs.next()) {

				PreparedStatement update = conn.prepareStatement(updateSql);
				update.setString(1, newPass);
				update.setInt(2, accountId);

				update.executeUpdate();

				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public void changePassword(int accountId, String newPassword) {

		String sql = "UPDATE account SET password=? WHERE id=?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, newPassword);
			ps.setInt(2, accountId);

			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<Account> getAll() {

		List<Account> list = new ArrayList<>();

		String sql = "SELECT * FROM account";

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				list.add(new Account(rs.getInt("id"), rs.getString("username"), rs.getString("password"),
						rs.getString("role")));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public Account getById(int id) {

		String sql = "SELECT * FROM account WHERE id=?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				return new Account(rs.getInt("id"), rs.getString("username"), rs.getString("password"),
						rs.getString("role"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public void insert(Account a) {
		if (existsByUsername(a.getUsername()) == false) {
			String sql = "INSERT INTO account(username,password,role) VALUES(?,?,?)";

			try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

				ps.setString(1, a.getUsername());
				ps.setString(2, a.getPassword());
				ps.setString(3, a.getRole());

				ps.executeUpdate();

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void update(Account a) {

		String sql = "UPDATE account SET username=?,password=?,role=? WHERE id=?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, a.getUsername());
			ps.setString(2, a.getPassword());
			ps.setString(3, a.getRole());
			ps.setInt(4, a.getId());

			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void delete(int id) {

		String sql = "DELETE FROM account WHERE id=?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, id);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<Account> search(String keyword) {

		List<Account> list = new ArrayList<>();

		String sql = "SELECT * FROM account WHERE username LIKE ? OR role LIKE ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, "%" + keyword + "%");
			ps.setString(2, "%" + keyword + "%");

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(new Account(rs.getInt("id"), rs.getString("username"), rs.getString("password"),
						rs.getString("role")));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean existsByUsername(String username) {
		String sql = "SELECT 1 FROM account WHERE username = ? LIMIT 1";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			return rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

}
