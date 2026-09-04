#tag Class
Protected Class clDecimal
	#tag Method, Flags = &h0
		Sub Constructor(theValue as clDecimal)
		  
		  mBaseValue = theValue.mBaseValue
		  mDecPos = theValue.mDecPos
		  mDecScale = theValue.mDecScale
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(theDecimalPosition as Integer)
		  
		  mBaseValue = 0
		  
		  if theDecimalPosition <=0 then
		    mDecPos = 0
		    mDecScale = 1
		    
		  else
		    mDecPos = theDecimalPosition
		    mDecScale = 10 ^ theDecimalPosition
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(theDecimalPosition as Integer, theValue as clDecimal)
		  
		  mBaseValue = 0
		  
		  if theDecimalPosition <=0 then
		    mDecPos = 0
		    mDecScale = 1
		    
		  else
		    mDecPos = theDecimalPosition
		    mDecScale = 10 ^ theDecimalPosition
		    
		  end if
		  
		  Value = theValue
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(theDecimalPosition as Integer, theValue as double)
		  
		  mBaseValue = 0
		  
		  if theDecimalPosition <=0 then
		    mDecPos = 0
		    mDecScale = 1
		    
		  else
		    mDecPos = theDecimalPosition
		    mDecScale = 10 ^ theDecimalPosition
		    
		  end if
		  
		  Value = theValue
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(theDecimalPosition as Integer, theValue as integer)
		  
		  mBaseValue = 0
		  
		  if theDecimalPosition <=0 then
		    mDecPos = 0
		    mDecScale = 1
		    
		  else
		    mDecPos = theDecimalPosition
		    mDecScale = 10 ^ theDecimalPosition
		    
		  end if
		  
		  Value = theValue
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getAdjustedBaseValue(SecondValue as clDecimal) As int64
		  
		  // Get the scaled value and the scale
		  var workValue as int64 = SecondValue .mBaseValue
		  dim workDecPos as integer = SecondValue .mDecPos
		  
		  // Adjust the scale down
		  while workDecPos > mDecPos
		    workDecPos = workDecPos - 1
		    workValue = workValue / 10
		    
		  wend
		  
		  // adjust the scale up, adjusting the value
		  while workDecPos < mDecPos
		    workDecPos = workDecPos + 1
		    workValue = workValue * 10
		    
		  wend
		  
		  return workValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Add(rhs as clDecimal) As clDecimal
		  
		  dim ret as new clDecimal(self)
		  
		  var workvalue as int64 = getAdjustedBaseValue(rhs)
		  
		  ret.mBaseValue = mBaseValue + workValue
		  
		  return ret
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Add(rhs as double) As clDecimal
		  
		  dim ret as new clDecimal(self)
		  
		  dim tmp as new clDecimal(mDecPos, rhs)
		  
		  ret.mBaseValue = mBaseValue + tmp.mBaseValue
		  
		  return ret
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Add(rhs as integer) As clDecimal
		  
		  dim ret as new clDecimal(self)
		  
		  dim tmp as new clDecimal(mDecPos, rhs)
		  
		  ret.mBaseValue = mBaseValue + tmp.mBaseValue
		  
		  return ret
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Divide(rhs as clDecimal) As clDecimal
		  dim ret as new clDecimal(self)
		  
		  try
		    var dtmp as double = rhs.ToDouble
		     
		    ret.mBaseValue = mBaseValue / dtmp
		    
		    //ret.mBaseValue = mBaseValue / n.mBaseValue * n.mDecScale
		    
		  catch
		    ret.mBaseValue = 0
		    
		  end try
		  
		  return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Divide(d as double) As clDecimal
		  dim ret as new clDecimal(self)
		  
		  
		  try 
		    ret.mBaseValue = mBaseValue / d
		    
		  catch 
		    ret.mBaseValue = 0
		    
		  end try
		  
		  return ret
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Divide(n as integer) As clDecimal
		  dim ret as new clDecimal(self)
		  
		  try
		    ret.mBaseValue = mBaseValue / n
		    
		  catch
		    ret.mBaseValue = 0
		    
		  end try
		  
		  return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Multiply(n as clDecimal) As clDecimal
		  dim ret as new clDecimal(self)
		  
		  try
		    var tmp_double as double = n.ToDouble
		    
		    ret.mBaseValue = mBaseValue * tmp_double
		    
		  catch
		    ret.mBaseValue = 0
		    
		  end try
		  
		  return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Multiply(d as double) As clDecimal
		  dim ret as new clDecimal(self)
		  
		  try
		    ret.mBaseValue = mBaseValue * d
		    
		  catch
		    ret.mBaseValue = 0
		    
		  end try
		  
		  return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Multiply(n as integer) As clDecimal
		  dim ret as new clDecimal(self)
		  
		  try
		    ret.mBaseValue = mBaseValue * n
		    
		  catch
		    ret.mBaseValue = 0
		    
		  end try
		  
		  return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subtract(rhs as clDecimal) As clDecimal
		  
		  dim ret as new clDecimal(self)
		  
		  var workValue as int64 = getAdjustedBaseValue(rhs)
		  
		  ret.mBaseValue = mBaseValue -  workValue
		  
		  return ret
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subtract(d as double) As clDecimal
		  
		  dim ret as new clDecimal(self)
		  dim tmp as new clDecimal(mDecPos)
		  
		  tmp.Value = d
		  
		  var workValue as int64 = getAdjustedBaseValue(tmp)
		  
		  ret.mBaseValue = mBaseValue - workValue
		  
		  return ret
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subtract(n as integer) As clDecimal
		  
		  dim ret as new clDecimal(self)
		  dim tmp as new clDecimal(mDecPos)
		  
		  tmp.Value = n
		  
		  var workValue as int64 = getAdjustedBaseValue(tmp)
		  
		  ret.mBaseValue = mBaseValue - workValue
		  
		  return ret
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScaledValue() As int64
		  //
		  // Get the value, without applying any scaling
		  // Expected to be used to transfer internal value from another clDecimal without going thru descaling and rescaling
		  //
		  // Parameters:
		  // -
		  // Returns:
		  // Scaled value
		  
		  return self.mBaseValue 
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ScaledValue(assigns v as int64)
		  //
		  // Set the value, without applying any scaling
		  // Expected to be used to transfer internal value from another clDecimal without going thru descaling and rescaling
		  //
		  // Parameters:
		  // - v: scaled value
		  //
		  
		  self.mBaseValue = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToclDecimal() As clDecimal
		  return new clDecimal(self)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDouble() As Double
		  return mBaseValue / mDecScale
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToInteger() As Integer
		  return mBaseValue / mDecScale
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As string
		  dim fmtStr as string
		  dim tmpstr as string
		  
		  fmtStr = "-#0"
		  
		  if mDecPos > 0 then
		    fmtStr = fmtStr+left("0000000000",mDecPos)
		    
		  end if
		  
		  tmpstr = format(mBaseValue , fmtStr)
		  
		  
		  if mDecPos > 0 then // insert '.' in string
		    tmpstr = tmpstr.Left(tmpstr.len - mDecPos) + "." + tmpstr.right(mDecPos)
		    
		  end  if
		  
		  
		  return tmpstr
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(assigns n as clDecimal)
		  
		  
		  mBaseValue = getAdjustedBaseValue(n)
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(assigns d as double)
		  mBaseValue = d * mDecScale
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(assigns n as integer)
		  mBaseValue = n * mDecScale
		End Sub
	#tag EndMethod


	#tag Note, Name = Important note
		
		clDecimal is under dev
		There are no test cases yet for clDecimal
		
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private mBaseValue As int64
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDecPos As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDecScale As Integer
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
	#tag EndViewBehavior
End Class
#tag EndClass
