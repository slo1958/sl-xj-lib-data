#tag Class
Protected Class clFunctionTransformer
Inherits clLinearTransformer
	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, TrsfFunction as TransformerFunction, ColumnNames() as string, Parameters() as variant)
		  //
		  // Run a transformation function to update data
		  // The output table is a view, the transformation function is allowed to add new columns
		  // 
		  // Parameters:
		  // - Input table
		  // - Transformation function to call
		  // - List of columns passed to function
		  // - List of parameters passed to function
		  //
		  
		  super.Constructor(MainTable)
		  
		  self.fct = TrsfFunction
		  self.FctColumnNames = ColumnNames
		  self.FctParameters = Parameters
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Transform() As Boolean
		  // Calling the overridden superclass method.
		  
		  var source as clDataTable = self.SourceTable
		  
		  if source = nil then return false
		  
		  // create virtual table for output
		  var output as clDataTable = source.SelectAllColumns(true)
		  
		  // Apply function
		  var success as Boolean = fct.Invoke(output, FctColumnNames, FctParameters)
		  
		  Self.SetOutputTable(cOutputConnectorName, output)
		  
		  return success
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Fct As TransformerFunction
	#tag EndProperty

	#tag Property, Flags = &h0
		FctColumnNames() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		FctParameters() As variant
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
