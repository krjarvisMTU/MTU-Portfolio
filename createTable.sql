drop table if exists enrolledIn;
drop table if exists student;
drop table if exists department;
drop table if exists course;
drop table if exists instructor;
drop table if exists surveytaker;
drop table if exists question;
drop table if exists choice;
drop table if exists response;

create table instructor(
	account char(8) primary key,
	name varchar(30),
	password char(64)
);
create table student(
	account char(8) primary key,
	name varchar(30),
	password char(64)
);
create table enrolledIn(
	account char(8) references student(account),
    course_id char(6) references course(course_id),
    timeCompleted datetime,
    primary key(account, course_id)
);
create table course(
	course_id char(6),
	title varchar(30) not null,
	credit int,
	dept_name varchar(30) references department(dept_name),
	teacher char(8) references instructor(account),
    primary key(course_id, dept_name)
);
create table department(
	dept_name varchar(30) primary key
);
create table question(
	qid char(8) not null,
	section enum("Departmental", "University", "Instructor") not null,
    description varchar(100) not null,
	type enum("MC", "Essay") not null,
	dept_name varchar(30) references department(dept_name) on delete set null,
	course_id char(6) references course(course_id) on delete set null,
    primary key(qid, section)
);
create table choice(
	qid char(8) references question(qid),
	choiceid varchar(10),
    description varchar(100),
    primary key(qid, choiceid)
);
create table surveytaker(
	takerid char(6) primary key
);
create table response(
	takerid char(6) references surveytaker(takerid),
    course_id char(6) references course(course_id),
	qid char(8) references choice(qid),
    essayAnswer varchar(100),
    choiceid varchar(10) references choice(choiceid),
    primary key(takerid, course_id, qid)
);