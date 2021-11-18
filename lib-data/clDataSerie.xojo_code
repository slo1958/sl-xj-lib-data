#tag Class
Protected Class clDataSerie
Inherits clAbstractDataSerie
Implements clDataSupport.itf_json_able
	#tag Method, Flags = &h0
		Sub append_element(the_item as Variant)
		  items.Append(the_item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function apply_filter(the_filter_function as filter_column, paramarray function_param as variant) As variant()
		  Dim return_boolean() As Variant
		  
		  For i As Integer=0 To items.Ubound
		    return_boolean.Append(the_filter_function.Invoke(i,  items.Ubound, name, items(i), function_param))
		    
		  Next
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone() As clDataSerie
		  Dim tmp As New clDataSerie(Self.name)
		  
		  For Each v As variant In Self.items
		    tmp.append_element(v)
		    
		  Next
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function filter_column(the_row_index as integer, the_row_count as integer, the_column_name as string, the_cell_value as variant, paramarray function_param as variant) As Boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function get_element(the_element_index as integer) As Variant
		  If 0 <= the_element_index And  the_element_index <= items.Ubound then
		    Return items(the_element_index)
		    
		  Else
		    Dim v As Variant
		    Return v
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function row_count() As integer
		  Return items.Ubound+1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_element(the_element_index as integer, the_item as Variant)
		  If 0 <= the_element_index And  the_element_index <= items.Ubound Then
		    items(the_element_index) = the_item
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_length(the_length as integer)
		  While items.Ubound < the_length-1
		    items.Append("")
		    
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function upper_bound() As integer
		  Return items.Ubound
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected items() As Variant
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="last_error_message"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="name"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
