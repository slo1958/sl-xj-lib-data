#tag Class
Protected Class clUnpivotTransformer
Inherits clLinearTransformer
	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, prmColumnsToRetain() as string, prmColumnForFieldNames as string, prmColumnForFieldValue as string)
		  // Calling the overridden superclass constructor.
		  
		  super.Constructor(MainTable)
		  
		  
		  self.ColumnsToRetain = prmColumnsToRetain
		  self.FieldNameColumn = prmColumnForFieldNames
		  self.FieldValueColumn = prmColumnForFieldValue
		  self.ColumnsToIgnore.RemoveAll
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, prmColumnsToRetain() as string, prmColumnForFieldNames as string, prmColumnForFieldValue as string, prmColumnsToIgnore() as string)
		  // Calling the overridden superclass constructor.
		  
		  super.Constructor(MainTable)
		  
		  self.ColumnsToRetain = prmColumnsToRetain
		  self.FieldNameColumn = prmColumnForFieldNames
		  self.FieldValueColumn = prmColumnForFieldValue
		  self.ColumnsToIgnore = prmColumnsToIgnore
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Transform() As Boolean
		  
		  
		  var source as clDataTable = self.GetInputTable(self.cInputConnectorName)
		  
		  var columnsToUnpivot() as string
		  
		  for each column as string in source.GetColumnNames
		    if ColumnsToRetain.IndexOf(column) < 0 and ColumnsToIgnore.IndexOf(column) < 0 then
		      columnsToUnpivot.Add(column)
		      
		    end if
		    
		  next
		  
		  var output as   clDataTable = EmptyOutputTable()
		  
		  for each fixedColumn as string in self.ColumnsToRetain
		    call output.AddColumn(source.Column(fixedColumn).CloneStructure)
		    
		  next
		  
		  call output.AddColumn(new clStringDataSerie(self.FieldNameColumn))
		  call output.AddColumn(new clNumberDataSerie(self.FieldValueColumn))
		  
		  for each row as clDataRow in source
		    
		    for each column as string in columnsToUnpivot
		      var OutputRow as new clDataRow
		      
		      // Move the fixed columns
		      for each fixedColumn as string in self.ColumnsToRetain
		        OutputRow.Cell(fixedColumn) = row.GetCell(fixedColumn)
		        
		      next
		      
		      //  Add the unpivoted value
		      
		      OutputRow.Cell(self.FieldNameColumn) = column
		      OutputRow.Cell(self.FieldValueColumn) = row.GetCell(column)
		      
		      output.AddRow(OutputRow)
		      
		    next
		    
		  next
		  
		  self.SetOutputTable(cOutputConnectorName, output)
		  
		  return true
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ColumnsToIgnore() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		ColumnsToRetain() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		FieldNameColumn As String
	#tag EndProperty

	#tag Property, Flags = &h0
		FieldValueColumn As String
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
			Name="FieldNameColumn"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FieldValueColumn"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
