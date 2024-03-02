/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Attendance;
import entity.Session;
import entity.Slot;
import entity.Student;
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
            while (rs.next()) {
                Attendance att = new Attendance();

                Session session = new Session();
                Slot slot = new Slot();
                slot.setId(rs.getInt("Slot"));
                session.setSlot(slot);
                session.setDate(rs.getDate("Date"));
                att.setSession(session);

                //if status is not null then it can be attendance or absent
                //but status is null then it it hasn't happened yet that is a session in future 
                if (rs.getObject("Status") != null) {
                    att.setStatus(rs.getBoolean("Status"));
                }

                attList.add(att);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return attList;
    }

    public ArrayList<Attendance> getAttendanceBySession(int sessionID) {
        ArrayList<Attendance> attList = new ArrayList<>();
        try {
            String sql = "select stu.ID, stu.Name as Student, stu.Image, a.Status, a.Note, a.RecordTime\n"
                    + "from [Session] s inner join EnrollMent e on s.GroupID = e.GroupID\n"
                    + "                 inner join Student stu on e.StudentID = stu.ID\n"
                    + "                 left join Attendance a on s.ID = a.SessionID and stu.ID = a.StudentID\n"
                    + "where s.ID = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, sessionID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Attendance att = new Attendance();

                Student student = new Student();
                student.setId(rs.getString("ID"));
                student.setName(rs.getString("Student"));
                student.setImage(rs.getString("Image"));
                att.setStudent(student);

                att.setStatus(rs.getBoolean("Status"));
                att.setNote(rs.getString("Note"));
                att.setRecordTime(rs.getTimestamp("RecordTime"));

                attList.add(att);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return attList;
    }

    public void setAttendancesIntoTable(int sessionID, ArrayList<Attendance> attList) {
        try {
            connection.setAutoCommit(false);
            String sql_delete_atts = "Delete from Attendance\n"
                                      + "where SessionID = ?";
            PreparedStatement delete = connection.prepareStatement(sql_delete_atts);
            delete.setInt(1, sessionID);
            delete.executeUpdate();

            for (Attendance attendance : attList) {
                String sql_insert_att = "Insert into Attendance(SessionID, StudentID, Status, Note, RecordTime)\n"
                        + "Values ( ? , ? , ? , ? , ?)";
                PreparedStatement insert = connection.prepareStatement(sql_insert_att);
                insert.setInt(1, sessionID);
                insert.setString(2, attendance.getStudent().getId());
                insert.setBoolean(3, attendance.getStatus());
                insert.setString(4, attendance.getNote());
                insert.setTimestamp(5, attendance.getRecordTime());
                insert.executeUpdate();
            }

            String sql_update_session = "Update [Session]\n"
                    + "set IsTaken = 'true'\n"
                    + "where ID = ?";
            PreparedStatement update = connection.prepareStatement(sql_update_session);
            update.setInt(1, sessionID);
            update.executeUpdate();

            connection.commit();
        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex1);
            }
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
