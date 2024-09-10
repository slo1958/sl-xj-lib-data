#tag Class
Protected Class clDateDataSerie
Inherits clAbstractDataSerie
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub AddElement(the_item as Variant)
		  
		  items.Append(prep_date(the_item))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone() As clDateDataSerie
		  var tmp As New clDateDataSerie(Self.name)
		  
		  self.CloneInfo(tmp)
		  
		  For Each v As DateTime In Self.items
		    tmp.AddElement(v)
		    
		  Next
		  
		  tmp.AddMetadata("source","clone from " + self.FullName)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CloneInfo(target as clDateDataSerie)
		  super.CloneInfo(target)
		  
		  target.default_value = self.default_value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function diff_to_days(d1 as DateTime, d2 as DateTime) As integer
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
		    return_boolean.Append(list_of_values.IndexOf(my_item)>=0)
		    
		  Next
		  
		  Return return_boolean
		  
		End Function
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
		    var v As integer
		    Return v
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsDate(the_element_index as integer) As DateTime
		  If 0 <= the_element_index And  the_element_index <= items.LastIndex then
		    return self.GetElement(the_element_index)
		    
		  else
		    return nil
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsString(the_element_index as integer) As string
		  If 0 <= the_element_index And  the_element_index <= items.LastIndex then
		    var tmp as DateTime = items(the_element_index)
		    if tmp = nil then return ""
		    
		    Return tmp.SQLDate
		    
		  Else
		    Return ""
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsString(the_element_index As integer, dateStyle As DateTime.FormatStyles) As String
		  If 0 <= the_element_index And  the_element_index <= items.LastIndex then
		    var tmp as DateTime = items(the_element_index)
		    if tmp = nil then return ""
		    
		    Return tmp.ToString(datestyle, DateTime.FormatStyles.None)
		    
		  Else
		    Return ""
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsString(the_element_index as integer, format as string) As string
		  If 0 <= the_element_index And  the_element_index <= items.LastIndex then
		    var tmp as DateTime = items(the_element_index)
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
		    return_boolean.Append((minimum_value <= my_item) and (my_item <= maximum_value))
		    
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
		    return_boolean.Append((minimum_value <= my_item) and (my_item <= maximum_value))
		    
		  Next
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex() As integer
		  Return items.LastIndex
		  
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
		  
		  for i as integer = 0 to mx0
		    
		    if i <= mx1 and i <= mx2 then
		      res.AddElement(diff_to_days(self.GetElementAsDate(i), right_serie.GetElementAsDate(i) ) )
		      
		    else
		      res.AddElement(0)
		      
		    end if
		    
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_subtract(right_value as DateTime) As clIntegerDataSerie
		  var res as new clIntegerDataSerie(self.name+" - "+ right_value.SQLDate)
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(diff_to_days(self.GetElementAsDate(i) , right_value))
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function prep_date(d as variant) As DateTime
		  var tmp as DateTime = d.DateTimeValue
		  
		  return tmp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetElementss()
		  
		  self.meta_dict.AddMetadata("type","date")
		  
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
		    items(the_element_index) = prep_date(the_item)
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLength(the_length as integer, default_value as variant)
		  
		  if items.LastIndex > the_length then
		    Raise New clDataException("Column " + self.name + " contains more elements than expected")
		  end if
		  
		  
		  While items.LastIndex < the_length-1
		    var v as DateTime = default_value.DateTimeValue
		    
		    items.Append(v)
		    
		  Wend
		  
		End Sub
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


	#tag Property, Flags = &h1
		Protected default_value As Variant
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected items() As DateTime
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
