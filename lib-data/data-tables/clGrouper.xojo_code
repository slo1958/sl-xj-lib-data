#tag Class
Protected Class clGrouper
	#tag Method, Flags = &h0
		Sub Constructor(selected_columns() as clAbstractDataSerie)
		  var usefull_columns(-1) as clAbstractDataSerie
		  
		  redim dimension_column_names(-1)
		  
		  for i as integer = 0 to selected_columns.LastIndex
		    if selected_columns(i) <> nil then
		      dimension_column_names.Add(selected_columns(i).name)
		      usefull_columns.add(selected_columns(i))
		    end if
		    
		  next
		  
		  if dimension_column_names.LastIndex < 0 then return
		  
		  top_dictionary = new Dictionary
		  
		  for row as integer = 0 to usefull_columns(0).RowCount-1
		    
		    var work_dict as Dictionary = top_dictionary
		    
		    var next_dict as Dictionary = nil
		    
		    for column_index as integer = 0 to usefull_columns.LastIndex
		      var tmp_value as variant = usefull_columns(column_index).GetElement(row)
		      
		      if work_dict.HasKey(tmp_value) then
		        next_dict = work_dict.value(tmp_value)
		        
		      else
		        next_dict = new Dictionary
		        work_dict.value(tmp_value) = next_dict
		        
		      end if
		      
		      work_dict = next_dict
		      
		    next
		    
		  next
		  
		  
		  
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
		  
		  
		  if top_dictionary = nil then return nil
		  
		  
		  var tmp_label() as string
		  var tmp_value() as variant
		  
		  //  
		  //  Pre-allocate work array
		  //  
		  
		  redim tmp_label(dimension_column_names.Count)
		  redim tmp_value(dimension_column_names.Count)
		  
		  //  
		  //  Prepare output space for grouped dimensions
		  //  
		  var output_dimensions() As clAbstractDataSerie
		  
		  for each name as string in dimension_column_names
		    output_dimensions.Add(new clDataSerie(name))
		    
		  Next
		  
		  FlattenNextDimension(tmp_label, tmp_value,  0, top_dictionary, output_dimensions)
		  
		  return output_dimensions
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FlattenNextDimension(labels() as string, ColumnLatestValue() as variant, depth as integer, level_dict as Dictionary, output_cols() as clAbstractDataSerie)
		  labels(depth) = dimension_column_names(depth)
		  
		  for each k as variant in level_dict.keys
		    
		    ColumnLatestValue(depth) = k
		    
		    var d as Dictionary = Dictionary(level_dict.value(k))
		    
		    if d.keys.Count = 0 then // reached the end
		      
		      for col as integer = 0 to output_cols.LastIndex
		        output_cols(col).AddElement(ColumnLatestValue(col))
		        
		      next
		      
		      
		    else
		      FlattenNextDimension(labels, ColumnLatestValue, depth+1, d, output_cols)
		      
		    end if
		    
		  next
		End Sub
	#tag EndMethod


	#tag Note, Name = Description
		The Grouper constructor creates a tree of dictionaries with the values of the selected dimensions (columns) as keys
		
		The tree is then flattened to obtain the combination of unique values
		
		Grouper can be extended to perform other calculations 
		
	#tag EndNote


	#tag Property, Flags = &h0
		dimension_column_names() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		top_dictionary As dictionary
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
