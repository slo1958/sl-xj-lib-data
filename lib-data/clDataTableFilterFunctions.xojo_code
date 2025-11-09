#tag Module
Protected Module clDataTableFilterFunctions
	#tag Method, Flags = &h0
		Function BasicFieldFilter(pRowIndex as integer, pRowCount as integer, pColumnNames() as string, pCellValues() as variant, paramarray pFunctionParameters as variant) As Boolean
		  //  
		  //  Implementation of basic RowFilter to compare the value of a cell in a column (name as paramter #0) to a constant value (paramter #1)
		  //  
		  //  Parameters
		  //  - pRowIndex: index of the current row
		  //  - pRowCount: number of rows in the table
		  //  - pColumnNames(): list of columns in in the table
		  //  - pCellValues(): values of the columns for the current row
		  //  - pFunctionParameters: additional paramters used to defined the bahaviour of the function
		  //     In this implementation:
		  //     - parameter #0 is the name of the column
		  //    -  parameter #1 is the expected value
		  //  
		  //  Returns:
		  //   - boolean: results of comparision, true if the value in the column matches the expected value
		  //  
		  var FieldName as string = pFunctionParameters(0)
		  var FieldValue as variant = pFunctionParameters(1)
		  
		  var idx as integer = pColumnNames.IndexOf(FieldName)
		  
		  if FieldValue.IsArray then
		    var va() as variant = ExtractVariantArray(FieldValue)
		    
		    for each v as variant in va
		      if pCellValues(idx) = v then return true
		      
		    next
		    return False
		    
		  else
		    return pCellValues(idx) = FieldValue
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RetainSerieHead(the_row as integer, pRowCount as integer, the_column as string, the_value as variant, paramarray pFunctionParameters as variant) As Boolean
		  //  
		  //  Implementation of basic RowFilter to return n top rows.
		  //  
		  //  Parameters
		  //  - pRowIndex: index of the current row
		  //  - pRowCount: number of rows in the table
		  //  - pColumnNames(): list of columns in in the table
		  //  - pCellValues(): values of the columns for the current row
		  //  - pFunctionParameters: additional paramters used to defined the bahaviour of the function
		  //     In this implementation:
		  //     - parameter #0 is the number of rows, with a default of 10
		  //  
		  //  Returns:
		  //   - boolean: true for selected header rows
		  //  
		  
		  If pFunctionParameters.LastIndex >= 0 Then
		    var tmp As Integer = pFunctionParameters(0)
		    Return the_row < tmp
		    
		  Else
		    Return the_row < DefaultHeadSize
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RetainSerieTail(the_row as integer, pRowCount as integer, the_column as string, the_value as variant, paramarray pFunctionParameters as variant) As Boolean
		  //  
		  //  Implementation of basic RowFilter to return n last rows.
		  //  
		  //  Parameters
		  //  - pRowIndex: index of the current row
		  //  - pRowCount: number of rows in the table
		  //  - pColumnNames(): list of columns in in the table
		  //  - pCellValues(): values of the columns for the current row
		  //  - pFunctionParameters: additional paramters used to defined the bahaviour of the function
		  //     In this implementation:
		  //     - parameter #0 is the number of rows, with a default of 10
		  //  
		  //  Returns:
		  //   - boolean: true for selected last rows
		  //  
		  
		  
		  If pFunctionParameters.LastIndex >= 0 Then
		    
		    var tmp As Integer = pFunctionParameters(0)
		    Return the_row > pRowCount - tmp
		    
		  Else
		    Return  the_row > pRowCount - DefaultTailSize
		    
		  End If
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About Table filter methods
		A function can be used as a table filter if it matches the prototype of the 'RowFilter' delegate defined in clDataTable.
		
		The prototype is:
		
		function xyz(pRowIndex as integer, pRowCount as integer, pColumnNames() as string, pCellValues() as variant, paramarray pFunctionParameters as variant) as boolean
		
		where
		- pRowIndex: index of the current row
		- pRowCount: number of rows in the table
		- pColumnNames(): list of columns in in the table
		- pCellValues(): values of the columns for the current row
		- pFunctionParameters: additional paramters used to defined the bahaviour of the function
		
		
		This module contains example table filter methods.
	#tag EndNote


	#tag Constant, Name = DefaultHeadSize, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DefaultTailSize, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
