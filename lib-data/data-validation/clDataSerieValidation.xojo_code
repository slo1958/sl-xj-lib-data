#tag Class
Protected Class clDataSerieValidation
	#tag Method, Flags = &h0
		Sub AddError(the_row as integer, message as String)
		  report_row_number.AddElement(the_row)
		  report_error_info.AddElement(message)
		  
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


	#tag Note, Name = License
		MIT License
		
		sl-xj-lib-data Data Handling Library
		Copyright (c) 2021-2025 slo1958
		
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
