<?php
if ($_POST['username']=="adarsh" && $_POST['password']=="12345") {
	echo("<h2>Welcome ".$_POST['username']."</h2>");
}
else {
	echo("<h2>You do not have access</h2>");
}
?>
