package com.college.controller;

import com.college.dao.StudentDAO;
import com.college.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {
    private StudentDAO studentDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "search":
                    searchStudents(request, response);
                    break;
                case "delete":
                    deleteStudent(request, response);
                    break;
                case "list":
                default:
                    listStudents(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("add".equals(action)) {
                addStudent(request, response);
            } else if ("update".equals(action)) {
                updateStudent(request, response);
            } else {
                listStudents(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Student> listStudents = studentDAO.getAllStudents();
        request.setAttribute("listStudents", listStudents);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    private void searchStudents(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        String type = request.getParameter("searchType");
        String query = request.getParameter("searchQuery");
        List<Student> searchResults;

        if ("id".equalsIgnoreCase(type)) {
            searchResults = studentDAO.getStudentById(query);
        } else if ("department".equalsIgnoreCase(type)) {
            searchResults = studentDAO.getStudentsByDepartment(query);
        } else {
            searchResults = studentDAO.getAllStudents();
        }

        request.setAttribute("listStudents", searchResults);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String id = request.getParameter("studentId");
        String name = request.getParameter("studentName");
        String department = request.getParameter("department");
        int semester = Integer.parseInt(request.getParameter("semester"));
        double cgpa = Double.parseDouble(request.getParameter("cgpa"));

        Student newStudent = new Student(id, name, department, semester, cgpa);
        studentDAO.addStudent(newStudent);
        response.sendRedirect("student?action=list");
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String id = request.getParameter("studentId");
        String department = request.getParameter("department");
        double cgpa = Double.parseDouble(request.getParameter("cgpa"));

        studentDAO.updateStudent(id, department, cgpa);
        response.sendRedirect("student?action=list");
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String id = request.getParameter("studentId");
        studentDAO.deleteStudent(id);
        response.sendRedirect("student?action=list");
    }
}
