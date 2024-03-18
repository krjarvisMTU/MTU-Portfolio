delete from student;
delete from department;
delete from course;
delete from instructor;
delete from survey;
delete from question;
delete from choice;

/*
	Adding Departments
*/
insert into department values("Math");
insert into department values("CS");

/*
	Adding Courses
*/
call create_course("CS2311", "Discrete Structures", 3, "CS", null);
call create_course("CS2321", "Data Structures", 3, "CS", null);
call create_course("CS1142", "HW/SW Interface", 3, "CS", null);
call create_course("MA3425", "epic math class", 4, "MATH", null);

/*
	Adding Intructors
*/
call create_instructor("alice000", "Alice", "keithskinwalker27");
call create_instructor("aaron000", "Aaron", "keithskinwalker28");
call create_instructor("al000000", "Al", "keithskinwalker29");
call create_instructor("bill0000", "Bill", "keithskinwalker30");

/*
	Assigning Teachers
*/
call assign_teacher("alice000", "CS2311");
call assign_teacher("aaron000", "CS1142");
call assign_teacher("al000000", "CS2321");
call assign_teacher("bill0000", "MA3425");

/*
	Adding Students
*/
call create_student("bob00000", "Bob", "keithskinwalker31"); 
call create_student("brook000", "Brook", "keithskinwalker32"); 
call create_student("ben00000", "Ben", "keithskinwalker33");
call create_student("brian000", "Brian", "keithskinwalker34");
call create_student("bethany0", "Bethany", "keithskinwalker35");
call create_student("greg0000", "Greg", "keithskinwalker36");
call create_student("jerry000", "Jerry", "keithskinwalker2.5");

/*
	Enrolling students
*/
call enroll_student("bob00000", "CS2311");
call enroll_student("bob00000", "CS2321");
call enroll_student("bob00000", "CS1142");
call enroll_student("ben00000", "CS2321");
call enroll_student("ben00000", "CS2311");
call enroll_student("ben00000", "CS1142");
call enroll_student("ben00000", "MA3425");
call enroll_student("brook000", "CS2311");
call enroll_student("brook000", "CS2321");
call enroll_student("brian000", "CS1142");
call enroll_student("brian000", "CS2321");
call enroll_student("brian000", "MA3425");
call enroll_student("bethany0", "CS1142");
call enroll_student("bethany0", "CS2321");
call enroll_student("greg0000", "MA3425");
call enroll_student("jerry000", "MA3425");

/*
	Creating Questions
*/
call add_question("University", "u0000001","The pace of this course:", "MC", null, null);
call add_question("University", "u0000002", "The feedback from homework assignment grading:", "MC", null, null);
call add_question("University", "u0000003", "Any thing you like about the teaching of this course?", "Essay", null, null);
call add_question("University", "u0000004", "How many hours did you spend per week on this course?", "MC", null, null);
call add_question("Departmental", "d0000001", "Do you use the lab for this course?", "MC", "CS", null);
call add_question("Departmental", "d0000002", "What operation system do you use for work related to this:", "MC", "CS", null);
call add_question("Departmental", "d0000003", "Did you feel adequately prepared for exams by homework/labs?", "MC", "MATH", null);
call add_question("Departmental", "d0000004", "How often did you use lab software outside of lab activities?", "MC", "MATH", null);
call add_question("Instructor", "i0000001", "Do you use the text book?", "MC", null, "CS2321");
call add_question("Instructor", "i0000002", "What would you change about this course:", "Essay", null, "CS1142");
call add_question("Instructor", "i0000003", "This courses content was:", "MC", null, "CS1142");

