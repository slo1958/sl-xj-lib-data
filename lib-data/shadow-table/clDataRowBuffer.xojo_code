#tag Class
Protected Class clDataRowBuffer
	#tag Method, Flags = &h0
		Sub AddRow(row as clDataRow)
		  
		  rows.Add(row)
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		  self.CurrentRowIndex = -1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndOfBuffer() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetIndex()
		  self.CurrentRowIndex = -1
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		CurrentRowIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		rows() As clDataRow
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
			Name="rows()"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
