#tag Class
Protected Class clGroupByTransformer
Inherits clLinearTransformer
	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, grouping_dimensions() as string, measures() as pair, rowCountColumnName as string)
		  //
		  // Group records per distinct values in the grouping_dimensions
		  // Aggregate the number fields as defined the each pair, columnname:agg mode
		  //
		  // Parameters:
		  // - Input table
		  // - grouping_dimenions() list of columns to be used as grouping dimensions
		  // - measures() pair of (columnname : agg mode)
		  //
		  
		  super.Constructor(MainTable)
		  
		  self.GroupingCountColumn = rowCountColumnName
		  self.GroupingDimensions= grouping_dimensions
		  self.GroupingMeasures = measures
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, grouping_dimensions() as string, measures() as String, rowCountColumnName as string)
		  //
		  // Group records per distinct values in the grouping_dimensions
		  // Aggregate the number fields as defined in the second array, aggregation mode is sum
		  //
		  // Parameters:
		  // - Input table
		  // - grouping_dimenions() list of columns to be used as grouping dimensions
		  // - measures() list of columns to sum
		  //
		  
		  super.Constructor(MainTable)
		  
		  self.GroupingCountColumn = rowCountColumnName
		  self.GroupingDimensions= grouping_dimensions
		  self.GroupingMeasures.RemoveAll
		  
		  for each measure as string in measures
		    self.GroupingMeasures.Add(measure: aggMode.Sum)
		    
		  next
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, grouping_dimensions() as string, rowCountColumnName as string)
		  //
		  // Group records per distinct values in the grouping_dimensions
		  // This is typically used to get a list of distinct combinations
		  //
		  // Parameters:
		  // - Input table
		  // - grouping_dimenions() list of columns to be used as grouping dimensions
		  //
		  
		  super.Constructor(MainTable)
		  
		  self.GroupingCountColumn = rowCountColumnName
		  self.GroupingDimensions= grouping_dimensions
		  self.GroupingMeasures.RemoveAll
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Transform() As Boolean
		  
		  
		  var source as clDataTable = self.SourceTable
		  
		  var t as clDataTable
		  
		  self.GroupingDataSeries = source.GetColumns(GroupingDimensions, False)
		  
		  if self.GroupingDataSeries.Count = 0 and self.GroupingMeasures.Count = 0 then
		    t = nil
		    
		  elseif self.GroupingDataSeries.Count = 0 then 
		    t =  self.TransformToOneLiner(source)
		    
		  else
		    t =  self.TransformWithGrouper(source)
		    
		  end if
		  
		  Self.SetOutputTable(cOutputConnectorName, t)
		  
		  return t <> nil
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function TransformToOneLiner(source as clDataTable) As clDataTable
		  //
		  // There are no grouping dimensions, so we aggregate all measures using the supported method from data series
		  //
		  //
		  // Parameters:
		  // (nothing)
		  //
		  // Returns
		  // Success status
		  //
		  
		  if self.GroupingDataSeries.Count > 0 then return nil
		  
		  var r as new clDataRow
		  
		  for each p as pair in GroupingMeasures
		    var col as clNumberDataSerie = clNumberDataSerie(source.GetColumn(p.Left))
		    var mode as AggMode = p.Right
		    
		    if col <> nil then
		      r.SetCell(clBasicMath.AggLabel(mode) + " of " + p.Left, col.Aggregate(mode))
		      
		    end if
		    
		  next
		  
		  var t as  clDataTable = self.EmptyOutputTable()
		  t.AddRow(r)
		  
		  return t
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function TransformWithGrouper(source as clDataTable) As clDataTable
		  
		  var MeasureColumns() as pair
		  
		  
		  for each p as pair in self.GroupingMeasures
		    var np as pair = source.GetColumn(p.Left) : p.Right
		    MeasureColumns.Add(np)
		    
		  next
		  
		  var connector as clTransformerConnector
		  var grp as new clSeriesGroupAndAggregate(GroupingDataSeries,MeasureColumns)
		  
		  var res() as clAbstractDataSerie = grp.Flattened(self.GroupingCountColumn)
		  
		  connector = self.GetOutputConnector(cOutputConnectorName)
		  
		  if connector = nil then
		    Return nil
		    
		  else
		    return new clDataTable(connector.GetTableName(false), res)
		    
		  end if
		  
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		GroupingCountColumn As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private GroupingDataSeries() As clAbstractDataSerie
	#tag EndProperty

	#tag Property, Flags = &h0
		GroupingDimensions() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		GroupingMeasures() As pair
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
		#tag ViewProperty
			Name="GroupingCountColumn"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
