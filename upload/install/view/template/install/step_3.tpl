<?php echo $header; ?>
<?php
//db info 

$connectstr_dbhost = '';
$connectstr_dbname = '';
$connectstr_dbusername = '';
$connectstr_dbpassword = '';
if (isset($_SERVER['MYSQLCONNSTR_localdb']))
{
//Windows app service
foreach ($_SERVER as $key => $value) {
    if (strpos($key, "MYSQLCONNSTR_") !== 0) {
        continue;
    }
    
    $connectstr_dbfullhost = preg_replace("/^.*Data Source=(.+?);.*$/", "\\1", $value);
    $connectstr_dbhost = substr($connectstr_dbfullhost, 0 , strpos($connectstr_dbfullhost ,":"));
    $connectstr_dbname = preg_replace("/^.*Database=(.+?);.*$/", "\\1", $value);
    $connectstr_dbusername = preg_replace("/^.*User Id=(.+?);.*$/", "\\1", $value);
    $connectstr_dbpassword = preg_replace("/^.*Password=(.+?)$/", "\\1", $value);
   }
}
//Port for MYSQL in-app or ClearDB 
    $connectstr_port = getenv('WEBSITE_MYSQL_PORT');
    if (empty($connectstr_port))
    {
      $connectstr_port= 3306;
    }

?>

<div class="container">
  <header>
    <div class="row">
      <div class="col-sm-6">
        <h1 class="pull-left">3<small>/4</small></h1>
        <h3><?php echo $heading_title; ?><br>
          <small><?php echo $text_step_3; ?></small></h3>
      </div>
      <div class="col-sm-6">
        <div id="logo" class="pull-right hidden-xs"> <img src="view/image/logo.png" alt="OpenCart" title="OpenCart" /> </div>
      </div>
    </div>
  </header>
  <?php if ($error_warning) { ?>
  <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="row">
    <div class="col-sm-9">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
        <p><?php echo $text_db_connection; ?></p>
        <fieldset>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-db-driver"><?php echo $entry_db_driver; ?></label>
            <div class="col-sm-10">
              <select name="db_driver" id="input-db-driver" class="form-control">
                <?php if ($mysqli) { ?>
                <?php if ($db_driver == 'mysqli') { ?>
                <option value="mysqli" selected="selected"><?php echo $text_mysqli; ?></option>
                <?php } else { ?>
                <option value="mysqli"><?php echo $text_mysqli; ?></option>
                <?php } ?>
                <?php } ?>
                <?php if ($pdo) { ?>
                <?php if ($db_driver == 'mpdo') { ?>
                <option value="mpdo" selected="selected"><?php echo $text_mpdo; ?></option>
                <?php } else { ?>
                <option value="mpdo"><?php echo $text_mpdo; ?></option>
                <?php } ?>
                <?php } ?>
                <?php if ($pgsql) { ?>
                <?php if ($db_driver == 'pgsql') { ?>
                <option value="pgsql" selected="selected"><?php echo $text_pgsql; ?></option>
                <?php } else { ?>
                <option value="pgsql"><?php echo $text_pgsql; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-db-hostname"><?php echo $entry_db_hostname; ?></label>
            <div class="col-sm-10">$entry_db_hostname;
              <input type="text" name="db_hostname" value="<?php echo  $connectstr_dbhost ; ?>" id="input-db-hostname" class="form-control" />
              <?php if ($error_db_hostname) { ?>
              <div class="text-danger"><?php echo $error_db_hostname; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-db-username"><?php echo $entry_db_username; ?></label>
            <div class="col-sm-10">
              <input type="text" name="db_username" value="<?php echo  $connectstr_dbusername; ?>" id="input-db-username" class="form-control" />
              <?php if ($error_db_username) { ?>
              <div class="text-danger"><?php echo $error_db_username; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-db-password"><?php echo $entry_db_password; ?></label>
            <div class="col-sm-10">
              <input type="password" name="db_password" value="<?php echo  $connectstr_dbpassword; ?>" id="input-db-password" class="form-control" />
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-db-database"><?php echo $entry_db_database; ?></label>
            <div class="col-sm-10">
              <input type="text" name="db_database" value="<?php echo $connectstr_dbname; ?>" id="input-db-database" class="form-control" />
              <?php if ($error_db_database) { ?>
              <div class="text-danger"><?php echo $error_db_database; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-db-port"><?php echo $entry_db_port; ?></label>
            <div class="col-sm-10">
              <input type="text" name="db_port" value="<?php echo $connectstr_port; ?>" id="input-db-port" class="form-control" />
              <?php if ($error_db_port) { ?>
              <div class="text-danger"><?php echo $error_db_port; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-db-prefix"><?php echo $entry_db_prefix; ?></label>
            <div class="col-sm-10">
              <input type="text" name="db_prefix" value="<?php echo $db_prefix; ?>" id="input-db-prefix" class="form-control" />
              <?php if ($error_db_prefix) { ?>
              <div class="text-danger"><?php echo $error_db_prefix; ?></div>
              <?php } ?>
            </div>
          </div>
        </fieldset>
        <p><?php echo $text_db_administration; ?></p>
        <fieldset>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-username"><?php echo $entry_username; ?></label>
            <div class="col-sm-10">
              <input type="text" name="username" value="<?php echo $username; ?>" id="input-username" class="form-control" />
              <?php if ($error_username) { ?>
              <div class="text-danger"><?php echo $error_username; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-password"><?php echo $entry_password; ?></label>
            <div class="col-sm-10">
              <input type="text" name="password" value="<?php echo $password; ?>" id="input-password" class="form-control" />
              <?php if ($error_password) { ?>
              <div class="text-danger"><?php echo $error_password; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
            <div class="col-sm-10">
              <input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control" />
              <?php if ($error_email) { ?>
              <div class="text-danger"><?php echo $error_email; ?></div>
              <?php } ?>
            </div>
          </div>
        </fieldset>
        <div class="buttons">
          <div class="pull-left"><a href="<?php echo $back; ?>" class="btn btn-default"><?php echo $button_back; ?></a></div>
          <div class="pull-right">
            <input type="submit" value="<?php echo $button_continue; ?>" class="btn btn-primary" />
          </div>
        </div>
      </form>
    </div>
    <div class="col-sm-3"><?php echo $column_left; ?></div>
  </div>
</div>
<?php echo $footer; ?>