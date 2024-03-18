<html>
    <?php
    session_start();
    require "db.php";
    ?> 
    <form action="main.php" method="post">
        <button type="submit" value="goHome" name="goHome"> Go Back </button>
    </form> 
    <?php    
    if (isset($_POST["takeSurvey"])) {
        $course = $_POST["takeSurvey"];
        $qids = array_merge(getSurveyQidsUniv(), getSurveyQidsDept($course), getSurveyQids($course));
        if ($qids) { ?>
            <body>
        <?php
        $university = false;
        $departmental = false;
        $instructor = false;
        ?> <form action="takeSurvey.php" method="post"> <?php
        foreach ($qids as $q) {
            if ($university == false && getQuestionSection($q['qid'])[0] == "University") {
                echo '<hr><p style="font-size:200%"> University Questions</p>'; $university = true;
            } else if ($departmental == false && getQuestionSection($q['qid'])[0] == "Departmental") {
                echo '<hr><p style="font-size:200%"> Departmental Questions</p>'; $departmental = true;
            } else if ($instructor == false && getQuestionSection($q['qid'])[0] == "Instructor") {
                echo '<hr><p style="font-size:200%"> Instructor Questions</p>'; $isntructor = true;
            }
            ?> <div> <?php
            echo '<p style="color:black;">' . getDescription($q['qid'])[0] . '</p>';
            $choiceIDs = getQuestionChoiceIDs($q['qid']);
            if (getQuestionType($q['qid'])[0] == "MC") {
                foreach($choiceIDs as $c) { ?>
                    <input type="radio" name="<?php echo $q['qid']; ?>" value="<?php echo $c[0]; ?>">
                    <label for="<?php echo $c[0]; ?>"><?php echo getChoiceDesc($q['qid'], $c[0])[0]; ?></label><br>
            <?php }
            } else { ?>
                    <textarea name="<?php echo $q['qid']; ?>" rows="5"></textarea>
            <?php } ?>  </div> <?php
        } ?>
                <button type="submit" name="submitSurvey" value="<?php echo $course; ?>">Submit Survey</button>
            </form>
        </body>
    <?php
        } else {
            echo '<p style="color:red">Error retrieving survey questions.</p>';
        }
    }

    if (isset($_POST["submitSurvey"])) {
        $course = $_POST["submitSurvey"];
        $qids = array_merge(getSurveyQidsUniv(), getSurveyQidsDept($course), getSurveyQids($course));
        $takerid = getNewTakerID();
        foreach ($qids as $q) {
            if (isset($_POST[$q['qid']])) {
                answerQuestion($q['qid'], $takerid, $_POST[$q['qid']], $course);
            }
        }
        completeSurvey($_SESSION["username"]);
        echo '<p style="color:green">Survey completed.</p>';
        //var_dump($_POST);
        header("LOCATION: main.php");
    }
    ?>
</html>