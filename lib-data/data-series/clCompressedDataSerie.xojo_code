#tag Class
Protected Class clCompressedDataSerie
Inherits clAbstractDataSerie
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub AddElement(the_item as Variant)
		  
		  var item_entry as Integer
		  
		  if self.items_value_dict.HasKey(the_item) then
		    item_entry = self.items_value_dict.Value(the_item)
		    
		  else
		    items_value_list.Append(the_item)
		    item_entry = items_value_list.LastIndex
		    self.items_value_dict.Value(the_item) = item_entry
		    
		  end if
		  
		  items_index.Append(item_entry)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ApplyFilterFunction(pFilterFunction as FilterColumnByRows, paramarray pFunctionParameters as variant) As variant()
		  var return_boolean() As Variant
		  
		  For row_index As Integer=0 To items_index.LastIndex
		    var item_index as integer = items_index(row_index)
		    var v as Variant
		    
		    if item_index >=0 then
		      v = self.items_value_list(item_index)
		      
		    end if
		    
		    return_boolean.Append(pFilterFunction.Invoke(row_index, items_index.LastIndex, name, v, pFunctionParameters))
		    
		  Next
		  
		  Return return_boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(NewName as string = "") As clAbstractDataSerie
		  
		  var tmp As New clCompressedDataSerie(StringWithDefault(NewName, self.name))
		  tmp.DisplayTitle = self.DisplayTitle
		  
		  tmp.AddMetadata("source","clone from " + self.FullName)
		  
		  For Each item_index As Integer In Self.items_index
		    var v as Variant 
		    
		    if item_index >=0 then
		      v = self.items_value_list(item_index)
		      
		    end if
		    
		    tmp.AddElement(v)
		    
		  Next
		  
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CloneStructure() As clCompressedDataSerie
		  var tmp As New clCompressedDataSerie(Self.name)
		  tmp.DisplayTitle = self.DisplayTitle
		  
		  tmp.AddMetadata("source","clone structure from " + self.FullName)
		  
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
		  
		  var v as Variant
		  
		  If 0 <= ElementIndex And  ElementIndex <= items_index.LastIndex then
		    var item_index As Integer = Self.items_index(ElementIndex)
		    
		    if item_index >=0 then
		      v = self.items_value_list(item_index)
		      
		    end if
		    
		  end if
		  
		  Return v
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastIndex() As integer
		  Return items_index.LastIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetElements()
		  
		  items_value_dict = new Dictionary
		  
		  redim items_index(-1)
		  redim items_value_list(-1)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetDefaultValue(v as Variant)
		  
		  DefaultValue = v
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetElement(ElementIndex as integer, the_item as Variant)
		  If 0 <= ElementIndex And  ElementIndex <= items_index.LastIndex Then
		    
		    var item_entry as Integer
		    
		    if self.items_value_dict.HasKey(the_item) then
		      item_entry = self.items_value_dict.Value(the_item)
		      
		    else
		      items_value_list.Append(the_item)
		      item_entry = items_value_list.LastIndex
		      self.items_value_dict.Value(the_item) = item_entry
		      
		    end if
		    
		    items_index(ElementIndex) = item_entry
		    
		  else
		    self.AddErrorMessage(CurrentMethodName,"Element index %0 out of range in column %1", str(ElementIndex), self.name)
		    
		  end if
		  
		  return
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLength(the_length as integer, DefaultValue as variant)
		  
		  While items_index.LastIndex < the_length-1
		    items_index.Append(-1)
		    
		  Wend
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected DefaultValue As variant
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected items_index() As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected items_value_dict As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected items_value_list() As Variant
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
