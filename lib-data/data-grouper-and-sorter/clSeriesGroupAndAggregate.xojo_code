#tag Class
Protected Class clSeriesGroupAndAggregate
Inherits clSeriesGroupBy
	#tag Method, Flags = &h21
		Private Sub BuildGroups_OUT(Grouping_Columns() as clAbstractDataSerie, MeasureColumns() as pair)
		  
		  usedDimensionColumns.RemoveAll
		  
		  usedMeasureColumns.RemoveAll
		  
		  titleOfDimensionColumns.RemoveAll
		  
		  for each DimensionColumn as clAbstractDataSerie in Grouping_Columns
		    TitleOfDimensionColumns.Add(DimensionColumn.name)
		    usedDimensionColumns.add(DimensionColumn)
		    
		  next
		  
		  usedMeasureColumns.RemoveAll
		  
		  for each ColumnInfo as pair in MeasureColumns 
		    if ColumnInfo.Left <> nil  and ColumnInfo.Left isa clNumberDataSerie then
		      
		      var aggregateType as mdEnumerations.AggMode = ColumnInfo.Right
		      var aggregLabel as  string = clBasicMath.AggLabel(aggregateType)
		      
		      var data as clNumberDataSerie =  clNumberDataSerie(ColumnInfo.Left)
		      
		      TitleOfMeasureColumns.add(aggregLabel  + " of "+ data.name)
		      NameOfMeasureColumns.add(data.name)
		      ActionOnMeasureColumns.Add(aggregateType)
		      usedMeasureColumns.add(data)
		      
		    end if
		    
		  next
		  
		  if titleOfDimensionColumns.LastIndex < 0 then return
		  
		  self.TopNode = new clSeriesGrouperElement
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(GroupingColumns() as clAbstractDataSerie, MeasureColumns() as Pair, PrepareOutput as Boolean = True)
		  
		  super.Constructor(GroupingColumns, false)
		  
		  PrepareMeasures(MeasureColumns)
		  
		  if PrepareOutput then ProcessRows
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindLeafGrouperElement(DimensionValues() as string, addIfMissing as Boolean = false) As clSeriesGrouperElement
		  // 
		  // Navigate the tree of grouperElements to find the leaf node corresponding to the passed dimension values
		  //
		  
		  var WorkElement as clSeriesGrouperElement = TopNode
		  
		  var NextElement as clSeriesGrouperElement = nil
		  
		  if DimensionValues.Count <> self.TitleOfDimensionColumns.count then return nil
		  
		  
		  for column_index as integer = 0 to DimensionValues.LastIndex
		    var tmp_value as variant = DimensionValues(column_index)
		    
		    if WorkElement.HasKey(tmp_value) then
		      NextElement = WorkElement.value(tmp_value)
		      
		    elseif not addIfMissing then 
		      return nil
		      
		    else
		      NextElement = new clSeriesGrouperElement
		      WorkElement.value(tmp_value) = NextElement
		      NextElement.MeasureCount = TopNode.MeasureCount
		      
		    end if
		    
		    WorkElement = NextElement
		    
		  next
		  
		  return NextElement
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Flattened() As clAbstractDataSerie()
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
		  
		  redim tmp_label(titleOfDimensionColumns.Count)
		  redim tmp_value(titleOfDimensionColumns.Count)
		  
		  //  
		  //  Prepare output space for grouped dimensions
		  //  
		  var OutputColumns() As clAbstractDataSerie
		  
		  for each name as string in TitleOfDimensionColumns
		    OutputColumns.Add(new clDataSerie(name))
		    
		  Next
		  
		  for each name as string in TitleOfMeasureColumns
		    OutputColumns.Add(new clNumberDataSerie(name))
		    
		  next
		  
		  FlattenNextDimension(tmp_label, tmp_value,  0, TopNode, OutputColumns)
		  
		  return OutputColumns
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FlattenNextDimension(labels() as string, ColumnLatestValue() as variant, depth as integer, level_dict as clSeriesGrouperElement, OutputColumns() as clAbstractDataSerie)
		  
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
		      
		      
		    else
		      FlattenNextDimension(labels, ColumnLatestValue, depth+1, d, OutputColumns)
		      
		    end if
		    
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRowIndexes(GroupingColumnValues() as variant) As integer()
		  var ret() as integer
		  
		  if GroupingColumnValues.Count <> TitleOfDimensionColumns.Count then return ret
		  
		  var WorkElement as clSeriesGrouperElement = self.TopNode
		  
		  
		  for column_index as integer = 0 to TitleOfDimensionColumns.LastIndex
		    var tmp_value as variant = GroupingColumnValues(column_index)
		    var NextElement  as clSeriesGrouperElement
		    
		    if WorkElement.HasKey(tmp_value) then
		      NextElement = WorkElement.value(tmp_value)
		      
		    else
		      return ret
		      
		    end if
		    
		    WorkElement = NextElement
		    
		  next
		  
		  if WorkElement.Keys.count <> 0 then 
		    System.DebugLog CurrentMethodName +": structure error"
		    return ret
		    
		  end if
		  
		  return WorkElement.GetRowIndexes
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTreeHead() As clSeriesGrouperElement
		  return self.TopNode
		  
		End Function
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
		  NameOfMeasureColumns.RemoveAll
		  ActionOnMeasureColumns.RemoveAll
		  
		  for each ColumnInfo as pair in MeasureColumns 
		    if ColumnInfo.Left <> nil  and ColumnInfo.Left isa clNumberDataSerie then
		      
		      var aggregateType as mdEnumerations.AggMode = ColumnInfo.Right
		      var aggregLabel as  string = clBasicMath.AggLabel(aggregateType)
		      
		      var data as clNumberDataSerie =  clNumberDataSerie(ColumnInfo.Left)
		      
		      TitleOfMeasureColumns.add(aggregLabel  + " of "+ data.name)
		      NameOfMeasureColumns.add(data.name)
		      ActionOnMeasureColumns.Add(aggregateType)
		      usedMeasureColumns.add(data)
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ProcessRows()
		  
		  //
		  // Process each row, handle dimensions and measures
		  //
		  
		  // Do NOT call the overloaded method
		  
		  for row_index as integer = 0 to usedDimensionColumns(0).RowCount-1
		    
		    var WorkElement as clSeriesGrouperElement = TopNode
		    
		    var NextElement as clSeriesGrouperElement = nil
		    
		    for column_index as integer = 0 to usedDimensionColumns.LastIndex
		      var tmp_value as variant
		      
		      if usedDimensionColumns(column_index) <> nil then
		        tmp_value =  usedDimensionColumns(column_index).GetElement(row_index)
		        
		      end if
		      
		      if WorkElement.HasKey(tmp_value) then
		        NextElement = WorkElement.value(tmp_value)
		        
		      else
		        NextElement = new clSeriesGrouperElement
		        WorkElement.value(tmp_value) = NextElement
		        NextElement.MeasureCount = usedMeasureColumns.Count
		        
		      end if
		      
		      WorkElement = NextElement
		      
		    next
		    
		    NextElement.AddRowIndex(row_index)
		    
		    
		    for column_index as integer = 0 to usedMeasureColumns.LastIndex
		      var tmp_value as Double = usedMeasureColumns(column_index).GetElement(row_index)
		      
		      NextElement.AddMeasureValue(column_index, tmp_value)
		      
		      
		    next
		    
		    
		  next
		  
		  
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
		Protected NameOfMeasureColumns() As String
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
