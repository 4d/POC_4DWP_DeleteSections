var $path : Text

CONFIRM:C162("Are you sure ?")
If (ok=1)
	$path:=File:C1566("/RESOURCES/demo.4wp").platformPath
	WP EXPORT DOCUMENT:C1337(WParea; $path; wk 4wp:K81:4)
End if 