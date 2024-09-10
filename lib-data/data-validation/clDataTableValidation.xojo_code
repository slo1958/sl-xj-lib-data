#tag Class
Protected Class clDataTableValidation
Implements TableColumnReaderInterface
	#tag Method, Flags = &h0
		Sub add_message(field_name as string, row_index as integer, message as string)
		  var r as new Dictionary
		  
		  r.value(field_name_output_column)=  field_name
		  r.value(row_index_output_column) =  row_index
		  r.Value(message_output_column) =  message
		  
		  if results_table <> nil then
		    self.results_table.AddRow(r)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function all_columns() As clAbstractDataSerie()
		  // Part of the TableColumnReaderInterface interface.
		  
		  var cols() as clAbstractDataSerie
		  
		  var col_name as new clDataSerie( field_name_input_column )
		  var col_input as new clDataSerie( field_nullable_input_column )
		  var col_mandatory as new clDataSerie(field_mandatory_input_column )
		  var col_type as new clDataSerie(field_type_input_column)
		  
		  
		  for each column as clDataSerieValidation in valid_columns
		    col_name.append_element(column.name)
		    col_input.append_element(column.is_nullable)
		    col_mandatory.append_element(column.is_required)
		    col_type.append_element("generic")
		    
		  next
		  
		  Return cols
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function column_count() As integer
		  // Part of the TableColumnReaderInterface interface.
		  
		  return 4
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(validation_name as string, columns() as clDataSerieValidation, allow_extra_columns as boolean = False)
		  redim valid_columns(-1)
		  
		  if validation_name.trim.len = 0 then
		    table_name = "Noname"
		    
		  else
		    table_name = validation_name.trim
		    
		  end if
		  
		  
		  for each column as clDataSerieValidation in columns
		    valid_columns.Append(column)
		    
		  next
		  
		  self.opt_allow_extra_columns = allow_extra_columns
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumnNames() As string()
		  // Part of the TableColumnReaderInterface interface
		  
		  var tmp() as string
		  
		  tmp.Append(field_name_input_column)
		  tmp.Append(field_type_input_column)
		  tmp.Append(field_nullable_input_column)
		  tmp.Append(field_mandatory_input_column)
		  
		  return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_column(the_column_name as String) As clAbstractDataSerie
		  // Part of the TableColumnReaderInterface interface.
		  
		  var output as new clDataSerie(the_column_name)
		  
		  for each column as clDataSerieValidation in valid_columns
		    
		    select case the_column_name
		    case  field_name_input_column 
		      output.append_element(column.name)
		      
		    case field_nullable_input_column 
		      output.append_element(column.is_nullable)
		      
		    case  field_mandatory_input_column 
		      output.append_element(column.is_required)
		      
		    case field_type_input_column
		      output.append_element("generic")
		      
		    case else
		      
		    end Select
		    
		  next
		  
		  return output
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_column_by_index(column_index as integer) As clAbstractDataSerie
		  
		  var output as clDataSerie
		  
		  try
		    output = new clDataSerie(self.get_column_name(column_index))
		    
		  catch
		    return nil
		    
		  end try
		  
		  
		  for each column as clDataSerieValidation in valid_columns
		    
		    select case column_index
		    case  0 
		      output.append_element(column.name)
		      
		    case 1 
		      output.append_element(column.is_nullable)
		      
		    case  2 
		      output.append_element(column.is_required)
		      
		    case 3
		      output.append_element("generic")
		      
		    case else
		      
		    end Select
		    
		  next
		  
		  return output
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_column_name(column_index as integer) As string
		  var tmp() as string = self.GetColumnNames()
		  
		  return tmp(column_index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_results() As clDataTable
		  Return results_table
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function is_persistant() As boolean
		  // Part of the TableColumnReaderInterface interface.
		  
		  return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function name() As String
		  return table_name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function row_count() As integer
		  // Part of the TableColumnReaderInterface interface.
		  
		  return valid_columns.Ubound+1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub validate(table as clDataTable)
		  
		  self.results_table = new clDataTable("error_report", array(field_name_output_column ,  row_index_output_column, message_output_column))
		  
		  var tmp_data_columns() as string = table.GetColumnNames
		  
		  for each column as clDataSerieValidation in valid_columns
		    
		    if  table.GetColumnNames.IndexOf(column.name) >= 0 then
		      var tmp() as clAbstractDataSerie = column.validate(table.get_column(column.name))
		      
		      tmp(0).rename(row_index_output_column)
		      tmp(1).rename(message_output_column )
		      
		      var tmp_table as new clDataTable("temp", tmp)
		      call tmp_table.AddColumn(field_name_output_column, column.name)
		      
		      self.results_table.append_from_column_source(tmp_table)
		      
		      tmp_data_columns.RemoveAt(tmp_data_columns.IndexOf(column.name))
		      
		    elseif column.is_required Then
		      add_message(column.name, -1, "missing mandatory column ")
		      
		    else
		      
		      
		    end if
		    
		    
		  next
		  
		  if not opt_allow_extra_columns and tmp_data_columns.Count >0 then
		    for each column as string in tmp_data_columns
		      add_message(column, -1, "unexpected extra column")
		      
		    next
		    
		  end if
		  
		  //return self.results_table
		End Sub
	#tag EndMethod


	#tag Note, Name = Description
		Validates a data table
		
		Applies defined data serie validator, clDataSerieValidation or its child class, to each column.
		Link between columns in DataTable and columns in validation are made by column name.
		
		Columns defined in validation but not found in datatable generate an error if the column is marked as mandatory.
		
		Columns defined in the DataTable but not defined in the validation are reported as error unless the flag 'allow_extra_columns' is True
		
		Column order is not tested
		
	#tag EndNote


	#tag Property, Flags = &h1
		Protected opt_allow_extra_columns As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected results_table As clDataTable
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected table_name As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected valid_columns() As clDataSerieValidation
	#tag EndProperty


	#tag Constant, Name = field_mandatory_input_column, Type = String, Dynamic = False, Default = \"is_mandatory", Scope = Public
	#tag EndConstant

	#tag Constant, Name = field_name_input_column, Type = String, Dynamic = False, Default = \"field_name", Scope = Public
	#tag EndConstant

	#tag Constant, Name = field_name_output_column, Type = String, Dynamic = False, Default = \"field_name", Scope = Public
	#tag EndConstant

	#tag Constant, Name = field_nullable_input_column, Type = String, Dynamic = False, Default = \"is_nullable", Scope = Public
	#tag EndConstant

	#tag Constant, Name = field_type_input_column, Type = String, Dynamic = False, Default = \"field_type", Scope = Public
	#tag EndConstant

	#tag Constant, Name = message_output_column, Type = String, Dynamic = False, Default = \"error_message", Scope = Public
	#tag EndConstant

	#tag Constant, Name = row_index_output_column, Type = String, Dynamic = False, Default = \"row_index", Scope = Public
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
End Class
#tag EndClass
