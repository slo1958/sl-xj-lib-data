#tag Class
Protected Class clLinearShadowTable
Inherits clAbstractShadowTable
	#tag Method, Flags = &h0
		Sub Constructor(pSourceShadowTable as clShadowTable)
		  
		  super.Constructor
		  
		  self.SourceTable = pSourceShadowTable
		  
		  return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRowBuffer(bufferSize as integer) As clDataRowBuffer
		  
		  return nil
		  
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Purpose
		
		A shadonTable does not hold any data.  
		It provides data in a data row buffer.
		
	#tag EndNote


	#tag Property, Flags = &h0
		SourceTable As clShadowTable
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
