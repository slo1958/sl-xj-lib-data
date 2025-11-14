#tag Class
Protected Class clIntegerDataSerie
Inherits clAbstractDataSerie
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub AddElement(the_item as Variant)
		  
		  //items.Add(the_item.IntegerValue)
		  
		  items.Add(Internal_ConversionToInteger(the_item))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipByRange(low_value as variant, high_value as variant) As integer
		  
		  var last_index as integer = self.RowCount
		  var count_changes as integer = 0
		  
		  var low_value_int as integer = low_value
		  var high_value_int as integer = high_value
		  
		  for index as integer = 0 to last_index
		    var tmp as integer = self.GetElement(index)
		    
		    if low_value_int > tmp then
		      self.SetElement(index, low_value_int)
		      count_changes = count_changes + 1
		      
		    elseif  tmp > high_value_int then
		      self.SetElement(index, high_value_int)
		      count_changes = count_changes + 1
		      
		    end if
		    
		  next
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClippedByRange(low_value as variant, high_value as variant) As clIntegerDataSerie
		  
		  var new_col as clIntegerDataSerie = self.Clone()
		  
		  new_col.rename("clip " + self.name)
		  
		  call new_col.ClipByRange(low_value, high_value)
		  
		  return new_col
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(NewName as string = "") As clIntegerDataSerie
		  
		  var tmp As New clIntegerDataSerie(StringWithDefault(NewName, self.name))
		  
		  self.CloneInfo(tmp)
		  
		  For Each v As integer In Self.items
		    tmp.AddElement(v)
		    
		  Next
		  
		  tmp. AddSourceToMetadata("clone from " + self.FullName)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CloneInfo(target as clIntegerDataSerie)
		  super.CloneInfo(target)
		  
		  target.DefaultValue = self.DefaultValue
		  target.Formatter = self.Formatter
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CloneStructure() As clIntegerDataSerie
		  var tmp As New clIntegerDataSerie(Self.name)
		  
		  self.CloneInfo(tmp)
		  
		  tmp. AddSourceToMetadata("clone structure from " + self.FullName)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilterValueInList(list_of_values() as integer) As variant()
		  var return_boolean() As Variant
		  var my_item as integer
		  
		  For row_index As Integer=0 To items.LastIndex
		    my_item = items(row_index)
		    return_boolean.Add(list_of_values.IndexOf(my_item)>=0)
		    
		  Next
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDefaultValue() As variant
		  return DefaultValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElement(ElementIndex as integer) As variant
		  
		  return self.GetElementAsInteger(ElementIndex)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsInteger(ElementIndex as integer) As integer
		  
		  If 0 <= ElementIndex And  ElementIndex <= items.LastIndex then
		    Return items(ElementIndex)
		    
		  Else
		    var v As integer
		    Return v
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsString(ElementIndex as integer) As string
		  
		  if self.Formatter = nil then 
		    return self.GetElementAsInteger(ElementIndex).ToString
		    
		  else
		    return self.Formatter.FormatInteger(self.GetElementAsInteger(ElementIndex))
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFilterColumnValuesInRange(minimum_value as integer, maximum_value as integer) As variant()
		  var return_boolean() As Variant
		  var my_item as integer
		  
		  For row_index As Integer=0 To items.LastIndex
		    my_item = items(row_index)
		    return_boolean.Add((minimum_value <= my_item) and (my_item <= maximum_value))
		    
		  Next
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetProperties() As clDataSerieProperties
		  // Calling the overridden superclass method.
		  Var p as clDataSerieProperties = Super.GetProperties()
		  
		  p.DefaultValue = self.DefaultValue
		  
		  if self.Formatter <> nil then
		    p.FormatStr = self.Formatter.GetInfo
		    
		  end if
		  
		  return p
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Internal_ConversionToInteger(v as Variant) As integer
		  
		  if v.Type  = variant.TypeInt32 or v.Type = Variant.TypeInt64 then
		    return v.IntegerValue
		    
		  elseif v.type <> variant.TypeString then
		    return v.IntegerValue
		    
		  elseif self.IntegerParser = nil Then
		    return v.DoubleValue
		    
		  else
		    return self.IntegerParser.ParseToInteger(v.StringValue)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex() As integer
		  
		  Return items.LastIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Maximum() As integer
		  
		  return clBasicMath.Maximum(items)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Minimum() As double
		  
		  
		  return clBasicMath.Minimum(items)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_add(right_serie as clIntegerDataSerie) As clIntegerDataSerie
		  var mx1 as integer = self.LastIndex
		  var mx2 as integer = right_serie.LastIndex
		  var mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  var res as new clIntegerDataSerie(self.name+"+"+right_serie.name)
		  
		  
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "add values from  " + right_serie.name)
		  
		  for i as integer = 0 to mx0
		    var n as integer
		    
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
		Function operator_add(right_value as integer) As clIntegerDataSerie
		  var res as new clIntegerDataSerie(self.name+"+"+str(right_value))
		  
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "add constant " + str(right_value))
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElement(i) + right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_multiply(right_serie as clIntegerDataSerie) As clIntegerDataSerie
		  var mx1 as integer = self.LastIndex
		  var mx2 as integer = right_serie.LastIndex
		  var mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  var res as new clIntegerDataSerie(self.name+"*"+right_serie.name)
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "Multiply by values from  " + right_serie.name)
		  
		  
		  for i as integer = 0 to mx0
		    var n as integer
		    
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
		Function operator_multiply(right_value as integer) As clIntegerDataSerie
		  var res as new clIntegerDataSerie(self.name+"*"+str(right_value))
		  
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "Multiply by   " + str(right_value))
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElement(i) * right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_subtract(right_serie as clIntegerDataSerie) As clIntegerDataSerie
		  var mx1 as integer = self.LastIndex
		  var mx2 as integer = right_serie.LastIndex
		  var mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  var res as new clIntegerDataSerie(self.name+"-"+right_serie.name)
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "Subtract values from  " + right_serie.name)
		  
		  for i as integer = 0 to mx0
		    var n as integer
		    
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
		Function operator_subtract(right_value as integer) As clIntegerDataSerie
		  var res as new clIntegerDataSerie(self.name+"-"+str(right_value))
		  
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "Subtract " + str(right_value))
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElement(i) - right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetElements()
		  
		  self.Metadata.Add("type","integer")
		  
		  items.RemoveAll
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RowCount() As integer
		  
		  return items.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetDefaultValue(v as variant)
		  DefaultValue = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetElement(ElementIndex as integer, the_item as Variant)
		  If 0 <= ElementIndex And  ElementIndex <= items.LastIndex Then
		    //items(ElementIndex) = the_item.IntegerValue
		    items(ElementIndex) = Internal_ConversionToInteger(the_item)
		    
		  else
		    self.AddErrorMessage(CurrentMethodName,ErrMsgIndexOutOfbounds, str(ElementIndex), self.name)
		    
		  end if
		  
		  return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetIntegerParser(parser as IntegerParserInterface)
		  self.IntegerParser = parser
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLength(the_length as integer, DefaultValue as variant)
		  
		  if items.LastIndex > the_length then
		    Raise New clDataException("Column " + self.name + " contains more elements than expected")
		  end if
		  
		  
		  While items.LastIndex < the_length-1
		    var v as integer = DefaultValue.IntegerValue
		    items.Add(v)
		    
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetProperties(properties as clDataSerieProperties)
		  // Calling the overridden superclass method.
		  Super.SetProperties(properties)
		  
		  self.DefaultValue = properties.DefaultValue
		  
		  if properties.FormatStr.Length = 0 then
		    
		  elseif properties.FormatStr ="Range formatting" then
		    
		  else
		    self.Formatter = new clIntegerFormatting(properties.FormatStr)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetStringFormat(the_format as String, UseLocal as Boolean = False)
		  if UseLocal then
		    self.Formatter = new clIntegerLocalFormatting(the_format)
		    
		  else
		    self.Formatter = new clIntegerFormatting(the_format)
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToNumber(NewName as string = "") As clNumberDataSerie
		  
		  var res as new clNumberDataSerie(if(NewName = "", "Convert " + self.name + " to number", NewName))
		  
		  for i as integer =0 to self.LastIndex
		    res.AddElement(self.GetElementAsNumber(i))
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString(NewName as string = "") As clStringDataSerie
		  
		  var res as new clStringDataSerie(if(NewName = "", "Convert " + self.name + " to string", NewName))
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElementAsString(i))
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected DefaultValue As integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Formatter As IntegerFormatInteraface
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected IntegerParser As IntegerParserInterface
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected items() As integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="DisplayTitle"
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
