#tag Module
Protected Module DataSerie_IO
	#tag Method, Flags = &h0
		Function append_textfile_to_DataSerie(the_source as FolderItem, theDataSerie as clAbstractDataSerie, has_header as Boolean) As clAbstractDataSerie
		  //
		  // Load the serie from a text file, each line is loaded into one element, without further processing
		  // The method returns the header if the 'has_header"  flag is set to true, otherwise it returns an empty string
		  //
		  
		  var got_header As Boolean
		  var text_file  As TextInputStream
		  var return_header As String
		  
		  If the_source = Nil Then
		    Return nil
		    
		  End If
		  
		  
		  text_file = TextInputStream.Open(the_source)
		  
		  got_header = Not has_header
		  
		  While Not text_file.EOF
		    var tmp_source_line As String = text_file.ReadLine
		    
		    If got_header Then
		      theDataSerie.append_element(tmp_source_line)
		      
		    Else
		      theDataSerie.rename(tmp_source_line)
		      return_header = tmp_source_line
		      got_header = True
		      
		    End If
		    
		  Wend
		  
		  text_file.close
		  
		  theDataSerie.add_meta_data("source",the_source.Name)
		  
		  return theDataSerie
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub save_DataSerie_to_textfile(the_destination as FolderItem, theDataSerie as clAbstractDataSerie, name_as_header as boolean)
		  //
		  // Load the serie from a text file, each line is loaded into one element, without further processing
		  // The method returns the header if the 'has_header"  flag is set to true, otherwise it returns an empty string
		  //
		  
		  var text_file  As TextOutputStream
		  
		  If the_destination = Nil Then
		    Return
		    
		  End If
		  
		  text_file = TextOutputStream.Create(the_destination)
		  
		  If name_as_header Then
		    text_file.WriteLine theDataSerie.name
		    
		  End If
		  
		  For i As Integer = 0 To theDataSerie.upper_bound
		    text_file.WriteLine theDataSerie.get_element(i)
		    
		  Next
		  
		  text_file.close
		  
		  
		  
		End Sub
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
