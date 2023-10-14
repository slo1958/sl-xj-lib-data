#tag Class
Protected Class clDataTableValidation
Implements itf_table_column_reader
	#tag Method, Flags = &h0
		Sub add_message(field_name as string, row_index as integer, message as string)
		  dim r as new Dictionary
		  
		  r.value(field_name_output_column)=  field_name
		  r.value(row_index_output_column) =  row_index
		  r.Value(message_output_column) =  message
		  
		  if results_table <> nil then
		    self.results_table.append_row(r)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function column_count() As integer
		  // Part of the itf_table_column_reader interface.
		  
		  return 3
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function column_names() As string()
		  // Part of the itf_table_column_reader interface.
		  dim tmp() as string
		  
		  tmp.Append(field_name_input_column)
		  tmp.Append(field_type_input_column)
		  tmp.Append(field_nullable_input_column)
		  tmp.Append(field_mandatory_input_column)
		  
		  return tmp
		  
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
		Function get_column(the_column_name as String) As clAbstractDataSerie
		  // Part of the itf_table_column_reader interface.
		  
		  dim output as new clDataSerie(the_column_name)
		  
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
		Function get_columns(column_names() as string) As clAbstractDataSerie()
		  // Part of the itf_table_column_reader interface.
		  
		  
		  Return get_columns(column_names)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_columns(paramarray column_names as string) As clAbstractDataSerie()
		  // Part of the itf_table_column_reader interface.
		  
		  Return get_columns(column_names)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function is_persistant() As boolean
		  // Part of the itf_table_column_reader interface.
		  
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
		  // Part of the itf_table_column_reader interface.
		  
		  return valid_columns.Ubound+1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function validate(table as clDataTable) As clDataTable
		  
		  self.results_table = new clDataTable("error_report", array(field_name_output_column ,  row_index_output_column, message_output_column))
		  
		  dim tmp_data_columns() as string = table.column_names
		  
		  for each column as clDataSerieValidation in valid_columns
		    
		    if  table.column_names.IndexOf(column.name) >= 0 then
		      dim tmp() as clAbstractDataSerie = column.validate(table.get_column(column.name))
		      
		      tmp(0).rename(row_index_output_column)
		      tmp(1).rename(message_output_column )
		      
		      dim tmp_table as new clDataTable("temp", tmp)
		      dim tmp_column as clAbstractDataSerie = tmp_table.add_column(field_name_output_column, column.name)
		      
		      self.results_table.append_rows_from_table(tmp_table)
		      
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
		  
		  
		  
		  return self.results_table
		End Function
	#tag EndMethod


	#tag Note, Name = Description
		Validates a data table
		
		Applies defined data serie validator, clDataSerieValidation or its child class, to each column.
		Link between columns in DataTable and columns in validation are made by column name.
		
		Columns defined in validation but not found in datatable generate an error if the column is marked as mandatory.
		
		Columns defined in the DataTable but not defined in the validation are reported as error unless the flag 'allow_extra_columns' is True
		
		Column order is not tested
		
	#tag EndNote

	#tag Note, Name = Version
		0.0.1 - 2023-04-16
		First version
		
		
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
