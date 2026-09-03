#tag Class
Protected Class clSeriesGroupAndAggregate
Inherits clSeriesGroupBy
	#tag Method, Flags = &h0
		Sub Constructor(GroupingColumns() as clAbstractDataSerie, MeasureColumns() as Pair, PrepareOutput as Boolean = True)
		  
		  
		  //Top node is assigned by parent constructor
		  
		  super.Constructor(GroupingColumns, false)
		  
		  PrepareMeasures(MeasureColumns)
		  
		  if PrepareOutput then ProcessRows
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Flattened(RowCountColumnName as string) As clAbstractDataSerie()
		  //  
		  //  Flatten the tree, creating one row for each unique combination of keys
		  //  Used to get unique values from the columns passed to the constructor
		  //  
		  //  Parameters:
		  //  - (none)
		  //  
		  //  Returns:
		  //  - array of dataseries
		  //  
		  
		  
		  if TopNode = nil then return nil
		  
		  
		  var tmp_label() as string
		  var tmp_value() as variant
		  
		  //  
		  //  Pre-allocate work array
		  //  
		  
		  tmp_label.ResizeTo(titleOfDimensionColumns.Count)
		  tmp_value.ResizeTo(titleOfDimensionColumns.Count)
		  
		  //  
		  //  Prepare output space for grouped dimensions
		  //  
		  var OutputColumns() As clAbstractDataSerie
		  
		  for each name as string in TitleOfDimensionColumns
		    OutputColumns.Add(new clDataSerie(name))
		    
		  Next
		  
		  var rowCountColumnIndex as integer = -1
		  
		  // if RowCountColumnName.Trim.Length > 0 then
		  // OutputColumns.Add(new clIntegerDataSerie(RowCountColumnName))
		  // rowCountColumnIndex = OutputColumns.LastIndex
		  // 
		  // end if
		  
		  for each name as string in TitleOfMeasureColumns
		    OutputColumns.Add(new clNumberDataSerie(name))
		    
		  next
		  
		  if RowCountColumnName.Trim.Length > 0 then
		    OutputColumns.Add(new clIntegerDataSerie(RowCountColumnName))
		    rowCountColumnIndex = OutputColumns.LastIndex
		    
		  end if
		  
		  
		  
		  FlattenNextDimension(tmp_label, tmp_value,  0, TopNode, OutputColumns, rowCountColumnIndex)
		  
		  return OutputColumns
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FlattenNextDimension(labels() as string, ColumnLatestValue() as variant, depth as integer, level_dict as clSeriesGrouperElement, OutputColumns() as clAbstractDataSerie, RowCountColumnIndex as integer)
		  
		  var NbrOfDimensions as integer = self.TitleOfDimensionColumns.Count
		  
		  labels(depth) = titleOfDimensionColumns(depth)
		  
		  for each k as variant in level_dict.keys
		    
		    ColumnLatestValue(depth) = k
		    
		    var d as clSeriesGrouperElement = clSeriesGrouperElement(level_dict.value(k))
		    
		    if d.keys.Count = 0 then // reached the end
		      
		      // Get all dimension values
		      for col as integer = 0 to NbrOfDimensions - 1
		        OutputColumns(col).AddElement(ColumnLatestValue(col))
		        
		      next
		      
		      // Get all measures
		      
		      for col as integer =0 to d.MeasureCount-1
		        var item as clNumberDataSerie = d.MeasureValues(col)
		        OutputColumns(col + NbrOfDimensions).AddElement( item.Aggregate(ActionOnMeasureColumns(col)))
		        
		      next
		      
		      if RowCountColumnIndex >= 0 then
		        var v as Variant = d.GetRowIndexCount
		        OutputColumns(RowCountColumnIndex).AddElement(v)
		        
		      end if
		      
		    else
		      FlattenNextDimension(labels, ColumnLatestValue, depth+1, d, OutputColumns, RowCountColumnIndex)
		      
		    end if
		    
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IsValidAggregation(Mode as String) As Boolean
		  return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub PrepareMeasures(MeasureColumns() as pair)
		  
		  usedMeasureColumns.RemoveAll
		  TitleOfMeasureColumns.RemoveAll
		  
		  ActionOnMeasureColumns.RemoveAll
		  
		  for each ColumnInfo as pair in MeasureColumns 
		    if ColumnInfo.Left <> nil  and ColumnInfo.Left isa clNumberDataSerie then
		      
		      var aggregateType as mdEnumerations.AggMode = ColumnInfo.Right
		      var aggregLabel as  string = clBasicMath.AggLabel(aggregateType)
		      
		      var data as clNumberDataSerie =  clNumberDataSerie(ColumnInfo.Left)
		      
		      TitleOfMeasureColumns.add(aggregLabel  + " of "+ data.name)
		      
		      ActionOnMeasureColumns.Add(aggregateType)
		      usedMeasureColumns.add(data)
		      
		    end if
		    
		  next
		  
		  self.ExpectedMeasureCount = usedMeasureColumns.Count
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ProcessRow(RowTarget as clSeriesGrouperElement, row_Index as integer)
		  // Calling the overridden superclass method.
		  Super.ProcessRow(RowTarget, row_Index)
		  
		  
		  for column_index as integer = 0 to usedMeasureColumns.LastIndex
		    var tmp_value as Double = usedMeasureColumns(column_index).GetElement(row_index)
		    
		    RowTarget.AddMeasureValue(column_index, tmp_value)
		    
		  next
		  
		  return
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Description
		The Grouper constructor creates a tree of dictionaries with the values of the selected dimensions (columns) as keys
		
		The tree is then flattened to obtain the combination of unique values
		
		Grouper can be extended to perform other calculations 
		
	#tag EndNote


	#tag Property, Flags = &h1
		Protected ActionOnMeasureColumns() As AggMode
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TitleOfMeasureColumns() As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected usedMeasureColumns() As clAbstractDataSerie
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
