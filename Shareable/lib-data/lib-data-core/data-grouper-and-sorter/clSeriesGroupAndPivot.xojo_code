#tag Class
Protected Class clSeriesGroupAndPivot
Inherits clSeriesGroupBy
	#tag Method, Flags = &h0
		Sub Constructor(GroupingColumns() as clAbstractDataSerie, MeasureColumns() as Pair, PivotingColumn as clAbstractDataSerie, PivotMapping() as Dictionary, PrepareOutput as Boolean = True)
		  //
		  //
		  // Parameters
		  //
		  //
		  // Pivoting column: Value from this column are used to pivot the measures
		  // Pivot Mapping: a list of pairs, the left value is the number data serie, the right value is a dictionary with name of output measure
		  // using the pivot value as key. If the pivot value does not exist, we look for an entry with key == ""
		  //
		  
		  super.Constructor(GroupingColumns, false)
		  
		  self.PivotColumn = PivotingColumn
		  
		  PrepareMeasures(MeasureColumns, PivotMapping)
		  
		  if PrepareOutput then ProcessRows
		  
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
		  
		  tmp_label.ResizeTo(titleOfDimensionColumns.Count)
		  tmp_value.ResizeTo(titleOfDimensionColumns.Count)
		  
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
		Shared Function IsValidAggregation(Mode as String) As Boolean
		  return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub PrepareMeasures(MeasureColumns() as pair, PivotMapping() as Dictionary)
		  
		  InputMeasureColumns().RemoveAll
		  TitleOfMeasureColumns.RemoveAll
		  
		  ActionOnMeasureColumns.RemoveAll
		  
		  self.PivotDefinition = PivotMapping
		  self.OutputColumnIndex = new Dictionary
		  
		  var running_column_index as integer = 0
		  
		  for idx as integer = 0 to MeasureColumns.LastIndex
		    var aggregateType as mdEnumerations.AggMode = MeasureColumns(idx).Right
		    var data as clNumberDataSerie =  clNumberDataSerie(MeasureColumns(idx).Left)
		    var mapping as Dictionary = PivotMapping(idx)
		    
		    InputMeasureColumns().add(data)
		    
		    
		    for each k as string in mapping.Keys
		      OutputColumnIndex.value(mapping.value(k)) = running_column_index
		      TitleOfMeasureColumns.Add(mapping.value(k))
		      ActionOnMeasureColumns.add(aggregateType)
		      
		      running_column_index = running_column_index + 1
		      
		    next
		    
		    
		  next
		  
		  self.ExpectedMeasureCount = running_column_index
		  
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ProcessRow(RowTarget as clSeriesGrouperElement, row_Index as integer)
		  // Calling the overridden superclass method.
		  Super.ProcessRow(RowTarget, row_Index)
		  
		  var pivotValue as variant = self.PivotColumn.GetElement(row_Index)
		  
		  
		  for column_index as integer = 0 to InputMeasureColumns.LastIndex
		    var tmp_value as Double = InputMeasureColumns(column_index).GetElement(row_index)
		    var mapping_dict as Dictionary = self.PivotDefinition(column_index)
		    
		    var output_index as integer
		    
		    if mapping_dict.HasKey(pivotValue) then
		      output_index = OutputColumnIndex.value(mapping_dict.Value(pivotValue))
		      
		    elseif mapping_dict.HasKey("") then
		      output_index = OutputColumnIndex.value(mapping_dict.Value(""))
		      
		    else
		      output_index = -1
		    end if
		    
		    if output_index >= 0 then RowTarget.AddMeasureValue(output_index, tmp_value)
		    
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
		Protected InputMeasureColumns() As clAbstractDataSerie
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected OutputColumnIndex As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected PivotColumn As clAbstractDataSerie
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected PivotDefinition() As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected TitleOfMeasureColumns() As string
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
