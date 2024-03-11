/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Account;
import entity.Instructor;
import entity.Student;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class AccountDBContext extends DBContext {

    //Get information of a account by username and password
    public Account getAccount(String username, String password) {
        try {
            Account account = new Account();
            String sql = "select a.Username, a.Password, s.ID as studentID, ins.ID as instructorID\n"
                    + "from Account a left join Student s on a.Username = s.Username\n"
                    + "		      left join Instructor ins on a.Username = ins.Username\n"
                    + "where a.Username = ? and a.Password = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                account.setUsername(rs.getString("Username"));
                account.setPassword(rs.getString("Password"));
                
                if (rs.getString("studentID") != null) {
                    Student student = new Student();
                    student.setId(rs.getString("studentID"));
                    account.setStudent(student);
                }
                
                if(rs.getObject("instructorID") != null){
                    Instructor instructor = new Instructor();
                    instructor.setId(rs.getInt("instructorID"));
                    account.setInstructor(instructor);
                }
                
                return account;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
