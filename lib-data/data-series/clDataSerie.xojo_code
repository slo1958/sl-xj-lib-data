#tag Class
Protected Class clDataSerie
Inherits clAbstractDataSerie
Implements itf_json_able
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub append_element(the_item as Variant)
		  items.Append(the_item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone() As clDataSerie
		  var tmp As New clDataSerie(Self.name)
		  
		  self.clone_info(tmp)
		  
		  tmp.AddMetaData("source","clone from " + self.full_name)
		  
		  For Each v As variant In Self.items
		    tmp.append_element(v)
		    
		  Next
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub clone_info(target as clDataSerie)
		  super.clone_info(target)
		  
		  target.default_value = self.default_value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone_structure() As clDataSerie
		  var tmp As New clDataSerie(Self.name)
		  
		  self.clone_info(tmp)
		  
		  tmp.AddMetaData("source","clone structure from " + self.full_name)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_value_in_list(list_of_values() as string) As boolean()
		  var return_boolean() As boolean
		  var my_item as variant
		  
		  For row_index As Integer=0 To items.Ubound
		    my_item = items(row_index)
		    return_boolean.Append(list_of_values.IndexOf(my_item)>=0)
		    
		  Next
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_with_function(the_filter_function as filter_column_by_rows, paramarray function_param as variant) As variant()
		  var return_boolean() As Variant
		  
		  For row_index As Integer=0 To items.Ubound
		    return_boolean.Append(the_filter_function.Invoke(row_index,  items.Ubound, name, items(row_index), function_param))
		    
		  Next
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_default_value() As variant
		  return default_value
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element(the_element_index as integer) As Variant
		  If 0 <= the_element_index And  the_element_index <= items.Ubound then
		    Return items(the_element_index)
		    
		  Else
		    var v As Variant
		    Return v
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub reset_elements()
		  
		  self.meta_dict.AddMetaData("type","general")
		  
		  redim items(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_default_value(v as variant)
		  default_value = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_element(the_element_index as integer, the_item as Variant)
		  If 0 <= the_element_index And  the_element_index <= items.Ubound Then
		    items(the_element_index) = the_item
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_length(the_length as integer, default_value as variant)
		  
		  if items.Ubound > the_length then
		    Raise New clDataException("Column " + self.name + " contains more elements than expected")
		  end if
		  
		  
		  While items.Ubound < the_length-1
		    var v as variant = default_value
		    items.Append(v)
		    
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function upper_bound() As integer
		  Return items.Ubound
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected default_value As Variant
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected items() As Variant
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="display_title"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="name"
			Visible=false
			Group="Behavior"
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