/*
	Adding Question Choices
*/
call add_question_choice("u0000001", "A", "is too slow");
call add_question_choice("u0000001", "B", "is just right");
call add_question_choice("u0000001", "C", "is too fast");
call add_question_choice("u0000001", "D", "I don't know");
call add_question_choice("u0000002", "A", "Too few");
call add_question_choice("u0000002", "B", "Sufficient");
call add_question_choice("u0000002", "C", "I don't know");
call add_question_choice("u0000004", "A", "< 1 hr");
call add_question_choice("u0000004", "B", "> 1 hr, < 3 hrs");
call add_question_choice("u0000004", "C", "> 3 hrs, < 5 hrs");
call add_question_choice("u0000004", "D", "> 5 hrs, < 8 hrs");
call add_question_choice("u0000004", "E", "> 8 hrs");
call add_question_choice("d0000001", "A", "Not at all");
call add_question_choice("d0000001", "B", "Occasionally");
call add_question_choice("d0000001", "C", "Sometimes");
call add_question_choice("d0000001", "D", "All the time");
call add_question_choice("d0000002", "A", "Mac");
call add_question_choice("d0000002", "B", "Windows");
call add_question_choice("d0000002", "C", "Linux");
call add_question_choice("d0000003", "A", "Yes");
call add_question_choice("d0000003", "B", "No");
call add_question_choice("d0000004", "A", "Very Often");
call add_question_choice("d0000004", "B", "Often");
call add_question_choice("d0000004", "C", "Sometimes");
call add_question_choice("d0000004", "D", "Rarely");
call add_question_choice("d0000004", "E", "Never");
call add_question_choice("i0000001", "A", "Not at all");
call add_question_choice("i0000001", "B", "Occasionally");
call add_question_choice("i0000001", "C", "Often");
call add_question_choice("i0000003", "A", "Very difficult");
call add_question_choice("i0000003", "B", "Difficult");
call add_question_choice("i0000003", "C", "Moderate");
call add_question_choice("i0000003", "D", "Easy");

delimiter $$
drop procedure if exists answer_question $$
create procedure answer_question (taker_id char(6), questionid char(8), choice_id varchar(10), essayAns varchar(100), course_id char(6))
begin
	if (select count(*) from surveytaker where takerid = taker_id) = 0 then
		insert into surveytaker values(taker_id);
	end if;
	if essayAns is null then
		insert into response(takerid, course_id, qid, choiceid) values(taker_id, course_id, questionid, choice_id);
	end if;
	if choice_id is null then
		insert into response(takerid, course_id, qid, essayAnswer) values(taker_id, course_id, questionid, essayAns);
	end if;
end $$
delimiter ;

call answer_question("000001", "u0000001", "A", null, "CS2311");
call answer_question("000002", "u0000001", "A", null, "CS2311");
call answer_question("000003", "u0000001", "A", null, "CS1142");
call answer_question("000004", "u0000001", "A", null, "CS1142");
call answer_question("000005", "u0000001", "A", null, "CS1142");
call answer_question("000006", "u0000001", "A", null, "CS2321");
call answer_question("000007", "u0000001", "A", null, "CS2321");
call answer_question("000008", "u0000001", "A", null, "CS2321");
call answer_question("000009", "u0000001", "A", null, "CS2321");
call answer_question("000010", "u0000001", "A", null, "CS2321");
call answer_question("000011", "u0000001", "B", null, "MA3425");
call answer_question("000012", "u0000001", "C", null, "MA3425");

call answer_question("000001", "u0000002", "A", null, "CS2311");
call answer_question("000002", "u0000002", "B", null, "CS2311");
call answer_question("000003", "u0000002", "A", null, "CS1142");
call answer_question("000004", "u0000002", "B", null, "CS1142");
call answer_question("000005", "u0000002", "B", null, "CS1142");
call answer_question("000006", "u0000002", "A", null, "CS2321");
call answer_question("000007", "u0000002", "B", null, "CS2321");
call answer_question("000008", "u0000002", "B", null, "CS2321");
call answer_question("000009", "u0000002", "C", null, "CS2321");
call answer_question("000010", "u0000002", "C", null, "CS2321");
call answer_question("000011", "u0000002", "A", null, "MA3425");
call answer_question("000012", "u0000002", "A", null, "MA3425");

