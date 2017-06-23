<?php

// get the application root folder
define('APP_ROOT', getcwd());

// perform delete operation only if the install is complete
if ( @file_exists(APP_ROOT . '/config.php') && @file_exists(APP_ROOT . '/admin/config.php') ) {
	// install directory path
	$install_dir = APP_ROOT . '/install';
	if ( is_dir($install_dir) ) {
		// delete the install directory
		$deleted = del_dir($install_dir);
		// after removing the install folder redirect to home page.
		if ( $deleted ) {
			header('Location: ./');
		}
		else {
			echo "Can't delete the install directory. Please check the permissions of install directory.";
		}
	} else {
		header('Location: ./');
	}
}
else {
	echo "Something wrong with your phpBB installation, please make sure that phpBB is installed completely";
}

/**
 * Delete a directory recursively
 * 
 * @param $dir String Directory to be removed
 * 
 * @return Boolean true on success
 */
function del_dir($dir) {
	$fp = opendir($dir);
	if ( $fp ) {
		while ( $current_file = readdir($fp) ) {
			$full_file = $dir . "/" . $current_file;
			// if the curent path is a directory call the del_dir again, else delete the file directly
			if ( $current_file == "." || $current_file == ".." ) {
				continue;
			}
			else if ( is_dir($full_file) ) {
				del_dir($full_file);
			}
			else {
				unlink($full_file);
			}
		}
		closedir($fp);
		// after making the directory empty call the rmdir to delete the empty root directory
		return rmdir($dir);
	}
}
