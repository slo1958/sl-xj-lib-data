#tag Class
Protected Class clDataRowBuffer
	#tag Method, Flags = &h0
		Sub AddingDone()
		  
		  self.rowCountFrozen = true
		  
		  return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddRow(row as clDataRow)
		  
		  if self.rowCountFrozen then Return
		  
		  rows.Add(row)
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		  self.CurrentRowIndex = -1
		  self.rowCountFrozen = false
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndOfBuffer() As Boolean
		  Return self.CurrentRowIndex > rows.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNextRow() As clDataRow
		  
		  self.CurrentRowIndex = self.CurrentRowIndex + 1
		  
		  if self.CurrentRowIndex > rows.LastIndex then
		    return nil
		    
		  end if
		  
		  return rows(self.CurrentRowIndex)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetIndex()
		  self.CurrentRowIndex = -1
		  
		  return
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		CurrentRowIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		rowCountFrozen As Boolean
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
