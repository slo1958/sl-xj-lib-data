#tag Class
Protected Class clLinearTransformer
Inherits clAbstractTransformer
	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable)
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  self.AddInput(new clTransformerConnector(cInputConnectorName, MainTable))
		  
		  self.AddOutput(new clTransformerConnector(cOutputConnectorName, cDefaultMainOutputTableName))
		  
		  return
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EmptyOutputTable() As clDataTable
		  
		  var c  as clTransformerConnector = OutputConnectors.lookup(cOutputConnectorName, nil)
		  
		  if c = nil then return nil
		  
		  return c.GetEmptyTable()
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SourceTable() As clDataTable
		  
		  return   self.GetInputTable(self.cInputConnectorName)
		  
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Description
		
		A linear transformer is a transformer that takes exactly one table as input and produces exactly one table.
		
	#tag EndNote


	#tag Constant, Name = cInputConnectorName, Type = String, Dynamic = False, Default = \"Input", Scope = Public
	#tag EndConstant

	#tag Constant, Name = cOutputConnectorName, Type = String, Dynamic = False, Default = \"Output", Scope = Public
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
