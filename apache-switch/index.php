<?php
// file modified from https://github.com/srgi79/tinwoo_home_server
$MOTD = "NAS Tinwoo Shop";
$EXT = ['nsp','xci','nsz','xcz'];
$FOLDER = "games";
$WEB_FOLDER = "/";
$SERVER = "http://192.168.0.6";
$PORT = "7000";

$dir = new DirectoryIterator($FOLDER."/");
foreach ($dir as $fileinfo) {
	if (!$fileinfo->isDot()) {
		if ($fileinfo->isDir()) {
			$DIR1 = $FOLDER;
			$DIR2 = $fileinfo->getBasename();
			$dir2 = new DirectoryIterator($FOLDER."/".$fileinfo->getBasename());
			foreach ($dir2 as $fileinfo2) {
				if ($fileinfo2->isFile()) {
					if (in_array($fileinfo2->getExtension(),$EXT)) {
						$arrFiles [] = [
							'url'=>$SERVER.":".$PORT.$WEB_FOLDER.rawurlencode($DIR1)."/".rawurlencode($DIR2)."/".rawurlencode($fileinfo2->getFilename()),
							'size'=> $fileinfo2->getSize()];
						$arrDir [] = [];
					}
				}
			}
		} elseif (!$fileinfo->isFile()) {
			if (in_array($fileinfo->getExtension(),$EXT)) {
				$arrFiles [] = [
					'url'=>$SERVER.":".$PORT.$WEB_FOLDER.rawurlencode($DIR1)."/".rawurlencode($fileinfo->getFilename()),
					'size'=> $fileinfo->getSize()];
				$arrDir [] = [];
			}
		}
	}
}

asort($arrFiles);
asort($arrDir);

$outObj['files'] = array_values($arrFiles);
$outObj['directories'] = [];
$outObj['success'] = $MOTD;

echo json_encode($outObj);
?>
