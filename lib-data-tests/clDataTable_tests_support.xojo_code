#tag Module
Protected Module clDataTable_tests_support
	#tag Method, Flags = &h0
		Function alloc_obj(name as string) As object
		  select case name
		  case "test_class_01"
		    return new test_class_01
		    
		  case "test_class_02"
		    return new test_class_02
		    
		  case "test_class_03"
		    return new test_class_03
		    
		  case else
		    return nil
		    
		  end select
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function alloc_series_019(column_name as string, column_type_info as string) As clAbstractDataSerie
		  if column_name = "Sales" then
		    Return new clNumberDataSerie(column_name)
		    
		  else
		    return new clDataSerie(column_name)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function alloc_series_io1(column_name as string, column_type_info as string) As clAbstractDataSerie
		  if column_name = "Alpha" then
		    Return new clCompressedDataSerie(column_name)
		    
		  else
		    return new clDataSerie(column_name)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function check_table(log as LogMessageInterface, label as string, expected as clDataTable, calculated as clDataTable, accepted_error_on_double as double = 0.00001) As Boolean
		  var cnt1 as integer  
		  var cnt2 as integer  
		  
		  if expected = nil then
		    if log <> nil then log.WriteMessage(CurrentMethodName+": Missing or unknow expected table.")
		    return False
		    
		  end if
		  
		  if calculated = nil then
		    if log <> nil then log.WriteMessage(CurrentMethodName+": Missing or unknow calculated table.")
		    return false
		    
		  end if
		  
		  cnt1 = expected.ColumnCount
		  cnt2 = calculated.ColumnCount
		  
		  if not check_value(log,"column count", cnt1, cnt2) then return False
		  
		  var col_ok as boolean = True
		  for col as integer = 0 to expected.ColumnCount-1
		    
		    col_ok = col_ok and check_serie(log, label + " field [" + expected.ColumnNameAt(col)+"]", expected.GetColumnAt(col), calculated.GetColumnAt(col), accepted_error_on_double)
		    
		  next
		  
		  Return col_ok
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_008(the_row_index as integer, the_RowCount as integer, the_column_names() as string, the_cell_values() as variant, paramarray function_param as variant) As Boolean
		  var idx as integer = the_column_names.IndexOf("cc2")
		  
		  return the_cell_values(idx) = function_param(0)
		End Function
	#tag EndMethod


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
End Module
#tag EndModule
