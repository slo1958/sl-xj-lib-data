#tag Class
Protected Class clBooleanDataSerie
Inherits clAbstractDataSerie
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub append_element(the_item as Variant)
		  
		  items.Append(the_item.BooleanValue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone() As clBooleanDataSerie
		  var tmp As New clBooleanDataSerie(Self.name)
		  
		  self.clone_info(tmp)
		  
		  For Each v As boolean In Self.items
		    tmp.append_element(v)
		    
		  Next
		  
		  tmp.AddMetaData("source","clone from " + self.full_name)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub clone_info(target as clBooleanDataSerie)
		  super.clone_info(target)
		  
		  target.default_value = self.default_value
		  target.str_for_false = self.str_for_false
		  target.str_for_true = self.str_for_true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone_structure() As clBooleanDataSerie
		  var tmp As New clBooleanDataSerie(Self.name)
		  
		  self.clone_info(tmp)
		  
		  tmp.AddMetaData("source","clone structure from " + self.full_name)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_default_value() As variant
		  return default_value
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element(the_element_index as integer) As variant
		  If 0 <= the_element_index And  the_element_index <= items.Ubound then
		    Return items(the_element_index)
		    
		  Else
		    var v As integer
		    Return v
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element_as_boolean(the_element_index as integer) As boolean
		  return self.get_element(the_element_index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element_as_integer(the_element_index as integer) As integer
		  return if(self.get_element(the_element_index),1,0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element_as_string(the_element_index as integer) As string
		  // Calling the overridden superclass method.
		  Var returnValue as string = Super.get_element_as_string(the_element_index)
		  return if(self.get_element(the_element_index),self.str_for_true,self.str_for_false)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_and(right_serie as clBooleanDataSerie) As clBooleanDataSerie
		  var mx1 as integer = self.upper_bound
		  var mx2 as integer = right_serie.upper_bound
		  var mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  var res as new clBooleanDataSerie(self.name+" and "+right_serie.name)
		  for i as integer = 0 to mx0
		    var n as Boolean = true
		    
		    if i <= mx1 then
		      n = self.get_element_as_boolean(i)
		    end if
		    
		    if i<= mx2 then
		      n = n and right_serie.get_element_as_boolean(i)
		      
		    end if
		    
		    res.append_element(n)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_not() As clBooleanDataSerie
		  var mx0 as integer = self.upper_bound
		  
		  var res as new clBooleanDataSerie("not " + self.name)
		  
		  for i as integer = 0 to mx0
		    res.append_element(not self.get_element_as_boolean(i))
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_or(right_serie as clBooleanDataSerie) As clBooleanDataSerie
		  var mx1 as integer = self.upper_bound
		  var mx2 as integer = right_serie.upper_bound
		  var mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  var res as new clBooleanDataSerie(self.name+" or "+right_serie.name)
		  for i as integer = 0 to mx0
		    var n as Boolean = False
		    
		    if i <= mx1 then
		      n = self.get_element_as_boolean(i)
		    end if
		    
		    if i<= mx2 then
		      n = n or right_serie.get_element_as_boolean(i)
		      
		    end if
		    
		    res.append_element(n)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub reset_elements()
		  
		  self.meta_dict.AddMetaData("type","boolean")
		  
		  redim items(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_default_value(v as variant)
		  default_value = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_element(the_element_index as integer, the_item as String)
		  If 0 <= the_element_index And  the_element_index <= items.Ubound Then
		    items(the_element_index) = (the_item.Trim.Uppercase = "TRUE")
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_element(the_element_index as integer, the_item as Variant)
		  If 0 <= the_element_index And  the_element_index <= items.Ubound Then
		    items(the_element_index) = the_item.BooleanValue
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_format(False_label as string, True_Label as string)
		  
		  self.str_for_false = False_label
		  self.str_for_true = True_Label
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_length(the_length as integer, default_value as variant)
		  
		  if items.Ubound > the_length then
		    Raise New clDataException("Column " + self.name + " contains more elements than expected")
		  end if
		  
		  
		  While items.Ubound < the_length-1
		    var v as boolean = default_value.BooleanValue
		    items.Append(v)
		    
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As clStringDataSerie
		  var res as new clStringDataSerie(self.name+" as string")
		  
		  for i as integer = 0 to self.upper_bound
		    res.append_element(self.get_element_as_string(i))
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function upper_bound() As integer
		  Return items.Ubound
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected default_value As Variant
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected items() As boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected str_for_false As String = "False"
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected str_for_true As String = "True"
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="display_title"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
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
