<html>
    <?php
        session_start();
    ?>
        <form action="main.php" method="post">
            <button type="submit" value="goHome" name="goHome"> Go Back </button>
        </form>
    <?php
        require "db.php";
        if (isset($_POST["review"])) {              //reviewing questions
            $options = getCourses($_SESSION["username"]);
            ?>
                <form action="review.php" method="post">
                    <label for="options"> Select a course to review: </label>
                    <select id="options" name="options">
                        <?php foreach ($options as $course) { ?>
                            <option value="<?php echo implode(",", array_unique($course)); ?>"><?php echo implode(" - ", array_unique($course)); ?></option>
                        <?php } ?>
                    </select>
                    <button type="submit" name="submit"> Review </button>
                </form>
        <?php } ?>
        <?php
        if (isset($_POST["submit"])) {
            $results = getSurveyResults($_POST["options"]);
            foreach ($results as $table) {
                echo $table;
            }
        }
    ?>
</html>