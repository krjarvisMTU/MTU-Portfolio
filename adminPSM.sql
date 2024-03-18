/*
	Procedures
*/
delimiter $$
drop procedure if exists create_instructor $$
create procedure create_instructor (account char (8), name varchar(30), password char(64))
begin
	insert into instructor values(account, name, sha2(password, 256));
end $$
delimiter ;

delimiter $$
drop procedure if exists create_student $$
create procedure create_student (account char(8), name varchar(30), password char(64)) 
begin
	insert into student values(account, name, sha2(password, 256));
end $$
delimiter ;

delimiter $$
drop procedure if exists create_course $$
create procedure create_course (course_id char(6), title varchar(30), credit int, dept_name varchar(30), teacher char(8))
begin	
	insert into course values(course_id, title, credit, dept_name, null);
end $$
delimiter ;

delimiter $$
drop procedure if exists assign_teacher $$
create procedure assign_teacher(newteacher char(8), cid char(6))
begin
	update course set teacher = newteacher where course_id = cid;
end $$
delimiter ;

delimiter $$
drop procedure if exists add_question $$
create procedure add_question(section enum("Departmental", "University", "Instructor"), qid char(8), description varchar(100), type enum("MC", "Essay"), department varchar(30), course_id char(6))
begin
	insert into question values(qid, section, description, type, department, course_id);
end $$
delimiter ;

delimiter $$
drop procedure if exists add_question_choice $$ 
create procedure add_question_choice(qid char(8), choiceid varchar(10), description varchar(100)) 
begin
	insert into choice values(qid, choiceid, description);
end $$
delimiter ;

delimiter $$
drop procedure if exists enroll_student $$ 
create procedure enroll_student(acc char(8), courseid char(6)) 
begin
	insert into enrolledIn(account, course_id) values(acc, courseid);
end $$
delimiter ;