call answer_question("000002", "u0000003", null, "everything", "CS2311");
call answer_question("000004", "u0000003", null, "everything", "CS1142");
call answer_question("000005", "u0000003", null, "Partial credit", "CS1142");
call answer_question("000007", "u0000003", null, "everything", "CS2321");
call answer_question("000008", "u0000003", null, "programming", "CS2321");
call answer_question("000010", "u0000003", null, "SAM sessions", "CS2321");
call answer_question("000011", "u0000003", null, "partial credit", "MA3425");
call answer_question("000012", "u0000003", null, "labs", "MA3425");

call answer_question("000001", "u0000004", "C", null, "CS2311");
call answer_question("000002", "u0000004", "B", null, "CS2311");
call answer_question("000003", "u0000004", "C", null, "CS1142");
call answer_question("000004", "u0000004", "B", null, "CS1142");
call answer_question("000005", "u0000004", "D", null, "CS1142");
call answer_question("000006", "u0000004", "B", null, "CS2321");
call answer_question("000007", "u0000004", "B", null, "CS2321");
call answer_question("000008", "u0000004", "C", null, "CS2321");
call answer_question("000009", "u0000004", "B", null, "CS2321");
call answer_question("000010", "u0000004", "D", null, "CS2321");
call answer_question("000011", "u0000004", "D", null, "MA3425");
call answer_question("000012", "u0000004", "E", null, "MA3425");

call answer_question("000001", "d0000001", "A", null, "CS2311");
call answer_question("000002", "d0000001", "A", null, "CS2311");
call answer_question("000003", "d0000001", "A", null, "CS1142");
call answer_question("000004", "d0000001", "A", null, "CS1142");
call answer_question("000005", "d0000001", "C", null, "CS1142");
call answer_question("000006", "d0000001", "A", null, "CS2321");
call answer_question("000007", "d0000001", "A", null, "CS2321");
call answer_question("000008", "d0000001", "A", null, "CS2321");
call answer_question("000009", "d0000001", "A", null, "CS2321");
call answer_question("000010", "d0000001", "A", null, "CS2321");

call answer_question("000001", "d0000002", "A", null, "CS2311");
call answer_question("000002", "d0000002", "B", null, "CS2311");
call answer_question("000003", "d0000002", "B", null, "CS1142");
call answer_question("000004", "d0000002", "B", null, "CS1142");
call answer_question("000005", "d0000002", "B", null, "CS1142");
call answer_question("000006", "d0000002", "A", null, "CS2321");
call answer_question("000007", "d0000002", "B", null, "CS2321");
call answer_question("000008", "d0000002", "A", null, "CS2321");
call answer_question("000009", "d0000002", "B", null, "CS2321");
call answer_question("000010", "d0000002", "B", null, "CS2321");

call answer_question("000011", "d0000003", "A", null, "MA3425");
call answer_question("000012", "d0000003", "A", null, "MA3425");

call answer_question("000011", "d0000004", "D", null, "MA3425");
call answer_question("000012", "d0000004", "C", null, "MA3425");

call answer_question("000006", "i0000001", "A", null, "CS2321");
call answer_question("000007", "i0000001", "C", null, "CS2321");
call answer_question("000008", "i0000001", "C", null, "CS2321");
call answer_question("000009", "i0000001", "B", null, "CS2321");
call answer_question("000010", "i0000001", "C", null, "CS2321");

call answer_question("000003", "i0000002", null, "more assignments for more points", "CS1142");
call answer_question("000004", "i0000002", null, "Move faster", "CS1142");
call answer_question("000005", "i0000002", null, "Give better feedback on assignments", "CS1142");

call answer_question("000003", "i0000003", "C", null, "CS1142");
call answer_question("000004", "i0000003", "D", null, "CS1142");
call answer_question("000005", "i0000003", "C", null, "CS1142");

select * from choice;
select * from response;
select * from enrolledIn;