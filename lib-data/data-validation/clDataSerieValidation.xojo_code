#tag Class
Protected Class clDataSerieValidation
	#tag Method, Flags = &h0
		Sub AddError(the_row as integer, message as String)
		  report_row_number.append_element(the_row)
		  report_error_info.append_element(message)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(column_name as string, allow_null_value as boolean = True, mandatory as boolean= false)
		  mname = column_name
		  allow_null = allow_null_value
		  mandatory_column = mandatory
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function is_nullable() As Boolean
		  return allow_null
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function is_required() As Boolean
		  return mandatory_column
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function name() As string
		  Return mname
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function validate(the_serie as clAbstractDataSerie) As clAbstractDataSerie()
		  report_row_number = new clDataSerie("row_number")
		  report_error_info = new clDataSerie("error_message")
		  
		  if the_serie = nil then
		    AddError(-1,"Missing column")
		    
		    return array(report_row_number, report_error_info)
		    
		  end if
		  
		  if the_serie.name <> mname then
		    AddError(-1,"Invalid name, expecting " + mname + ", found " + the_serie.name+".")
		    
		    return array(report_row_number, report_error_info)
		    
		  end if
		  
		  //  
		  //  no more tests
		  //  
		  if not allow_null then
		    var row_index as integer = 0
		    
		    for each element as variant in the_serie
		      row_index = row_index + 1
		      validate_element(row_index, element)
		      
		    next 
		    
		    return array(report_row_number, report_error_info)
		  end if
		  
		  return array(report_row_number, report_error_info)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub validate_element(row_index as integer, element as Variant)
		  
		  if element.IsNull then
		    AddError(row_index, "Null value")
		    
		  elseif element.StringValue = "" then
		    AddError(row_index, "Null value")
		    
		  else
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected allow_null As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mandatory_column As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mname As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected report_error_info As clDataSerie
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected report_row_number As clDataSerie
	#tag EndProperty


	#tag Constant, Name = message_column, Type = String, Dynamic = False, Default = \"error_message", Scope = Public
	#tag EndConstant

	#tag Constant, Name = row_index_column, Type = String, Dynamic = False, Default = \"row_num", Scope = Public
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
			Name="name"
			Visible=false
			Group="Behavior"
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
