/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Result;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class ResultDBContext extends DBContext {

    public void setResultIntoTable(String studentID, int courseID, Result result) {
        try {
            connection.setAutoCommit(false);
            String sql_delete_result = "Delete from Result\n"
                    + "where StudentID = ? and CourseID = ?";
            PreparedStatement delete = connection.prepareStatement(sql_delete_result);
            delete.setString(1, studentID);
            delete.setInt(2, courseID);
            delete.executeUpdate();

            String sql_insert_result = "Insert into Result(StudentID, CourseID, Average, Status, Comment)\n"
                    + "Values (?, ?, ?, ?, ?)";
            PreparedStatement insert = connection.prepareStatement(sql_insert_result);
            insert.setString(1, studentID);
            insert.setInt(2, courseID);
            insert.setFloat(3, result.getAverage());
            insert.setString(4, result.getStatus());
            insert.setString(5, result.getComment());
            insert.executeUpdate();
            
            connection.commit();
        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(ResultDBContext.class.getName()).log(Level.SEVERE, null, ex1);
            }
            Logger.getLogger(ResultDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(ResultDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
