#tag Class
Protected Class clNumberLocalParser
Inherits clNumberParser
	#tag Method, Flags = &h0
		Sub Constructor()
		  super.Constructor
		  
		  self.GroupingChar = Locale.Current.GroupingSeparator
		  self.DecimalMarkChar = Locale.Current.DecimalSeparator
		  
		End Sub
	#tag EndMethod


End Class
#tag EndClass
