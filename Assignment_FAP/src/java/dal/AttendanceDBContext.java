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

    //Get attendance for display in time table of student
    public ArrayList<Attendance> getAttendanceByWeek(String studentID, Date from, Date to) {
        ArrayList<Attendance> attList = new ArrayList<>();
        try {
            String sql = "select slot.ID as Slot, [Start], [End], Date, a.Status\n"
                    + "from Student stu inner join EnrollMent e on stu.ID = e.StudentID\n"
                    + "                 inner join [Session] s on e.GroupID = s.GroupID\n"
                    + "                 inner join Slot slot on s.SloID = slot.ID\n"
                    + "                 left join Attendance a on stu.ID = a.StudentID and s.ID = a.SessionID\n"
                    + "where stu.ID = ? AND [Date] >= ? AND [Date] <= ?";
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

    //Get attendance for display to take attendance by instructor
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

    //Get attendance for display in session detail
    public Attendance getAttedanceByStudent(int sessionID, String studentID) {
        Attendance att = new Attendance();
        try {
            String sql = "select a.Status, a.RecordTime\n"
                    + "from [Session] s inner join EnrollMent e on s.GroupID = e.GroupID\n"
                    + "                 inner join Student stu on e.StudentID = stu.ID\n"
                    + "                 left join Attendance a on stu.ID = a.StudentID and s.ID = a.SessionID\n"
                    + "where s.ID = ? and stu.ID = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, sessionID);
            stm.setString(2, studentID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                if (rs.getObject("Status") != null) {
                    att.setStatus(rs.getBoolean("Status"));
                }

                if (rs.getObject("RecordTime") != null) {
                    att.setRecordTime(rs.getTimestamp("RecordTime"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return att;
    }

    //Get attendance for display to student by course
    public ArrayList<Attendance> getAttedanceByCourse(String studentID, int courseID) {
        ArrayList<Attendance> attList = new ArrayList<>();
        try {
            String sql = "select s.ID, a.Status, a.Note\n"
                    + "from Student stu inner join EnrollMent e on stu.ID = e.StudentID\n"
                    + "                 inner join Groups g on e.GroupID = g.ID\n"
                    + "                 inner join Course c on g.CourseID = c.ID\n"
                    + "                 inner join [Session] s on g.ID = s.GroupID \n"
                    + "                 left join Attendance a on stu.ID = a.StudentID and s.ID = a.SessionID\n"
                    + "where stu.ID = ? and g.CourseID = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, studentID);
            stm.setInt(2, courseID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Attendance att = new Attendance();

                Session session = new Session();
                session.setId(rs.getInt("ID"));
                att.setSession(session);

                if (rs.getObject("Status") != null) {
                    att.setStatus(rs.getBoolean("Status"));
                }

                att.setNote(rs.getString("Note"));

                attList.add(att);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return attList;
    }

    //Delete all attendance records of a session, then re-insert the attendance records of that session
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
