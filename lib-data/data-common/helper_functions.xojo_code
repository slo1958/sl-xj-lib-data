#tag Module
Protected Module helper_functions
	#tag Method, Flags = &h0
		Function AsString(extends c as clAbstractDataSerie, ColumnName as string = "") As clStringDataSerie
		  var res as   clStringDataSerie
		  
		  if ColumnName.Length = 0 then
		    res = new clStringDataSerie(c.name + " as string")
		    
		  else
		    res = new clStringDataSerie(ColumnName)
		    
		  end if
		  
		  for index as integer = 0 to c.LastIndex
		    res.AddElement(c.GetElementAsString(index))
		    
		  next
		  
		  return res
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExtractVariantArray(v as Variant) As variant()
		  var res() as variant
		  
		  if not v.IsArray then return res
		  
		  Select case v.ArrayElementType 
		    
		  case variant.TypeBoolean 
		    var s() as Boolean = v
		    
		    for each a as boolean in s
		      res.add(a)
		      
		    next
		    
		  case Variant.TypeInteger, Variant.TypeInt32, Variant.TypeInt64
		    var s() as integer = v
		    
		    for each a as integer in s
		      res.add(a)
		      
		    next
		    
		    
		  case Variant.TypeDouble, variant.TypeSingle
		    var s() as double = v
		    
		    for each a as double in s
		      res.add(a)
		      
		    next
		    
		  case Variant.TypeCurrency
		    var s() as Currency = v
		    
		    for each a as Currency in s
		      res.add(a)
		      
		    next
		    
		    
		  case Variant.TypeString
		    var s() as string = v
		    
		    for each a as string in s
		      res.add(a)
		      
		    next
		    
		  end Select
		  
		  
		  return res
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMemoryStats() As clMemoryStats
		  
		  var ms as new clMemoryStats
		  
		  Var o As Runtime.ObjectIterator = Runtime.IterateObjects
		  o.Reset
		  
		  While o.MoveNext
		    ms.Add(o.Current)
		    
		    
		  wend
		  
		  return ms
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PairArray(paramarray items as pair) As Pair()
		  var ret() As pair
		  
		  For Each item As variant In items
		    ret.Add(item)
		    
		  Next
		  
		  Return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SerieArray(paramarray series as clAbstractDataSerie) As clAbstractDataSerie()
		  var tmp() As clAbstractDataSerie
		  
		  For Each c As clAbstractDataSerie In series
		    tmp.Add(c)
		    
		  Next
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StandardSerieAllocatorFromType(NewColumnName as string, NewColumnType as string) As clAbstractDataSerie
		  
		  return clDataType.CreateDataSerieFromType(NewColumnName, NewColumnType)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringArray(paramarray items as string) As string()
		  var ret() As String
		  
		  For Each item As String In items
		    ret.Add(item)  
		    
		  Next
		  
		  Return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function VariantArray(paramarray items as variant) As variant()
		  var ret() As variant
		  
		  For Each item As variant In items
		    ret.Add(item)
		    
		  Next
		  
		  Return ret
		  
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
End Module
#tag EndModule
