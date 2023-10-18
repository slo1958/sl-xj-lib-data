#tag Module
Protected Module datatable_to_list
	#tag Method, Flags = &h0
		Sub show_table_in_listbox(thetable as itf_table_column_reader, thelist as Listbox)
		  
		  dim tmp_listbox as Listbox = thelist
		  dim tmp_tbl as itf_table_column_reader = thetable
		  
		  dim column_names()  as String = tmp_tbl.column_names
		  
		  // find number columns
		  
		  dim tmp_formatted as new Dictionary
		  
		  
		  for each column as string in column_names
		    
		    if tmp_tbl.get_column(column) isa clNumberDataSerie then
		      tmp_formatted.value(column) ="###,###.###"
		      
		    elseif tmp_tbl.get_column(column) isa clIntegerDataSerie then
		      tmp_formatted.value(column) ="###,###"
		      
		    else
		      
		    end if
		    
		  next
		  
		  tmp_listbox.DeleteAllRows
		  
		  //  
		  //  update table header
		  //  
		  tmp_listbox.HasHeading = True
		  
		  tmp_listbox.ColumnCount = column_names.Ubound + 2
		  
		  tmp_listbox.Heading(0)="#"
		  
		  for column_index as integer = 0 to column_names.Ubound
		    tmp_listbox.Heading(column_index+1) = column_names(column_index)
		    
		  next
		  
		  //  
		  //  show data
		  //  
		  dim tmp_last_row as integer = tmp_tbl.row_count
		  
		  for row_index as integer = 0 to tmp_last_row - 1
		    tmp_listbox.AddRow(str(row_index))
		    
		  next
		  
		  dim column_index as integer=0
		  
		  for each column as string in column_names
		    dim tmp_col as clAbstractDataSerie = tmp_tbl.get_column(column)
		    
		    column_index = column_index + 1
		    
		    for  row_index as integer = 0 to tmp_last_row - 1
		      dim tmp_val as string
		      if tmp_formatted.HasKey(column) then
		        tmp_val = format( tmp_col.get_element(row_index), tmp_formatted.value(column))
		        
		      else
		        tmp_val = tmp_col.get_element(row_index).StringValue
		        
		      end if
		      
		      tmp_listbox.Cell(row_index, column_index) = tmp_val
		      
		    next
		    
		  next
		  
		  
		  
		  
		End Sub
	#tag EndMethod


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
