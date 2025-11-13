#tag Class
Protected Class clStringDataSerie
Inherits clAbstractDataSerie
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub AddElement(the_item as Variant)
		  
		  items.Add(the_item.StringValue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(NewName as string = "") As clStringDataSerie
		  
		  var tmp As New clStringDataSerie(StringWithDefault(NewName, self.name))
		  
		  self.CloneInfo(tmp)
		  
		  For Each v As string In Self.items
		    tmp.AddElement(v)
		    
		  Next
		  
		  tmp. AddSourceToMetadata("clone from " + self.FullName)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CloneInfo(target as clStringDataSerie)
		  
		  super.CloneInfo(target)
		  
		  target.DefaultValue = self.DefaultValue
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CloneStructure() As clStringDataSerie
		  
		  var tmp As New clStringDataSerie(Self.name)
		  
		  self.CloneInfo(tmp)
		  
		  tmp. AddSourceToMetadata("clone structure from " + self.FullName)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilterValueInList(list_of_values() as string) As variant()
		  var return_boolean() As Variant
		  var my_item as string
		  
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
		  
		  return self.GetElementAsString(ElementIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsBoolean(ElementIndex as integer) As boolean
		  
		  
		  if self.BooleanParser = nil then
		    // Calling the overridden superclass method
		    return Super.GetElementAsBoolean(ElementIndex)
		    
		  end if
		  
		  return self.BooleanParser.ParseToBoolean(self.GetElementAsString(ElementIndex))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsCurrency(ElementIndex as integer) As currency
		  
		  
		  if self.CurrencyParser = nil then
		    // Calling the overridden superclass method.
		    return Super.GetElementAsCurrency(ElementIndex)
		    
		  end if
		  
		  return self.CurrencyParser.ParseToCurrency(self.GetElementAsString(ElementIndex))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsInteger(ElementIndex as integer) As integer
		  
		  
		  if self.IntegerParser = nil then
		    // Calling the overridden superclass method
		    return Super.GetElementAsInteger(ElementIndex)
		    
		  end if
		  
		  return self.IntegerParser.ParseToInteger(self.GetElementAsString(ElementIndex))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsNumber(ElementIndex as integer) As double
		  
		  
		  
		  if self.NumberParser = nil then
		    // Calling the overridden superclass method.
		    return Super.GetElementAsNumber(ElementIndex)
		    
		  end if
		  
		  return self.NumberParser.ParseToNumber(self.GetElementAsString(ElementIndex))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsString(ElementIndex as integer) As string
		  
		  
		  If 0 <= ElementIndex And  ElementIndex <= items.LastIndex then
		    Return items(ElementIndex)
		    
		  Else
		    var v As variant
		    Return v
		    
		  End If
		  
		  
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
		Function Left(count as integer) As clStringDataSerie
		  var res as new clStringDataSerie(me.name+ " left " + str(count))
		  
		  for i as integer = 0 to me.LastIndex
		    res.AddElement(me.GetElementAsString(i).left(count))
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lowercase() As clStringDataSerie
		  var res as new clStringDataSerie(me.name+ " lower")
		  
		  for i as integer = 0 to me.LastIndex
		    res.AddElement(me.GetElementAsString(i).Lowercase())
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxLength() As integer
		  //
		  // Returns the maximum length of the strings in the serie
		  //
		  // Parameters:
		  // (nothing)
		  // 
		  // Returns:
		  //  Maximum of length
		  //
		  
		  var temp() as integer
		  for each item as string in items
		    if item.Length > 0 then temp.Add(item.Length)
		    
		  next
		  
		  return clBasicMath.Maximum(temp)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Middle(from_char as integer, length as integer) As clStringDataSerie
		  var res as new clStringDataSerie(me.name+ " Middle " + str(length) + " char. from "  + str(from_char) )
		  
		  for i as integer = 0 to me.LastIndex
		    res.AddElement(me.GetElementAsString(i).Middle(from_char, length))
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MiinLength() As integer
		  //
		  // Returns the minimum length of the non empty strings in the serie
		  //
		  // Parameters:
		  // (nothing)
		  // 
		  // Returns:
		  //  Minimum of length
		  //
		  
		  var temp() as integer
		  for each item as string in items
		    if item.Length > 0 then temp.Add(item.Length)
		    
		  next
		  
		  return clBasicMath.Minimum(temp)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_add(right_serie as clStringDataSerie) As clStringDataSerie
		  var mx1 as integer = self.LastIndex
		  var mx2 as integer = right_serie.LastIndex
		  var mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  var res as new clStringDataSerie(self.name+"+"+right_serie.name)
		  
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "add string values from  " + right_serie.name)
		  
		  
		  for i as integer = 0 to mx0
		    var n as string
		    
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
		Function operator_add(right_value as String) As clStringDataSerie
		  var res as new clStringDataSerie(self.name+"+"+str(right_value))
		  
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "Append string " + right_value)
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElementAsString(i) + right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetElements()
		  
		  self.Metadata.Add("type","string")
		  
		  items.RemoveAll
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Right(count as integer) As clStringDataSerie
		  var res as new clStringDataSerie(me.name+ " right " + str(count))
		  
		  for i as integer = 0 to me.LastIndex
		    res.AddElement(me.GetElementAsString(i).right(count))
		    
		  next
		  
		  return res
		  
		  
		End Function
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
		    items(ElementIndex) = the_item.StringValue
		    
		  End If
		  
		  
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
		    var v as string = DefaultValue.StringValue
		    items.Add(v)
		    
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetNumberParser(parser as NumberParserInterface)
		  self.NumberParser = parser
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetParser(parser as BooleanParserInterface)
		  // self.IntegerParser = nil
		  // self.NumberParser = nil
		  //self.CurrencyParser = nil
		  self.BooleanParser = parser
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetParser(parser as CurrencyParserInterface)
		  // self.IntegerParser = nil
		  // self.NumberParser = nil
		  self.CurrencyParser = parser
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetParser(parser as IntegerParserInterface)
		  self.IntegerParser = parser
		  // self.NumberParser = nil
		  // self.CurrencyParser = nil 
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetParser(parser as NumberParserInterface)
		  // self.IntegerParser = nil
		  self.NumberParser = parser
		  // self.CurrencyParser = nil
		  
		  return
		  
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
		Function TextAfter(search_str as string) As clStringDataSerie
		  var res as clStringDataSerie
		  
		  res = new clStringDataSerie(me.name+ " text after  " + search_str)
		  
		  
		  for i as integer = 0 to me.LastIndex
		    var tmp as string = me.GetElementAsString(i)
		    var idx as integer = tmp.IndexOf(search_str)
		    
		    if idx <0 then 
		      res.AddElement("")
		      
		    else
		      res.AddElement(tmp.mid( idx + 1 +  len(search_str), len(tmp)))
		      
		    end if
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextBefore(search_str as string) As clStringDataSerie
		  var res as new clStringDataSerie(me.name+ " text before  " + search_str)
		  
		  for i as integer = 0 to me.LastIndex
		    var tmp as string = me.GetElementAsString(i)
		    var idx as integer = tmp.IndexOf(search_str)
		    
		    if idx <0 then 
		      res.AddElement("")
		      
		    else
		      res.AddElement(tmp.left(idx))
		      
		    end if
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Titlecase() As clStringDataSerie
		  var res as new clStringDataSerie(me.name+ " upper" )
		  
		  for i as integer = 0 to me.LastIndex
		    res.AddElement(me.GetElementAsString(i).Titlecase)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToCurrency() As clCurrencyDataSerie
		  //
		  // Converts the data serie to a clCurrencyDataSerie
		  //
		  var res as new clCurrencyDataSerie(self.name+" as Currency")
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElementAsCurrency(i))
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToInteger() As clIntegerDataSerie
		  //
		  // Converts the data serie to a clIntegerDataSerie
		  //
		  var res as new clIntegerDataSerie(self.name+" as integer")
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElementAsInteger(i))
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToNumber() As clNumberDataSerie
		  //
		  // Converts the data serie to a clNumberDataSerie
		  //
		  var res as new clNumberDataSerie(self.name+" as number")
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElementAsNumber(i))
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Trim() As clStringDataSerie
		  var res as new clStringDataSerie(me.name+ " trim" )
		  
		  for i as integer = 0 to me.LastIndex
		    res.AddElement(me.GetElementAsString(i).Trim)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Uppercase() As clStringDataSerie
		  var res as new clStringDataSerie(me.name+ " upper" )
		  
		  for i as integer = 0 to me.LastIndex
		    res.AddElement(me.GetElementAsString(i).Uppercase)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected BooleanParser As BooleanParserInterface
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected CurrencyParser As CurrencyParserInterface
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected DefaultValue As Variant
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected IntegerParser As IntegerParserInterface
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected items() As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected NumberParser As NumberParserInterface
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
