#tag Class
Protected Class clTextfileLogWriter
Inherits clGenericLogWriter
Implements itfLogWriter
	#tag Method, Flags = &h0
		Sub AddLogEntry(MessageSeverity as string, MessageTime as string, MessageSource as string, MessageText as string)
		  // Part of the itfLogingWriter interface.
		  
		  if not self.AcceptSeverity(MessageSeverity) then return
		  
		  var output As TextOutputStream
		  
		  Try
		    output = TextOutputStream.Append(file_path)
		    
		    var tmp_line() as string = array(MessageTime, MessageSource, MessageSeverity, MessageText)
		    
		    output.WriteLine(string.FromArray(tmp_line, field_separator))
		    
		    output.Close
		    
		    fileError = ""
		    
		  Catch e As IOException
		    fileError = "Error appending to log: "+e.Message
		    
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_folder as folderitem = Nil, the_file_name as string, TimeStampPlaceHolder as string = "")
		  
		  super.Constructor
		  
		  field_separator = Chr(9)
		  
		  if the_file_name.trim.length > 0 and the_folder <> nil then 
		    SetFilePath(the_folder, the_file_name, TimeStampPlaceHolder)
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFileError() As String
		  return fileError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFilePath() As FolderItem
		  Return self.file_path
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFilePath(the_folder as folderitem, the_file_name as string, TimeStampPlaceHolder as string = "")
		  var tmp_file_path As FolderItem
		  
		  If TimeStampPlaceHolder.Len > 0 Then
		    var tmp_time As String  =DateTime.Now.SQLDateTime
		    tmp_time = tmp_time.ReplaceAll("-","")
		    tmp_time = tmp_time.ReplaceAll(":","")
		    tmp_time = tmp_time.ReplaceAll(" ","_")
		    
		    tmp_file_path = the_folder.Child(the_file_name.Replace(TimeStampPlaceHolder, tmp_time))
		    
		  Else
		    tmp_file_path = the_folder.Child(the_file_name)
		    
		  End If
		  
		  file_path = New FolderItem(tmp_file_path.NativePath)
		  
		  try
		    var output As TextOutputStream = TextOutputStream.Open(file_path)
		    
		    var field_names() as string
		    field_names.Append(kWhen)
		    field_names.Append(kWho)
		    field_names.Append(kSeverity)
		    field_names.Append(kMessage)
		    
		    output.WriteLine(string.FromArray(field_names, field_separator))
		    
		    output.Close
		    
		    fileError = ""
		    
		  Catch e As IOException
		    fileError = "Error creating log file: "+e.Message
		    
		  End Try
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected field_separator As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fileError As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private file_path As FolderItem
	#tag EndProperty


	#tag Constant, Name = kMessage, Type = String, Dynamic = False, Default = \"Message", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSeverity, Type = String, Dynamic = False, Default = \"Severity", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWhen, Type = String, Dynamic = False, Default = \"\"When\"", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWho, Type = String, Dynamic = False, Default = \"Who", Scope = Public
	#tag EndConstant


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
