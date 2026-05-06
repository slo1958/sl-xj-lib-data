#tag Class
Protected Class clFunctionByRowTransformer
Inherits clLinearTransformer
	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, TrsfFunction as RowTransformerFunction, previousRowCount as integer, usedRowCountColumnName as string, BreakColumnNames() as string, DataColumnNames() as string, Parameters() as variant)
		  //
		  // Run a transformation function to update data, one row at a time
		  // The output table is a new table
		  // 
		  // Parameters:
		  // - Input table
		  // - Transformation function to call for each row in the input table
		  // - Number of rows to include in the 'previous rows' argument of the transformation function
		  // - Name of the column in the output table to store the total number of rows passed to the function
		  // - BreakColumnNames: any change of the value in one of those columns causes the list of previous rows to be cleared
		  // - DataColumnNames: List of columns passed to the transformation function  
		  // - List of parameters passed to function
		  //
		  
		  
		  super.Constructor(MainTable)
		  
		  self.NumberOfRows = previousRowCount
		  
		  self.fct = TrsfFunction
		  
		  self.IncludeRowCount = usedRowCountColumnName.Length > 0
		  self.RowCountColumn = usedRowCountColumnName
		  
		  self.FctColumnNames =  DataColumnNames 
		  
		  self.FctBreakColumnNames = BreakColumnNames
		  self.FctParameters = Parameters
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, TrsfFunction as RowTransformerFunction, BreakColumnNames() as string, DataColumnNames() as string, Parameters() as variant)
		  //
		  // Run a transformation function to update data, one row at a time
		  // The output table is a new table
		  // 
		  // Parameters:
		  // - Input table
		  // - Transformation function to call for each row in the input table
		  // - BreakColumnNames: any change of the value in one of those columns causes the list of previous rows to be cleared
		  // - DataColumnNames: List of columns passed to the transformation function  
		  // - List of parameters passed to function
		  //
		  // - Number of rows to include in the 'previous rows' is fixed to 1
		  // 
		  
		  super.Constructor(MainTable)
		  
		  self.NumberOfRows = 1
		  
		  self.fct = TrsfFunction
		  
		  self.IncludeRowCount = false
		  self.RowCountColumn = ""
		  
		  self.FctColumnNames =  DataColumnNames 
		  
		  self.FctBreakColumnNames = BreakColumnNames
		  self.FctParameters = Parameters
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Transform() As Boolean
		  // Calling the overridden superclass method.
		  
		  var previousRows() as clDataRow
		  
		  var source as clDataTable = self.SourceTable
		  
		  if source = nil then return false
		  
		  // create virtual table for output
		  var output as clDataTable = source.CloneStructure
		  
		  var outputRow as clDataRow
		  var previousBreakValues() as pair
		  
		  var currentRowNumber as integer = 0
		  
		  // Apply function
		  
		  var success as Boolean = True
		  
		  for each r as clDataRow in source
		    
		    if currentRowNumber = 0 then
		      for each col as string in self.FctBreakColumnNames
		        previousBreakValues.Add(col:r.GetCell(col))
		        
		      next
		      
		    else
		      
		      for idx as integer = 0 to previousBreakValues.LastIndex
		        var col as string = previousBreakValues(idx).Left
		        if previousBreakValues(idx).Right <> r.GetCell(col) then
		          previousRows.RemoveAll
		          previousBreakValues(idx) = (col:r.GetCell(col))
		          
		        end if
		        
		      next
		      
		    end if
		    
		    outputRow = fct.Invoke( r, previousRows, FctColumnNames, self.FctParameters)
		    
		    if self.IncludeRowCount then
		      outputRow.SetCell(self.RowCountColumn , previousRows.count + 1)
		      
		    end if
		    
		    if outputRow <> nil then
		      output.AddRow(outputRow, clDataTable.AddRowMode.CreateNewColumn)
		      
		    end if
		    
		    if NumberOfRows <= 1 then
		      previousRows.RemoveAll
		      
		    elseif previousRows.Count+1 >= NumberOfRows then
		      previousRows.RemoveAt(0)
		      
		    end if
		    
		    previousRows.Add(r)
		    currentRowNumber = currentRowNumber + 1
		    
		  next
		  
		  var vTemp as clAbstractDataSerie
		  
		  for each col as string in self.FctColumnNames
		    vTemp = output.GetColumn(col)
		    vTemp.GetMetadata.AddSource("Updated by FunctionByRowTransformer")
		    
		  next
		  
		  if self.IncludeRowCount then
		    vTemp = output.GetColumn(self.RowCountColumn)
		    vTemp.GetMetadata.AddSource("Added by FunctionByRowTransformer")
		    
		  end if
		  
		  Self.SetOutputTable(cOutputConnectorName, output)
		  
		  return True
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Fct As RowTransformerFunction
	#tag EndProperty

	#tag Property, Flags = &h0
		FctBreakColumnNames() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		FctColumnNames() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		FctParameters() As variant
	#tag EndProperty

	#tag Property, Flags = &h0
		IncludeRowCount As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		NumberOfRows As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		RowCountColumn As string
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
