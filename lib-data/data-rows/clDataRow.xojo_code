#tag Class
Protected Class clDataRow
Implements Iterable
	#tag Method, Flags = &h0
		Sub Constructor(values as Dictionary)
		  my_storage = New Dictionary
		  mutable_flag = False
		  my_label = ""
		  
		  for each k as string in values.Keys
		    my_storage.Value(k) = values.Value(k)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(obj as object)
		  my_storage = new Dictionary
		  mutable_flag = False
		  my_label = ""
		  
		  if obj = nil then 
		    my_label = "built from nil object" 
		    return
		    
		  end if
		  
		  var t as Introspection.TypeInfo = Introspection.GetType(obj)
		  
		  my_label = t.Name
		  
		  for each p as Introspection.PropertyInfo in t.GetProperties
		    
		    if  p.PropertyType.IsPrimitive and  p.IsPublic and p.CanRead then
		      var name as string = p.Name
		      var value as variant = p.Value(obj)
		      my_storage.value(name) = value
		      
		    end if
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_row_label as string = "")
		  my_storage = New Dictionary
		  mutable_flag = False
		  my_label = the_row_label
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_cell(the_cell_name as String) As variant
		  If my_storage.HasKey(the_cell_name) Then
		    Return  my_storage.Value(the_cell_name) 
		    
		  Else
		    Return ""
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_cells() As Dictionary
		  return  my_storage.Clone
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_cells(column_names() as string) As Variant()
		  var v() as variant
		  
		  for each k as string in column_names
		    v.Add(my_storage.value(k))
		    
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
		  Return my_label
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_cell(the_cell_name as string, the_cell_value as Variant)
		  If my_storage.HasKey(the_cell_name) And Not mutable_flag Then
		    Raise New clDataException("Cannot update a non mutable element")
		    
		  Else
		    my_storage.Value(the_cell_name) = the_cell_value
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub update_object(obj as Object)
		  
		  if obj = nil then return
		  
		  var t as Introspection.TypeInfo = Introspection.GetType(obj)
		  
		  for each p as Introspection.PropertyInfo in t.GetProperties
		    
		    if  p.PropertyType.IsPrimitive and  p.IsPublic and p.CanWrite then
		      var name as string = p.Name
		      
		      If my_storage.HasKey(name) Then
		        p.Value(obj) =   my_storage.Value(name) 
		        
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
