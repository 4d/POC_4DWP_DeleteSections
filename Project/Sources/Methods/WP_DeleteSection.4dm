//%attributes = {}
#DECLARE($document : Object; $sectionID : Integer)

var $elems; $breaks : Collection
var $elem; $range; $section; $attributes : Object
var $start; $end : Integer
var $delete : Boolean


$breaks:=WP Get breaks:C1768($document).query("breakType = :1"; wk section break:K81:187)
If ($breaks.length>0)
	If ($sectionID<=($breaks.length+1))
		
		
		// REMOVE PICTURES ANCHORED TO THIS SECTION  (IF ANY)
		$elems:=WP Get elements:C1550($document; wk type image anchored:K81:248)
		For each ($elem; $elems)
			If ($elem.anchorSection=$sectionID)
				WP DELETE PICTURE:C1701($elem)
			End if 
		End for each 
		
		
		// REMOVE TEXT BOXES ANCHORED TO THIS SECTION  (IF ANY)
		$elems:=WP Get elements:C1550($document; wk type text box:K81:372)
		For each ($elem; $elems)
			If ($elem.anchorSection=$sectionID)
				WP DELETE TEXT BOX:C1798($elem)
			End if 
		End for each 
		
		
		// SELECT THE SECTION RANGE
		Case of 
			: ($sectionID=1)  // first
				$start:=1
				$end:=$breaks[0].end
				
			: ($sectionID>$breaks.length)  //last
				$start:=$breaks[$sectionID-2].start
				$end:=MAXLONG:K35:2
				
			Else 
				$start:=$breaks[$sectionID-2].end
				$end:=$breaks[$sectionID-1].end
		End case 
		
		
		// avoid Word behaviour: memorize the attributes of the last-1 section !
		If ($sectionID=($breaks.length+1))  // LAST SECTION
			$section:=WP Get section:C1581($document; $sectionID-1)  // READ PREVIOUS SECTION !
			$attributes:=WP_GetSectionAttributes($section)
		End if 
		
		// REMOVE THE SECTION ITSELF
		$range:=WP Text range:C1341($document; $start; $end)
		WP SET TEXT:C1574($range; ""; wk replace:K81:177)  // Replace break by "" = remove break
		
		// Avoid Word behaviour: set properties as before !
		If ($sectionID=($breaks.length+1))  // LAST SECTION = FIRST SECTION
			WP_SetSectionAttributes($section; $attributes)
		End if 
		
		
		//FINALY UN-SHIT anchorSection IDs OF PICTURES AND TEXTBOXES
		$elems:=WP Get elements:C1550($document; wk type image anchored:K81:248)
		For each ($elem; $elems)
			If ($elem.anchorSection>$sectionID)
				$elem.anchorSection-=1
			End if 
		End for each 
		
		$elems:=WP Get elements:C1550($document; wk type text box:K81:372)
		For each ($elem; $elems)
			If ($elem.anchorSection>$sectionID)
				$elem.anchorSection-=1
			End if 
		End for each 
		
	Else 
		ALERT:C41("This section does not exist. Deletion is impossible.")
	End if 
Else 
	ALERT:C41("No section breaks; Deletion is impossible.")
End if 



