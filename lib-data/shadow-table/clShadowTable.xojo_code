#tag Class
Protected Class clShadowTable
Inherits clAbstractShadowTable
	#tag Method, Flags = &h0
		Sub Constructor(pSourceTable as clDataTable)
		  super.Constructor
		  
		  self.SourceTable = pSourceTable
		  
		  return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRowBuffer(bufferSize as integer) As clDataRowBuffer
		  
		  
		  if self.SourceTable = nil then return nil
		  
		  var tempMax as integer = self.SourceTable.LastRowIndex
		  
		  var tempStart as integer = self.CurrentRowIndex + 1
		  var tempEnd as integer = min( tempMax, self.CurrentRowIndex + bufferSize)
		  
		  if tempStart > tempMax then return nil
		  
		  var buf as new clDataRowBuffer()
		  
		  for idx as integer = tempStart to tempEnd
		    buf.AddRow(self.SourceTable.GetRowAt(idx, True))
		    
		  next
		  
		  self.CurrentRowIndex = tempEnd
		  
		  return buf
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MoveFirst()
		  
		  self.CurrentRowIndex = -1
		End Sub
	#tag EndMethod


	#tag Note, Name = Purpose
		
		A shadonTable does not hold any data.  
		It provides data in a data row buffer.
		
	#tag EndNote


	#tag Property, Flags = &h0
		CurrentRowIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceTable As clDataTable
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
	#tag EndViewBehavior
End Class
#tag EndClass
