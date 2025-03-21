#tag Class
Protected Class clBooleanDataSerie
Inherits clAbstractDataSerie
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub AddElement(the_item as Variant)
		  
		  items.Add(the_item.BooleanValue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(NewName as string = "") As clBooleanDataSerie
		  //
		  // Clone the data serie
		  //
		  
		  var tmp As New clBooleanDataSerie(StringWithDefault(NewName, self.name))
		  
		  self.CloneInfo(tmp)
		  
		  For Each v As boolean In Self.items
		    tmp.AddElement(v)
		    
		  Next
		  
		  tmp. AddSourceToMetadata("clone from " + self.FullName)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CloneInfo(target as clBooleanDataSerie)
		  super.CloneInfo(target)
		  
		  target.DefaultValue = self.DefaultValue
		  target.str_for_false = self.str_for_false
		  target.str_for_true = self.str_for_true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CloneStructure() As clBooleanDataSerie
		  var tmp As New clBooleanDataSerie(Self.name)
		  
		  self.CloneInfo(tmp)
		  
		  tmp. AddSourceToMetadata("clone structure from " + self.FullName)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDefaultValue() As variant
		  return DefaultValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElement(ElementIndex as integer) As variant
		  
		  return self.GetElementAsBoolean(ElementIndex)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsBoolean(ElementIndex as integer) As boolean
		  
		  If 0 <= ElementIndex And  ElementIndex <= items.LastIndex then
		    Return items(ElementIndex)
		    
		  Else
		    var v As Boolean
		    Return v
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsInteger(ElementIndex as integer) As integer
		  
		  return if(self.GetElementAsBoolean(ElementIndex),1,0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsNumber(ElementIndex as integer) As double
		  
		  return if(self.GetElementAsBoolean(ElementIndex),1,0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetElementAsString(ElementIndex as integer) As string
		  
		  return if(self.GetElementAsBoolean(ElementIndex),self.str_for_true,self.str_for_false)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetProperties() As clDataSerieProperties
		  // Calling the overridden superclass method.
		  Var p as clDataSerieProperties = Super.GetProperties()
		  
		  p.DefaultValue = self.DefaultValue
		  p.FormatStr = String.FromArray(array(str_for_false, str_for_true), chr(8))
		  
		  return p
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex() As integer
		  
		  Return items.LastIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_and(right_serie as clBooleanDataSerie) As clBooleanDataSerie
		  var mx1 as integer = self.LastIndex
		  var mx2 as integer = right_serie.LastIndex
		  var mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  var res as new clBooleanDataSerie(self.name+" and "+right_serie.name)
		  
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "And values from  " + right_serie.name)
		  
		  
		  for i as integer = 0 to mx0
		    var n as Boolean = true
		    
		    if i <= mx1 then
		      n = self.GetElementAsBoolean(i)
		    end if
		    
		    if i<= mx2 then
		      n = n and right_serie.GetElementAsBoolean(i)
		      
		    end if
		    
		    res.AddElement(n)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_not() As clBooleanDataSerie
		  var mx0 as integer = self.LastIndex
		  
		  var res as new clBooleanDataSerie("not " + self.name)
		  
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "complement")
		  
		  for i as integer = 0 to mx0
		    res.AddElement(not self.GetElementAsBoolean(i))
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_or(right_serie as clBooleanDataSerie) As clBooleanDataSerie
		  var mx1 as integer = self.LastIndex
		  var mx2 as integer = right_serie.LastIndex
		  var mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  var res as new clBooleanDataSerie(self.name+" or "+right_serie.name)
		  
		  res. AddSourceToMetadata( self.name)
		  res.AddMetadata("transformation", "Or values from  " + right_serie.name)
		  
		  
		  for i as integer = 0 to mx0
		    var n as Boolean = False
		    
		    if i <= mx1 then
		      n = self.GetElementAsBoolean(i)
		    end if
		    
		    if i<= mx2 then
		      n = n or right_serie.GetElementAsBoolean(i)
		      
		    end if
		    
		    res.AddElement(n)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetElements()
		  
		  self.Metadata.Add("type","boolean")
		  
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
		Sub SetElement(ElementIndex as integer, the_item as String)
		  If 0 <= ElementIndex And  ElementIndex <= items.LastIndex Then
		    items(ElementIndex) = (the_item.Trim.Uppercase = "TRUE")
		    
		  else
		    self.AddErrorMessage(CurrentMethodName,ErrMsgIndexOutOfbounds, str(ElementIndex), self.name)
		    
		  end if
		  
		  return
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetElement(ElementIndex as integer, the_item as Variant)
		  If 0 <= ElementIndex And  ElementIndex <= items.LastIndex Then
		    items(ElementIndex) = the_item.BooleanValue
		    
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
		    var v as boolean = DefaultValue.BooleanValue
		    items.Add(v)
		    
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetProperties(properties as clDataSerieProperties)
		  // Calling the overridden superclass method.
		  Super.SetProperties(properties)
		  
		  self.DefaultValue = properties.DefaultValue
		  
		  var s() as string = properties.FormatStr.ToArray(chr(8))
		  
		  while s.LastIndex < 1
		    s.Add("")
		    
		  wend
		  
		  self.str_for_false = s(0)
		  self.str_for_true = s(1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetStringFormat(False_label as string, True_Label as string)
		  
		  self.str_for_false = False_label
		  self.str_for_true = True_Label
		  
		End Sub
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
		Protected DefaultValue As Variant
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
