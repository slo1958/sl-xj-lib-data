#tag Class
Protected Class clStringDataSerie
Inherits clAbstractDataSerie
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub AddElement(the_item as Variant)
		  
		  items.Append(the_item.StringValue)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As clStringDataSerie
		  var tmp As New clStringDataSerie(Self.name)
		  
		  self.CloneInfo(tmp)
		  
		  For Each v As string In Self.items
		    tmp.AddElement(v)
		    
		  Next
		  
		  tmp.AddMetadata("source","clone from " + self.FullName)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub CloneInfo(target as clStringDataSerie)
		  super.CloneInfo(target)
		  
		  target.default_value = self.default_value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CloneStructure() As clStringDataSerie
		  // Calling the overridden superclass method.
		  Var returnValue as clAbstractDataSerie = Super.CloneStructure()
		  var tmp As New clStringDataSerie(Self.name)
		  
		  self.CloneInfo(tmp)
		  
		  tmp.AddMetadata("source","clone structure from " + self.FullName)
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FilterValueInList(list_of_values() as string) As variant()
		  var return_boolean() As Variant
		  var my_item as string
		  
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
		Function GetElementAsString(the_element_index as integer) As string
		  return self.GetElement(the_element_index)
		  
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
		Function Middle(from_char as integer, length as integer) As clStringDataSerie
		  var res as new clStringDataSerie(me.name+ " Middle " + str(length) + " char. from "  + str(from_char) )
		  
		  for i as integer = 0 to me.LastIndex
		    res.AddElement(me.GetElementAsString(i).Middle(from_char, length))
		    
		  next
		  
		  return res
		  
		  
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
		Function operator_add(right_value as String) As clStringDataSerie
		  var res as new clStringDataSerie(self.name+"+"+str(right_value))
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElementAsString(i) + right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetElementss()
		  
		  self.meta_dict.AddMetadata("type","string")
		  
		  redim items(-1)
		  
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
		Sub SetDefaultValue(v as variant)
		  default_value = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetElement(the_element_index as integer, the_item as Variant)
		  If 0 <= the_element_index And  the_element_index <= items.LastIndex Then
		    items(the_element_index) = the_item.StringValue
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLength(the_length as integer, default_value as variant)
		  
		  if items.LastIndex > the_length then
		    Raise New clDataException("Column " + self.name + " contains more elements than expected")
		  end if
		  
		  
		  While items.LastIndex < the_length-1
		    var v as string = default_value.StringValue
		    items.Append(v)
		    
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function text_after(search_str as string) As clStringDataSerie
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
		Function text_before(search_str as string) As clStringDataSerie
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
		Function ToInteger() As clIntegerDataSerie
		  var res as new clIntegerDataSerie(self.name+" as integer")
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElementAsInteger(i))
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToNumber() As clNumberDataSerie
		  var res as new clNumberDataSerie(self.name+" as double")
		  
		  for i as integer = 0 to self.LastIndex
		    res.AddElement(self.GetElementAsInteger(i))
		    
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
