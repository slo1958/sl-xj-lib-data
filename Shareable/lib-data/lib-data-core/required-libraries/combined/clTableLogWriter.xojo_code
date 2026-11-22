#tag Class
Protected Class clTableLogWriter
Inherits clGenericLogWriter
Implements itfLogWriter
	#tag Method, Flags = &h0
		Sub AddLogEntry(MessageSeverity as string, MessageTime as string, MessageSource as string, MessageText as string)
		  // Part of the itfLogingWriter interface.
		  
		  var r as new clDataRow
		  r.SetCell(kWhen, MessageTime)
		  r.SetCell(kWho, MessageSource)
		  r.SetCell(kSeverity, MessageSeverity)
		  r.SetCell(kMessage, MessageText)
		  
		  if table <> nil then table.AddRow(r)
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(tableName as string)
		  
		  super.Constructor
		  
		  self.table = new clDataTable(tableName, array( _ 
		  new clDataSerie(kWhen) _
		  , new clDataSerie(kSeverity) _
		  , new clDataSerie(kWho) _
		  , new clDataSerie(kMessage) _
		  ))
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTable() As clDataTable
		  return table
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		table As clDataTable
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
