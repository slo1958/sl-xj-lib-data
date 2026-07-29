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
		  
		  self.LastReturnedRowIndex = -1
		  self.rowCountFrozen = false
		  self.IsLastBuffer = False
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndOfBuffer() As Boolean
		  Return self.LastReturnedRowIndex >= rows.LastIndex
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnNames() As string()
		  var ret() as String
		  
		  if rows.LastIndex < 0 then return ret
		  
		  if rows(0) = nil then return ret
		  
		  return rows(0).getCellNames
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNextRow() As clDataRow
		  
		  if self.LastReturnedRowIndex >= rows.LastIndex then
		    return nil
		    
		  end if
		  
		  self.LastReturnedRowIndex = self.LastReturnedRowIndex + 1
		  
		  return rows(self.LastReturnedRowIndex)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetIndex()
		  self.LastReturnedRowIndex = -1
		  
		  return
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		IsLastBuffer As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		LastReturnedRowIndex As Integer
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
			Name="LastReturnedRowIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="rowCountFrozen"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
