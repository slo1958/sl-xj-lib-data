#tag Class
Protected Class clDoubleDataRow
	#tag Method, Flags = &h0
		Sub Constructor()
		  
		  self.my_label = "Nolabel"
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(NbrOfCells as integer)
		  
		  self.my_label = "Nolabel"
		  self.SetSize(NbrOfCells)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(pRowLabel as string)
		  
		  self.my_label = pRowLabel
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(pRowLabel as string, NbrOfCells as integer)
		  
		  self.my_label = pRowLabel
		  self.SetSize(NbrOfCells)
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCell(theColumnIndex as integer) As double
		  //  
		  //  Get the value of one field / cell
		  //  
		  //  Parameters:
		  //  - the index of the cell
		  //  
		  //  Returns:
		  //   value of the cell or unassigned variant
		  //  
		  
		  if  (0<= theColumnIndex)  and (theColumnIndex <= values.LastIndex) then
		    return self.values(theColumnIndex)
		    
		  else
		    return 0
		    
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCellName(theColumnIndex as integer) As string
		  //  
		  //  Get the name of one field / cell
		  //  
		  //  Parameters:
		  //  - the index of the cell
		  //  
		  //  Returns:
		  //    name of the cell or '-' if the cell is not used or names are not propagated
		  //  
		  
		  if  (0<= theColumnIndex)  and (theColumnIndex <= columns.LastIndex) then
		    return self.columns(theColumnIndex)
		    
		  else
		    return "-"
		    
		  end if
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function IsUsed(tmp as clAbstractDataSerie) As Boolean
		  return tmp isa clIntegerDataSerie  or tmp isa clNumberDataSerie or tmp isa clCurrencyDataSerie
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As string
		  //  
		  //  Get the name of the row
		  //  
		  //  Parameters:
		  // (none)
		  //  
		  //  Returns:
		  //   name of the row as a string
		  //  
		  
		  Return my_label
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetCell(theColumnIndex as integer, NewCellValue as Double)
		  //  
		  //  Set the value of one field / cell
		  //  
		  //  Parameters:
		  //  - the index of the cell
		  //  - the new value
		  //  
		  //  Returns:
		  //  -
		  //  
		  
		  if  (0<= theColumnIndex)  and (theColumnIndex <= values.LastIndex) then
		    self.values(theColumnIndex) = NewCellValue
		    self.columnsUsed(theColumnIndex) = true
		    
		  else
		    Raise New clDataException("Index out of range in SetCell : [" + str(theColumnIndex) + "]")
		    
		  end if
		  
		  return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFieldNames(names() as string)
		  //
		  // Update the list of field names
		  //
		  
		  self.columns = names
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetSize(NbrOfCells as integer)
		  
		  self.values.ResizeTo(NbrOfCells)
		  
		  self.columnsUsed.ResizeTo(NbrOfCells)
		  
		  for i as integer = 0 to self.columnsUsed.LastIndex
		    self.columnsUsed(i) = false
		    
		  next
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetTableLink(theTable as clDataTable)
		  if self.table_link = nil then
		    self.table_link = theTable
		    
		  else
		    raise new clDataException("Row already linked to table")
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As string
		  
		  // 
		  // Returns a string formed with label/value or index/value
		  //
		  
		  var ret() as string
		  
		  for i as integer = 0 to values.LastIndex
		    
		    if self.columnsUsed(i) then
		      var tmp as string
		      tmp = str(i) 
		      
		      if i <= self.columns.LastIndex then tmp = tmp + "/" +  self.columns(i)
		      tmp = tmp + "[" + self.values(i).ToString + "]"
		      
		      ret.Add(tmp)
		      
		    end if
		    
		    
		  next
		  
		  return string.FromArray(ret, ";")
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		columns() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		columnsUsed() As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		my_label As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected table_link As clDataTable
	#tag EndProperty

	#tag Property, Flags = &h0
		values() As Double
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
			Name="my_label"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
