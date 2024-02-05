<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP 8.3 - Ubuntu Projects</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>

<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8 g-4">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h1>Project List</h1>
                        <a class="btn btn-sm btn-success" href="phpinfo.php">phpInfo</a>
                    </div>
                    <div class="card-body">
                        <ul class="list-group">
                            <?php
                            // Define the directory to scan
                            $directory = './';

                            // Check if the directory exists
                            if (is_dir($directory)) {
                                // Open the directory
                                if ($handle = opendir($directory)) {
                                    // Loop through the directory
                                    while (($folder = readdir($handle)) !== false) {
                                        // Exclude current and parent directories
                                        if ($folder != "." && $folder != "..") {
                                            // Check if it's a directory
                                            if (is_dir($directory . $folder)) {
                            ?>
                                                <li class="list-group-item">
                                                    <a href="<?php echo $directory . $folder; ?>">
                                                        <i class="fas fa-folder me-2"></i><?php echo $folder; ?>
                                                    </a>
                                                </li>
                            <?php
                                            }
                                        }
                                    }
                                    // Close directory handle
                                    closedir($handle);
                                }
                            } else {
                                echo '<li class="list-group-item">No Project in list!</li>';
                            }
                            ?>
                        </ul>
                    </div>
                </div>
            </div>
        </div>


    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <!-- FontAwesome Script -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>

</html>