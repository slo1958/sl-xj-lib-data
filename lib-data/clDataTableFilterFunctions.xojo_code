#tag Module
Protected Module clDataTableFilterFunctions
	#tag Method, Flags = &h0
		Function field_filter(the_row_index as integer, the_row_count as integer, the_column_names() as string, the_cell_values() as variant, paramarray function_param as variant) As Boolean
		  //  
		  //  Implementation of basic filter_row to compare the value of a cell in a column (name as paramter #0) to a constant value (paramter #1)
		  //  
		  //  Parameters
		  //  - the_row_index: index of the current row
		  //  - the_row_count: number of rows in the table
		  //  - the_column_names(): list of columns in in the table
		  //  - the_cell_values(): values of the columns for the current row
		  //  - function_param: additional paramters used to defined the bahaviour of the function
		  //     In this implementation:
		  //     - parameter #0 is the name of the column
		  //    -  parameter #1 is the expected value
		  //  
		  //  Returns:
		  //   - boolean: results of comparision, true if the value in the column matches the expected value
		  //  
		  var field_name as string = function_param(0)
		  var field_value as variant = function_param(1)
		  
		  var idx as integer = the_column_names.IndexOf(field_name)
		  
		  return the_cell_values(idx) = field_value
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function retain_dataSerie_head(the_row as integer, the_row_count as integer, the_column as string, the_value as variant, paramarray function_param as variant) As Boolean
		  //  
		  //  Implementation of basic filter_row to return n top rows.
		  //  
		  //  Parameters
		  //  - the_row_index: index of the current row
		  //  - the_row_count: number of rows in the table
		  //  - the_column_names(): list of columns in in the table
		  //  - the_cell_values(): values of the columns for the current row
		  //  - function_param: additional paramters used to defined the bahaviour of the function
		  //     In this implementation:
		  //     - parameter #0 is the number of rows, with a default of 10
		  //  
		  //  Returns:
		  //   - boolean: true for selected header rows
		  //  
		  
		  If function_param.ubound >= 0 Then
		    var tmp As Integer = function_param(0)
		    Return the_row < tmp
		    
		  Else
		    Return the_row < 10
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function retain_dataSerie_tail(the_row as integer, the_row_count as integer, the_column as string, the_value as variant, paramarray function_param as variant) As Boolean
		  //  
		  //  Implementation of basic filter_row to return n last rows.
		  //  
		  //  Parameters
		  //  - the_row_index: index of the current row
		  //  - the_row_count: number of rows in the table
		  //  - the_column_names(): list of columns in in the table
		  //  - the_cell_values(): values of the columns for the current row
		  //  - function_param: additional paramters used to defined the bahaviour of the function
		  //     In this implementation:
		  //     - parameter #0 is the number of rows, with a default of 10
		  //  
		  //  Returns:
		  //   - boolean: true for selected last rows
		  //  
		  
		  
		  If function_param.ubound >= 0 Then
		    
		    var tmp As Integer = function_param(0)
		    Return the_row > the_row_count - tmp
		    
		  Else
		    Return  the_row > the_row_count - 10
		    
		  End If
		  
		End Function
	#tag EndMethod


	#tag Note, Name = About Table filter methods
		A function can be used as a table filter if it matches the prototype of the 'filter_row' delegate defined in clDataTable.
		
		The prototype is:
		
		function xyz(the_row_index as integer, the_row_count as integer, the_column_names() as string, the_cell_values() as variant, paramarray function_param as variant) as boolean
		
		where
		- the_row_index: index of the current row
		- the_row_count: number of rows in the table
		- the_column_names(): list of columns in in the table
		- the_cell_values(): values of the columns for the current row
		- function_param: additional paramters used to defined the bahaviour of the function
		
		
		This module contains example table filter methods.
	#tag EndNote


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
