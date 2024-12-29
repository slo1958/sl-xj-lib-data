#tag Class
Protected Class clJSONPoolReader
	#tag Method, Flags = &h0
		Sub Constructor(fld as FolderItem, config as clJSONPoolFileConfig)
		  //
		  // Read saved data pool as one or more JSON files
		  //
		  // If fld is a folder, we assume the folder contains a set of JSON files, where one file is one table
		  // if fld is a file, we assume it contains a set of tables with a manifest
		  //
		  //  Parameters
		  //  - Source file or source folder
		  //  - Configuration parameters
		  //
		  // Returns
		  //   (nothing)
		  //
		  
		  
		  var TempConfig as clJSONPoolFileConfig = config
		  
		  var tmp_stream as TextInputStream  
		  
		  
		  if TempConfig = nil then TempConfig = new clJSONPoolFileConfig
		  
		  self.mDataFile = fld
		  
		  if not fld.Exists  then Return
		  
		  
		  if fld.IsFolder then
		    
		    For Each file As FolderItem In fld.Children
		      var filename as string = file.Name
		      
		      if filename.Right(4)="JSON" then
		        var tempJSONReader as new clJSONReader(file, TempConfig)
		        var tempTable as new clDataTable(tempJSONReader)
		        
		        
		        
		      end if
		      
		      
		    Next
		    
		  else
		    
		  end if
		  
		  var tmp_stream as TextInputStream =  TextInputStream.Open(self.mDataFile)
		  
		  self.JSONSource = tmp_stream.ReadAll
		  
		  tmp_stream.close
		  
		  var tmp_master as new JSONItem(self.JSONSource)
		  
		  self.ProcessJSONData(tmp_master, TempConfig)
		  
		  return
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
End Class
#tag EndClass
