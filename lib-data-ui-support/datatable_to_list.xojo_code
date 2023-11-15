#tag Module
Protected Module datatable_to_list
	#tag Method, Flags = &h0
		Sub show_table_in_listbox(thetable as TableColumnReaderInterface, thelist as DesktopListBox)
		  
		  dim tmp_listbox as DesktopListBox = thelist
		  dim tmp_tbl as TableColumnReaderInterface = thetable
		  
		  
		  dim nbr_columns as integer = tmp_tbl.column_count
		  
		  tmp_listbox.RemoveAllRows
		  
		  //  
		  //  update table header
		  //  
		  tmp_listbox.HasHeader = True
		  
		  tmp_listbox.ColumnCount = nbr_columns + 1
		  
		  tmp_listbox.HeaderAt(0)="#"
		  
		  for column_index as integer = 0 to  nbr_columns-1
		    tmp_listbox.HeaderAt(column_index+1) = tmp_tbl.get_column_by_index(column_index).display_title
		    tmp_listbox.ColumnTagAt(column_index+1) = tmp_tbl.get_column_by_index(column_index)
		  next
		  
		  //  
		  //  show data
		  //  
		  dim tmp_last_row as integer = tmp_tbl.row_count
		  
		  for row_index as integer = 0 to tmp_last_row - 1
		    tmp_listbox.AddRow(str(row_index))
		    
		  next
		  
		  
		  for column_index as integer = 0 to  nbr_columns-1
		    dim tmp_col as clAbstractDataSerie = tmp_tbl.get_column_by_index(column_index)
		    
		    for  row_index as integer = 0 to tmp_last_row - 1
		      
		      tmp_listbox.CellTextAt(row_index, column_index+1) =  tmp_col.get_element_as_string(row_index)
		      
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
