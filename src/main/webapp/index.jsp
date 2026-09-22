<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Records</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        .top-actions {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            justify-content: center;
        }
        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--border-radius);
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s ease, color 0.2s ease;
        }
        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }
        .btn-primary:hover {
            background-color: var(--primary-hover);
        }
        .btn-outline {
            background-color: transparent;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
        }
        .btn-outline:hover {
            background-color: var(--primary-color);
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Student Record Management</h2>

        <div class="top-actions">
            <button class="btn btn-primary" onclick="toggleForm('addForm')">Add Student</button>
            <button class="btn btn-outline" onclick="toggleForm('updateForm')">Update Student</button>
        </div>
        
        <div class="forms-wrapper">
            <!-- Search Student Form (Always Visible) -->
            <div class="form-section">
                <h3>Search Student</h3>
                <form action="student" method="get">
                    <input type="hidden" name="action" value="search">
                    <div class="form-group">
                        <label>Search By</label>
                        <select name="searchType">
                            <option value="id">Student ID</option>
                            <option value="department">Department</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Query</label>
                        <input type="text" name="searchQuery" required placeholder="Search...">
                    </div>
                    <input type="submit" value="Search">
                </form>
                <form action="student" method="get" style="margin-top: 1rem;">
                    <input type="hidden" name="action" value="list">
                    <input type="submit" value="Show All" class="btn btn-secondary" style="width: 100%;">
                </form>
            </div>

            <!-- Add Student Form (Hidden initially) -->
            <div class="form-section" id="addForm" style="display: none;">
                <h3>Add Student</h3>
                <form action="student" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="form-group">
                        <label>Student ID</label>
                        <input type="text" name="studentId" required placeholder="e.g. S101">
                    </div>
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" name="studentName" required placeholder="Full Name">
                    </div>
                    <div class="form-group">
                        <label>Department</label>
                        <input type="text" name="department" required placeholder="e.g. CSE">
                    </div>
                    <div class="form-group">
                        <label>Semester (1-12)</label>
                        <input type="number" name="semester" min="1" max="12" required>
                    </div>
                    <div class="form-group">
                        <label>CGPA (0-10)</label>
                        <input type="number" step="0.01" name="cgpa" min="0" max="10" required>
                    </div>
                    <input type="submit" value="Save Student">
                </form>
            </div>

            <!-- Update Student Form (Hidden initially) -->
            <div class="form-section" id="updateForm" style="display: none;">
                <h3>Update Student</h3>
                <form action="student" method="post">
                    <input type="hidden" name="action" value="update">
                    <div class="form-group">
                        <label>Student ID</label>
                        <input type="text" name="studentId" required placeholder="Existing ID">
                    </div>
                    <div class="form-group">
                        <label>New Department</label>
                        <input type="text" name="department" required placeholder="New Dept">
                    </div>
                    <div class="form-group">
                        <label>New CGPA</label>
                        <input type="number" step="0.01" name="cgpa" min="0" max="10" required>
                    </div>
                    <input type="submit" value="Update Record">
                </form>
            </div>
        </div>

        <!-- Student List Table (Visible only if search/list action was performed) -->
        <c:if test="${searchPerformed}">
            <div class="table-section">
                <h3>Search Results</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Student ID</th>
                            <th>Name</th>
                            <th>Department</th>
                            <th>Semester</th>
                            <th>CGPA</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="student" items="${listStudents}">
                            <tr>
                                <td>${student.studentId}</td>
                                <td>${student.studentName}</td>
                                <td>${student.department}</td>
                                <td>${student.semester}</td>
                                <td>${student.cgpa}</td>
                                <td>
                                    <a href="student?action=delete&studentId=${student.studentId}" class="delete-link" onclick="return confirm('Are you sure you want to delete this student?');">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty listStudents}">
                            <tr>
                                <td colspan="6" style="text-align: center; padding: 2rem; color: #666;">No student records found matching your query.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </c:if>
    </div>

    <script>
        function toggleForm(formId) {
            var form = document.getElementById(formId);
            if (form.style.display === "none") {
                form.style.display = "block";
            } else {
                form.style.display = "none";
            }
        }
    </script>
</body>
</html>
