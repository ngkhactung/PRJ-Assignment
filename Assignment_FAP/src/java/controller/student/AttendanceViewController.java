/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.student;

import controller.authorization.BaseRoleBACController;
import dal.AttendanceDBContext;
import dal.GroupDBContext;
import dal.SessionDBContext;
import entity.Account;
import entity.Attendance;
import entity.Feature;
import entity.Group;
import entity.Session;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author Admin
 */
public class AttendanceViewController extends BaseRoleBACController {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response, Account account)
            throws ServletException, IOException {
        GroupDBContext groupDB = new GroupDBContext();
        ArrayList<Group> groupList = groupDB.getGroupsByStudent(account.getStudent().getId());

        String raw_courseID = request.getParameter("courseID");
        int courseID = (raw_courseID == null) ? groupList.get(0).getCourse().getId() : Integer.parseInt(raw_courseID);

        SessionDBContext sessDB = new SessionDBContext();
        ArrayList<Session> sessionList = sessDB.getSessionsForAttendance(account.getStudent().getId(), courseID);

        AttendanceDBContext attDB = new AttendanceDBContext();
        ArrayList<Attendance> attList = attDB.getAttedanceByCourse(account.getStudent().getId(), courseID);

        int totalAbsent = 0;
        for (Attendance attendance : attList) {
            if(attendance.getStatus() !=null && attendance.getStatus() == false){
                totalAbsent++;
            }
        }
        
        request.setAttribute("courseID", courseID);
        request.setAttribute("groupList", groupList);
        request.setAttribute("sessList", sessionList);
        request.setAttribute("attList", attList);
        request.setAttribute("totalAbsent", totalAbsent);
        request.getRequestDispatcher("../view/student/attendance_view.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response,
            Account account, ArrayList<Feature> featureList)
            throws ServletException, IOException {
        processRequest(request, response, account);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response,
            Account account, ArrayList<Feature> featureList)
            throws ServletException, IOException {
        processRequest(request, response, account);
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
