#tag Class
Protected Class clCurrencyDataSerie
Inherits clAbstractDataSerie
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub AddElement(the_item as Variant)
		  
		  items.Add(Internal_ConversionToCurrency(the_item))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddFormattingRange(low_bound as Currency, high_bound as Currency, label as string)
		  if self.Formatter = nil then Return
		  
		  if self.Formatter isa clCurrencyRangeFormatting then
		    clCurrencyRangeFormatting(self.Formatter).AddRange(low_bound, high_bound, label)
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddFormattingRanges(low_bound as clCurrencyDataSerie, high_bound as clCurrencyDataSerie, label as clDataSerie)
		  if self.Formatter = nil then Return
		  
		  if self.Formatter isa NumberFormatInteraface then
		    
		    for i as integer = 0 to label.LastIndex
		      try
		        self.AddFormattingRange( _
		        low_bound.GetElementAsCurrency(i) _
		        , high_bound.GetElementAsCurrency(i)_
		        , label.GetElementAsString(i) _
		        )
		        
		      catch OutOfBoundsException
		        
		      Catch
		        
		      end try
		      
		    next
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Aggregate(mode as AggMode) As Currency
		  //
		  // Apply aggregation to array of items
		  //
		  // Parameters:
		  // - type of aggregation (aggMode)
		  //
		  // Returns
		  // Aggregation results
		  //
		  
		  return clBasicMath.Aggregate(mode, items)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Average() As Double
		  
		  return clBasicMath.Average(items)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AverageAsCurrency() As Currency
		  
		  return clBasicMath.Average(items)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AverageNonZero() As Double
		  
		  return clBasicMath.AverageNonZero(items)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AverageNonZeroAsCurrency() As Currency
		  
		  return clBasicMath.AverageNonZero(items)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipByRange_gg(low_value as variant, high_value as variant) As integer
		  
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
		Function ClippedByRange(low_value as variant, high_value as variant) As clCurrencyDataSerie
		  
		  var new_col as clCurrencyDataSerie = self.Clone()
		  
		  new_col.rename("clip " + self.name)
		  
		  call new_col.ClipByRange(low_value, high_value)
		  
		  return new_col
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(NewName as string = "") As clCurrencyDataSerie
		  
		  var tmp As New clCurrencyDataSerie(StringWithDefault(NewName, self.name))
		  
		  self.CloneInfo(tmp)
		  
		  For Each v As double In Self.items
		    tmp.AddElement(v)
		    
		  Next
		  
		  tmp. AddSourceToMetadata("clone from " + self.FullName)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CloneInfo(target as clCurrencyDataSerie)
		  super.CloneInfo(target)
		  
		  target.DefaultValue = self.DefaultValue
		  target.Formatter = self.Formatter
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CloneStructure() As clCurrencyDataSerie
		  var tmp As New clCurrencyDataSerie(Self.name)
		  
		  self.CloneInfo(tmp)
		  
		  tmp. AddSourceToMetadata("clone structure from " + self.FullName)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  //
		  // Count items in the dataserie
		  //
		  // Paramters
		  // (none)
		  //
		  // Returns:
		  // - number of items as integer
		  //
		  return clBasicMath.Count(items)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountNonZero() As integer
		  
		  return clBasicMath.CountNonZero(items)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DropRangeFormatting()
		  self.Formatter = nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDefaultValue() As variant
		  
		  return DefaultValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElement(ElementIndex as integer) As variant
		  
		  return self.GetElementAsCurrency(ElementIndex)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsCurrency(ElementIndex as integer) As currency
		  
		  
		  If 0 <= ElementIndex And  ElementIndex <= items.LastIndex then
		    Return items(ElementIndex)
		    
		  Else
		    var v As Currency
		    Return v
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsNumber(ElementIndex as integer) As double
		  
		  return self.GetElementAsCurrency(ElementIndex)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsString(ElementIndex as integer) As string
		  
		  if self.Formatter = nil then 
		    return self.GetElementAsCurrency(ElementIndex).ToString
		    
		  else
		    return self.Formatter.FormatCurrency(self.GetElementAsCurrency(ElementIndex))
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFilterColumnValuesInRange(minimum_value as Currency, maximum_value as Currency) As variant()
		  var return_boolean() As Variant
		  var my_item as Currency
		  
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
		Private Function Internal_ConversionToCurrency(v as Variant) As Currency
		  
		  
		  if v.Type  = variant.TypeCurrency then
		    return v.CurrencyValue
		    
		  elseif v.type <> variant.TypeString then
		    return v.CurrencyValue
		    
		  elseif self.CurrencyParser = nil Then
		    return v.CurrencyValue
		    
		  else
		    return self.CurrencyParser.ParseToCurrency(v.StringValue)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsZero(value as Currency) As Boolean
		  return abs(value) <0.0001
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex() As integer
		  
		  Return items.LastIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Maximum() As Currency
		  
		  return clBasicMath.Maximum(items)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Minimum() As Currency
		  // Calling the overridden superclass method.
		  
		  return clBasicMath.Minimum(items)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_add(right_serie as clCurrencyDataSerie) As clCurrencyDataSerie
		  var mx1 as integer = self.LastIndex
		  var mx2 as integer = right_serie.LastIndex
		  var mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  var res as new clCurrencyDataSerie(self.name+"+"+right_serie.name)
		  
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "add values from  " + right_serie.name)
		  
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
		Function operator_add(right_value as double) As clCurrencyDataSerie
		  var res as new clCurrencyDataSerie(self.name+"+"+str(right_value))
		  
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "add constant " + str(right_value))
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElement(i) + right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_divide(right_serie as clCurrencyDataSerie) As clCurrencyDataSerie
		  var mx1 as integer = self.LastIndex
		  var mx2 as integer = right_serie.LastIndex
		  var mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  var res as new clCurrencyDataSerie(self.name+"/"+right_serie.name)
		  res.AddMetadata("transformation", "divide by values from  " + right_serie.name)
		  
		  for i as integer = 0 to mx0
		    var n1 as double = 1
		    var n2 as double = 0
		    
		    if i <= mx1 then n1 = self.GetElement(i)
		    
		    if i<= mx2 then
		      n2 = right_serie.GetElement(i)
		      
		    end if
		    
		    if IsZero(n2) then
		      res.AddElement(nil)
		    else
		      res.AddElement(n1/n2)
		    end if
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_divide(right_value as double) As clCurrencyDataSerie
		  var res as new clCurrencyDataSerie(self.name+"/"+str(right_value))
		  
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "divide by constant " + str(right_value))
		  
		  if self.IsZero(right_value) then
		    for i as integer = 0 to self.LastIndex
		      res.AddElement(nil)
		      
		    next
		    
		  else
		    for i as integer = 0 to self.LastIndex
		      res.AddElement(self.GetElement(i) / right_value)
		      
		    next
		  end if
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_multiply(right_serie as clCurrencyDataSerie) As clCurrencyDataSerie
		  var mx1 as integer = self.LastIndex
		  var mx2 as integer = right_serie.LastIndex
		  var mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  var res as new clCurrencyDataSerie(self.name+"*"+right_serie.name)
		  res.AddMetadata("transformation", "multiply by values from  " + right_serie.name)
		  
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
		Function operator_multiply(right_value as double) As clCurrencyDataSerie
		  var res as new clCurrencyDataSerie(self.name+"*"+str(right_value))
		  
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "multiply by constant " + str(right_value))
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElement(i) * right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_subtract(right_serie as clCurrencyDataSerie) As clCurrencyDataSerie
		  var mx1 as integer = self.LastIndex
		  var mx2 as integer = right_serie.LastIndex
		  var mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  var res as new clCurrencyDataSerie(self.name+"-"+right_serie.name)
		  res.AddMetadata("transformation", "substract values from  " + right_serie.name)
		  
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
		Function operator_subtract(right_value as double) As clCurrencyDataSerie
		  var res as new clCurrencyDataSerie(self.name+"-"+str(right_value))
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "subtract constant " + str(right_value))
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElement(i) - right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetElements()
		  
		  
		  self.Metadata.Add("type","number")
		  
		  items.RemoveAll
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RowCount() As integer
		  // Calling the overridden superclass method.
		  
		  return items.Count
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetCurrencyParser(parser as CurrencyParserInterface)
		  self.CurrencyParser = parser
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetDefaultValue(v as variant)
		  DefaultValue = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetElement(ElementIndex as integer, the_item as Variant)
		  
		  
		  If 0 <= ElementIndex And  ElementIndex <= items.LastIndex Then 
		    items(ElementIndex) = Internal_ConversionToCurrency(the_item)
		    
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
		    var v as double = DefaultValue.DoubleValue
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
		    self.Formatter = new clCurrencyFormatting(properties.FormatStr)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetStringFormat(the_formatter as CurrencyFormatInterface)
		  
		  self.Formatter = the_Formatter
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetStringFormat(the_format as String, UseLocal as Boolean = False)
		  if UseLocal then
		    self.Formatter = new clCurrencyLocalFormatting(the_format)
		    
		  else
		    self.Formatter = new clCurrencyFormatting(the_format)
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sum() As double
		  //
		  // Calculates the sum
		  // The sum is calculated using Currency, but the results is converted to double
		  //
		  
		  var c as new clBasicMath
		  return c.sum(items)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SumAsCurrency() As Currency
		  
		  //
		  // Calculates the sum
		  // The sum is calculated using Currency, and the results is returned as is
		  //
		  
		  var c as new clBasicMath
		  return c.sum(items)
		  
		  
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
		Protected CurrencyParser As CurrencyParserInterface
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected DefaultValue As Currency
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Formatter As CurrencyFormatInterface
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected items() As Currency
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
