#tag Class
Protected Class clDataRow
Implements Iterable
	#tag Method, Flags = &h0
		Sub AppendCellsFrom(SourceRow as clDataRow)
		  //
		  // Append cells from the SourceRow to the current row
		  // 
		  //  Values in the sourcerow are ignored if the cell is already defined in the current row
		  //
		  // Parameters:
		  // - Source row
		  //
		  // Returns:
		  // - Nothing
		  //
		  
		  for each CellName as string  in SourceRow
		    
		    if  my_storage.HasKey(CellName) Then
		      
		    else
		      my_storage.Value(CellName) = SourceRow.GetCell(CellName)
		      
		    end if
		    
		  next
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AsObject(allocator as clDataTable.ObjectAllocator = nil) As object
		  //
		  // Use the current datarow to allocate an object and set its properties.
		  //  The object name (the parameter passed to the allocator) is taken from the row name column.
		  //
		  // Parameters:
		  // - Object allocator
		  //
		  // Returns
		  //  Allocated object
		  //
		  
		  var obj as Object
		  
		  if allocator = nil then return nil
		  
		  obj = allocator.Invoke(self.GetCell(clDataTable.RowNameColumn))
		  
		  if obj = nil then return nil
		  
		  self.UpdateObject(obj)
		  
		  return obj
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AsObject(TypeFieldName as string, allocator as clDataTable.ObjectAllocator = nil) As object
		  //
		  // Use the current datarow to allocate an object and set its properties. 
		  // The parameter passed to the allocator is taken from the row name column.
		  //
		  // Parameters:
		  // - TypeFieldName: name of the field containing the object type passed to the allocator
		  // - Object allocator
		  //
		  // Returns
		  //  Allocated object
		  //
		  
		  var obj as Object
		  
		  if allocator = nil then return nil
		  
		  obj = allocator.Invoke(self.GetCell(TypeFieldName))
		  
		  if obj = nil then return nil
		  
		  self.UpdateObject(obj)
		  
		  return obj
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Cell(the_cell_name as String) As variant
		  //  
		  //  Get the value of one field / cell
		  //  
		  //  Parameters:
		  //  - the name of the cell
		  //  
		  //  Returns:
		  //   value of the cell or empty string
		  //  
		  
		  
		  If my_storage.HasKey(the_cell_name) Then
		    Return  my_storage.Value(the_cell_name) 
		    
		  Else
		    Return ""
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cell(CellName as string, assigns NewCellValue as Variant)
		  //  
		  //  Update the value of one field / cell
		  //  
		  //  Parameters:
		  //  - CellName: the name of the cell
		  // -  NewCellValue: the value of the cell
		  //
		  // An exception is generated if the row is flagged as 'non mutable'
		  //  
		  //  Returns:
		  //   (none)
		  //  
		  
		  
		  If my_storage.HasKey(CellName) And Not mutable_flag Then
		    Raise New clDataException("Cannot update a field in a non mutable row: [" + CellName + "]")
		    
		  Else
		    my_storage.Value(CellName) = NewCellValue
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ClearTableLink()
		  self.table_link = nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As clDataRow
		  //
		  // Clone the current data row
		  //
		  // Parameters: 
		  // (nothing)
		  //
		  // Returns:
		  // cloned data row
		  //
		  
		  var ret as new clDataRow(self.my_storage,self.my_label)
		  ret.mutable_flag = self.mutable_flag
		  ret.table_link = self.table_link
		  
		  return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(SourceValues as Dictionary, the_row_label as string = "")
		  //  
		  //  Create a row based on a dictionary
		  //  
		  //  Parameters:
		  //  - the dictionary to create a datarow 
		  //  
		  //  Returns:
		  //   This is a constructor
		  //  
		  
		  my_storage = New Dictionary
		  mutable_flag = False
		  my_label = ""
		  
		  if SourceValues = nil then 
		    my_label = "built from nil dictionary" 
		    return
		    
		  end if
		  
		  for each k as string in SourceValues.Keys
		    my_storage.Value(k) = SourceValues.Value(k)
		    
		  next
		  
		  if the_row_label.trim.Length > 0 then
		    self.my_label = the_row_label.Trim
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(SourceObject as object)
		  //  
		  //  Create a row based on an object
		  //  Uses only the values of public properties r
		  //  
		  //  Parameters:
		  //  - an instance of the class to create a datarow 
		  //  
		  //  Returns:
		  //   This is a constructor
		  //  
		  
		  my_storage = new Dictionary
		  mutable_flag = False
		  my_label = ""
		  
		  if SourceObject = nil then 
		    my_label = "built from nil object" 
		    return
		    
		  end if
		  
		  var t as Introspection.TypeInfo = Introspection.GetType(SourceObject)
		  
		  my_label = t.Name
		  
		  for each p as Introspection.PropertyInfo in t.GetProperties
		    
		    if  p.PropertyType.IsPrimitive and  p.IsPublic and p.CanRead then
		      var name as string = p.Name
		      var value as variant = p.Value(SourceObject)
		      my_storage.value(name) = value
		      
		    end if
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(firstEntry as Pair, entries() as Pair)
		  //  
		  //  Create a row based on a list of pairs of field name and field value
		  //   
		  //  
		  //  Parameters:
		  //  - firstEntry: first (mandatory) pair
		  //  - the pairs to create a datarow 
		  //  
		  //  Returns:
		  //   This is a constructor
		  //  
		  
		  my_storage = New Dictionary()
		  mutable_flag = False
		  my_label = ""
		  
		  if firstEntry = nil then 
		    my_label = "built from nil pair" 
		    return
		    
		  end if
		  
		  my_storage.value(firstEntry.Left) = firstEntry.Right
		  
		  for each p as pair in entries
		    my_storage.value(p.Left) = p.Right
		    
		  next
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(firstEntry as pair, ParamArray entries as Pair)
		  //  
		  //  Create a row based on a list of pairs of field name and field value
		  //  
		  //  Parameters:
		  //  - firstEntry: first (mandatory) pair
		  //  - the pairs to create a datarow 
		  //  
		  //  Returns:
		  //   This is a constructor
		  //  
		  
		  my_storage = New Dictionary()
		  mutable_flag = False
		  my_label = ""
		  
		  if firstEntry = nil then 
		    my_label = "built from nil pair" 
		    return
		    
		  end if
		  
		  my_storage.value(firstEntry.Left) = firstEntry.Right
		  
		  for each p as pair in entries
		    my_storage.value(p.Left) = p.Right
		    
		  next
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(pRowLabel as string = "")
		  //  
		  //  Create a row based object
		  //  
		  //  Parameters:
		  //  - the name of the row
		  //
		  // The generated row has no cells
		  //  
		  //  Returns:
		  //   This is a constructor
		  //  
		  
		  my_storage = New Dictionary
		  mutable_flag = False
		  my_label = pRowLabel
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCell(the_cell_name as String) As variant
		  //  
		  //  Get the value of one field / cell
		  //  
		  //  Parameters:
		  //  - the name of the cell
		  //  
		  //  Returns:
		  //   value of the cell or unassigned variant
		  //  
		  
		  If my_storage.HasKey(the_cell_name) Then
		    Return  my_storage.Value(the_cell_name) 
		    
		  Else
		    var v as variant
		    Return v
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCells() As Dictionary
		  //  
		  //  Get the value of all fields / cells as a dictionary
		  //  
		  //  Parameters:
		  // (none)
		  //  
		  //  Returns:
		  //   dictionary with value of all cells
		  //  
		  
		  return  my_storage.Clone
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCells(RequestedColumnNames() as string) As Variant()
		  //  
		  //  Get the value of listed fields / cells
		  //  
		  //  Parameters:
		  //  - the name of the cell
		  //  
		  //  Returns:
		  //   list of value of the cells or empty string as an array of variant
		  //  
		  
		  var v() as variant
		  
		  for each k as string in RequestedColumnNames
		    if my_storage.HasKey(k) then
		      v.Add(my_storage.value(k))
		      
		    else
		      v.Add("")
		      
		    end if
		  next
		  
		  return v
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTableLink() As clDataTable
		  return self.table_link  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  
		  var iteration_keys() As String
		  
		  For Each s As String In my_storage.Keys
		    iteration_keys.Add(s)
		    
		  Next
		  
		  var tmp_row_iterator As New clDataRowIterator(iteration_keys)
		  Return tmp_row_iterator 
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
		Sub SetCell(CellName as string, NewCellValue as Variant)
		  //  
		  //  Update the value of one field / cell
		  //  
		  //  Parameters:
		  //  - CellName: the name of the cell
		  // -  NewCellValue: the value of the cell
		  //
		  // An exception is generated if the row is flagged as 'non mutable'
		  //  
		  //  Returns:
		  //   (none)
		  //  
		  
		  
		  If my_storage.HasKey(CellName) And Not mutable_flag Then
		    Raise New clDataException("Cannot update a field in a non mutable row, updating: [" + CellName + "]")
		    
		  Else
		    my_storage.Value(CellName) = NewCellValue
		    
		  End If
		  
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
		Sub UpdateObject(TargetObject as Object)
		  //  
		  //  Update the public properties of an object from the cell values
		  //  
		  //  Parameters:
		  //  - an instance of the class to be updated from the datarow 
		  //  
		  //  Returns:
		  //   (none)
		  //  
		  
		  if TargetObject = nil then return
		  
		  var t as Introspection.TypeInfo = Introspection.GetType(TargetObject)
		  
		  for each p as Introspection.PropertyInfo in t.GetProperties
		    
		    if  p.PropertyType.IsPrimitive and  p.IsPublic and p.CanWrite then
		      var name as string = p.Name
		      
		      If my_storage.HasKey(name) Then
		        p.Value(TargetObject) =   my_storage.Value(name) 
		        
		      end if
		      
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Description
		A dataRow is a dictionary where the keys are the column name and the values are taken from the current record in each dataSerie.
		
		This is a conveniant but very slow process to loop over records in a table.
		
		Available on: https://github.com/slo1958/sl-xj-lib-data.git
		
		
		
	#tag EndNote

	#tag Note, Name = License
		MIT License
		
		sl-xj-lib-data Data Handling Library
		Copyright (c) 2021-2025 slo1958
		
		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.
		
		
	#tag EndNote


	#tag Property, Flags = &h1
		Protected mutable_flag As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected my_label As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected my_storage As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected table_link As clDataTable
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
