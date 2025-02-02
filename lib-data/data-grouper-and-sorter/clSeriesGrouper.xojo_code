#tag Class
Protected Class clSeriesGrouper
	#tag Method, Flags = &h0
		Shared Function Aggregate(mode as string, values as clNumberDataSerie) As Double
		  
		  select case mode
		    
		  case aggSum
		    return values.Sum
		    
		  case aggCount
		    return values.Count
		    
		  case aggMin
		    return values.Minimum
		    
		  case aggMax
		    return values.Maximum
		    
		  case else
		    return 0
		    
		  end select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BuildGroups(Grouping_Columns() as clAbstractDataSerie, MeasureColumns() as pair)
		  
		  var usedDimensionColumns(-1) as clAbstractDataSerie
		  var usedMeasureColumns(-1) as clNumberDataSerie
		  
		  redim titleOfDimensionColumns(-1)
		  
		  for i as integer = 0 to Grouping_Columns.LastIndex
		    //if Grouping_Columns(i) <> nil then
		    TitleOfDimensionColumns.Add(Grouping_Columns(i).name)
		    usedDimensionColumns.add(Grouping_Columns(i))
		    //end if
		    
		  next
		  
		  
		  for i as integer = 0 to MeasureColumns.LastIndex
		    if MeasureColumns(i).Left <> nil  and MeasureColumns(i).Left isa clNumberDataSerie then
		      //titleOfDimensionColumns.Add(Grouping_Columns(i).name)
		      var tmp as string = MeasureColumns(i).Right
		      TitleOfMeasureColumns.add(tmp  + " of "+ clAbstractDataSerie(MeasureColumns(i).Left).name)
		      NameOfMeasureColumns.add(clAbstractDataSerie(MeasureColumns(i).Left).name)
		      ActionOnMeasureColumns.Add(MeasureColumns(i).Right)
		      usedMeasureColumns.add(MeasureColumns(i).Left)
		      
		    end if
		    
		  next
		  
		  
		  if titleOfDimensionColumns.LastIndex < 0 then return
		  
		  TopNode = new clSeriesGrouperElement
		  
		  for row as integer = 0 to usedDimensionColumns(0).RowCount-1
		    
		    var WorkElement as clSeriesGrouperElement = TopNode
		    
		    var NextElement as clSeriesGrouperElement = nil
		    
		    for column_index as integer = 0 to usedDimensionColumns.LastIndex
		      var tmp_value as variant
		      
		      if usedDimensionColumns(column_index) <> nil then
		        tmp_value =  usedDimensionColumns(column_index).GetElement(row)
		        
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
		    
		    NextElement.AddRowIndex(row)
		    
		    
		    
		    for column_index as integer = 0 to usedMeasureColumns.LastIndex
		      var tmp_value as Double = usedMeasureColumns(column_index).GetElement(row)
		      
		      NextElement.AddMeasureValue(column_index, tmp_value)
		      
		      var n as integer = 0
		    next
		    
		    
		  next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(GroupingColumns() as clAbstractDataSerie)
		  var dummy() as pair
		  BuildGroups(GroupingColumns, dummy)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(GroupingColumns() as clAbstractDataSerie, MeasureColumns() as Pair)
		  BuildGroups(GroupingColumns, MeasureColumns)
		End Sub
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
		        OutputColumns(col + NbrOfDimensions).AddElement(Aggregate(ActionOnMeasureColumns(col), item))
		        
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
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IsValidAggregation(Mode as String) As Boolean
		  if mode = AggSum then return true
		  if mode = AggCount then return true
		  if mode = AggMin then return true
		  if mode = AggMax then return true
		  
		  return false
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Description
		The Grouper constructor creates a tree of dictionaries with the values of the selected dimensions (columns) as keys
		
		The tree is then flattened to obtain the combination of unique values
		
		Grouper can be extended to perform other calculations 
		
	#tag EndNote


	#tag Property, Flags = &h1
		Protected ActionOnMeasureColumns() As Variant
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected NameOfMeasureColumns() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TitleOfDimensionColumns() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TitleOfMeasureColumns() As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TopNode As clSeriesGrouperElement
	#tag EndProperty


	#tag Constant, Name = aggCount, Type = String, Dynamic = False, Default = \"count", Scope = Public
	#tag EndConstant

	#tag Constant, Name = aggMax, Type = String, Dynamic = False, Default = \"max", Scope = Public
	#tag EndConstant

	#tag Constant, Name = aggMin, Type = String, Dynamic = False, Default = \"min", Scope = Public
	#tag EndConstant

	#tag Constant, Name = aggSum, Type = String, Dynamic = False, Default = \"sum", Scope = Public
	#tag EndConstant


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
