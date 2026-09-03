#tag Class
Protected Class DesktopListboxForTable
Inherits DesktopListBox
	#tag Method, Flags = &h0
		Sub DefineColumnOrder(ColumnNames() as string)
		  
		  var nbr_columns as integer = ColumnNames.count
		  
		  Redim ColumnsOrder(nbr_columns-1)
		  
		  for column_index as integer = 0 to  nbr_columns-1
		    ColumnsOrder(column_index) = column_index
		    
		  next
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FormatRowID(rowID as Integer, maxRowID as integer) As string
		  //
		  // When the row count is know, prefix the rowID with zeroes
		  //
		  // Parameters:
		  // - rowID: number to convert
		  // - maxRowID: maximum value or -1
		  
		  if maxRowID <= 0 then
		    return str(rowid)
		    
		  else
		    return format( rowId, left("0000000",maxRowID.ToString.Length))
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetColumn(colNo as integer) As clAbstractDataSerie
		  
		  if colNo < 0 or colNo > columns.LastIndex then return nil
		  
		  return columns(colno)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SetupListbox(ColumnNames() as string) As integer
		  var tmp_listbox as DesktopListBox = self
		  
		  var nbr_columns as integer = ColumnNames.Count
		  
		  if ColumnsOrder.Count <> nbr_columns then DefineColumnOrder(ColumnNames())
		  
		  //
		  // Clean up
		  //
		  tmp_listbox.RemoveAllRows
		  self.Columns.RemoveAll
		  
		  //  
		  //  update table header
		  //  
		  tmp_listbox.HasHeader = True
		  
		  tmp_listbox.ColumnCount = nbr_columns + 1
		  
		  tmp_listbox.HeaderAt(0)="#"
		  
		  var tmp_col_names() as string = ColumnNames()
		  
		  for column_base_index as integer = 0 to  nbr_columns-1
		    var column_index as integer = self.ColumnsOrder(column_base_index)
		    tmp_listbox.HeaderAt(column_base_index+1) = tmp_col_names(column_index)
		    tmp_listbox.ColumnTagAt(column_base_index+1) = nil
		    
		  next
		  
		  return nbr_columns
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowTable(Source as TableColumnReaderInterface)
		  
		  var tmp_listbox as DesktopListBox = self
		  
		  
		  if source  = nil then
		    tmp_listbox.RemoveAllRows
		    tmp_listbox.AddRow("Missing data source")
		    return 
		    
		  end if
		  
		  
		  var tmp_tbl as TableColumnReaderInterface = Source
		  
		  var nbr_columns as integer =  SetupListbox(source.GetColumnNames())
		  
		  columns.add(nil) // first column is the row number
		  
		  for column_base_index as integer = 0 to  nbr_columns-1
		    var column_index as integer = self.ColumnsOrder(column_base_index)
		    columns.Add(tmp_tbl.GetColumnAt(column_index))
		    
		  next
		  
		  //  
		  //  show data
		  //  
		  var tmp_last_row as integer = tmp_tbl.RowCount
		  
		  for row_index as integer = 0 to tmp_last_row - 1
		    tmp_listbox.AddRow(FormatRowID(row_index, tmp_last_row))
		    
		  next
		  
		  
		  for column_base_index as integer = 0 to  nbr_columns-1
		    var column_index as integer = self.ColumnsOrder(column_base_index)
		    var tmp_col as clAbstractDataSerie = tmp_tbl.GetColumnAt(column_index)
		    
		    for  row_index as integer = 0 to tmp_last_row - 1
		      
		      tmp_listbox.CellTextAt(row_index, column_base_index+1) =  tmp_col.GetElementAsString(row_index)
		      
		    next
		    
		  next
		  
		  Return
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowTable(Source as TableRowReaderInterface)
		  
		  
		  var tmp_listbox as DesktopListBox = self
		  var tmp_rowsource as TableRowReaderInterface = Source
		  var nbr_columns as integer = SetupListbox(source.GetColumnNames)
		  
		  //  
		  //  show data
		  //
		  var tmp_rowindex as integer = 0
		  
		  while not tmp_rowsource.EndOfTable
		    var tmp_row() as String
		    tmp_row  = tmp_rowsource.NextRowAsString
		    
		    tmp_listbox.AddRow(FormatRowID(tmp_rowindex, -1))
		    
		    for column_base_index as integer = 0 to  nbr_columns-1
		      var column_index as integer = self.ColumnsOrder(column_base_index)
		      
		      tmp_listbox.CellTextAt(tmp_rowindex, column_base_index+1) =  tmp_row(column_index)
		      
		    next
		    
		    
		    tmp_rowindex = tmp_rowindex + 1
		    
		  wend
		  
		  return
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		#tag Note
			Cannot use ColumnTag to store a pointer to the column
			Even when ColumnTag are set to nil, the desctructors are not called
		#tag EndNote
		Private Columns() As clAbstractDataSerie
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ColumnsOrder() As Integer
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
			InitialValue=""
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
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollOffset"
			Visible=false
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollWidth"
			Visible=false
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBorder"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnCount"
			Visible=true
			Group="Appearance"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnWidths"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultRowHeight"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridLineStyle"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="GridLineStyles"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - Horizontal"
				"2 - Vertical"
				"3 - Both"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHeader"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HeadingIndex"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialValue"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHorizontalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasVerticalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DropIndicatorVisible"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontUnit"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="FontUnits"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inch"
				"4 - Millimeter"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoHideScrollbars"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowResizableColumns"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowDragging"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowReordering"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowExpandableRows"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RequiresSelection"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RowSelectionType"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="RowSelectionTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Single"
				"1 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
