#tag Class
Protected Class clFilterTransformer
Inherits clLinearTransformer
	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, BooleanColumnName as string, prmFilterMode as FilterMode = FilterMode.IncludeSelected)
		  //
		  // Filter the rows of the source table
		  // 
		  // Parameters:
		  // - Input table
		  // - BooleanColumnName: name of filter column
		  // - filter mode
		  //
		  
		  super.Constructor(MainTable)
		  
		  self.FilterColumnNames.RemoveAll
		  self.FilterColumnNames.Add(BooleanColumnName)
		  self.Mode = prmFilterMode
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(BooleanColumnName as string, prmFilterMode as FilterMode = FilterMode.IncludeSelected)
		  //
		  // Filter the rows of the source table
		  // The input connector should be setup using a distinct call
		  //
		  // Parameters:
		  // - BooleanColumnName: name of filter column
		  // - filter mode
		  //
		  
		  super.Constructor()
		  
		  self.FilterColumnNames.RemoveAll
		  self.FilterColumnNames.Add(BooleanColumnName)
		  self.Mode = prmFilterMode
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Transform() As Boolean
		  // Calling the overridden superclass method.
		  
		  var source as clDataTable = self.SourceTable
		  
		  if source = nil then return false
		  
		  var filterSerie as clBooleanDataSerie = source.GetBooleanColumn(FilterColumnNames(0))
		  
		  if filterSerie = nil then return false
		  
		  if self.Mode = FilterMode.ExcludeSelected then
		    filterSerie = not filterSerie
		    
		  end if
		  
		  var retval as new clDataTableFilter(source, filterSerie)
		  
		  var output as clDataTable = source.CloneStructure
		  
		  for each row as clDataRow in retval
		    output.AddRow(row)
		    
		    
		  next
		  
		  Self.SetOutputTable(cOutputConnectorName, output)
		  
		  return true
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		FilterColumnNames() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		Mode As FilterMode
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="StepLabel"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EnableTraceMode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
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
			Name="Mode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="FilterMode"
			EditorType="Enum"
			#tag EnumValues
				"0 - IncludeSelected"
				"1 - ExcludeSelected"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
