CREATE TABLE IF NOT EXISTS students (
    student_id VARCHAR(20) PRIMARY KEY, 
    student_name VARCHAR(100) NOT NULL, 
    department VARCHAR(100) NOT NULL,
    semester INTEGER NOT NULL CHECK (semester BETWEEN 1 AND 12), 
    cgpa NUMERIC(3,2) NOT NULL CHECK (cgpa BETWEEN 0 AND 10)
);
