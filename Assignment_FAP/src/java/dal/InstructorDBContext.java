/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Instructor;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class InstructorDBContext extends DBContext {

    //Get all informations of instructor by instructor id
    public Instructor getInstructor(int instructorID) {
        Instructor instructor = new Instructor();
        try {
            String sql = "select ins.ID, ins.Code, ins.Name, ins.Gender, ins.Phone, ins.Email, ins.Image\n"
                    + "from Instructor ins\n"
                    + "where ins.ID = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, instructorID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                instructor.setId(rs.getInt("ID"));
                instructor.setCode(rs.getString("Code"));
                instructor.setName(rs.getString("Name"));
                instructor.setGender(rs.getBoolean("Gender"));
                instructor.setPhone(rs.getString("Phone"));
                instructor.setEmail(rs.getString("Email"));
                instructor.setImage(rs.getString("Image"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(InstructorDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return instructor;
    }
}
