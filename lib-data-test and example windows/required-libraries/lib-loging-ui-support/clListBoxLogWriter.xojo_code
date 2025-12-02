#tag Class
Protected Class clListBoxLogWriter
Inherits clGenericLogWriter
Implements itfLogWriter
	#tag Method, Flags = &h0
		Sub AddLogEntry(MessageSeverity as string, MessageTime as string, MessageSource as string, MessageText as string)
		  
		  // Part of the itfLogWriter interface.
		  
		  if not self.AcceptSeverity(MessageSeverity) then return
		  
		  If mlb = Nil Then Return
		  
		  mlb.AddRow ""
		  
		  var row_num As Integer = mlb.LastRowIndex
		  
		  If mlb.ColumnCount >2 Then
		    mlb.CellTextAt(row_num, 0 )  = MessageTime
		    mlb.CellTextAt(row_num, 1 )  = MessageSeverity
		    mlb.CellTextAt(row_num, 2 )  = MessageText
		    if mlb.ColumnCount > 3 then mlb.CellTextAt(row_num, 3 )  = MessageSource
		    
		  Elseif mlb.ColumnCount > 1 Then
		    mlb.CellTextAt(row_num, 0 )  = MessageTime
		    mlb.CellTextAt(row_num, 1 )  = MessageSeverity+" "+ MessageText
		    
		  Else
		    mlb.CellTextAt(row_num, 0 )  = MessageTime + ". " + MessageSeverity+" "+ MessageText
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_listbox as DesktopListBox)
		  
		  Super.Constructor
		  
		  mlb = the_listbox
		  
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		MIT License
		
		sl-xj-lib-loger Library
		Copyright (c) 2021-2025 Serge Louvet
		
		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.
		
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private mlb As DesktopListBox
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
