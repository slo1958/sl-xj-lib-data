#tag Class
Protected Class clDecimalDataSerie
Inherits clAbstractDataSerie
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub AddElement(the_item as Variant)
		  
		  items.Add(Internal_ConversionToDecimal(the_item))
		  
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

	#tag Method, Flags = &h21
		Private Sub AddInternalElement(v as int64)
		  //
		  // Adds a scaled element, typically when processing another clDecimalDataSerie
		  //
		  // Parameters:
		  // v: scaled value to add
		  //
		  
		  items.Add(v)
		  
		  Return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Aggregate(mode as AggMode) As double
		  //
		  // Apply aggregation to array of items
		  //
		  // Parameters:
		  // - type of aggregation (aggMode)
		  //
		  // Returns
		  // Aggregation results
		  //
		  
		  // !! TODO: align behaivour with individual aggregation calls
		  // !! TODO: test cases
		  
		  return clBasicMath.Aggregate(mode, items)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Average() As Double
		  
		  // !! TODO: test cases
		  
		  return self.DecimalToDouble(clBasicMath.Average(items))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AverageAsDecimal() As clDecimal
		  // !! TODO: test cases
		  
		  var r as new clDecimal(self.mDecPos)
		  
		  r.ScaledValue = clBasicMath.Average(items)
		  
		  Return r
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AverageNonZero() As Double
		  // !! TODO: test cases
		  
		  return self.DecimalToDouble(clBasicMath.AverageNonZero(items))
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AverageNonZeroAsCurrency() As clDecimal
		  // !! TODO: test cases
		  
		  var r as new clDecimal(self.mDecPos)
		  
		  r.ScaledValue = clBasicMath.AverageNonZero(items)
		  
		  Return r
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClipByRange(low_value as variant, high_value as variant) As integer
		  
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  
		  var last_index as integer = self.RowCount
		  var count_changes as integer = 0
		  
		  var low_value_dcl as int64 = Internal_ConversionToDecimal(low_value)
		  
		  var high_value_dcl as double = Internal_ConversionToDecimal(high_value)
		  
		  for index as integer = 0 to last_index
		    var tmp as int64 = self.items(index)
		    
		    if low_value_dcl> tmp then
		      self.items(index) = low_value_dcl
		      count_changes = count_changes + 1
		      
		    elseif  tmp > high_value_dcl then
		      self.items(index) = high_value_dcl
		      count_changes = count_changes + 1
		      
		    end if
		    
		  next
		  
		  Return count_changes
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClippedByRange(low_value as variant, high_value as variant) As clDecimalDataSerie
		  // !! TODO: test cases
		  
		  var new_col as clDecimalDataSerie = self.Clone()
		  
		  new_col.rename("clip " + self.name)
		  
		  call new_col.ClipByRange(low_value, high_value)
		  
		  return new_col
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(NewName as string = "") As clDecimalDataSerie
		  // !! TODO: test cases
		  
		  var tmp As New clDecimalDataSerie(StringWithDefault(NewName, self.name))
		  
		  self.CloneInfo(tmp)
		  
		  For Each v As int64 In Self.items
		    
		    tmp.AddInternalElement(v)
		    
		  Next
		  
		  tmp. AddSourceToMetadata("clone from " + self.FullName)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CloneInfo(target as clDecimalDataSerie)
		  super.CloneInfo(target)
		  
		  target.DefaultValue = self.DefaultValue
		  target.Formatter = self.Formatter
		  target.mDecPos = self.mDecPos
		  target.mDecScale = self.mDecScale
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CloneStructure() As clDecimalDataSerie
		  var tmp As New clDecimalDataSerie(Self.name)
		  
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
		  // !! TODO: test cases
		  // !! TODO: description
		  
		  return clBasicMath.CountNonZero(items)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DecimalToDouble(v as int64) As Double
		  
		  // !! TODO: description
		  
		  return v / mDecScale
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
		  
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  return self.GetElementAsNumber(ElementIndex)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsDecimal(ElementIndex as integer) As clDecimal
		  
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  
		  var v as new clDecimal(self.mDecPos)
		  
		  If 0 <= ElementIndex And  ElementIndex <= items.LastIndex then
		    v.ScaledValue = items(ElementIndex)
		    
		  End if
		  
		  Return v
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsNumber(ElementIndex as integer) As double
		  
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  var v As double
		  
		  If 0 <= ElementIndex And  ElementIndex <= items.LastIndex then
		      v= DecimalToDouble(items(ElementIndex))
		    
		  End If
		  
		  Return v
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsString(ElementIndex as integer) As string
		  // !! TODO; update code
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  
		  if self.Formatter = nil then 
		    return self.GetElementAsNumber(ElementIndex).ToString
		    
		  else
		    return self.Formatter.FormatCurrency(self.GetElementAsCurrency(ElementIndex))
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFilterColumnValuesInRange(minimum_value as Currency, maximum_value as Currency) As variant()
		  // !! TODO; update code
		  // !! TODO: description
		  // !! TODO: test cases
		  
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

	#tag Method, Flags = &h1
		Protected Sub InitFromConstructor()
		  // Calling the overridden superclass method.
		  
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  Super.InitFromConstructor()
		  
		  self.mDecPos = 2
		  self.mDecScale = 100
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Internal_ConversionToDecimal(v as Variant) As int64
		   
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  if v.Type  = variant.TypeDouble then
		    return mDecScale * v.DoubleValue
		    
		    
		  elseif v.type <> variant.TypeString then
		    return  mDecScale * v.DoubleValue
		    
		  elseif self.CurrencyParser = nil Then
		    return mDecScale * v.DoubleValue
		    
		  else
		    return self.CurrencyParser.ParseToCurrency(v.StringValue)/0
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsZero(value as Currency) As Boolean
		  // !! TODO; update code
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  return abs(value) <0.0001
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex() As integer
		   
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  Return items.LastIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Maximum() As Currency
		   
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  return DecimalToDouble(clBasicMath.Maximum(items))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Minimum() As Currency
		   
		  
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  
		  return DecimalToDouble(clBasicMath.Minimum(items))
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_add(right_serie as clCurrencyDataSerie) As clCurrencyDataSerie
		  
		  // !! TODO: review code
		  // !! TODO: description
		  // !! TODO: test cases
		  
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
		  
		  // !! TODO: review code
		  // !! TODO: description
		  // !! TODO: test cases
		  
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
		  
		  // !! TODO: review code
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  
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
		  
		  // !! TODO: review code
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  
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
		  
		  // !! TODO: review code
		  // !! TODO: description
		  // !! TODO: test cases
		  
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
		  
		  // !! TODO: review code
		  // !! TODO: description
		  // !! TODO: test cases
		  
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
		  
		  // !! TODO: review code
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  
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
		  
		  // !! TODO: review code
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  var res as new clCurrencyDataSerie(self.name+"-"+str(right_value))
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "subtract constant " + str(right_value))
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElement(i) - right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Rescale(oldValue as int64, oldScale as int64, newScale as int64) As int64
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  
		  var temp as int64 = oldValue * newScale
		  
		  temp = temp / oldScale
		  
		  Return temp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetElements()
		  
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  self.Metadata.Add("type","decimal")
		  
		  items.RemoveAll
		  
		  Return
		  
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
		  
		  // !! TODO: update code
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  self.CurrencyParser = parser
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetDefaultValue(v as variant)
		  
		  // !! TODO: review code
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  
		  self.DefaultValue = Internal_ConversionToDecimal(v)
		  
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetElement(ElementIndex as integer, the_item as Variant)
		  
		  // !! TODO: review code
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  
		  If 0 <= ElementIndex And  ElementIndex <= items.LastIndex Then 
		    items(ElementIndex) = Internal_ConversionToDecimal(the_item)
		    
		  else
		    self.AddErrorMessage(CurrentMethodName,ErrMsgIndexOutOfbounds, str(ElementIndex), self.name)
		    
		  end if
		  
		  return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLength(the_length as integer, DefaultValue as variant)
		  
		  // !! TODO: review code
		  // !! TODO: description
		  // !! TODO: test cases
		  
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
		Sub SetPrecision(DecimalPosition as integer)
		  //
		  // Set the precision of the number stored in the data serie. Existing numbers are rescaled.
		  //
		  // DecimalPosition: number of digits after decimal point
		  //
		  
		  // !! TODO: review code
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  
		  var oldDecScale as integer = mDecScale
		  
		  if DecimalPosition <=0 then
		    self.mDecPos = 0
		    self.mDecScale = 1
		    
		  else
		    self.mDecPos = DecimalPosition
		    self.mDecScale = 10 ^ DecimalPosition
		    
		  end if
		  
		  if oldDecScale = self.mDecScale then Return
		  
		  
		  for i as integer = 0 to self.items.LastIndex
		    
		    self.items(i) = Rescale(self.items(i), oldDecScale, self.mDecScale)
		    
		    
		  next
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetProperties(properties as clDataSerieProperties)
		  // Calling the overridden superclass method.
		  
		  // !! TODO: description
		  // !! TODO: test cases
		  
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
		  
		  // !! TODO: review code
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  self.Formatter = the_Formatter
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetStringFormat(the_format as String, UseLocal as Boolean = False)
		  
		  // !! TODO: review code
		  // !! TODO: description
		  // !! TODO: test cases
		  
		  
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
		  // The sum is calculated using int64, but the results is scaled and converted to double
		  //
		  
		  return self.DecimalToDouble(clBasicMath.sum(items))
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SumAsDecimal() As clDecimal
		  
		  //
		  // Calculates the sum
		  // The sum is calculated using int64, and the results is returned as clDecimal
		  //
		  
		  var r as new clDecimal(self.mDecPos)
		  
		  r.ScaledValue = clBasicMath.sum(items)
		  
		  Return r
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString(NewName as string = "") As clStringDataSerie
		  
		  // !! TODO: review code
		  // !! TODO: description
		  // !! TODO: test cases
		  
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
		Protected DefaultValue As int64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Formatter As CurrencyFormatInterface
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected items() As int64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDecPos As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDecScale As Integer
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
