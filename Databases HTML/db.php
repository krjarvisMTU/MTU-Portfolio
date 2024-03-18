<?php
    function connectDB() {
        $config = parse_ini_file("/local/my_web_files/mgbundsh/db.ini");
        $dbh = new PDO($config['dsn'], $config['username'], $config['password']);
        $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $dbh;
    }
    //return number of rows matching the given user and passwd.
    function authenticate($user, $passwd) {
        try {
            $dbh = connectDB();
            if ($_POST["login"] == "instructor") {
                $statement = $dbh->prepare("SELECT count(*) FROM instructor where account = :username and password = sha2(:passwd,256) ");
            } else {
                $statement = $dbh->prepare("SELECT count(*) FROM student where account = :username and password = sha2(:passwd,256) ");
            }
            $statement->bindParam(":username", $user);
            $statement->bindParam(":passwd", $passwd);
            $result = $statement->execute();
            $row=$statement->fetch();
            if ($row[0] == 1) {
                //set session role to be the proper role
                $_SESSION["role"] = ($_POST["login"] == "instructor") ? 'I' : 'S'; 
                if ($_POST["login"] == "instructor") {
                    $statement2 = $dbh->prepare("SELECT name FROM instructor where account = :username");
                } else {
                    $statement2 = $dbh->prepare("SELECT name FROM student where account = :username");
                }
                $statement2->bindParam(":username", $user);
                $statement2->execute();
                $_SESSION["name"] = $statement2->fetch();
                $_SESSION["username"] = $user;
                $dbh = null;
                return 1;
            } else { 
                $dbh = null;
                return 0; 
            }
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }
    
    //changes password
    function changePW($acc, $newP) {                        //Broken somewhere, needs fixing
        try {
            $dbh = connectDB();
            if ($_SESSION["role"] == "I") {
                $statement = $dbh->prepare("CALL change_password_instructor(:account ,:newPassword)");
                $statement->bindParam(":account", $acc, PDO::PARAM_STR);
                $statement->bindParam(":newPassword", $newP, PDO::PARAM_STR);
                $statement->execute();
                $dbh = null;
                return;
            } else {
                $statement = $dbh->prepare("CALL change_password_student(:account ,:newPassword)");
                $statement->bindParam(":account", $acc, PDO::PARAM_STR);
                $statement->bindParam(":newPassword", $newP, PDO::PARAM_STR);
                $statement->execute();
                $dbh = null;
                return;
            }
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //returns whether the user has logged in before
    function getFirstLogin($acc) {
        try{
            $dbh = connectDB();
            if ($_SESSION["role"] == "I") {
                $statement = $dbh->prepare("SELECT firstLogin FROM instructor WHERE account = :acc");
            } else {
                $statement = $dbh->prepare("SELECT firstLogin FROM student WHERE account = :acc");
            }
            $statement->bindParam(":acc", $acc);
            $statement->execute();
            $result = $statement->fetch()[0];
            $statement = null;
            return $result;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //return survey questions that were created for the course
    function getSurveyQ($course) {
        try{
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT description FROM question INNER JOIN course USING (course_id)  WHERE course.course_id = :course_id");
            $statement->bindParam(":course_id", $course);
            $statement->execute();
            $results = $statement->fetchAll();
            $dbh = null;
            return $results;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //returns departmental survey questions for a course
    function getSurveyQDept($course){
        try{
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT dept_name FROM course WHERE course_id = :course_id");
            $statement->bindParam(":course_id", $course);
            $statement->execute();
            $dept = $statement->fetch()[0];
            $statement = null;
            $statement = $dbh->prepare("SELECT description FROM question WHERE dept_name = :dept");
            $statement->bindParam(":dept", $dept);
            $statement->execute();
            $results = $statement->fetchAll();
            $dbh = null; $statement = null;
            return $results;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //returns university survey questions
    function getSurveyQUniv() {
        try{
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT description FROM question WHERE section = :u");
            $statement->bindValue(":u", "University");
            $statement->execute();
            $results = $statement->fetchAll();
            $dbh = null;
            return $results;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //return survey questions that were created for the course
    function getSurveyQids($course) {
        try{
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT qid FROM question INNER JOIN course USING (course_id)  WHERE course.course_id = :course_id");
            $statement->bindParam(":course_id", $course);
            $statement->execute();
            $results = $statement->fetchAll();
            $dbh = null;
            return $results;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //returns departmental survey questions for a course
    function getSurveyQidsDept($course){
        try{
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT dept_name FROM course WHERE course_id = :course_id");
            $statement->bindParam(":course_id", $course);
            $statement->execute();
            $dept = $statement->fetch()[0];
            $statement = null;
            $statement = $dbh->prepare("SELECT qid FROM question WHERE dept_name = :dept");
            $statement->bindParam(":dept", $dept);
            $statement->execute();
            $results = $statement->fetchAll();
            $dbh = null; $statement = null;
            return $results;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //returns university survey questions
    function getSurveyQidsUniv() {
        try{
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT qid FROM question WHERE section = :u");
            $statement->bindValue(":u", "University");
            $statement->execute();
            $results = $statement->fetchAll();
            $dbh = null;
            return $results;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //return question choices
    function getQuestionChoices($qid) {
        try {
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT choice.description FROM question INNER JOIN choice USING (qid) WHERE qid = :qid");
            $statement->bindParam(":qid", $qid);
            $statement->execute();
            $results = $statement->fetchAll();
            $dbh = null;
            return $results;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //return question choices
    function getQuestionChoiceIDs($qid) {
        try {
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT choice.choiceid FROM question INNER JOIN choice USING (qid) WHERE qid = :qid");
            $statement->bindParam(":qid", $qid);
            $statement->execute();
            $results = $statement->fetchAll();
            $dbh = null;
            return $results;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //returns choice description based on qid and choiceid
    function getChoiceDesc($qid, $choiceid) {
        try {
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT description FROM choice WHERE qid = :qid AND choiceid = :choiceid");
            $statement->bindParam(":qid", $qid);
            $statement->bindParam(":choiceid", $choiceid);
            $statement->execute();
            $result = $statement->fetch();
            $dbh = null;
            return $result;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //return if question is an essay or multiple choice
    function getQuestionType($qid) {
        try {
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT type FROM question WHERE qid = :qid");
            $statement->bindParam(":qid", $qid);
            $statement->execute();
            $result = $statement->fetch();
            $dbh = null;
            return $result;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //returns the description for a question
    function getDescription($qid) {
        try{
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT description FROM question where qid = :qid");
            $statement->bindParam(':qid', $qid);
            $statement->execute();
            $result = $statement->fetch();
            $statement = null;
            return $result;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //returns question section
    function getQuestionSection($qid) {
        try{
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT section FROM question where qid = :qid");
            $statement->bindParam(':qid', $qid);
            $statement->execute();
            $result = $statement->fetch();
            $statement = null;
            return $result;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    
    
/*
-----------------------------------------------------------------------------------------------------------------------INSTRUCTOR FUNCTIONS------------------------------------------------------------------------------------------
*/
    //return courses a teacher is assigned to
    function getCourses($user) {
        try {
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT course_id FROM course WHERE teacher = :username");
            $statement->bindParam(":username", $user);
            $statement->execute();
            $results = $statement->fetchALL();
            $dbh = null;
            return $results;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //returns course department
    function getCourseDept($course) {
        try{
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT dept_name FROM course WHERE course_id = :course_id");
            $statement->bindParam(":course_id", $course);
            $statement->execute();
            $result = $statement->fetch();
            $dbh = null;
            return $result;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }
    
    //return survey results
    function getSurveyResults($course) {
        try{
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT dept_name from course where course_id = :course");
            $statement->bindParam(":course", $course);
            $statement->execute();
            $dept = $statement->fetch();
            $statement = null;

            $statement = $dbh->prepare("SELECT qid from question where question.section = 'Departmental' and question.dept_name = :dept");
            $statement->bindParam(":dept", $dept["dept_name"]);
            $statement->execute();
            $deptQids = $statement->fetchAll();
            $statement = null;

            $statement = $dbh->prepare("SELECT qid from question where question.section = 'University'");
            $statement->execute();
            $univQids = $statement->fetchAll();
            $statement = null;
            
            $statement = $dbh->prepare("SELECT qid from question where question.course_id = :course");
            $statement->bindParam(":course", $course);
            $statement->execute();
            $courseQids = $statement->fetchAll();
            $statement = null;

            $qids = array_merge($univQids, $deptQids, $courseQids);
            $results = array();

            foreach ($qids as $qid) {
                $statement = $dbh->prepare("SELECT description, SUM(CASE WHEN response.choiceid = choice.choiceid THEN 1 ELSE 0 END) as frequency, 
                    CONCAT(FORMAT(SUM(CASE WHEN response.choiceid = choice.choiceid THEN 1 ELSE 0 END) / (SELECT COUNT(*) FROM enrolledIn WHERE course_id = :course) * 100.0, 2), '%') AS percent FROM choice
                    LEFT OUTER JOIN response using(qid) WHERE course_id = :course AND qid = :qid GROUP BY description, choice.choiceid ORDER BY choice.choiceid ASC");
                $statement->bindParam(":course", $course);
                $statement->bindParam(":qid", $qid["qid"]);
                $statement->execute();
                $result = $statement->fetchAll();
                $statement = null;

                // generate an HTML table for the result set
                $table = "<table>";
                $table .= "<tr><th>Description</th><th>Frequency</th><th>Percent</th></tr>";
                foreach ($result as $row) {
                    $table .= "<tr>";
                    $table .= "<td>" . $row['description'] . "</td>";
                    $table .= "<td>" . $row['frequency'] . "</td>";
                    $table .= "<td>" . $row['percent'] . "</td>";
                    $table .= "</tr>";
                }
                $table .= "</table>";

                // add the HTML table to the results array
                $results[] = $table;
            }

            $dbh = null;
            return $results;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //used to create a new survey question
    function createNewSQ($qid, $description, $type, $course_id) {
        try{
            $dbh = connectDB();
            $statement = $dbh->prepare("CALL add_question(:section, :qid, :description, :type, null, :course_id)");
            $section = 'Instructor';
            
            $statement->bindParam(':section', $section);
            $statement->bindParam(':qid', $qid, PDO::PARAM_STR);
            $statement->bindParam(':description', $description);
            $statement->bindParam(':type', $type);
            $statement->bindParam(':course_id', $course_id);
            $statement->execute();
            $statement = null;

            
            
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    function createNewSA($qid, $choice_id, $answer){
        try{
            $statement = $dbh ->prepare("CALL add_question_choice(:qid, :choice_id, :answer)");

            $statement->bindParam(':qid', $qid);
            $statement->bindParam(':choice_id', $choice_id);
            $statement->bindParam(':answer', $answer);
            $statement->execute();
            $statement = null;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }

    }

    //deletes a question based on its qid
    function deleteQuestion($qid){
        try{
            $dbh = connectDB();
            $statement = $dbh->prepare("DELETE FROM question WHERE qid = :qid");
            $statement->bindParam(':qid', $qid);
            $statement->execute();
            $statement = null;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //adds a question choice to a question
    function addQuestionChoice($qid, $choiceid, $desc) {
        try {
            $dbh = connectDB();
            $statement = $dbh->prepare("CALL add_question_choice(:qid, :choiceid, :desc)");
            $statement->bindParam(':qid', $qid);
            $statement->bindParam(':choiceid', $choiceid);
            $statement->bindParam(':desc', $desc);
            $statement->execute();
            $statement = null;
            $dbh = null;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //removes a question choice
    function removeQuestionChoice($qid, $choiceid) {
        try {
            $dbh = connectDB();
            $statement = $dbh->prepare("DELETE FROM choice WHERE qid = :qid AND choiceid = :choiceid");
            $statement->bindParam(':qid', $qid);
            $statement->bindParam(':choiceid', $choiceid);
            $statement->execute();
            $statement = null;
            $dbh = null;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

/*
-----------------------------------------------------------------------------------------------------------------------STUDENT FUNCTIONS---------------------------------------------------------------------------------------------
*/
    //return classes enrolled in
    function getClasses($user) {
        try {
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT course_id, timeCompleted FROM enrolledIn where account = :username");
            $statement->bindParam(":username", $user);
            $statement->execute();
            $results = $statement->fetchALL();
            $dbh = null;
            return $results;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    function studentRegister($user, $course_id) {
        try{
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT count(*) FROM course WHERE course_id = :course_id");
            $statement->bindParam(':course_id', $course_id);
            $statement->execute();
            $result = $statement->fetch()[0];
            if ($result != 1) {
                print "Class does not exist";
                return 1;
            }
            $statement = $dbh->prepare("CALL enroll_student(:user, :course_id)");
            $statement->bindParam(':user', $user);
            $statement->bindParam(':course_id', $course_id);
            $statement->execute();
            $statement = null;
            return 0;
        } catch (PDOException $e) {
            //print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //returns next takerid
    function getNewTakerID() {
        try {
            $dbh = connectDB();
            $statement = $dbh->prepare("SELECT * FROM surveytaker ORDER BY takerid DESC LIMIT 1");
            $statement->execute();
            $result = $statement->fetch()[0]+1;
            $result = str_pad($result, 6, '0', STR_PAD_LEFT);
            $statement=null;
            $dbh = null;
            return $result;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //enters an answer into the database
    function answerQuestion($qid, $takerid, $answer, $course) {
        try {
            $dbh = connectDB();
            $statement = $dbh->prepare("CALL answer_question(:takerid, :qid, :choiceid, :essayAns, :courseid)");
            $statement->bindParam(':takerid', $takerid);
            $statement->bindParam(':qid', $qid);
            $statement->bindParam(':courseid', $course);
            
            $questionType = getQuestionType($qid)[0];
            var_dump($questionType);
            if ($questionType == "MC") {
            $statement->bindParam(':choiceid', $answer);
            $statement->bindValue(':essayAns', null);
            } else {
            $statement->bindParam(':essayAns', $answer);
            $statement->bindValue(':choiceid', null);
            }
            /*
            echo "takerid: " . $takerid . "<br>";
            echo "qid: " . $qid . "<br>";
            echo "courseid: " . $course . "<br>";
            echo "choiceid: " . $answer . "<br>";
            echo "essayAns: " . null . "<br>";
            */
            $statement->execute();
            $statement=null;
            $dbh = null;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }

    //function completes a survey
    function completeSurvey($user) {
        try {
            $dbh = connectDB();
            $statement = $dbh->prepare("CALL complete_survey(:user, now())");
            $statement->bindParam(":user", $user);
            $statement->execute();
            $statement=null;
            $dbh = null;
        } catch (PDOException $e) {
            print "Error!" . $e->getMessage() . "<br/>";
            die();
        }
    }
?>