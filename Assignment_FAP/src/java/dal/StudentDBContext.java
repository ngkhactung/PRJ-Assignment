/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Student;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Date;

/**
 *
 * @author Admin
 */
public class StudentDBContext extends DBContext {

    //Get list of student to display as a result of instructor's searching 
    public ArrayList<Student> getStudentsBySearch(String studentID, String name,
            Boolean gender, Date from, Date to, String groupName) {
        ArrayList<Student> studentList = new ArrayList<>();
        try {
            String sql = "Select DISTINCT s.ID, s.Name, s.Image, s.Gender, s.DoB\n"
                    + "from Student s inner join EnrollMent e on s.ID = e.StudentID\n"
                    + "		     inner join Groups g on e.GroupID = g.ID\n"
                    + "where 1 = 1 ";
            int count = 0;
            if (!studentID.isEmpty()) {
                sql += "and s.id = ? ";
                count++;
            }
            if (!name.isEmpty()) {
                sql += "and s.Name like ? ";
                count++;
            }
            if (gender != null) {
                sql += "and s.Gender = ? ";
                count++;
            }
            if (from != null) {
                sql += "and s.DoB >= ? ";
                count++;
            }
            if (to != null) {
                sql += "and s.DoB <= ? ";
                count++;
            }
            if (!groupName.isEmpty()) {
                sql += "and g.Name = ? ";
                count++;
            }
            PreparedStatement stm = connection.prepareStatement(sql);
            if (!groupName.isEmpty()) {
                stm.setString(count--, groupName);
            }
            if (to != null) {
                stm.setDate(count--, to);
            }
            if (from != null) {
                stm.setDate(count--, from);
            }
            if (gender != null) {
                stm.setBoolean(count--, gender);
            }
            if (!name.isEmpty()) {
                stm.setString(count--, "%" + name + "%");
            }
            if (!studentID.isEmpty()) {
                stm.setString(count--, studentID);
            }
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Student student = new Student();

                student.setId(rs.getString("ID"));
                student.setName(rs.getString("Name"));
                student.setImage(rs.getString("Image"));
                student.setDob(rs.getDate("DoB"));
                student.setGender(rs.getBoolean("Gender"));

                studentList.add(student);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return studentList;
    }

    //Get all informations of a student by student id
    public Student getStudent(String studentID) {
        Student student = new Student();
        try {
            String sql = "Select s.ID, s.Name, s.Gender, s.DoB, s.Phone, s.Email, s.Address, s.Image\n"
                    + "from Student s\n"
                    + "where s.ID = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, studentID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                student.setId(rs.getString("ID"));
                student.setName(rs.getString("Name"));
                student.setGender(rs.getBoolean("Gender"));
                student.setDob(rs.getDate("DoB"));
                student.setPhone(rs.getString("Phone"));
                student.setEmail(rs.getString("Email"));
                student.setAddress(rs.getString("Address"));
                student.setImage(rs.getString("Image"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return student;
    }
}
