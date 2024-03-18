<html>
<head>
  <link rel="stylesheet" href="style.css">
</head>
    <?php
        session_start();
        require "db.php";
        if (!isset($_SESSION["name"])) {
            header("LOCATION:login.php");
        }
    ?>
    
        <div class="header">
            <?php echo '<p align="center"> Welcome '. $_SESSION["name"]["name"].'</p>'; ?>
            <form action = "login.php" method="post">
                <div class="button-container"> 
                <button type="submit" value="logout" name="logout">Log out</button>
                </div>
            </form>
        </div>
    <?php
    if (isset($_POST["goHome"])) {
        header("LOCATION:main.php");
    }
    ?>
    <div class="container">
    <?php
        if ($_SESSION["role"] == "I") {                             //INSTRUCTOR MAIN PAGE
            ?>
            <div>
                <form method="post" action="review.php">
                    <div class="inline">
                        <button type="submit" value="review" name="review">Review Course Survey Problems</button>
                    </div>
                </form>
                <form method="post" action="edit.php">
                    <div class="inline">
                        <button type="submit" value="edit" name="edit">Edit Surveys</button>
                    </div>
                </form>
            </div>
            <?php
            $courses = getCourses($_SESSION["username"]);
            echo '<ul>';
            foreach ($courses as $row) {
                echo '<li>' . $row['course_id'] . '</li>';
                $surveyQs = getSurveyQ($row[0]);
                echo '<ul>';
                foreach ($surveyQs as $row1) {
                    echo '<li>' . $row1['description'] . '</li>';
                }
                echo '</ul>';
            }
            echo '</ul>';
        }



        if ($_SESSION["role"] == "S") {                             //STUDENT MAIN PAGE
            ?>
                <form method="post" action="main.php">
                    <div class="inline">
                        <input type="text" name="newClass" id="newClass">
                        <button type="submit" value="register" name="register">Register for a New Course</button>
                    </div>
                </form>
            <?php
            $classes = getClasses($_SESSION["username"]);
            echo '<ul>';
            foreach ($classes as $row) {
                $time = $row['timeCompleted'] == null ? 'Not completed' : $row['timeCompleted'];
                echo '<li>' . $row['course_id'] . "        Survey completed: " . $time . '</li>';
                if($row['timeCompleted'] == null) {
                    ?>
                        <form method="post" action ="takeSurvey.php">
                            <div class="inline">
                                <button type="submit" value="<?php echo $row['course_id']; ?>" name="takeSurvey">Take the survey for this class</button>
                            </div>
                        </form>
                    <?php
                }
            }
            echo '</ul>';
            


            if(isset($_POST["register"])) {
                    if (studentRegister($_SESSION["username"], $_POST["newClass"]) == 0) {
                        echo '<p style="color:black">You have been added to ' . $_POST["newClass"] . ', page reloading...</p>';
                        // Refresh the page after 5 seconds
                        echo '<script>setTimeout(function(){location.reload();}, 2000);</script>';
                }
            }
        }
    ?>
    </div>
</html>