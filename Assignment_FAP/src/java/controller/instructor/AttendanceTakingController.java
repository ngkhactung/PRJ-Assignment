/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.instructor;

import dal.AttendanceDBContext;
import dal.SessionDBContext;
import entity.Attendance;
import entity.Session;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class AttendanceTakingController extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int sessionID = Integer.parseInt(request.getParameter("sessId"));

        SessionDBContext sessDB = new SessionDBContext();
        Session session = sessDB.getSession(sessionID);

        AttendanceDBContext attDB = new AttendanceDBContext();
        ArrayList<Attendance> attList = attDB.getAttendanceBySession(sessionID);

        request.setAttribute("session", session);
        request.setAttribute("attList", attList);
        request.getRequestDispatcher("../view/instructor/attendance_taking.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int sessionID = Integer.parseInt(request.getParameter("sessionID"));
        AttendanceDBContext attDB = new AttendanceDBContext();
        ArrayList<Attendance> attList = attDB.getAttendanceBySession(sessionID);
        for (Attendance attendance : attList) {
            Boolean status = Boolean.valueOf(request.getParameter("status" + attendance.getStudent().getId()));
            attendance.setStatus(status);
            String note = request.getParameter("note" + attendance.getStudent().getId());
            attendance.setNote(note);
            attendance.setRecordTime(Timestamp.valueOf(LocalDateTime.now()));
        }
        attDB.setAttendancesIntoTable(sessionID, attList);
        response.sendRedirect("attendance_review?sessId=" + sessionID);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
