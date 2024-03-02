/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Attendance;
import entity.Session;
import entity.Slot;
import java.sql.Date;
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
public class AttendanceDBContext extends DBContext {

    public ArrayList<Attendance> getAttendanceByWeek(String studentID, Date from, Date to) {
        ArrayList<Attendance> attList = new ArrayList<>();
        try {
            String sql = "select slot.ID as Slot, [Start], [End], Date, a.Status \n"
                    + "from Student student inner join EnrollMent e on student.ID = e.StudentID\n"
                    + "				inner join Groups g on e.GroupID = g.ID\n"
                    + "				inner join [Session] s on g.ID = s.GroupID\n"
                    + "				inner join Slot slot on s.SloID = slot.ID\n"
                    + "				inner join Room r on s.RoomID = r.ID\n"
                    + "				inner join Building build on r.BuildingID = build.ID\n"
                    + "				left join Attendance a on s.ID = a.SessionID\n"
                    + "where student.ID = ? AND [Date] >= ? AND [Date] <= ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, studentID);
            stm.setDate(2, from);
            stm.setDate(3, to);
            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                Attendance att = new Attendance();
                
                Session session = new Session();
                Slot slot = new Slot();
                slot.setId(rs.getInt("Slot"));
                session.setSlot(slot);
                session.setDate(rs.getDate("Date"));
                att.setSession(session);
                
                //if status is not null then it can be attendance or absent
                //but status is null then it it hasn't happened yet that is a session in future 
                if(rs.getObject("Status") != null){
                    att.setStatus(rs.getBoolean("Status"));
                }
                
                attList.add(att);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return attList;
    }
}
