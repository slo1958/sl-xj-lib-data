#tag Module
Protected Module datatable_to_list
	#tag Method, Flags = &h0
		Sub ShowTableInListbox(thetable as TableColumnReaderInterface, thelist as DesktopListBox)
		  
		  var tmp_listbox as DesktopListBox = thelist
		  var tmp_tbl as TableColumnReaderInterface = thetable
		  
		  
		  var nbr_columns as integer = tmp_tbl.ColumnCount
		  
		  tmp_listbox.RemoveAllRows
		  
		  //  
		  //  update table header
		  //  
		  tmp_listbox.HasHeader = True
		  
		  tmp_listbox.ColumnCount = nbr_columns + 1
		  
		  tmp_listbox.HeaderAt(0)="#"
		  
		  for column_index as integer = 0 to  nbr_columns-1
		    tmp_listbox.HeaderAt(column_index+1) = tmp_tbl.GetColumnAt(column_index).DisplayTitle
		    tmp_listbox.ColumnTagAt(column_index+1) = tmp_tbl.GetColumnAt(column_index)
		  next
		  
		  //  
		  //  show data
		  //  
		  var tmp_last_row as integer = tmp_tbl.RowCount
		  var tmp_index_format as string = left("0000000", tmp_last_row.ToString.Length)
		  
		  for row_index as integer = 0 to tmp_last_row - 1
		    tmp_listbox.AddRow(format(row_index, tmp_index_format))
		    
		  next
		  
		  
		  for column_index as integer = 0 to  nbr_columns-1
		    var tmp_col as clAbstractDataSerie = tmp_tbl.GetColumnAt(column_index)
		    
		    for  row_index as integer = 0 to tmp_last_row - 1
		      
		      tmp_listbox.CellTextAt(row_index, column_index+1) =  tmp_col.GetElementAsString(row_index)
		      
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
