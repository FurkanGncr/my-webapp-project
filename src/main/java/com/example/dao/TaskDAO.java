package com.example.dao;

import com.example.model.Task;
import java.sql.*;
import java.util.*;

public class TaskDAO {
    private Connection conn;
    
    private static class SingletonHolder {
        static final TaskDAO INSTANCE = new TaskDAO();
    }
    
    public static TaskDAO getInstance() {
        return SingletonHolder.INSTANCE;
    }
    
    private TaskDAO() {
        try {
            Class.forName("org.sqlite.JDBC");
            String dbPath = "/tmp/tasks.db";
            conn = DriverManager.getConnection("jdbc:sqlite:" + dbPath);
        try (Statement st = conn.createStatement()) {
            st.execute("CREATE TABLE IF NOT EXISTS tasks ("
                    + "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                    + "title TEXT NOT NULL,"
                    + "completed BOOLEAN NOT NULL DEFAULT 0)");
        }
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException("Unable to open database", e);
        }
    }

    public List<Task> findAll() throws SQLException {
        List<Task> list = new ArrayList<>();
        String sql = "SELECT id,title,completed FROM tasks";
        try (Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Task t = new Task(rs.getInt("id"),
                                  rs.getString("title"),
                                  rs.getBoolean("completed"));
                list.add(t);
            }
        }
        return list;
    }

    public Task find(int id) throws SQLException {
        String sql = "SELECT id,title,completed FROM tasks WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                return new Task(rs.getInt("id"),
                                rs.getString("title"),
                                rs.getBoolean("completed"));
            }
        }
    }

    public Task create(Task t) throws SQLException {
        String sql = "INSERT INTO tasks(title,completed) VALUES (?,?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, t.getTitle());
            ps.setBoolean(2, t.isCompleted());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) t.setId(keys.getInt(1));
            }
        }
        return t;
    }

    public boolean update(Task t) throws SQLException {
        String sql = "UPDATE tasks SET title=?,completed=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, t.getTitle());
            ps.setBoolean(2, t.isCompleted());
            ps.setInt(3, t.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM tasks WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }
}
