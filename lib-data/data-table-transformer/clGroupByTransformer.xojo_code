#tag Class
Protected Class clGroupByTransformer
Inherits clAbstractTransformer
	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, grouping_dimensions() as string)
		  
		  InputTables.add(MainTable)
		  OutputNames.add( "Results")
		  
		  self.GroupingDimensions= grouping_dimensions
		  self.GroupingMeasures.RemoveAll
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, grouping_dimensions() as string, measures() as pair)
		  //
		  // Group records per distinct values in the grouping_dimensions
		  // Aggregate the number fields as defined the each pair, columnname:agg mode
		  //
		  // Parameters:
		  // - source table
		  // - grouping_dimenions() list of columns to be used as grouping dimensions
		  // - measures() pair of columnname : agg mode
		  //
		  
		  
		  InputTables.add(MainTable)
		  OutputNames.add( "Results")
		  
		  self.GroupingDimensions= grouping_dimensions
		  self.GroupingMeasures = measures
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, grouping_dimensions() as string, measures() as String)
		  
		  InputTables.add(MainTable)
		  OutputNames.add( "Results")
		  
		  self.GroupingDimensions= grouping_dimensions
		  self.GroupingMeasures.RemoveAll
		  
		  for each measure as string in measures
		    self.GroupingMeasures.Add(measure: clDataTable.AggSum)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Transform() As Boolean
		  
		  if self.GroupingDimensions.Count = 0 and self.GroupingMeasures.Count = 0 then
		    OutputTables.add(nil)
		    return false
		    
		  end if
		  
		  if self.GroupingDimensions.Count = 0 then 
		    return self.TransformToOneLiner
		    
		  else
		    return self.TransformWithGrouper
		    
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function TransformToOneLiner() As Boolean
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
		  
		  if self.GroupingDimensions.Count > 0 then return false
		  
		  var source as clDataTable = self.InputTables(0)
		  
		  var r as new clDataRow
		  
		  for each p as pair in GroupingMeasures
		    var col as clNumberDataSerie = clNumberDataSerie(source.GetColumn(p.Left))
		    
		    if col <> nil then
		      r.SetCell(p.Right + " of " + p.Left, clSeriesGrouper.Aggregate(p.Right, col))
		      
		    end if
		    
		  next
		  
		  var t as new clDataTable(OutputNames(0))
		  t.AddRow(r)
		  
		  OutputTables.add(t)
		  
		  Return True
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function TransformWithGrouper() As Boolean
		  
		  var source as clDataTable = self.InputTables(0)
		  
		  
		  var GroupingDataSeries() as clAbstractDataSerie = source.GetColumns(GroupingDimensions, False)
		  var MeasureColumns() as pair
		  
		  
		  for each p as pair in self.GroupingMeasures
		    var np as pair = source.GetColumn(p.Left) : p.Right
		    MeasureColumns.Add(np)
		    
		  next
		  
		  var grp as new clSeriesGrouper(GroupingDataSeries,MeasureColumns)
		  
		  var res() as clAbstractDataSerie = grp.Flattened()
		  
		  OutputTables.add(new clDataTable(OutputNames(0), res))
		  
		   
		  
		  
		End Function
	#tag EndMethod


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
			Name="GroupingDimensions()"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
