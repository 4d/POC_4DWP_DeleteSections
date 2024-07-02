//%attributes = {}
#DECLARE($section : Object)->$properties : Object

var $attributes : Collection
var $attribute : Text

$attributes:=WP_GetAttributesCollection("section")

$properties:=New object:C1471
$properties.list:=New object:C1471

For each ($attribute; $attributes)
	If (Not:C34(Undefined:C82($section[$attribute])))
		$properties.list[$attribute]:=$section[$attribute]
	End if 
End for each 

$properties.subFirst:=(WP Get subsection:C1582($section; wk first page:K81:203)#Null:C1517)
$properties.subLeftRight:=(WP Get subsection:C1582($section; wk left page:K81:204)#Null:C1517)



