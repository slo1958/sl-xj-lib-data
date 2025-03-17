#tag Class
Protected Class clDataSerieMultiValued
Inherits clDataSerie
	#tag Method, Flags = &h0
		Sub AddElement(the_item as Variant)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone(NewName as string = "") As clDataSerie
		  
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
		  
		  self.serie_headers.RemoveAll
		  
		  For Each element As String In the_labels
		    Self.serie_headers.Append(element)
		    
		  Next
		  
		  Super.Constructor(Self.name)
		  
		End Sub
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
		Sub SetElement(ElementIndex as integer, the_item as Variant)
		  
		  var tmp() As String
		  
		  tmp = Split(the_item, serie_value_separator)
		  
		  If tmp.LastIndex = Self.serie_headers.LastIndex Then
		    
		    
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
			Name="DisplayTitle"
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
			Name="serie_value_separator"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
