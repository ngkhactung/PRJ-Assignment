/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Assessment;
import entity.Grade;
import entity.Student;
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
public class GradeDBContext extends DBContext {

    //Get all grades except the final exam, final re-exam and practice test 
    //of students belonging to the group with the given group id.
    public ArrayList<Grade> getGradeByGroup(int groupID) {
        ArrayList<Grade> gradeList = new ArrayList<>();
        try {
            String sql = "select a.ID as AssessmentID, stu.ID as StudentID, grade.Value, grade.Comment\n"
                    + "from Groups g inner join Course c on g.CourseID = c.ID\n"
                    + "		 inner join Assessment a on c.ID = a.CourseID\n"
                    + "		 inner join EnrollMent e on g.ID = e.GroupID\n"
                    + "		 inner join Student stu on e.StudentID = stu.ID\n"
                    + "		 left join Grade grade on a.ID = grade.AssessID and stu.ID = grade.StudentID\n"
                    + "where g.ID = ? and a.Type <> 'Final Exam' and a.Type <> 'Final Exam Resit' \n"
                    + "and a.Type <> 'Practical Exam'";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, groupID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Grade grade = new Grade();

                Assessment assessment = new Assessment();
                assessment.setId(rs.getInt("AssessmentID"));
                grade.setAssessment(assessment);

                Student student = new Student();
                student.setId(rs.getString("StudentID"));
                grade.setStudent(student);

                if (rs.getObject("Value") != null) {
                    grade.setValue(rs.getFloat("Value"));
                }

                grade.setComment(rs.getString("Comment"));

                gradeList.add(grade);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GradeDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return gradeList;
    }

    //Get all grades of student of a course by the given course id and student id
    public ArrayList<Grade> getGradeByCourse(String studentID, int courseID) {
        ArrayList<Grade> gradeList = new ArrayList<>();
        try {
            String sql = "select a.ID as AssessmentID, a.Type, a.Name, a.Weight, "
                    + "stu.ID as StudentID, grade.Value, grade.Comment\n"
                    + "from Groups g inner join Course c on g.CourseID = c.ID\n"
                    + "              inner join Assessment a on c.ID = a.CourseID\n"
                    + "              inner join EnrollMent e on g.ID = e.GroupID\n"
                    + "              inner join Student stu on e.StudentID = stu.ID\n"
                    + "              left join Grade grade on a.ID = grade.AssessID and stu.ID = grade.StudentID\n"
                    + "where stu.ID = ? and g.CourseID = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, studentID);
            stm.setInt(2, courseID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Grade grade = new Grade();

                Assessment assessment = new Assessment();
                assessment.setId(rs.getInt("AssessmentID"));
                assessment.setType(rs.getString("Type"));
                assessment.setName(rs.getString("Name"));
                assessment.setWeight(rs.getFloat("Weight"));
                grade.setAssessment(assessment);

                Student student = new Student();
                student.setId(rs.getString("StudentID"));
                grade.setStudent(student);

                if (rs.getObject("Value") != null) {
                    grade.setValue(rs.getFloat("Value"));
                }

                grade.setComment(rs.getString("Comment"));

                gradeList.add(grade);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GradeDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return gradeList;
    }

    //Delete all grades except the final exam, final re-exam and practice test of 
    //students belonging to the group with the given group id, 
    //then re-insert the new grades of those students
    public void setGradeIntoTable(int groupID, ArrayList<Grade> gradeList) {
        try {
            connection.setAutoCommit(false);
            String sql_delete_grade = "Delete from Grade\n"
                    + "where ID in ( select grade.ID\n"
                    + "		    from Groups g inner join Course c on g.CourseID = c.ID\n"
                    + "                            inner join Assessment a on c.ID = a.CourseID\n"
                    + "                            inner join EnrollMent e on g.ID = e.GroupID\n"
                    + "                            inner join Student stu on e.StudentID = stu.ID\n"
                    + "                            left join Grade grade on a.ID = grade.AssessID \n"
                    + "						  and stu.ID = grade.StudentID\n"
                    + "			where g.ID = ? and a.Type <> 'Final Exam' \n"
                    + "			and a.Type <> 'Final Exam Resit' and a.Type <> 'Practical Exam' )";
            PreparedStatement delete = connection.prepareStatement(sql_delete_grade);
            delete.setInt(1, groupID);
            delete.executeUpdate();

            for (Grade grade : gradeList) {
                String sql_insert_grade = "Insert into Grade(AssessID, StudentID, [Value])\n"
                        + "Values (?, ?, ?)";
                PreparedStatement insert = connection.prepareStatement(sql_insert_grade);
                insert.setInt(1, grade.getAssessment().getId());
                insert.setString(2, grade.getStudent().getId());
                if (grade.getValue() != null) {
                    insert.setFloat(3, grade.getValue());
                } else {
                    insert.setNull(3, Types.FLOAT);
                }
                insert.executeUpdate();
            }

            connection.commit();
        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(GradeDBContext.class.getName()).log(Level.SEVERE, null, ex1);
            }
            Logger.getLogger(GradeDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(GradeDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
