#tag Class
Protected Class clNumberRangeFormatting
Implements NumberFormatInteraface
	#tag Method, Flags = &h0
		Sub AddRange(low_bound as double, high_bound as double, label as string)
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
		  
		  self.below_label = DefaultLowLabel
		  self.above_label = DefaultHighLabel
		  self.no_label = DefaultNoLabel
		  
		  if the_below_label.trim.len > 0 then self.below_label = the_below_label.trim
		  if the_above_label.trim.len > 0 then self.above_label = the_above_label.trim
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FormatNumber(the_value as Double) As String
		  // Part of the NumberFormatInteraface interface.
		  
		  if the_value < lowest_value then return below_label
		  
		  if the_value > highest_value then return above_label
		  
		  for i as integer = 0 to range_max.LastIndex 
		    if (self.range_min(i) <= the_value) and (the_value < self.range_max(i)) then 
		      return self.range_label(i)
		    end if
		    
		  next
		  
		  return self.no_label
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetInfo() As string
		  return "number range formatting"
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		above_label As string
	#tag EndProperty

	#tag Property, Flags = &h0
		below_label As string
	#tag EndProperty

	#tag Property, Flags = &h0
		highest_value As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		lowest_value As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		no_label As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private range_label() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private range_max() As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private range_min() As double
	#tag EndProperty


	#tag Constant, Name = DefaultHighLabel, Type = String, Dynamic = False, Default = \"High", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DefaultLowLabel, Type = String, Dynamic = False, Default = \"Low", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DefaultNoLabel, Type = String, Dynamic = False, Default = \"No label", Scope = Public
	#tag EndConstant


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
			InitialValue="'LOW"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="above_label"
			Visible=false
			Group="Behavior"
			InitialValue="HIGH"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="highest_value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="lowest_value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="no_label"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
