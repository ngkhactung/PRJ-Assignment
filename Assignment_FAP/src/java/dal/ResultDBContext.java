/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Course;
import entity.Result;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Types;

/**
 *
 * @author Admin
 */
public class ResultDBContext extends DBContext {

    //Get the result record of a course of a student
    public Result getResultByStudentCourse(String studentID, int courseID) {
        Result result = new Result();
        try {
            String sql = "select r.Average, r.Status, r.Comment\n"
                    + "from Result r\n"
                    + "where r.StudentID = ? and r.CourseID = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, studentID);
            stm.setInt(2, courseID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {

                if (rs.getObject("Average") != null) {
                    result.setAverage(rs.getFloat("Average"));
                }
                result.setStatus(rs.getString("Status"));
                result.setComment(rs.getString("Comment"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(ResultDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    //Get all course result records for all courses for a student
    public ArrayList<Result> getAllResultsOfStudent(String studentID) {
        ArrayList<Result> resultList = new ArrayList<>();
        try {
            String sql = "select c.Code, c.PreRequisite, c.ReplacedCourse, c.Name, c.Credits, r.Average, r.Status\n"
                    + "from Student stu inner join EnrollMent e on e.StudentID = stu.ID\n"
                    + "                 inner join Groups g on g.ID = e.GroupID\n"
                    + "                 inner join Course c on g.CourseID = c.ID\n"
                    + "                 left join Result r on stu.ID = r.StudentID and c.ID = r.CourseID\n"
                    + "where stu.ID = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, studentID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Result result = new Result();

                Course course = new Course();
                course.setCode(rs.getString("Code"));
                course.setPreRequisite(rs.getString("PreRequisite"));
                course.setReplacedCourse(rs.getString("ReplacedCourse"));
                course.setName(rs.getString("Name"));
                course.setCredit(rs.getInt("Credits"));
                result.setCourse(course);

                if (rs.getObject("Average") != null) {
                    result.setAverage(rs.getFloat("Average"));
                }

                result.setStatus(rs.getString("Status"));

                resultList.add(result);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ResultDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return resultList;
    }

    //Delete all result course records of a student, 
    //then re-insert the result course records of that student
    public void setResultIntoTable(ArrayList<Result> resultList) {
        try {
            connection.setAutoCommit(false);
            String sql_delete_result = "Delete from Result\n"
                    + "where StudentID = ?";
            PreparedStatement delete = connection.prepareStatement(sql_delete_result);
            delete.setString(1, resultList.get(0).getStudent().getId());
            delete.executeUpdate();

            for (Result result : resultList) {
                String sql_insert_result = "Insert into Result(StudentID, CourseID, Average, Status, Comment)\n"
                        + "Values (?, ?, ?, ?, ?)";
                PreparedStatement insert = connection.prepareStatement(sql_insert_result);
                insert.setString(1, result.getStudent().getId());
                insert.setInt(2, result.getCourse().getId());
                if (result.getAverage() != null) {
                    insert.setFloat(3, result.getAverage());
                } else {
                    insert.setNull(3, Types.FLOAT);
                }
                insert.setString(4, result.getStatus());
                insert.setString(5, result.getComment());
                insert.executeUpdate();
            }

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
