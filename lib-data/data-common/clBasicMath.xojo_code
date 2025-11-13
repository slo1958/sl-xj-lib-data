#tag Class
Protected Class clBasicMath
	#tag Method, Flags = &h0
		Shared Function AggLabel(mode as AggMode) As string
		  select case mode
		    
		  case Aggmode.Sum
		    return "Sum"
		    
		  case AggMode.SumSquared
		    return "SumSquared"
		    
		  case AggMode.Average
		    Return "Average"
		    
		  case AggMode.AverageNonZero
		    Return "AverageNonZero"
		    
		  case AggMode.Count
		    return "Count"
		    
		  case AggMode.CountNonZero
		    return "CountNonZero"
		    
		  case AggMode.StandartDeviationPopulation
		    return "StandartDeviationPopulation"
		    
		  case AggMode.StandardDeviationSample
		    return "StandardDeviationSample"
		    
		  case AggMode.StandartDeviationPopulationNonZero
		    return "StandartDeviationPopulationNonZero"
		    
		  case AggMode.StandardDeviationSampleNonZero
		    return "StandardDeviationSampleNonZero" 
		    
		  case aggMode.Min
		    return "Min"
		    
		  case AggMode.max
		    return "Max"
		    
		  case else
		    return "?"
		    
		  end select
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Aggregate(mode as AggMode, values() as Currency) As Currency
		  select case mode
		    
		  case Aggmode.Sum
		    return sum(values)
		    
		  case AggMode.SumSquared
		    Raise New clDataException("Unimplemented method " + CurrentMethodName)
		    
		  case AggMode.Average
		    Return Average(values)
		    
		  case AggMode.AverageNonZero
		    Return AverageNonZero(values)
		    
		  case AggMode.Count
		    return count(values)
		    
		  case AggMode.CountNonZero
		    return CountNonZero(values)
		    
		  case AggMode.StandartDeviationPopulation
		    Raise New clDataException("Unimplemented method " + CurrentMethodName)
		    
		  case AggMode.StandardDeviationSample
		    Raise New clDataException("Unimplemented method " + CurrentMethodName)
		    
		  case AggMode.StandartDeviationPopulationNonZero
		    Raise New clDataException("Unimplemented method " + CurrentMethodName)
		    
		  case AggMode.StandardDeviationSampleNonZero
		    Raise New clDataException("Unimplemented method " + CurrentMethodName)
		    
		  case aggMode.Min
		    return Minimum(values)
		    
		  case AggMode.max
		    return Maximum(values)
		    
		  case else
		    return 0
		    
		  end select
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Aggregate(mode as AggMode, values() as double) As double
		  select case mode
		    
		  case Aggmode.Sum
		    return sum(values)
		    
		  case AggMode.SumSquared
		    return SumSquared(values)
		    
		  case AggMode.Average
		    Return Average(values)
		    
		  case AggMode.AverageNonZero
		    Return AverageNonZero(values)
		    
		  case AggMode.Count
		    return count(values)
		    
		  case AggMode.CountNonZero
		    return CountNonZero(values)
		    
		  case AggMode.StandartDeviationPopulation
		    return StandardDeviation(values, True)
		    
		  case AggMode.StandardDeviationSample
		    return StandardDeviation(values, False)
		    
		  case AggMode.StandartDeviationPopulationNonZero
		    return StandardDeviationNonZero(values, True)
		    
		  case AggMode.StandardDeviationSampleNonZero
		    return StandardDeviationNonZero(values, False)
		    
		  case aggMode.Min
		    return Minimum(values)
		    
		  case AggMode.max
		    return Maximum(values)
		    
		  case else
		    return 0
		    
		  end select
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Aggregate(mode as AggMode, values() as integer) As double
		  select case mode
		    
		  case Aggmode.Sum
		    return sum(values)
		    
		  case AggMode.SumSquared
		    Raise New clDataException("Unimplemented method " + CurrentMethodName)
		    
		  case AggMode.Average
		    Raise New clDataException("Unimplemented method " + CurrentMethodName)
		    
		  case AggMode.AverageNonZero
		    Raise New clDataException("Unimplemented method " + CurrentMethodName)
		    
		  case AggMode.Count
		    return count(values)
		    
		  case AggMode.CountNonZero
		    return CountNonZero(values)
		    
		  case AggMode.StandartDeviationPopulation
		    Raise New clDataException("Unimplemented method " + CurrentMethodName)
		    
		  case AggMode.StandardDeviationSample
		    Raise New clDataException("Unimplemented method " + CurrentMethodName)
		    
		  case AggMode.StandartDeviationPopulationNonZero
		    Raise New clDataException("Unimplemented method " + CurrentMethodName)
		    
		  case AggMode.StandardDeviationSampleNonZero
		    Raise New clDataException("Unimplemented method " + CurrentMethodName)
		    
		  case aggMode.Min
		    return Minimum(values)
		    
		  case AggMode.max
		    return Maximum(values)
		    
		  case else
		    return 0
		    
		  end select
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Average(values() as Currency) As Currency
		  var s As Currency
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
		Shared Function Average(values() as double) As double
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
		Shared Function AverageNonZero(values() as Currency) As Currency
		  var s As Currency
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
		Shared Function AverageNonZero(values() as double) As double
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
		Shared Function Count(values() as Currency) As integer
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
		Shared Function Count(values() as double) As integer
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
		Shared Function Count(values() as integer) As integer
		  
		  return values.Count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CountNonZero(values() as Currency) As integer
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
		Shared Function CountNonZero(values() as double) As integer
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
		Shared Function CountNonZero(values() as integer) As integer
		  var n as integer
		  
		  for each d as integer in values
		    if   (d <>0) then
		      n = n + 1
		      
		    end if
		    
		  Next
		  
		  return n
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Maximum(values() as Currency) As Currency
		  
		  if values.Count = 0 then return 0
		  
		  if values.Count = 1 then return values(0)
		  
		  var mx as Currency = values(0)
		  
		  for each v as double in values
		    mx = Max(mx, v)
		    
		  Next
		  
		  return mx
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Maximum(values() as DateTime) As DateTime
		  
		  if values.Count = 0 then return new DateTime(0)
		  
		  if values.Count = 1 then return values(0)
		  
		  var mx as DateTime = values(0)
		  
		  for each v as DateTime in values
		    if v > mx then mx = v
		    
		  Next
		  
		  return mx
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Maximum(values() as double) As double
		  
		  if values.Count = 0 then return 0
		  
		  if values.Count = 1 then return values(0)
		  
		  var mx as Double = values(0)
		  
		  for each v as double in values
		    mx = Max(mx, v)
		    
		  Next
		  
		  return mx
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Maximum(values() as integer) As integer
		  
		  if values.Count = 0 then return 0
		  
		  if values.Count = 1 then return values(0)
		  
		  var mx as integer = values(0)
		  
		  for each v as double in values
		    mx = Max(mx, v)
		    
		  Next
		  
		  return mx
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Minimum(values() as Currency) As Currency
		  
		  if values.Count = 0 then return 0
		  
		  if values.Count = 1 then return values(0)
		  
		  var mx as Currency = values(0)
		  
		  for each v as double in values
		    mx = Min(mx, v)
		    
		  Next
		  
		  return mx
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Minimum(values() as DateTime) As DateTime
		  
		  if values.Count = 0 then return new DateTime(0)
		  
		  if values.Count = 1 then return values(0)
		  
		  var mx as DateTime = values(0)
		  
		  for each v as DateTime in values
		    if v < mx then mx = v
		    
		  Next
		  
		  return mx
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Minimum(values() as double) As double
		  
		  if values.Count = 0 then return 0
		  
		  if values.Count = 1 then return values(0)
		  
		  var mx as Double = values(0)
		  
		  for each v as double in values
		    mx = Min(mx, v)
		    
		  Next
		  
		  return mx
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Minimum(values() as integer) As integer
		  
		  if values.Count = 0 then return 0
		  
		  if values.Count = 1 then return values(0)
		  
		  var mx as integer = values(0)
		  
		  for each v as double in values
		    mx = Min(mx, v)
		    
		  Next
		  
		  return mx
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function StandardDeviation(values() as double, is_population as boolean) As double
		  
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
		Shared Function StandardDeviationNonZero(values() as double, is_population as boolean) As double
		  
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
		Shared Function Sum(values() as Currency) As Currency
		  var retValue as Currency
		  
		  for each d as double in values
		    if not (d.IsNotANumber or d.IsInfinite) then
		      retValue = retValue + d
		      
		    end if
		    
		  next
		  
		  return retValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Sum(values() as double) As double
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
		Shared Function Sum(values() as integer) As integer
		  var retValue as integer
		  
		  for each d as integer in values
		    retValue = retValue + d
		    
		  next
		  
		  return retValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function SumSquared(values() as double) As double
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
