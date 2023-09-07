#tag Class
Protected Class clRowParser_full
Inherits clRowParser_generic
	#tag Method, Flags = &h0
		Sub Constructor(the_delimiter as string)
		  If the_delimiter.Len <> 1 Then
		    delimiter = ","
		    
		  Else
		    delimiter = the_delimiter
		    
		  End If
		  
		  always_add_quotes = False
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function parse_line(the_line as String) As string()
		  Const kState_not_started = 0
		  Const kState_in_quoted_field = 1
		  Const kState_done_with_field = 2
		  Const kState_non_quoted_field = 3
		  Const kState_wait_field = 4
		  
		  Const kDbl_Quote = """"
		  
		  Dim ret() As String
		  
		  Dim current_state  As Integer 
		  
		  Dim current_item As String
		  Dim current_char As String
		  Dim tmp_line As String
		  Dim tmp_safety As Integer = 10000
		  
		  
		  tmp_line = the_line
		  current_state = kState_not_started
		  
		  
		  While tmp_line.Len > 0 And tmp_safety >0
		    tmp_safety = tmp_safety -1
		    current_char = Left(tmp_line,1)
		    tmp_line = tmp_line.Mid(2)
		    Dim kkk As Integer = 1
		    Select  Case current_state 
		      
		    Case kState_not_started, kState_wait_field
		      Select Case current_char
		      Case kDbl_Quote
		        current_state = kState_in_quoted_field
		        
		      Case delimiter
		        ret.Append(current_item)
		        current_item = ""
		        current_state = kState_wait_field
		        
		      Case Else
		        current_item = current_char
		        current_state = kState_non_quoted_field
		        
		      End Select
		      
		      
		    Case kState_in_quoted_field
		      If current_char = kDbl_Quote  Then
		        
		        If Left(tmp_line,1) = kDbl_Quote Then
		          current_item = current_item + kDbl_Quote
		          tmp_line = Mid(tmp_line, 2)
		          
		        Else
		          ret.Append(current_item)
		          current_item = ""
		          current_state = kState_done_with_field
		          
		        End If
		        
		      Else
		        current_item = current_item + current_char
		        
		      End If
		      
		    Case kState_done_with_field
		      If current_char = delimiter Then
		        current_state = kState_wait_field
		        
		      Else
		        // parsing error
		        
		      End If
		      
		    Case kState_non_quoted_field
		      If current_char = delimiter Then
		        ret.Append(current_item)
		        current_item = ""
		        current_state = kState_wait_field
		        
		      Else
		        current_item = current_item + current_char
		        
		      End If
		      
		      
		    Case Else
		      // error
		      
		    End Select
		    
		  Wend
		  
		  If current_state = kState_non_quoted_field Or current_state = kState_wait_field Then
		    ret.Append(current_item)
		    current_item = ""
		    
		  Else
		    
		  End If
		  
		  Return ret 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function serialize_line(the_data() as String) As string
		  Const kDbl_Quote = """"
		  
		  Dim res As String
		  
		  Dim tmp_data() As String
		  
		  tmp_data = the_data
		  
		  For i As Integer = 0 To tmp_data.Ubound
		    If tmp_data(i).InStr(kDbl_Quote) >0 Or tmp_data(i).InStr(delimiter)>0 Then
		      tmp_data(i) = tmp_data(i).ReplaceAll(kDbl_Quote, kDbl_Quote+kDbl_Quote)
		      tmp_data(i) = kDbl_Quote + tmp_data(i) + kDbl_Quote
		      
		    Elseif always_add_quotes Then
		      tmp_data(i) = kDbl_Quote + tmp_data(i) + kDbl_Quote
		      
		    End If
		    
		  Next
		  
		  res = Join(tmp_data, delimiter)
		  
		  Return res
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		always_add_quotes As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		delimiter As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="always_add_quotes"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="delimiter"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
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
