#tag Class
Protected Class clBasicMath
	#tag Method, Flags = &h0
		Function Average(values() as double) As double
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
		Function AverageNonZero(values() as double) As double
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
		Function Count(values() as double) As integer
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
		Function CountNonZero(values() as double) As integer
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
		Function StandardDeviation(values() as double, is_population as boolean = False) As double
		  
		  var c as new clBasicMath
		  
		  var s1 As Double = c.sum(values)
		  var s2 as double = c.SumSquared(values)
		  var n as integer = c.Count(values)
		  
		  
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
		Function StandardDeviationNonZero(values() as double, is_population as boolean = False) As double
		  
		  var c as new clBasicMath
		  
		  var s1 As Double = c.sum(values)
		  var s2 as double = c.SumSquared(values)
		  var n as integer = c.CountNonZero(values)
		  
		  
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
		Function Sum(values() as double) As double
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
		Function SumSquared(values() as double) As double
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
