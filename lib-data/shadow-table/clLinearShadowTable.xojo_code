#tag Class
Protected Class clLinearShadowTable
Inherits clAbstractShadowTable
	#tag Method, Flags = &h0
		Sub Constructor(pSourceShadowTable as clAbstractShadowTable)
		  
		  super.Constructor
		  
		  self.Source = pSourceShadowTable
		  
		  return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndOfTable() As boolean
		  
		  return source.EndOfTable
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNextRowBuffer(bufferSize as integer) As clDataRowBuffer
		  // Calling the overridden superclass method.
		  
		  var input_wb as clDataRowBuffer = source.GetNextRowBuffer(bufferSize)
		  
		  var output_wb as clDataRowBuffer = self.TransformBuffer(input_wb)
		  
		  return output_wb
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TransformBuffer(input as clDataRowBuffer) As clDataRowBuffer
		  
		  return input
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Purpose
		
		A shadonTable does not hold any data.  
		It provides data in a data row buffer.
		
	#tag EndNote


	#tag Property, Flags = &h0
		Source As clAbstractShadowTable
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
