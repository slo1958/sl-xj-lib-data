#tag Class
Protected Class clRangeFormatting
	#tag Method, Flags = &h0
		Sub add_range(low_bound as double, high_bound as double, label as string)
		  self.range_min.Add(low_bound)
		  self.range_max.Add(high_bound)
		  
		  if label.trim.len > 0 then 
		    self.range_label.Add(label.trim)
		    
		  else
		    self.range_label.Add("-")
		    
		  end if
		  
		  if low_bound < self.lowest_value or self.range_min.LastIndex = 0 then
		    self.lowest_value = low_bound
		    
		  end if
		  
		  if high_bound > self.highest_value or self.range_max.LastIndex = 0 then
		    self.highest_value = high_bound
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_below_label as string, the_above_label as string)
		  
		  if the_below_label.trim.len > 0 then self.below_label = the_below_label.trim
		  if the_above_label.trim.len > 0 then self.above_label = the_above_label.trim
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function range_format(the_value as Double) As String
		  
		  if the_value < lowest_value then return below_label
		  
		  if the_value > highest_value then return above_label
		  
		  for i as integer = 0 to range_max.LastIndex
		    System.DebugLog(str(the_value)+" " +str(i)+ " "+ str(self.range_min(i)) + " " + str(self.range_max(i))+" " + self.range_label(i))
		    if (self.range_min(i) <= the_value) and (the_value < self.range_max(i)) then 
		      System.DebugLog("use " + self.range_label(i))
		      return self.range_label(i)
		    end if
		    
		  next
		  
		  return "no range"
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		above_label As string = """HIGH"""
	#tag EndProperty

	#tag Property, Flags = &h0
		below_label As string = "'LOW"""
	#tag EndProperty

	#tag Property, Flags = &h0
		highest_value As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		lowest_value As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		range_label() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		range_max() As double
	#tag EndProperty

	#tag Property, Flags = &h0
		range_min() As double
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="below_label"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
