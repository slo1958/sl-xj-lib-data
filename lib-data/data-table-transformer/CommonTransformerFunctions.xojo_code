#tag Module
Protected Module CommonTransformerFunctions
	#tag Method, Flags = &h0
		Function TransformerRowAverage(CurrentRow as clDataRow, previousRows() as clDataRow, columns() as string, parameters() as variant) As clDataRow
		  //
		  // Transformer function 
		  // Clone the current input row to the output row
		  // Replace the values in the columns, name passed in argument columns(), by their average
		  //
		  
		  var outputRow as clDataRow = CurrentRow.CloneAsMutable
		  
		  if previousRows.Count = 0 then return outputRow
		  
		  for each col as string in columns
		    var sumVal as double
		    var countVal as Double
		    
		    sumVal = CurrentRow.GetCell(col)
		    countVal = 1
		    
		    for each row as clDataRow in previousRows
		      sumVal = sumVal + row.GetCell(col)
		      countVal = countVal  + 1
		      
		    next
		    
		    outputRow.SetCell(col, sumVal / countVal)
		    
		  next
		  
		  return outputRow
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TransformerRowDelta(CurrentRow as clDataRow, previousRows() as clDataRow, columns() as string, parameters() as variant) As clDataRow
		  //
		  // Transformer function 
		  // Clone the current input row to the output row
		  // Replace the values in the columns, name passed in argument columns(), by the difference with the previous row
		  //
		  // Parameters(0) defines the behaviour when the list of previous row is empty:
		  //  0 : set to zero (default)
		  //  1 : use current value 
		  //  2 : do not return the row (returns nil)
		  //
		  
		  var v as variant = 0
		  
		  if parameters.Count > 0 then v = parameters(0)
		  
		  var outputRow as clDataRow = CurrentRow.CloneAsMutable
		  
		  if previousRows.Count = 0 then
		    if v = 1 then return outputRow
		    if v = 2 then return nil
		    
		  end if
		  
		  
		  for each col as string in columns
		    var curVal as double
		    var prevVal as Double
		    
		    curVal = CurrentRow.GetCell(col)
		    if previousRows.Count = 0 then
		      outputRow.SetCell(col, 0.0) // we arrive here if v=0 => set the value to zero
		       
		    else
		      prevVal = previousRows(0).GetCell(col)
		      outputRow.SetCell(col, curVal - prevVal)
		      
		    end if
		    
		  next
		  
		  return outputRow
		  
		  
		End Function
	#tag EndMethod


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
End Module
#tag EndModule
