<%-- 
    Document   : timetable
    Created on : Feb 29, 2024, 8:31:44 PM
    Author     : Admin
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
              integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="/assign.fap.fpt/css/components/footer.css"/>
        <link rel="stylesheet" href="/assign.fap.fpt/css/components/header.css"/>
        <link rel="stylesheet" href="/assign.fap.fpt/css/components/menu.css"/>
        <link rel="stylesheet" href="/assign.fap.fpt/css/student/timetable.css"/>
    </head>
    <body>
        <jsp:include page="../components/header.jsp" />
        <jsp:include page="../components/student_menu.jsp"/>

        <br>
        <br>
        <br>
        <div class="container table-responsive-md">
            <table id="timetable" class="table table-bordered align-middle">
                <tr class="headtable">
                    <th rowspan="2" class="headtime p-0">
                        <div class="row py-2">
                            <h4 class="time-title col-4 ps-4 pe-0 d-lg-block d-none">YEAR</h4>
                            <form class="col-8 " id="yearForm" action="timetable" method="GET">
                                <select name="year" onchange="document.getElementById('yearForm').submit()">
                                    <c:forEach begin="2021" end="2025" var="i">
                                        <option <c:if test="${requestScope.year == i}">
                                                selected
                                            </c:if>
                                            value="${i}">${i}</option>
                                    </c:forEach>
                                </select>
                            </form>
                        </div>
                        <div class="row py-2">
                            <h4 class="time-title col-4 ps-4 pe-0 d-lg-block d-none">WEEK</h4>
                            <form class="col-8  " id="dayForm" action="timetable" method="GET">
                                <select name="startDay" onchange="document.getElementById('dayForm').submit()">
                                    <c:forEach items="${requestScope.weeks}" var="week">
                                        <option <c:if test="${requestScope.startDay == week.startDay}">
                                                selected
                                            </c:if>
                                            value="${week.startDay}">${week.from} To ${week.to}</option>
                                    </c:forEach>
                                </select>
                            </form>
                        </div>
                    </th>

                    <c:forEach items="${requestScope.daysOfWeek}" var="day">
                        <th>
                            <fmt:formatDate pattern="E" value="${day}" />
                        </th>
                    </c:forEach>
                </tr>

                <tr class="headtable">
                    <c:forEach items="${requestScope.daysOfWeek}" var="day">
                        <th>
                            <fmt:formatDate pattern="dd/MM" value="${day}" />
                        </th>
                    </c:forEach>
                </tr>

                <c:forEach items="${requestScope.slots}" var="slot">
                    <tr>
                        <td>Slot ${slot.id}</td>
                        <c:forEach items="${requestScope.daysOfWeek}" var="day">
                            <td>
                                <c:forEach items="${requestScope.sessionList}" var="session">
                                    <c:if test="${session.slot.id == slot.id && session.date == day}">
                                        <div>
                                            <a href="session_detail?sessId=${session.id}">${session.group.course.code} -</a>
                                            <a class="btn btn-warning option-item" href="https://flm.fpt.edu.vn/"
                                               target="_blank">View
                                                Materials</a>
                                        </div>

                                        <div>
                                            at ${session.room.building.id}-${session.room.name} -
                                            <a class="btn btn-primary option-item" href="https://fu-edunext.fpt.edu.vn/"
                                               target="_blank">Edunext</a>
                                        </div>

                                        <c:forEach items="${requestScope.attList}" var="att">
                                            <c:if test="${att.session.slot.id == slot.id 
                                                          && att.session.date == day}">
                                                <c:if test="${att.status == null}">
                                                    <p style="color: red">(Not Yet)</p>
                                                </c:if>
                                                <c:if test="${att.status == true}">
                                                    <p style="color: green">(Attended)</p>
                                                </c:if>
                                                <c:if test="${att.status == false}">
                                                    <p style="color: red">(Absent)</p>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>

                                        <div class="option-item time">${session.slot.start} - ${session.slot.end}</div>
                                    </c:if>
                                </c:forEach>
                            </td>
                        </c:forEach>
                    </tr>
                </c:forEach>
            </table>
        </div>
        
        <br>
        <br>
        <br>
        
        <jsp:include page="../components/footer.jsp"/>
    </body>
</html>
