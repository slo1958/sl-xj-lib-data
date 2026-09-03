#tag Class
Protected Class clDecimal
	#tag Method, Flags = &h0
		Sub Constructor(theValue as clDecimal)
		  
		  mValue = theValue.mValue
		  mDecPos = theValue.mDecPos
		  mDecScale = theValue.mDecScale
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(theDecimalPosition as Integer)
		  
		  mValue = 0
		  
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
		  
		  mValue = 0
		  
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
		  
		  mValue = 0
		  
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
		  
		  mValue = 0
		  
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
		Function Operator_Add(rhs as clDecimal) As clDecimal
		  dim workValue as int64 
		  
		  dim ret as new clDecimal(self)
		  
		  ScaleSecondValue(rhs, workValue)
		  
		  ret.mValue = mValue + workValue
		  
		  return ret
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Add(d as double) As clDecimal
		  dim workValue as int64 
		  
		  dim ret as new clDecimal(self)
		  dim tmp as new clDecimal(mDecPos)
		  
		  tmp.Value = d
		  
		  ScaleSecondValue(tmp, workValue)
		  
		  ret.mValue = mValue + workValue
		  
		  return ret
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Add(n as integer) As clDecimal
		  dim workValue as int64 
		  
		  dim ret as new clDecimal(self)
		  dim tmp as new clDecimal(mDecPos)
		  
		  tmp.Value = n
		  
		  ScaleSecondValue(tmp, workValue)
		  
		  ret.mValue = mValue + workValue
		  
		  return ret
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Divide(n as clDecimal) As clDecimal
		  dim ret as new clDecimal(self)
		  
		  try
		    ret.mValue = mValue / n.mValue * n.mDecScale
		    
		  catch
		    ret.mValue = 0
		    
		  end try
		  
		  return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Divide(d as double) As clDecimal
		  dim ret as new clDecimal(self)
		  
		  
		  try 
		    ret.mValue = mValue / d
		    
		  catch 
		    ret.mValue = 0
		    
		  end try
		  
		  return ret
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Divide(n as integer) As clDecimal
		  dim ret as new clDecimal(self)
		  
		  try
		    ret.mValue = mValue / n
		    
		  catch
		    ret.mValue = 0
		    
		  end try
		  
		  return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Multiply(n as clDecimal) As clDecimal
		  dim ret as new clDecimal(self)
		  
		  try
		    ret.mValue = mValue * n.mValue / n.mDecScale
		    
		  catch
		    ret.mValue = 0
		    
		  end try
		  
		  return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Multiply(d as double) As clDecimal
		  dim ret as new clDecimal(self)
		  
		  try
		    ret.mValue = mValue * d
		    
		  catch
		    ret.mValue = 0
		    
		  end try
		  
		  return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Multiply(n as integer) As clDecimal
		  dim ret as new clDecimal(self)
		  
		  try
		    ret.mValue = mValue * n
		    
		  catch
		    ret.mValue = 0
		    
		  end try
		  
		  return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subtract(rhs as clDecimal) As clDecimal
		  dim workValue as int64
		  
		  
		  dim ret as new clDecimal(self)
		  
		  ScaleSecondValue(rhs, workValue )
		  
		  ret.mValue = mValue -  workValue
		  
		  return ret
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subtract(d as double) As clDecimal
		  dim workValue as int64
		  
		  dim ret as new clDecimal(self)
		  dim tmp as new clDecimal(mDecPos)
		  
		  tmp.Value = d
		  
		  ScaleSecondValue(tmp, workValue)
		  
		  ret.mValue = mValue - workValue
		  
		  return ret
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subtract(n as integer) As clDecimal
		  dim workValue as int64
		  
		  dim ret as new clDecimal(self)
		  dim tmp as new clDecimal(mDecPos)
		  
		  tmp.Value = n
		  
		  ScaleSecondValue(tmp, workValue)
		  
		  ret.mValue = mValue - workValue
		  
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
		  
		  return self.mValue 
		  
		  
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
		  
		  self.mValue = v
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ScaleSecondValue(SecondValue as clDecimal, byref workValue as int64)
		  workValue  = SecondValue .mValue
		  dim workScale as integer = SecondValue .mDecPos
		  
		  while workScale > mDecPos
		    workScale = workScale - 1
		    workValue = workValue / 10
		    
		  wend
		  
		  while workScale < mDecPos
		    workScale = workScale + 1
		    workValue = workValue * 10
		    
		  wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToclDecimal() As clDecimal
		  return new clDecimal(self)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDouble() As Double
		  return mValue / mDecScale
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToInteger() As Integer
		  return mValue / mDecScale
		  
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
		  
		  tmpstr = format(mValue , fmtStr)
		  
		  
		  if mDecPos > 0 then // insert '.' in string
		    tmpstr = tmpstr.Left(tmpstr.len - mDecPos) + "." + tmpstr.right(mDecPos)
		    
		  end  if
		  
		  
		  return tmpstr
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(assigns n as clDecimal)
		  dim workValue as int64
		  
		  
		  ScaleSecondValue(n, workValue)
		  
		  mValue = workValue
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(assigns d as double)
		  mValue = d * mDecScale
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(assigns n as integer)
		  mValue = n * mDecScale
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mDecPos As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDecScale As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValue As int64
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
