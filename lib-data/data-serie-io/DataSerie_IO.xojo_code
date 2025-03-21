#tag Module
Protected Module DataSerie_IO
	#tag Method, Flags = &h0
		Sub AppendDataSerieToTextfile(DestinationFile as FolderItem, theDataSerie as clAbstractDataSerie, name_as_header as boolean)
		  //
		  // Load the serie from a text file, each line is loaded into one element, without further processing
		  // The method returns the header if the 'has_header"  flag is set to true, otherwise it returns an empty string
		  //
		  
		  var TextFile  As TextOutputStream
		  
		  If DestinationFile = Nil Then
		    Return
		    
		  End If
		  
		  TextFile = TextOutputStream.Open(DestinationFile)
		  
		  If name_as_header and DestinationFile.Length = 0 then 
		    TextFile.WriteLine theDataSerie.name
		    
		  End If
		  
		  For i As Integer = 0 To theDataSerie.LastIndex
		    TextFile.WriteLine theDataSerie.GetElement(i)
		    
		  Next
		  
		  TextFile.close
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AppendTextfileToDataSerie(SourceFIle as FolderItem, theDataSerie as clAbstractDataSerie, has_header as Boolean) As clAbstractDataSerie
		  //
		  // Load the serie from a text file, each line is loaded into one element, without further processing
		  // The method returns the header if the 'has_header"  flag is set to true, otherwise it returns an empty string
		  //
		  
		  var got_header As Boolean
		  var TextFile  As TextInputStream
		  var return_header As String
		  
		  If SourceFIle = Nil Then
		    Return nil
		    
		  End If
		  
		  
		  TextFile = TextInputStream.Open(SourceFIle)
		  
		  got_header = Not has_header
		  
		  While Not TextFile.EOF
		    var tmp_source_line As String = TextFile.ReadLine
		    
		    If got_header Then
		      theDataSerie.AddElement(tmp_source_line)
		      
		    Else
		      theDataSerie.rename(tmp_source_line)
		      return_header = tmp_source_line
		      got_header = True
		      
		    End If
		    
		  Wend
		  
		  TextFile.close
		  
		  theDataSerie. AddSourceToMetadata(SourceFIle.Name)
		  
		  return theDataSerie
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveDataSerieToTextfile(DestinationFile as FolderItem, theDataSerie as clAbstractDataSerie, name_as_header as boolean)
		  //
		  // Load the serie from a text file, each line is loaded into one element, without further processing
		  // The method returns the header if the 'has_header"  flag is set to true, otherwise it returns an empty string
		  //
		  
		  var TextFile  As TextOutputStream
		  
		  If DestinationFile = Nil Then
		    Return
		    
		  End If
		  
		  TextFile = TextOutputStream.Create(DestinationFile)
		  
		  If name_as_header Then
		    TextFile.WriteLine theDataSerie.name
		    
		  End If
		  
		  For i As Integer = 0 To theDataSerie.LastIndex
		    TextFile.WriteLine theDataSerie.GetElement(i)
		    
		  Next
		  
		  TextFile.close
		  
		  
		  
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
