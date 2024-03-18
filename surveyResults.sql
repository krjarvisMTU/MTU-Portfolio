select * from enrolledIn;
select * from student;
select * from department;
select * from course;
select * from instructor;
select * from survey;
select * from question;
select * from choice;

/*
	course report for CS2321
*/
select title from course where course_id = "CS2321";
select name from instructor where account = (select teacher from course where course_id = "CS2321");

select count(*) from (select count(*) from response where course_id = "CS2321" group by takerid)h;

select description, 
		(select count(*) from response left outer join choice on response.qid = choice.qid where course_id = "CS2321" and response.qid = "u0000001" and response.choiceid = choice.choiceid) as freq,
        (select count(*) from enrolledIn where course_id = "CS2321") as percent
	from response left outer join choice 
	on response.qid = choice.qid
	where course_id = "CS2321" and response.qid = "u0000001"
	group by choice.description
;

select *
from response left outer join choice 
on response.qid = choice.qid
where course_id = "CS2321" and response.qid = "u0000001"
;
