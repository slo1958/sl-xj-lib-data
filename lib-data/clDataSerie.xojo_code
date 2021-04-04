#tag Class
Protected Class clDataSerie
	#tag Method, Flags = &h0
		Sub append_element(the_item as Variant)
		  items.Append(the_item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_source_file as FolderItem)
		  Dim tmp_serie_name As String
		  
		  tmp_serie_name = load_from_text(the_source_file, True)
		  
		  If tmp_serie_name.Len>0 Then
		    serie_name = tmp_serie_name
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_label as string)
		  serie_name = the_label
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function find_row_index_for_value(the_find_value as Variant) As integer()
		  //
		  // returns row index of rows matching the value
		  //
		  Dim ret() As Integer
		  
		  For i As Integer = 0 To items.Ubound
		    If items(i) = the_find_value Then
		      ret.Append(i)
		      
		    End If
		    
		  Next
		  
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element(the_element_index as integer) As Variant
		  If items.Ubound >= the_element_index Then
		    Return items(the_element_index)
		    
		  Else
		    Return ""
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function load_from_text(the_source as FolderItem, has_header  as Boolean) As String
		  //
		  // Load the serie from a text file, each line is loaded into one element, without further processing
		  // The method returns the header if the 'has_header' flag is set to true, otherwise it returns an empty string
		  //
		  
		  Dim got_header As Boolean
		  Dim text_file  As TextInputStream
		  Dim return_header As String
		  
		  If the_source = Nil Then
		    Return "noname"
		    
		  End If
		  
		  text_file = TextInputStream.Open(the_source)
		  
		  got_header = Not has_header
		  
		  While Not text_file.EOF
		    Dim tmp_source_line As String = text_file.ReadLine
		    
		    If got_header Then
		      append_element(tmp_source_line)
		      
		    Else
		      return_header = tmp_source_line
		      got_header = True
		      
		    End If
		    
		  Wend
		  
		  text_file.close
		  
		  Return return_header
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function name() As String
		  Return serie_name
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function row_count() As integer
		  Return items.Ubound+1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub save_as_text(the_destination as FolderItem)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_element(the_element_index as integer, the_item as Variant)
		  If items.Ubound <= the_element_index Then
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


	#tag Property, Flags = &h1
		Protected items() As Variant
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected serie_name As string
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
