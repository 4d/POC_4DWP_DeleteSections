//%attributes = {}
#DECLARE($section : Object; $properties : Object)

var $sub : Object
var $property : Text

For each ($property; $properties.list)
	WP SET ATTRIBUTES:C1342($section; $property; $properties.list[$property])
End for each 

If ($properties.subFirst) && (WP Get subsection:C1582($section; wk first page:K81:203)=Null:C1517)
	$sub:=WP New subsection:C1583($section; wk first page:K81:203)
End if 

If ($properties.subLeftRight) && (WP Get subsection:C1582($section; wk left page:K81:204)=Null:C1517)
	$sub:=WP New subsection:C1583($section; wk left page:K81:204)
End if 