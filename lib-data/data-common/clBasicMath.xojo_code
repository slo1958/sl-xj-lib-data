#tag Class
Protected Class clBasicMath
	#tag Method, Flags = &h0
		Function average(values() as double) As double
		  var s As Double
		  var n as integer
		  
		  for each d as double in values
		    if not (d.IsNotANumber or d.IsInfinite) then
		      s = s + d
		      n = n + 1
		      
		    end if
		    
		  Next
		  
		  if n < 1 then return 0
		  
		  return s / n
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function average_non_zero(values() as double) As double
		  var s As Double
		  var n as integer
		  
		  for each d as double in values
		    if not (d.IsNotANumber or d.IsInfinite) and (d <>0) then 
		      s = s + d
		      n = n + 1
		      
		    end if
		    
		  Next
		  
		  if n < 1 then return 0
		  
		  return s / n
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function count(values() as double) As integer
		  var n as integer
		  
		  for each d as double in values
		    if not (d.IsNotANumber or d.IsInfinite) then
		      n = n + 1
		      
		    end if
		    
		  Next
		  
		  return n
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function count_non_zero(values() as double) As integer
		  var n as integer
		  
		  for each d as double in values
		    if not (d.IsNotANumber or d.IsInfinite) and (d <>0) then
		      n = n + 1
		      
		    end if
		    
		  Next
		  
		  return n
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function standard_deviation(values() as double, is_population as boolean = False) As double
		  
		  var c as new clBasicMath
		  
		  var s1 As Double = c.sum(values)
		  var s2 as double = c.sum_squared(values)
		  var n as integer = c.count(values)
		  
		  
		  if n < 2 then return 0
		  
		  var m as double = s1 / n
		  
		  if is_population then
		    return Sqrt((n * m * m - 2 * m *s1 + s2)  / (n))
		    
		  else
		    return Sqrt((n * m * m - 2 * m *s1 + s2)  / (n-1))
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function standard_deviation_non_zero(values() as double, is_population as boolean = False) As double
		  
		  var c as new clBasicMath
		  
		  var s1 As Double = c.sum(values)
		  var s2 as double = c.sum_squared(values)
		  var n as integer = c.count_non_zero(values)
		  
		  
		  if n < 2 then return 0
		  
		  var m as double = s1 / n
		  
		  if is_population then
		    return Sqrt((n * m * m - 2 * m *s1 + s2)  / (n))
		    
		  else
		    return Sqrt((n * m * m - 2 * m *s1 + s2)  / (n-1))
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function sum(values() as double) As double
		  var retValue as Double
		  
		  for each d as double in values
		    if not (d.IsNotANumber or d.IsInfinite) then
		      retValue = retValue + d
		      
		    end if
		    
		  next
		  
		  return retValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function sum_squared(values() as double) As double
		  var retValue as Double
		  
		  for each d as double in values
		    if not (d.IsNotANumber or d.IsInfinite) then
		      retValue = retValue + d * d
		      
		    end if
		    
		  next
		  
		  return retValue
		End Function
	#tag EndMethod


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
	#tag EndViewBehavior
End Class
#tag EndClass
