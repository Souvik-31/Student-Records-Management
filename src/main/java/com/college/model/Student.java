package com.college.model;

public class Student {
    private String studentId;
    private String studentName;
    private String department;
    private int semester;
    private double cgpa;

    public Student() {
    }

    public Student(String studentId, String studentName, String department, int semester, double cgpa) {
        this.studentId = studentId;
        this.studentName = studentName;
        this.department = department;
        this.semester = semester;
        this.cgpa = cgpa;
    }

    public String getStudentId() {
        return studentId;
    }
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getDepartment() {
        return department;
    }
    public void setDepartment(String department) {
        this.department = department;
    }

    public int getSemester() {
        return semester;
    }
    public void setSemester(int semester) {
        this.semester = semester;
    }

    public double getCgpa() {
        return cgpa;
    }
    public void setCgpa(double cgpa) {
        this.cgpa = cgpa;
    }
}
