
<?php

// Get the current default response code
//var_dump(http_response_code()); // int(200)

// Set our response code
//http_response_code(404);

// Get our new response code
//var_dump(http_response_code()); // int(404)

header('HTTP/1.0 404 Not Found');
 
?>
