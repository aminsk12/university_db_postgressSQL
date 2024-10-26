-- Active: 1729140286259@@127.0.0.1@5432@postgres
-- Create the 'students' table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    age INTEGER NOT NULL,
    email VARCHAR(100) NOT NULL,
    frontend_mark INTEGER NOT NULL,
    backend_mark INTEGER NOT NULL,
    status VARCHAR(50)
);

-- Create the 'courses' table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INTEGER NOT NULL
);

-- Create the 'enrollment' table
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students (student_id),
    course_id INTEGER REFERENCES courses (course_id)
);

INSERT INTO
    students (
        student_name,
        age,
        email,
        frontend_mark,
        backend_mark,
        status
    )
VALUES (
        'Sameer',
        21,
        'sameer@example.com',
        48,
        60,
        NULL
    ),
    (
        'Zoya',
        23,
        'zoya@example.com',
        52,
        58,
        NULL
    ),
    (
        'Nabil',
        22,
        'nabil@example.com',
        37,
        46,
        NULL
    ),
    (
        'Rafi',
        24,
        'rafi@example.com',
        41,
        40,
        NULL
    ),
    (
        'Sophia',
        22,
        'sophia@example.com',
        50,
        52,
        NULL
    ),
    (
        'Hasan',
        23,
        'hasan@gmail.com',
        43,
        39,
        NULL
    );

-- Insert data into the 'courses' table
INSERT INTO
    courses (course_name, credits)
VALUES ('Next.js', 3),
    ('React.js', 4),
    ('Databases', 3),
    ('Prisma', 3);

-- Insert data into the 'enrollment' table
INSERT INTO
    enrollment (student_id, course_id)
VALUES (1, 1),
    (1, 2),
    (2, 1),
    (3, 2);

SELECT * FROM students

SELECT * FROM courses

SELECT * FROM enrollment

-- Query 1
-- Insert a new student record
INSERT INTO
    students (
        student_name,
        age,
        email,
        frontend_mark,
        backend_mark,
        status
    )
VALUES (
        'Amin sk',
        22,
        'aminskeh786@gmail.com',
        54,
        60,
        NULL
    );

-- Retrieve the names of students enrolled in 'Next.js'
SELECT student_name
FROM
    students
    JOIN enrollment ON students.student_id = enrollment.student_id
    JOIN courses ON enrollment.course_id = courses.course_id
WHERE
    courses.course_name = 'Next.js';

    
-- Query 2
-- Update the status of the student with the highest total marks to 'Awarded'
UPDATE students
SET
    status = 'Awarded'
WHERE (frontend_mark + backend_mark) = (
        SELECT MAX(frontend_mark + backend_mark)
        FROM students
    );

-- Update the status of the student with the highest total marks to 'Awarded'
UPDATE students
SET
    status = 'Awarded'
WHERE (frontend_mark + backend_mark) = (
        SELECT MAX(frontend_mark + backend_mark)
        FROM students
    );

-- Retrieve the names of students starting from the 3rd student with a limit of 2
SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2
OFFSET
    2;

-- Retrieve course names and the number of students enrolled in each course
SELECT courses.course_name, COUNT(enrollment.student_id) AS students_enrolled
FROM courses
    LEFT JOIN enrollment ON courses.course_id = enrollment.course_id
GROUP BY
    courses.course_name;

-- Calculate the average age of all students
SELECT AVG(age) AS average_age FROM students;

-- Retrieve names of students with email addresses containing 'example.com'
SELECT student_name FROM students WHERE email LIKE '%example.com%';