#tag Class
Protected Class clRowParser_simple_delimited
Inherits clRowParser_generic
	#tag Method, Flags = &h0
		Sub Constructor(the_delimiter as string)
		  If the_delimiter.Len <> 1 Then
		    delimiter = Chr(9)
		    
		  Else
		    delimiter = the_delimiter
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function parse_line(the_line as String) As string()
		  Dim ret() As String
		  
		  ret = the_line.Split(delimiter)
		  
		  Return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function serialize_line(the_data() as String) As string
		  Dim res As String
		  
		  Dim tmp_data() As String
		  
		  tmp_data = the_data
		  
		  res = Join(tmp_data, delimiter)
		  
		  Return res
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		delimiter As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="delimiter"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
