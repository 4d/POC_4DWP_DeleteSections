//%attributes = {}
#DECLARE($section : Object)

var $attributes : Collection
var $attribute : Text

$attributes:=WP_GetAttributesCollection("section")

For each ($attribute; $attributes)
	WP RESET ATTRIBUTES:C1344($section; $attribute)
End for each 


