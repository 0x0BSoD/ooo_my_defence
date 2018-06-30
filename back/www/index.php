<? include "getter.php"; ?>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>ООО! Моя оборона</title>
  </head>
  <body>
    <h2>DB connection status: <?php echo $state ?></h2>
    <hr>
    <h1>Output: <?php echo $result ?></h1>
    <hr>
    <h1><?php if ($error) {
      echo $error;
    }?></h1>
  </body>
</html>
