#tag Class
Protected Class clNumberDataSerie
Inherits clAbstractDataSerie
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub ActiveRangeFormatting(the_below_label as string, the_above_label as string)
		  self.formatter = new clRangeFormatting(the_below_label, the_above_label)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddElement(the_item as Variant)
		  
		  items.Append(the_item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddFormattingRange(low_bound as double, high_bound as double, label as string)
		  if self.formatter = nil then Return
		  
		  self.formatter.add_range(low_bound, high_bound, label)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function average() As double
		  var c as new clBasicMath
		  return c.average(items)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AverageNonZero() As double
		  var c as new clBasicMath
		  return c.AverageNonZero(items)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipByRange(low_value as variant, high_value as variant) As integer
		  // Calling the overridden superclass method.
		  Var returnValue as integer = Super.ClipByRange(low_value, high_value)
		  var last_index as integer = self.RowCount
		  var count_changes as integer = 0
		  
		  var low_value_dbl as double = low_value
		  var high_value_dbl as double = high_value
		  
		  for index as integer = 0 to last_index
		    var tmp as double = self.GetElement(index)
		    
		    if low_value_dbl > tmp then
		      self.SetElement(index, low_value_dbl)
		      count_changes = count_changes + 1
		      
		    elseif  tmp > high_value_dbl then
		      self.SetElement(index, high_value_dbl)
		      count_changes = count_changes + 1
		      
		    end if
		    
		  next
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClippedByRange(low_value as variant, high_value as variant) As clNumberDataSerie
		  
		  var new_col as clNumberDataSerie = self.Clone()
		  
		  new_col.rename("clip " + self.name)
		  
		  call new_col.ClipByRange(low_value, high_value)
		  
		  return new_col
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As clNumberDataSerie
		  var tmp As New clNumberDataSerie(Self.name)
		  
		  self.CloneInfo(tmp)
		  
		  For Each v As double In Self.items
		    tmp.AddElement(v)
		    
		  Next
		  
		  tmp.AddMetadata("source","clone from " + self.FullName)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CloneInfo(target as clNumberDataSerie)
		  super.CloneInfo(target)
		  
		  target.default_value = self.default_value
		  target.format_str = self.format_str
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CloneStructure() As clNumberDataSerie
		  var tmp As New clNumberDataSerie(Self.name)
		  
		  self.CloneInfo(tmp)
		  
		  tmp.AddMetadata("source","clone structure from " + self.FullName)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function count() As double
		  
		  var c as new clBasicMath
		  return c.Count(items)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountNonZero() As double
		  
		  var c as new clBasicMath
		  return c.CountNonZero(items)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DropRangeFormatting()
		  self.formatter = nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDefaultValue() As variant
		  
		  return default_value
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElement(the_element_index as integer) As variant
		  If 0 <= the_element_index And  the_element_index <= items.LastIndex then
		    Return items(the_element_index)
		    
		  Else
		    var v As double
		    Return v
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsNumber(the_element_index as integer) As double
		  return self.GetElement(the_element_index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsString(the_element_index as integer) As string
		  // Calling the overridden superclass method.
		  
		  if self.formatter = nil then return format(self.GetElement(the_element_index), format_str)
		  
		  return self.formatter.range_format(self.GetElement(the_element_index))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFilterColumnValuesInRange(minimum_value as double, maximum_value as double) As variant()
		  var return_boolean() As Variant
		  var my_item as double
		  
		  For row_index As Integer=0 To items.LastIndex
		    my_item = items(row_index)
		    return_boolean.Append((minimum_value <= my_item) and (my_item <= maximum_value))
		    
		  Next
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex() As integer
		  // Calling the overridden superclass method.
		  Var returnValue as integer = Super.LastIndex()
		  Return items.LastIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_add(right_serie as clNumberDataSerie) As clNumberDataSerie
		  var mx1 as integer = self.LastIndex
		  var mx2 as integer = right_serie.LastIndex
		  var mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  var res as new clNumberDataSerie(self.name+"+"+right_serie.name)
		  for i as integer = 0 to mx0
		    var n as double
		    
		    if i <= mx1 then
		      n = self.GetElement(i)
		    end if
		    
		    if i<= mx2 then
		      n = n + right_serie.GetElement(i)
		      
		    end if
		    
		    res.AddElement(n)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_add(right_value as double) As clNumberDataSerie
		  var res as new clNumberDataSerie(self.name+"+"+str(right_value))
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElement(i) + right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_multiply(right_serie as clNumberDataSerie) As clNumberDataSerie
		  var mx1 as integer = self.LastIndex
		  var mx2 as integer = right_serie.LastIndex
		  var mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  var res as new clNumberDataSerie(self.name+"*"+right_serie.name)
		  for i as integer = 0 to mx0
		    var n as double
		    
		    if i <= mx1 then
		      n = self.GetElement(i)
		    end if
		    
		    if i<= mx2 then
		      n = n * right_serie.GetElement(i)
		      
		    end if
		    
		    res.AddElement(n)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_multiply(right_value as double) As clNumberDataSerie
		  var res as new clNumberDataSerie(self.name+"*"+str(right_value))
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElement(i) * right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_subtract(right_serie as clNumberDataSerie) As clNumberDataSerie
		  var mx1 as integer = self.LastIndex
		  var mx2 as integer = right_serie.LastIndex
		  var mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  var res as new clNumberDataSerie(self.name+"-"+right_serie.name)
		  for i as integer = 0 to mx0
		    var n as double
		    
		    if i <= mx1 then
		      n = self.GetElement(i)
		    end if
		    
		    if i<= mx2 then
		      n = n - right_serie.GetElement(i)
		      
		    end if
		    
		    res.AddElement(n)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_subtract(right_value as double) As clNumberDataSerie
		  var res as new clNumberDataSerie(self.name+"-"+str(right_value))
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElement(i) - right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetElementss()
		  // Calling the overridden superclass method.
		  Super.ResetElements()
		  
		  self.meta_dict.AddMetadata("type","number")
		  
		  redim items(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetDefaultValue(v as variant)
		  default_value = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetElement(the_element_index as integer, the_item as Variant)
		  If 0 <= the_element_index And  the_element_index <= items.LastIndex Then
		    items(the_element_index) = the_item
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetFormat(the_format as String)
		  format_str = the_format
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLength(the_length as integer, default_value as variant)
		  
		  if items.LastIndex > the_length then
		    Raise New clDataException("Column " + self.name + " contains more elements than expected")
		  end if
		  
		  
		  While items.LastIndex < the_length-1
		    var v as double = default_value.DoubleValue
		    items.Append(v)
		    
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StandardDeviation(is_population as boolean = False) As double
		  var c as new clBasicMath
		  return c.StandardDeviation(items, is_population)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StandardDeviationNonZero(is_population as boolean = False) As double
		  var c as new clBasicMath
		  return c.StandardDeviationNonZero(items, is_population)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sum() As double
		  var c as new clBasicMath
		  return c.sum(items)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As clStringDataSerie
		  var res as new clStringDataSerie(self.name+" as string")
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElementAsString(i))
		    
		  next
		  
		  return res
		  
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
