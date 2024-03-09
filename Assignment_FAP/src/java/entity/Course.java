/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Admin
 */
public class Course {
    private int id;
    private String code;
    private String name;
    private String preRequisite;
    private String replacedCourse;
    private int credit;

    public Course() {
    }

    public Course(int id, String code, String name, int credit) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.credit = credit;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPreRequisite() {
        return preRequisite;
    }

    public void setPreRequisite(String preRequisite) {
        this.preRequisite = preRequisite;
    }

    public String getReplacedCourse() {
        return replacedCourse;
    }

    public void setReplacedCourse(String replacedCourse) {
        this.replacedCourse = replacedCourse;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }
    
}
