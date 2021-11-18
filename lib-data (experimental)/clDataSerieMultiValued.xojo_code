#tag Class
Protected Class clDataSerieMultiValued
Inherits clDataSerie
	#tag Method, Flags = &h0
		Sub append_element(the_item as Variant)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone() As clDataSerie
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_labels() as string)
		  // Calling the overridden superclass constructor.
		  // Note that this may need modifications if there are multiple constructor choices.
		  // Possible constructor calls:
		  // Constructor(the_source_file as FolderItem) -- From clDataSerie
		  // Constructor(the_label as string) -- From clDataSerie
		  // Constructor(the_label as string, the_values() as variant) -- From clDataSerie
		  
		  serie_value_separator = Chr(9)
		  
		  Redim Self.serie_headers(-1)
		  For Each element As String In the_labels
		    Self.serie_headers.Append(element)
		    
		  Next
		  
		  Super.Constructor(Self.name)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function load_from_text(the_source as FolderItem, has_header  as Boolean) As String
		  Raise New clDataException("Cannot load a multivalued serie")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function name() As String
		  Return Join(Self.serie_headers, serie_value_separator)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub rename(the_new_name as string)
		  Raise New clDataException("Cannot rename multivalues serie")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_element(the_element_index as integer, the_item as Variant)
		  
		  Dim tmp() As String
		  
		  tmp = Split(the_item, serie_value_separator)
		  
		  If tmp.Ubound = Self.serie_headers.Ubound Then
		    
		    
		  Else
		    Raise New clDataException("Number of values does not match expected number of values")
		    
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		serie_headers() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		serie_value_separator As String
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
			Name="serie_value_separator"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
