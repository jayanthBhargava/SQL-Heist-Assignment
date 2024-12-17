Student Assignment creation of tables.

CREATE TABLE Students (
    student_id SERIAL PRIMARY KEY,  -- Auto-incrementing unique identifier
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL, -- Enforcing unique email addresses
    date_of_birth DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE -- Defaults to TRUE if not specified
);

CREATE TYPE dept AS ENUM ('Science', 'Arts', 'Engineering');

-- Create the Courses table
CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY,  -- Auto-incrementing unique identifier
    course_name VARCHAR(100) NOT NULL,
    department dept NOT NULL, -- Restrict values to specific departments
    credits INTEGER NOT NULL CHECK (credits BETWEEN 1 AND 5), -- Enforce valid range for credits
    faculty_id INTEGER NOT NULL, -- Foreign key to Faculty table
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id) -- Assuming Faculty table exists
);

-- Create the Enrollments table


CREATE TYPE status1 AS ENUM ('Enrolled', 'Dropped', 'Completed');

CREATE TABLE Enrollments (
    enrollment_id SERIAL PRIMARY KEY,  -- Auto-incrementing unique identifier
    student_id INTEGER NOT NULL, -- Foreign key to Students table
    course_id INTEGER NOT NULL, -- Foreign key to Courses table
    enrollment_date DATE NOT NULL,
    status status1 NOT NULL, -- Restrict values for status
    CONSTRAINT unique_enrollment UNIQUE (student_id, course_id), -- Composite key to prevent duplicate enrollments
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE, -- Cascade deletion
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) -- Maintain referential integrity
);

=========================================================================
1.The mission name starts with "A" and is exactly 7 characters long.
select * from Missions
where  mission_name LIKE 'A______%'

2.The mission was launched between 2010 and 2020.
select * from Missions
where launch_date BETWEEN '2010-01-01' AND '2020-12-31'
 
3.The remarks contain the word "mission".
SELECT *
FROM Missions
where remarks LIKE '%mission%';

Q2. Find missions funded by agencies that:
1.Conducted missions with payloads between 5,000 and 25,000 kg.
select * from missions where payload_kg between 5000 and 25000

2.Were launched before 2000 or had a crew count greater than 3.
SELECT *
FROM Missions
WHERE launch_date < '2000-01-01' OR crew_count > 3;

Q3. Find missions that:
1.Are not reusable.
SELECT *
FROM Missions
WHERE is_reusable = FALSE
2.Were launched from a site that is either "Kennedy Space Center" or
"Satish Dhawan Space Centre".
SELECT *
FROM Missions
WHERE launch_site IN ('Kennedy Space Center', 'Satish Dhawan Space Centre');
3.Were unsuccessful or had remarks containing the word "failure
select *
FROM Missions
WHERE is_successful = FALSE OR remarks LIKE '%failure%';


Q4. Find missions with:
1.A name containing a % or _ as a literal character.
SELECT *
FROM Missions
WHERE mission_name LIKE 'A\_%'ESCAPE'\';

2.Remarks that start with the word "First".
SELECT *
FROM Missions WHERE  remarks LIKE 'First%';



5. Find missions:
 1.Where the remarks are NULL.
 SELECT *
FROM Missions  
  WHERE  remarks IS NULL;

 2.The payload is less than 10,000 kg or the total cost is NULL.
  SELECT *
FROM Missions WHERE  total_cost_usd IS NULL or payload_kg <10000
 3.Launched after 2015.
SELECT *
FROM Missions
where launch_date > '2015-01-01';




