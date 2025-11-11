#tag Class
Protected Class clSortTransformer
Inherits clLinearTransformer
	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, ColumnNames() as string, prmOrder as SortOrder = SortOrder.ascending)
		  //
		  // Sort the rows of the datatable using one or more column as sort key. The order is defined for the combined sort keys.
		  // 
		  // Parameters:
		  // - Input table
		  // - name of columns used as sort key
		  // - sort order
		  //
		  
		  super.Constructor(MainTable)
		  
		  self.SortColumnsNames= ColumnNames
		  self.Order = prmOrder
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function TerminateSort(ColumnNames() as string, SortArray() as pair, order as SortOrder = SortOrder.ascending) As clDataTable
		  //
		  // Use the SortArray prepared to generate the sorted output table
		  //
		  // - SortArray (array of pair): the rght of the element contains the row index 
		  // - order: Sort order (ascending or descending), the order apply on the combined keys
		  //
		  // Returns:
		  //  sorted table
		  
		  
		  var source as clDataTable = self.SourceTable
		  
		  var SortTempArray() as pair = SortArray
		  
		  var connector as clTransformerConnector = self.GetOutputConnector(cOutputConnectorName)
		  
		  var NewTable as clDataTable = source.CloneStructure(connector.GetTableName(false))
		  
		  NewTable.AddMetaData("Transformation","Sorting " + source.Name + " on " + String.FromArray(ColumnNames,","))
		  
		  if order = SortOrder.Ascending then
		    
		    for index as integer = 0 to SortTempArray.LastIndex  
		      var r as clDataRow = source.GetRowAt(SortTempArray(index).Right.IntegerValue, false)
		      
		      NewTable.AddRow(r)
		      
		    next
		    
		  else
		    for index as integer = SortTempArray.LastIndex downto 0
		      var r as clDataRow = source.GetRowAt(SortTempArray(index).Right.IntegerValue, false)
		      
		      NewTable.AddRow(r)
		      
		    next
		    
		  end if
		  
		  return newtable
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Transform() As Boolean
		  
		  var source as clDataTable = self.SourceTable
		  
		  if source = nil then return false
		  
		  var SortKeyColumns() as clAbstractDataSerie = Source.GetColumns(self.SortColumnsNames, False)
		  
		  var srt as new clSorter(SortKeyColumns, order)
		  
		  var t as clDataTable = TerminateSort(self.SortColumnsNames, srt.GetSortedListOfIndexes(), self.order)
		  
		  Self.SetOutputTable(cOutputConnectorName, t)
		  
		  return t <> nil
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Order As SortOrder
	#tag EndProperty

	#tag Property, Flags = &h0
		SortColumnsNames() As String
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
			Name="Order"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="SortOrder"
			EditorType="Enum"
			#tag EnumValues
				"0 - Ascending"
				"1 - Descending"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
