/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Course;
import entity.Group;
import entity.Student;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class GroupDBContext extends DBContext {

    public Group getGroupBySession(int sessionID) {
        Group group = new Group();
        try {
            String sql = "select s.GroupID, stu.ID as StudentID, stu.Name, stu.Image, stu.Email\n"
                    + "from [Session] s inner join EnrollMent e on s.GroupID = e.GroupID\n"
                    + "                 inner join Student stu on e.StudentID = stu.ID\n"
                    + "where s.ID = '1'";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Student student = new Student();

                student.setId(rs.getString("StudentID"));
                student.setName(rs.getString("Name"));
                student.setImage(rs.getString("Image"));
                student.setEmail(rs.getString("Email"));

                group.getStudents().add(student);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return group;
    }

    public ArrayList<Group> getGroupsByStudent(String studentID) {
            ArrayList<Group> groupList = new ArrayList<>();
        try {
            String sql = "select g.ID , g.Name, c.ID as CourseID, c.Code, c.Name as CourseName\n"
                    + "from Student stu inner join EnrollMent e on stu.ID = e.StudentID\n"
                    + "                 inner join Groups g on e.GroupID = g.ID\n"
                    + "                 inner join Course c on g.CourseID = c.ID\n"
                    + "where stu.ID = ?";
                PreparedStatement stm = connection.prepareStatement(sql);
                stm.setString(1, studentID);
                ResultSet rs = stm.executeQuery();
                while(rs.next()){
                    Group group = new Group();
                    
                    group.setId(rs.getInt("ID"));
                    group.setName(rs.getString("Name"));
                    
                    Course course = new Course();
                    course.setId(rs.getInt("CourseID"));
                    course.setCode(rs.getString("Code"));
                    course.setName(rs.getString("CourseName"));
                    group.setCourse(course);
                    
                    groupList.add(group);
                }
        } catch (SQLException ex) {
            Logger.getLogger(GroupDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return groupList;
    }
}
