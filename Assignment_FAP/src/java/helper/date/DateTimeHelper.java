/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package helper.date;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.sql.Date;

/**
 *
 * @author Admin
 */
public class DateTimeHelper {

    public static ArrayList<Week> getWeeks(int year) {
        ArrayList<Week> weekList = new ArrayList<>();
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM");
        
        LocalDate firstDayOfYear = LocalDate.of(year, 1, 1);
        LocalDate startDayWeekOfYear = null;
        //if first day of year is not monday then 
        //the first day of first week of year is monday of next week 
        if (firstDayOfYear.getDayOfWeek().getValue() != 1) {
            startDayWeekOfYear = firstDayOfYear.plusDays(8 - firstDayOfYear.getDayOfWeek().getValue());
        } else {
            startDayWeekOfYear = firstDayOfYear;
        }

        LocalDate lastDayOfYear = LocalDate.of(year, 12, 31);
        LocalDate endDayWeekOfYear = null;
        //if last day of year is not sunday then 
        //the last day of last week of year is sunday of that week 
        if (lastDayOfYear.getDayOfWeek().getValue() != 7) {
            endDayWeekOfYear = lastDayOfYear.plusDays(7 - lastDayOfYear.getDayOfWeek().getValue());
        } else {
            endDayWeekOfYear = lastDayOfYear;
        }

        LocalDate currentDate = startDayWeekOfYear;
        while (currentDate.isBefore(endDayWeekOfYear)) {
            Week week = new Week();
            week.setStartDay(currentDate);
            week.setFrom(fmt.format(currentDate));
            week.setTo(fmt.format(currentDate.plusDays(6)));
            weekList.add(week);
            
            currentDate = currentDate.plusDays(7);
        }
        
        return weekList;
    }
    
    public static LocalDate getStartDayWeek(LocalDate currentDate){
        LocalDate startDay = currentDate.minusDays(currentDate.getDayOfWeek().getValue() - 1);
        return startDay;
    }
    
    //Get all days of week from a first day of week
    public static ArrayList<Date> getAllDayOfWeek(LocalDate startDay){
        ArrayList<Date> daysOfWeek = new ArrayList<>();
        
        daysOfWeek.add(Date.valueOf(startDay));
        for (int i = 1; i < 7; i++) {
            daysOfWeek.add(Date.valueOf(startDay.plusDays(i)));
        }
        
        return daysOfWeek;
    }
}
