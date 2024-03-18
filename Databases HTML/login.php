<html>
<head>
  <link rel="stylesheet" href="style.css">
</head>
    <?php
        session_start();
        if(!isset($_POST["login"])) {
    ?>
    <div class="container">
        <form action="login.php" method="post">
        <label for = "username"> Enter your username: </label>
        <input type = "text" name = "username" id = "username" required>
        <br>
        <label for = "password"> Enter your password: </label>
        <input type = "password" name = "password" id = "password" required>
        <br>
        <button type="submit" name="login" value="instructor"> Instructor Login </button><br>
        <button type="submit" name="login" value="student"> Student Login </button>
        
        <?php
        }
            require "db.php";
            // user clicked the login button */
            if ( isset($_POST["login"]) ) {
                //check the username and passwd, if correct, redirect to main.php page
                if (authenticate($_POST["username"], $_POST["password"]) ==1) {
                    //check for first time login and change password if so
                    if (getFirstLogin($_SESSION["username"]) == 1) {
                        ?>  
                        <div class="header">
                        <label for="newlog" text-align="center">New password required upon first time login: </label>
                        </div>
                    <div class="container">
                        <div class="button-container">
                            <br><br>
                            <form action="login.php" method="post">
                                <label for = "newPass"> Enter new password: </label>
                                <input type = "password" name = "newPass1" id = "newPass1" required><br>
                                <label for = "newPass"> Enter new password again: </label>
                                <input type = "password" name = "newPass2" id = "newPass2" required>
                                <button type="submit" name="change" value="change"> Change password </button>
                            </form>
                        </div>
                    </div>
                        <?php
                    } else {
                        //redirect after succesful login
                        header("LOCATION:main.php");
                        return;    
                    }
                    return;
                } else {
                    echo '<p style="color:red">incorrect username and password</p>';
                    return;
                }
            }
            if (isset($_POST["change"])) {
                if ($_POST["newPass1"] != $_POST["newPass2"]) {
                    echo "Passwords do not match!";
                } else {
                    changePW($_SESSION["username"], $_POST["newPass1"]);
                    //redirect after succesful login
                    header("LOCATION:login.php");
                    return;
                }
            }

            if (isset($_POST["logout"])) {
                session_destroy();
            }
        ?>
    </form>
    </div>
</html>