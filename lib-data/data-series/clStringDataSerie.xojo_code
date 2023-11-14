#tag Class
Protected Class clStringDataSerie
Inherits clAbstractDataSerie
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit)) or  (TargetAndroid and (Target64Bit))
	#tag Method, Flags = &h0
		Sub append_element(the_item as Variant)
		  
		  items.Append(the_item.StringValue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone() As clStringDataSerie
		  Dim tmp As New clStringDataSerie(Self.name)
		  
		  self.clone_info(tmp)
		  
		  For Each v As string In Self.items
		    tmp.append_element(v)
		    
		  Next
		  
		  tmp.add_meta_data("source","clone from " + self.full_name)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub clone_info(target as clStringDataSerie)
		  super.clone_info(target)
		  
		  target.default_value = self.default_value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone_structure() As clStringDataSerie
		  // Calling the overridden superclass method.
		  Var returnValue as clAbstractDataSerie = Super.clone_structure()
		  Dim tmp As New clStringDataSerie(Self.name)
		  
		  self.clone_info(tmp)
		  
		  tmp.add_meta_data("source","clone structure from " + self.full_name)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_value_in_list(list_of_values() as string) As variant()
		  Dim return_boolean() As Variant
		  dim my_item as string
		  
		  For row_index As Integer=0 To items.Ubound
		    my_item = items(row_index)
		    return_boolean.Append(list_of_values.IndexOf(my_item)>=0)
		    
		  Next
		  
		  Return return_boolean
		  
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
		    Dim v As integer
		    Return v
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element_as_string(the_element_index as integer) As string
		  return self.get_element(the_element_index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Left(count as integer) As clStringDataSerie
		  dim res as new clStringDataSerie(me.name+ " left " + str(count))
		  
		  for i as integer = 0 to me.upper_bound
		    res.append_element(me.get_element_as_string(i).left(count))
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lowercase() As clStringDataSerie
		  dim res as new clStringDataSerie(me.name+ " lower")
		  
		  for i as integer = 0 to me.upper_bound
		    res.append_element(me.get_element_as_string(i).Lowercase())
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Middle(from_char as integer, length as integer) As clStringDataSerie
		  dim res as new clStringDataSerie(me.name+ " Middle " + str(length) + " char. from "  + str(from_char) )
		  
		  for i as integer = 0 to me.upper_bound
		    res.append_element(me.get_element_as_string(i).Middle(from_char, length))
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_add(right_serie as clStringDataSerie) As clStringDataSerie
		  dim mx1 as integer = self.upper_bound
		  dim mx2 as integer = right_serie.upper_bound
		  dim mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  dim res as new clStringDataSerie(self.name+"+"+right_serie.name)
		  for i as integer = 0 to mx0
		    dim n as integer
		    
		    if i <= mx1 then
		      n = self.get_element(i)
		    end if
		    
		    if i<= mx2 then
		      n = n + right_serie.get_element(i)
		      
		    end if
		    
		    res.append_element(n)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_add(right_value as String) As clStringDataSerie
		  dim res as new clStringDataSerie(self.name+"+"+str(right_value))
		  
		  for i as integer = 0 to self.upper_bound
		    res.append_element(self.get_element_as_string(i) + right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub reset_elements()
		  
		  self.meta_dict.add_meta_data("type","string")
		  
		  redim items(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Right(count as integer) As clStringDataSerie
		  dim res as new clStringDataSerie(me.name+ " right " + str(count))
		  
		  for i as integer = 0 to me.upper_bound
		    res.append_element(me.get_element_as_string(i).right(count))
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_default_value(v as variant)
		  default_value = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_element(the_element_index as integer, the_item as Variant)
		  If 0 <= the_element_index And  the_element_index <= items.Ubound Then
		    items(the_element_index) = the_item.StringValue
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_length(the_length as integer, default_value as variant)
		  
		  if items.Ubound > the_length then
		    Raise New clDataException("Column " + self.name + " contains more elements than expected")
		  end if
		  
		  
		  While items.Ubound < the_length-1
		    dim v as string = default_value.StringValue
		    items.Append(v)
		    
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function text_after(search_str as string) As clStringDataSerie
		  dim res as clStringDataSerie
		  
		  res = new clStringDataSerie(me.name+ " text after  " + search_str)
		  
		  
		  for i as integer = 0 to me.upper_bound
		    dim tmp as string = me.get_element_as_string(i)
		    dim idx as integer = tmp.IndexOf(search_str)
		    
		    if idx <0 then 
		      res.append_element("")
		      
		    else
		      res.append_element(tmp.mid( idx + 1 +  len(search_str), len(tmp)))
		      
		    end if
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function text_before(search_str as string) As clStringDataSerie
		  dim res as new clStringDataSerie(me.name+ " text before  " + search_str)
		  
		  for i as integer = 0 to me.upper_bound
		    dim tmp as string = me.get_element_as_string(i)
		    dim idx as integer = tmp.IndexOf(search_str)
		    
		    if idx <0 then 
		      res.append_element("")
		      
		    else
		      res.append_element(tmp.left(idx))
		      
		    end if
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Titlecase() As clStringDataSerie
		  dim res as new clStringDataSerie(me.name+ " upper" )
		  
		  for i as integer = 0 to me.upper_bound
		    res.append_element(me.get_element_as_string(i).Titlecase)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToInteger() As clIntegerDataSerie
		  dim res as new clIntegerDataSerie(self.name+" as integer")
		  
		  for i as integer = 0 to self.upper_bound
		    res.append_element(self.get_element_as_integer(i))
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToNumber() As clNumberDataSerie
		  dim res as new clNumberDataSerie(self.name+" as double")
		  
		  for i as integer = 0 to self.upper_bound
		    res.append_element(self.get_element_as_integer(i))
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Trim() As clStringDataSerie
		  dim res as new clStringDataSerie(me.name+ " trim" )
		  
		  for i as integer = 0 to me.upper_bound
		    res.append_element(me.get_element_as_string(i).Trim)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Uppercase() As clStringDataSerie
		  dim res as new clStringDataSerie(me.name+ " upper" )
		  
		  for i as integer = 0 to me.upper_bound
		    res.append_element(me.get_element_as_string(i).Uppercase)
		    
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
		Protected items() As string
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
