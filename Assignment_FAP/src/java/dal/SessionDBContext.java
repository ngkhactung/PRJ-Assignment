/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import entity.Attendance;
import entity.Building;
import entity.Course;
import entity.Group;
import entity.Room;
import entity.Session;
import entity.Slot;
import java.util.ArrayList;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class SessionDBContext extends DBContext {

    public ArrayList<Session> getTimeTableOfInstructor(int instructorID, Date from, Date to) {
        ArrayList<Session> sessionList = new ArrayList<>();
        try {
            String sql = "select s.ID, slot.ID as Slot, [Start], [End], r.Name as Room, r.BuildingID As Building, \n"
                    + "Date, g.Name as [Group], c.Code as [Course], s.IsTaken \n"
                    + "from [Session] s inner join Slot slot on s.SloID = slot.ID\n"
                    + "				inner join Room r on s.RoomID = r.ID\n"
                    + "				inner join Building build on r.BuildingID = build.ID\n"
                    + "				inner join Groups g on s.GroupID = g.ID\n"
                    + "				inner join Course c on g.CourseID = c.ID\n"
                    + "				inner join Instructor Ins on s.InstructorID = Ins.ID\n"
                    + "where Ins.ID = ? AND [Date] >= ? AND [Date] <= ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, instructorID);
            stm.setDate(2, from);
            stm.setDate(3, to);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Session session = new Session();
                session.setId(rs.getInt("ID"));

                Slot slot = new Slot();
                slot.setId(rs.getInt("Slot"));
                slot.setStart(rs.getString("Start"));
                slot.setEnd(rs.getString("End"));
                session.setSlot(slot);

                Room room = new Room();
                room.setName(rs.getInt("Room"));
                Building building = new Building();
                building.setId(rs.getString("Building"));
                room.setBuilding(building);
                session.setRoom(room);

                session.setDate(rs.getDate("Date"));

                Group group = new Group();
                group.setName(rs.getString("Group"));
                Course course = new Course();
                course.setCode(rs.getString("Course"));
                group.setCourse(course);
                session.setGroup(group);

                session.setIsTaken(rs.getBoolean("IsTaken"));

                sessionList.add(session);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SessionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return sessionList;
    }

    public ArrayList<Session> getTimeTableOfStudent(String studentID, Date from, Date to) {
        ArrayList<Session> sessionList = new ArrayList<>();
        try {
            String sql = "select slot.ID as Slot, [Start], [End], r.Name as Room, r.BuildingID As Building, \n"
                    + "Date, c.Code as [Course], a.Status \n"
                    + "from Student student inner join EnrollMent e on student.ID = e.StudentID\n"
                    + "				inner join Groups g on e.GroupID = g.ID\n"
                    + "				inner join [Session] s on g.ID = s.GroupID\n"
                    + "				inner join Slot slot on s.SloID = slot.ID\n"
                    + "				inner join Room r on s.RoomID = r.ID\n"
                    + "				inner join Building build on r.BuildingID = build.ID\n"
                    + "				inner join Course c on g.CourseID = c.ID\n"
                    + "				left join Attendance a on s.ID = a.SessionID\n"
                    + "where student.ID = ? AND [Date] >= ? AND [Date] <= ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, studentID);
            stm.setDate(2, from);
            stm.setDate(3, to);
            ResultSet rs = stm.executeQuery();
            while(rs.next()){
                Session session = new Session();
                
                Slot slot = new Slot();
                slot.setId(rs.getInt("Slot"));
                slot.setStart(rs.getString("Start"));
                slot.setEnd(rs.getString("End"));
                session.setSlot(slot);
                
                Room room = new Room();
                room.setName(rs.getInt("Room"));
                Building building = new Building();
                building.setId(rs.getString("Building"));
                room.setBuilding(building);
                session.setRoom(room);
                
                session.setDate(rs.getDate("Date"));

                Group group = new Group();
                Course course = new Course();
                course.setCode(rs.getString("Course"));
                group.setCourse(course);
                session.setGroup(group);
                
                sessionList.add(session);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SessionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return sessionList;
    }
}
