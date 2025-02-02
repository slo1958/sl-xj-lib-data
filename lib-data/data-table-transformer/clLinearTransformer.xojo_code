#tag Class
Protected Class clLinearTransformer
Inherits clAbstractTransformer
	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable)
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  
		  self.AddInput(cInputConnectionName, MainTable)
		  self.SetOutputName(cOutputConnectionName, "Results")
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EmptyOutputTable() As clDataTable
		  
		  return new clDataTable(self.GetName(cOutputConnectionName))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SourceTable() As clDataTable
		  
		  return   self.GetTable(self.cInputConnectionName)
		  
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = cInputConnectionName, Type = String, Dynamic = False, Default = \"Input", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cOutputConnectionName, Type = String, Dynamic = False, Default = \"Output", Scope = Public
	#tag EndConstant


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
