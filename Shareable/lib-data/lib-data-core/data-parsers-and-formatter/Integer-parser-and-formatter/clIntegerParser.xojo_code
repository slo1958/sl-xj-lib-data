#tag Class
Protected Class clIntegerParser
Implements IntegerParserInterface
	#tag Method, Flags = &h0
		Sub Constructor()
		  
		  self.GroupingChar = ","
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetInfo() As string
		  Return ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParseToInteger(the_value as string) As integer
		  // Part of the IntegerParserInterface interface.
		  
		  var tmp as string = the_value.trim
		  
		  tmp = tmp.ReplaceAll(self.GroupingChar, "")
		  
		  var tmp_sign as integer = 0
		  
		  if tmp.left(1) = "+" then 
		    tmp = tmp.mid(2,999)
		    tmp_sign = 1
		    
		  end if
		  
		  if tmp.left(1) = "-" then
		    tmp = tmp.mid(2,999)
		    tmp_sign = -1
		    
		  end if
		  
		  if tmp.right(1) = "+" and tmp_sign = 0 then 
		    tmp = tmp.left(tmp.Length-1)
		    tmp_sign = 1
		  end if
		  
		  if tmp.right(1) = "-" and tmp_sign = 0then
		    tmp = tmp.left(tmp.Length-1)
		    tmp_sign = -1
		    
		  end if
		  
		  if tmp_sign = 0 then tmp_sign = 1
		  
		  
		  return UnsignedConversion(tmp) * tmp_sign
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function UnsignedConversion(Value as string) As integer
		  
		  const mask as string  = "0123456789"
		  
		  var acc as integer
		  
		  for i as integer = 0 to value.Length
		    var j as integer = mask.IndexOf(value.mid(i,1))
		    if j < 0 then return 0
		    
		    acc = acc * 10 + j
		    
		  next
		  
		  return acc
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		GroupingChar As string
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GroupingChar"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
