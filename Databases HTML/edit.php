<html>
    <?php
        session_start();
    ?>
    <form action="main.php" method="post">
            <button type="submit" value="goHome" name="goHome"> Go Back </button>
    </form>
    <?php
        require "db.php";
        if (isset($_POST["edit"])) {              //editing questions
            $options = getCourses($_SESSION["username"]);
            ?>
                <form action="edit.php" method="post">
                    <label for="options"> Select a course survey to edit: </label>
                    <select id="options" name="options">
                        <?php foreach ($options as $course) { ?>
                            <option value="<?php echo implode(",", array_unique($course)); ?>"><?php echo implode(" - ", array_unique($course)); ?></option>
                        <?php } ?>
                    </select>
                    <button type="submit" name="submit"> Edit </button>
                </form>
    <?php }
        if (isset($_POST["submit"])) {
            $_SESSION["editCourse"] = $_POST["options"];
        ?>
            <form action="edit.php" method="post">
                <button type="submit" value="newQuestion" name="newQuestion"> New Question </button>
            </form>
        <?php
            $qids = getSurveyQids($_POST["options"]);
            echo '<ul>';
            foreach ($qids as $q) {
                $qid = $q[0];
                echo '<li>' . getDescription($qid)[0] . '</li>';    //print question description
                ?>
                    <form action="edit.php" method="post">
                        <button type="submit" value="<?php echo $qid ?>" name="delete"> Delete Question </button>
                        <?php if (getQuestionType($qid)[0] == "MC") { ?>
                            <button type="submit" value="<?php echo $qid ?>" name="addchoice"> Add Choice </button>
                        <?php } ?>
                    </form>
                <?php
                $choices = getQuestionChoiceIDs($qid);
                echo '<ul>';
                ?> <form action="edit.php" method="post"> <?php
                foreach ($choices as $c) {                          //loop to print question choice descriptions
                    if (getQuestionType($qid)[0] == "Essay") {
                        echo '<li>' . "Essay Question" . '</li>';
                    } else {
                        echo '<li>' . getChoiceDesc($qid, $c[0])[0] . '</li>'; ?>
                        <input type="hidden" name="qid" value="<?php echo $qid ?>">
                        <button type="submit" name="deletechoice" value="<?php echo $c[0]; ?>"> Delete Choice </button>
                        <?php
                    }
                }
                ?> </form> <?php
                echo '</ul>';
            }
            echo '</ul>';
        }
        
        if (isset($_POST["delete"])) {
            deleteQuestion($_POST["delete"]);
            echo '<p style="color:green">Question removed.</p>';
        }

        if (isset($_POST["deletechoice"])) {
            removeQuestionChoice($_POST["qid"], $_POST["deletechoice"]);
            echo '<p style="color:green">Choice removed.</p>';
        }

        if (isset($_POST["addchoice"])) {
            var_dump($_POST["addchoice"]);
            ?> <form action="edit.php" method="post"> 
                    <label for="choiceid">Choice ID (A, B, C,...):</label>
                    <input type="text" name="choiceid"><br>
                    <label for="desc">Choice description:</label>
                    <textarea name="desc" rows="3"></textarea><br>
                    <button type="submit" name="submitchoice" value="<?php echo $_POST["addchoice"]; ?>">Submit</button>
            </form> <?php
        }

        if (isset($_POST["submitchoice"])) {
            var_dump($_POST["submitchoice"], $_POST["choiceid"], $_POST["desc"]);
            addQuestionChoice($_POST["submitchoice"], $_POST["choiceid"], $_POST["desc"]);
            echo '<p style="color:green">Choice added.</p>';
        }

        if (isset($_POST["newQuestion"])) {
            ?>
                <form action="edit.php" method="post">
                    <label for="newQid">Question ID:</label>
                    <input type="text" name="newQid" id="newQid"><br>
                    <label for="description">Description:</label>
                    <input type="text" name="description" id="description"><br>
                    <select id="type" name="type">
                        <option value="MC"> Multiple choice</option>
                        <option value="Essay">Essay</option>
                    </select><br>
                    <button type="submit" name="submitQ">Submit</button>
                </form>
            <?php
        }
        if (isset($_POST["submitQ"])) {
            $newQ = createNewSQ($_POST["newQid"], $_POST["description"], $_POST["type"], $_SESSION["editCourse"]);
        }
    ?>
</html>