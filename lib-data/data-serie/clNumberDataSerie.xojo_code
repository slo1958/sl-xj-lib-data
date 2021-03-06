#tag Class
Protected Class clNumberDataSerie
Inherits clAbstractDataSerie
	#tag Method, Flags = &h0
		Sub append_element(the_item as Variant)
		  
		  items.Append(the_item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone() As clNumberDataSerie
		  Dim tmp As New clNumberDataSerie(Self.name)
		  
		  For Each v As double In Self.items
		    tmp.append_element(v)
		    
		  Next
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element(the_element_index as integer) As variant
		  If 0 <= the_element_index And  the_element_index <= items.Ubound then
		    Return items(the_element_index)
		    
		  Else
		    Dim v As double
		    Return v
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_element_as_number(the_element_index as integer) As double
		  return self.get_element(the_element_index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_add(right_serie as clNumberDataSerie) As clNumberDataSerie
		  dim mx1 as integer = self.upper_bound
		  dim mx2 as integer = right_serie.upper_bound
		  dim mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  dim res as new clNumberDataSerie(self.name+"+"+right_serie.name)
		  for i as integer = 0 to mx0
		    dim n as double
		    
		    if i <= mx1 then
		      n = self.get_element(i)
		    end if
		    
		    if i<= mx2 then
		      n = n + right_serie.get_element(i)
		      
		    end if
		    
		    res.append_element(n)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_add(right_value as double) As clNumberDataSerie
		  dim res as new clNumberDataSerie(self.name+"+"+str(right_value))
		  
		  for i as integer = 0 to self.upper_bound
		    res.append_element(self.get_element(i) + right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_multiply(right_serie as clNumberDataSerie) As clNumberDataSerie
		  dim mx1 as integer = self.upper_bound
		  dim mx2 as integer = right_serie.upper_bound
		  dim mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  dim res as new clNumberDataSerie(self.name+"*"+right_serie.name)
		  for i as integer = 0 to mx0
		    dim n as double
		    
		    if i <= mx1 then
		      n = self.get_element(i)
		    end if
		    
		    if i<= mx2 then
		      n = n * right_serie.get_element(i)
		      
		    end if
		    
		    res.append_element(n)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_multiply(right_value as double) As clNumberDataSerie
		  dim res as new clNumberDataSerie(self.name+"*"+str(right_value))
		  
		  for i as integer = 0 to self.upper_bound
		    res.append_element(self.get_element(i) * right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_subtract(right_serie as clNumberDataSerie) As clNumberDataSerie
		  dim mx1 as integer = self.upper_bound
		  dim mx2 as integer = right_serie.upper_bound
		  dim mx0 as integer 
		  
		  if mx1 > mx2 then
		    mx0 = mx1
		  else
		    mx0=mx2
		  end if
		  
		  dim res as new clNumberDataSerie(self.name+"-"+right_serie.name)
		  for i as integer = 0 to mx0
		    dim n as double
		    
		    if i <= mx1 then
		      n = self.get_element(i)
		    end if
		    
		    if i<= mx2 then
		      n = n - right_serie.get_element(i)
		      
		    end if
		    
		    res.append_element(n)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_subtract(right_value as double) As clNumberDataSerie
		  dim res as new clNumberDataSerie(self.name+"-"+str(right_value))
		  
		  for i as integer = 0 to self.upper_bound
		    res.append_element(self.get_element(i) - right_value)
		    
		  next
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub reset()
		  redim items(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_element(the_element_index as integer, the_item as Variant)
		  If 0 <= the_element_index And  the_element_index <= items.Ubound Then
		    items(the_element_index) = the_item
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_length(the_length as integer)
		  
		  if items.Ubound > the_length then
		    Raise New clDataException("Column " + self.name + " contains more elements than expected")
		  end if
		  
		  
		  While items.Ubound < the_length-1
		    dim v as double = 0
		    items.Append(v)
		    
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function upper_bound() As integer
		  Return items.Ubound
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected items() As double
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="last_error_message"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="name"
			Group="Behavior"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
