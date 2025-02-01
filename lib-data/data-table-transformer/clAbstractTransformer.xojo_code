#tag Class
Protected Class clAbstractTransformer
	#tag Method, Flags = &h0
		Function getSourceTables() As clDataTable()
		  //
		  // Returns an array with the input tables
		  //
		  // Parameters:
		  // (nothing)
		  //
		  // Returns:
		  // Array of input tables
		  //
		  return self.InputTables
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTransformedTable(TableIndex as integer = 0) As clDataTable
		  //
		  // Returns one output table
		  //
		  // Parameters:
		  // - index of output table
		  //
		  // Returns:
		  // selected output table
		  //
		  if TableIndex > self.OutputTables.LastIndex then
		    return nil
		    
		  else
		    return self.OutputTables(TableIndex)
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTransformedTables() As clDataTable()
		  //
		  // Returns an array with the output tables
		  //
		  // Parameters:
		  // (nothing)
		  //
		  // Returns:
		  // Array of output tables
		  //
		  return self.OutputTables
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetOutputName(OutputIndex as integer, OutputName as string)
		  //
		  // Overwrite a default output name
		  // Default output names are expected to be defined by the transformer constructpr
		  //
		  //
		  // Parameters
		  // - index of the output table to be renamed
		  // - new name
		  //
		  
		  if OutputIndex > OutputNames.LastIndex then return
		  
		  self.OutputNames(OutputIndex) = OutputName
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Transform() As Boolean
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected InputTables() As clDataTable
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected OutputNames() As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected OutputTables() As clDataTable
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
