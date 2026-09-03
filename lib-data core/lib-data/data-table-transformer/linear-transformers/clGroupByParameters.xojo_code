#tag Class
Protected Class clGroupByParameters
	#tag Method, Flags = &h0
		Sub Constructor()
		  //
		  // Group records per distinct values in the grouping_dimensions
		  // This is typically used to get a list of distinct combinations
		  //
		  // Parameters:
		  // - grouping_dimenions() list of columns to be used as grouping dimensions
		  // - rowCountColumnName: name of column in output table to store row count
		  //
		  
		  self.GroupingCountColumn = ""
		  self.GroupingDimensions.RemoveAll
		  self.GroupingMeasures.RemoveAll
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetGroupByDimensions(grouping_dimensions() as string)
		  
		  
		  self.GroupingDimensions= grouping_dimensions
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetGroupByDimensions(paramarray grouping_dimensions as string)
		  
		  
		  self.GroupingDimensions= grouping_dimensions
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetMeasures(measures() as pair)
		  self.GroupingMeasures = measures
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetMeasures(measures() as String)
		  self.GroupingMeasures.RemoveAll
		  
		  for each measure as string in measures
		    self.GroupingMeasures.Add(measure: aggMode.Sum)
		    
		  next
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetMeasures(paramarray measures as String)
		  self.GroupingMeasures.RemoveAll
		  
		  for each measure as string in measures
		    self.GroupingMeasures.Add(measure: aggMode.Sum)
		    
		  next
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetRowCountColumnName(rowCountColumnName as string)
		  self.GroupingCountColumn = rowCountColumnName
		  
		  Return
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		GroupingCountColumn As string
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
