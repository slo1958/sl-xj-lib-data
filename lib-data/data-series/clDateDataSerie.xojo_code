#tag Class
Protected Class clDateDataSerie
Inherits clAbstractDataSerie
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub AddElement(the_item as Variant)
		  
		  items.Add(prep_date(the_item))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(NewName as string = "") As clDateDataSerie
		  
		  var tmp As New clDateDataSerie(StringWithDefault(NewName, self.name))
		  
		  self.CloneInfo(tmp)
		  
		  For Each v As DateTime In Self.items
		    tmp.AddElement(v)
		    
		  Next
		  
		  tmp. AddSourceToMetadata("clone from " + self.FullName)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CloneInfo(target as clDateDataSerie)
		  super.CloneInfo(target)
		  
		  target.DefaultValue = self.DefaultValue
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function diff_to_integer(d1 as DateTime, d2 as DateTime) As integer
		  //
		  // Returns the difference in number of days
		  //
		  if d1 = nil or d2 = nil then return 0
		  
		  return round((d1.SecondsFrom1970 - d2.SecondsFrom1970) / (24 * 60 * 60))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilterValueInList(list_of_values() as DateTime) As variant()
		  var return_boolean() As Variant
		  var my_item as DateTime
		  
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
		  If 0 <= ElementIndex And  ElementIndex <= items.LastIndex then
		    Return items(ElementIndex)
		    
		  Else
		    var v As integer
		    Return v
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsDate(ElementIndex as integer) As DateTime
		  If 0 <= ElementIndex And  ElementIndex <= items.LastIndex then
		    return self.GetElement(ElementIndex)
		    
		  else
		    return nil
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsString(ElementIndex as integer) As string
		  If 0 <= ElementIndex And  ElementIndex <= items.LastIndex then
		    var tmp as DateTime = items(ElementIndex)
		    if tmp = nil then return ""
		    
		    Return tmp.SQLDate
		    
		  Else
		    Return ""
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsString(ElementIndex As integer, dateStyle As DateTime.FormatStyles) As String
		  If 0 <= ElementIndex And  ElementIndex <= items.LastIndex then
		    var tmp as DateTime = items(ElementIndex)
		    if tmp = nil then return ""
		    
		    Return tmp.ToString(datestyle, DateTime.FormatStyles.None)
		    
		  Else
		    Return ""
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsString(ElementIndex as integer, format as string) As string
		  If 0 <= ElementIndex And  ElementIndex <= items.LastIndex then
		    var tmp as DateTime = items(ElementIndex)
		    if tmp = nil then return ""
		    
		    Return tmp.ToString(format)
		    
		  Else
		    Return ""
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFilterColumnValuesInRange(minimum_value as datetime, maximum_value as DateTime) As variant()
		  var return_boolean() As Variant
		  var my_item as DateTime
		  
		  For row_index As Integer=0 To items.LastIndex
		    my_item = items(row_index)
		    return_boolean.Add((minimum_value <= my_item) and (my_item <= maximum_value))
		    
		  Next
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFilterColumnValuesInRange(minimum_value_str as string, maximum_value_str as string) As variant()
		  var return_boolean() As Variant
		  var my_item as DateTime
		  
		  var minimum_value as DateTime = DateTime.FromString(minimum_value_str)
		  var maximum_value as DateTime = DateTime.FromString(maximum_value_str)
		  
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
		  
		  return p
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex() As integer
		  Return items.LastIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Maximum() As DateTime
		  
		  
		  return clBasicMath.Maximum(items)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Minimum() As DateTime
		  
		  
		  return clBasicMath.Minimum(items)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_add(right_interval as DateInterval) As clDateDataSerie
		  var res as new clDateDataSerie(self.name+" + interval ")
		  
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "add interval")
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElementAsDate(i).AddInterval(right_interval.Years, right_interval.Months, right_interval.Days))
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_subtract(right_serie as clDateDataSerie) As clIntegerDataSerie
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
		  res.AddMetadata("transformation", "Subtract date from " + right_serie.name)
		  
		  for i as integer = 0 to mx0
		    
		    if i <= mx1 and i <= mx2 then
		      res.AddElement(diff_to_integer(self.GetElementAsDate(i), right_serie.GetElementAsDate(i) ) )
		      
		    else
		      res.AddElement(0)
		      
		    end if
		    
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_subtract(right_interval as DateInterval) As clDateDataSerie
		  var res as new clDateDataSerie(self.name+" - interval ")
		  
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "Subtract interval")
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElementAsDate(i).SubtractInterval(right_interval.Years, right_interval.Months, right_interval.Days))
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_subtract(right_value as DateTime) As clIntegerDataSerie
		  var res as new clIntegerDataSerie(self.name+" - "+ right_value.SQLDate)
		  
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "Subtract date from " + right_value.SQLDate)
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(diff_to_integer(self.GetElementAsDate(i) , right_value))
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function prep_date(d as variant) As DateTime
		  var tmp as DateTime = d.DateTimeValue
		  
		  return new DateTime(tmp.year, tmp.Month, tmp.Day)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetElements()
		  
		  self.Metadata.Add("type","date")
		  
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
		    items(ElementIndex) = prep_date(the_item)
		    
		  else
		    self.AddErrorMessage(CurrentMethodName,ErrMsgIndexOutOfbounds, str(ElementIndex), self.name)
		    
		  end if
		  
		  return
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLength(the_length as integer, DefaultValue as variant)
		  
		  if items.LastIndex > the_length then
		    Raise New clDataException("Column " + self.name + " contains more elements than expected")
		  end if
		  
		  
		  While items.LastIndex < the_length-1
		    var v as DateTime = DefaultValue.DateTimeValue
		    
		    items.Add(v)
		    
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetProperties(properties as clDataSerieProperties)
		  // Calling the overridden superclass method.
		  Super.SetProperties(properties)
		  
		  self.DefaultValue = properties.DefaultValue
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDayInteger() As clIntegerDataSerie
		  var res as new clIntegerDataSerie("Day of " + self.name)
		  
		  for i as integer = 0 to self.LastIndex
		    var d as datetime = self.GetElementAsDate(i)
		    
		    if d = nil then
		      res.AddElement(0)
		      
		    else
		      res.AddElement(d.day)
		      
		    end if
		    
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDayOfWeekInteger(WeekStartsOnMonday as boolean = false) As clIntegerDataSerie
		  
		  // The day of the week as an integer: 1=Sunday, 7=Saturday.
		  
		  var res as new clIntegerDataSerie("Day of week of " + self.name)
		  
		  
		  for i as integer = 0 to self.LastIndex
		    var item as datetime = self.GetElementAsDate(i)
		    
		    if item = nil then
		      res.AddElement(0)
		      
		    elseif WeekStartsOnMonday then
		      var d as integer = item.DayOfWeek()
		      if d=1 then 
		        res.AddElement(7)
		      else
		        res.AddElement(d-1)
		        
		      end if
		      
		      
		    else
		      res.AddElement(item.DayOfWeek)
		      
		    end if
		    
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDayOfYearInteger() As clIntegerDataSerie
		  
		  // The day of the week as an integer: 1=Sunday, 7=Saturday.
		  
		  var res as new clIntegerDataSerie("Day of year of " + self.name)
		  
		  
		  for i as integer = 0 to self.LastIndex
		    var d as datetime = self.GetElementAsDate(i)
		    
		    if d = nil then
		      res.AddElement(0)
		      
		    else
		      res.AddElement(d.DayOfYear)
		      
		    end if
		    
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToMonthInteger() As clIntegerDataSerie
		  var res as new clIntegerDataSerie("Month of " + self.name)
		  
		  
		  for i as integer = 0 to self.LastIndex
		    var d as datetime = self.GetElementAsDate(i)
		    
		    if d = nil then
		      res.AddElement(0)
		      
		    else
		      res.AddElement(d.month)
		      
		    end if
		    
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As clStringDataSerie
		  var res as new clStringDataSerie(self.name+" as sql-date")
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElementAsString(i))
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString(dateStyle As DateTime.FormatStyles) As clStringDataSerie
		  var res as new clStringDataSerie(self.name+" as string")
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElementAsString(i, dateStyle))
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString(format as string) As clStringDataSerie
		  var res as new clStringDataSerie(self.name+" as " + format)
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElementAsString(i, format))
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToYearInteger() As clIntegerDataSerie
		  var res as new clIntegerDataSerie("Year of " + self.name)
		  
		  
		  for i as integer = 0 to self.LastIndex
		    var d as datetime = self.GetElementAsDate(i)
		    
		    if d = nil then
		      res.AddElement(0)
		      
		    else
		      res.AddElement(d.year)
		      
		    end if
		    
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToYearMonthString(separator as string = "-") As clStringDataSerie
		  var res as new clStringDataSerie("Year Month of " + self.name)
		  
		  
		  for i as integer = 0 to self.LastIndex
		    var d as datetime = self.GetElementAsDate(i)
		    
		    if d = nil then
		      res.AddElement("")
		      
		    else
		      res.AddElement(d.ToString("yyyy" + separator + "MM"))
		      
		    end if
		    
		    
		  next
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToYearString() As clStringDataSerie
		  var res as new clStringDataSerie("Year of " + self.name)
		  
		  
		  for i as integer = 0 to self.LastIndex
		    var d as datetime = self.GetElementAsDate(i)
		    
		    if d = nil then
		      res.AddElement("")
		      
		    else
		      res.AddElement(d.ToString("yyyy"))
		      
		    end if
		    
		    
		  next
		  return res
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected DefaultValue As Variant
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected items() As DateTime
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
