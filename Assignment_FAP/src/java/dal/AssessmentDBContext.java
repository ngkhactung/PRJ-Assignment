/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Assessment;
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
public class AssessmentDBContext extends DBContext {

    public ArrayList<Assessment> getAssessmentByGroup(int groupID) {
        ArrayList<Assessment> assessList = new ArrayList<>();
        try {
            String sql = "select g.ID, a.ID as AssessmentID, a.Type, a.Name, a.Weight\n"
                    + "from Groups g inner join Course c on g.CourseID = c.ID\n"
                    + "		 inner join Assessment a on c.ID = a.CourseID\n"
                    + "where g.ID = ? and a.Type <> 'Final Exam' \n"
                    + "and a.Type <> 'Final Exam Resit' and a.Type <> 'Practical Exam'";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, groupID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Assessment assessment = new Assessment();

                assessment.setId(rs.getInt("AssessmentID"));
                assessment.setType(rs.getString("Type"));
                assessment.setName(rs.getString("Name"));
                assessment.setWeight(rs.getFloat("Weight"));

                assessList.add(assessment);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AssessmentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return assessList;
    }
}
