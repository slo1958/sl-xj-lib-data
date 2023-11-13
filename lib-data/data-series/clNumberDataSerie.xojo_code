#tag Class
Protected Class clNumberDataSerie
Inherits clAbstractDataSerie
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub active_range_formatting(the_below_label as string, the_above_label as string)
		  self.formatter = new clRangeFormatting(the_below_label, the_above_label)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub add_formatting_range(low_bound as double, high_bound as double, label as string)
		  if self.formatter = nil then Return
		  
		  self.formatter.add_range(low_bound, high_bound, label)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub append_element(the_item as Variant)
		  
		  items.Append(the_item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function average() As double
		  dim c as new clBasicMath
		  return c.average(items)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function average_non_zero() As double
		  dim c as new clBasicMath
		  return c.average_non_zero(items)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clipped_by_range(low_value as variant, high_value as variant) As clNumberDataSerie
		  
		  dim new_col as clNumberDataSerie = self.clone()
		  
		  new_col.rename("clip " + self.name)
		  
		  call new_col.clip_range(low_value, high_value)
		  
		  return new_col
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clip_range(low_value as variant, high_value as variant) As integer
		  dim last_index as integer = self.row_count
		  dim count_changes as integer = 0
		  
		  dim low_value_dbl as double = low_value
		  dim high_value_dbl as double = high_value
		  
		  for index as integer = 0 to last_index
		    dim tmp as double = self.get_element(index)
		    
		    if low_value_dbl > tmp then
		      self.set_element(index, low_value_dbl)
		      count_changes = count_changes + 1
		      
		    elseif  tmp > high_value_dbl then
		      self.set_element(index, high_value_dbl)
		      count_changes = count_changes + 1
		      
		    end if
		    
		  next
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone() As clNumberDataSerie
		  Dim tmp As New clNumberDataSerie(Self.name)
		  
		  self.clone_info(tmp)
		  
		  For Each v As double In Self.items
		    tmp.append_element(v)
		    
		  Next
		  
		  tmp.add_meta_data("source","clone from " + self.full_name)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub clone_info(target as clNumberDataSerie)
		  super.clone_info(target)
		  
		  target.default_value = self.default_value
		  target.format_str = self.format_str
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone_structure() As clNumberDataSerie
		  Dim tmp As New clNumberDataSerie(Self.name)
		  
		  self.clone_info(tmp)
		  
		  tmp.add_meta_data("source","clone structure from " + self.full_name)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function count() As double
		  
		  dim c as new clBasicMath
		  return c.count(items)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function count_non_zero() As double
		  
		  dim c as new clBasicMath
		  return c.count_non_zero(items)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub drop_range_formatting()
		  self.formatter = nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function filter_value_in_range(minimum_value as double, maximum_value as double) As variant()
		  Dim return_boolean() As Variant
		  dim my_item as double
		  
		  For row_index As Integer=0 To items.Ubound
		    my_item = items(row_index)
		    return_boolean.Append((minimum_value <= my_item) and (my_item <= maximum_value))
		    
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
		    Dim v As double
		    Return v
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element_as_number(the_element_index as integer) As double
		  return self.get_element(the_element_index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element_as_string(the_element_index as integer) As string
		  // Calling the overridden superclass method.
		  
		  if self.formatter = nil then return format(self.get_element(the_element_index), format_str)
		  
		  return self.formatter.range_format(self.get_element(the_element_index))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_add(right_serie as clNumberDataSerie) As clNumberDataSerie
		  dim mx1 as integer = self.upper_bound
		  dim mx2 as integer = right_serie.upper_bound
		  dim mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  dim res as new clNumberDataSerie(self.name+"+"+right_serie.name)
		  for i as integer = 0 to mx0
		    dim n as double
		    
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
		Function operator_add(right_value as double) As clNumberDataSerie
		  dim res as new clNumberDataSerie(self.name+"+"+str(right_value))
		  
		  for i as integer = 0 to self.upper_bound
		    res.append_element(self.get_element(i) + right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_multiply(right_serie as clNumberDataSerie) As clNumberDataSerie
		  dim mx1 as integer = self.upper_bound
		  dim mx2 as integer = right_serie.upper_bound
		  dim mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  dim res as new clNumberDataSerie(self.name+"*"+right_serie.name)
		  for i as integer = 0 to mx0
		    dim n as double
		    
		    if i <= mx1 then
		      n = self.get_element(i)
		    end if
		    
		    if i<= mx2 then
		      n = n * right_serie.get_element(i)
		      
		    end if
		    
		    res.append_element(n)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_multiply(right_value as double) As clNumberDataSerie
		  dim res as new clNumberDataSerie(self.name+"*"+str(right_value))
		  
		  for i as integer = 0 to self.upper_bound
		    res.append_element(self.get_element(i) * right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_subtract(right_serie as clNumberDataSerie) As clNumberDataSerie
		  dim mx1 as integer = self.upper_bound
		  dim mx2 as integer = right_serie.upper_bound
		  dim mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  dim res as new clNumberDataSerie(self.name+"-"+right_serie.name)
		  for i as integer = 0 to mx0
		    dim n as double
		    
		    if i <= mx1 then
		      n = self.get_element(i)
		    end if
		    
		    if i<= mx2 then
		      n = n - right_serie.get_element(i)
		      
		    end if
		    
		    res.append_element(n)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_subtract(right_value as double) As clNumberDataSerie
		  dim res as new clNumberDataSerie(self.name+"-"+str(right_value))
		  
		  for i as integer = 0 to self.upper_bound
		    res.append_element(self.get_element(i) - right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub reset_elements()
		  
		  self.meta_dict.add_meta_data("type","number")
		  
		  redim items(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_default_value(v as variant)
		  default_value = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_element(the_element_index as integer, the_item as Variant)
		  If 0 <= the_element_index And  the_element_index <= items.Ubound Then
		    items(the_element_index) = the_item
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_format(the_format as String)
		  format_str = the_format
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_length(the_length as integer, default_value as variant)
		  
		  if items.Ubound > the_length then
		    Raise New clDataException("Column " + self.name + " contains more elements than expected")
		  end if
		  
		  
		  While items.Ubound < the_length-1
		    dim v as double = default_value.DoubleValue
		    items.Append(v)
		    
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function standard_deviation(is_population as boolean = False) As double
		  dim c as new clBasicMath
		  return c.standard_deviation(items, is_population)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function standard_deviation_non_zero(is_population as boolean = False) As double
		  dim c as new clBasicMath
		  return c.standard_deviation_non_zero(items, is_population)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function sum() As double
		  dim c as new clBasicMath
		  return c.sum(items)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As clStringDataSerie
		  dim res as new clStringDataSerie(self.name+" as string")
		  
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
		Protected default_value As double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected formatter As clRangeFormatting
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected format_str As string = "###,##0.00"
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected items() As double
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
