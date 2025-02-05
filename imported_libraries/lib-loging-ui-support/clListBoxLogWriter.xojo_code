#tag Class
Protected Class clListBoxLogWriter
Inherits clGenericLogWriter
Implements itfLogingWriter
	#tag Method, Flags = &h0
		Sub AddLogEntry(MessageSeverity as string, MessageTime as string, MessageSource as string, MessageText as string)
		  // Part of the itfLogingWriter interface.
		  
		  if not self.AcceptSeverity(MessageSeverity) then return
		  
		  If mlb = Nil Then Return
		  
		  mlb.AddRow ""
		  var row_num As Integer = mlb.LastIndex
		  
		  
		  If mlb.ColumnCount >2 Then
		    mlb.cell(row_num, 0 )  = MessageTime
		    mlb.cell(row_num, 1 )  = MessageSeverity
		    mlb.cell(row_num, 2 )  = MessageText
		    if mlb.ColumnCount > 3 then mlb.cell(row_num, 3 )  = MessageSource
		    
		  Elseif mlb.ColumnCount > 1 Then
		    mlb.cell(row_num, 0 )  = MessageTime
		    mlb.cell(row_num, 1 )  = MessageSeverity+" "+ MessageText
		    
		  Else
		    mlb.cell(row_num, 0 )  = MessageTime + ". " + MessageSeverity+" "+ MessageText
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_listbox as Listbox)
		  
		  Super.Constructor
		  
		  mlb = the_listbox
		  
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mlb As Listbox
	#tag EndProperty


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
