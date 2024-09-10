#tag Class
Protected Class clDataRow
Implements Iterable
	#tag Method, Flags = &h0
		Function AsObject(allocator as clDataTable.object_allocator = nil) As object
		  var obj as Object
		  
		  if allocator = nil then return nil
		  
		  obj = allocator.Invoke(self.get_cell(clDataTable.row_name_column))
		  
		  if obj = nil then return nil
		  
		  self.update_object(obj)
		  
		  return obj
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AsObject(TypeFieldName as string, allocator as clDataTable.object_allocator = nil) As object
		  var obj as Object
		  
		  if allocator = nil then return nil
		  
		  obj = allocator.Invoke(self.get_cell(TypeFieldName))
		  
		  if obj = nil then return nil
		  
		  self.update_object(obj)
		  
		  return obj
		  
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
		Sub Constructor(the_row_label as string = "")
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
		  my_label = the_row_label
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_cell(the_cell_name as String) As variant
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
		Function get_cells() As Dictionary
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
		Function get_cells(RequestedColumnNames() as string) As Variant()
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
		Function Iterator() As Iterator
		  // Part of the Iterable interface.
		  
		  
		  var iteration_keys() As String
		  
		  For Each s As String In my_storage.Keys
		    iteration_keys.Append(s)
		    
		  Next
		  
		  var tmp_row_iterator As New clDataRowIterator(iteration_keys)
		  Return tmp_row_iterator 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function name() As string
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
		Sub set_cell(the_cell_name as string, the_cell_value as Variant)
		  //  
		  //  Update the value of one field / cell
		  //  
		  //  Parameters:
		  //  - the name of the cell
		  // -  the value of the cell
		  //
		  // An exception is generated if the row is flagged as 'non mutable'
		  //  
		  //  Returns:
		  //   (none)
		  //  
		  
		  
		  If my_storage.HasKey(the_cell_name) And Not mutable_flag Then
		    Raise New clDataException("Cannot update a field in a non mutable row")
		    
		  Else
		    my_storage.Value(the_cell_name) = the_cell_value
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub update_object(TargetObject as Object)
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
