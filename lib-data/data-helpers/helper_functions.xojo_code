#tag Module
Protected Module helper_functions
	#tag Method, Flags = &h0
		Function make_variant_array(v as Variant) As variant()
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
		Function serie_array(paramarray series as clAbstractDataSerie) As clAbstractDataSerie()
		  var tmp() As clAbstractDataSerie
		  
		  For Each c As clAbstractDataSerie In series
		    tmp.Append(c)
		    
		  Next
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function standard_serie_allocator(column_name as string, column_type_info as string) As clAbstractDataSerie
		  
		  select case column_type_info
		    
		  case "clNumberDataSerie"
		    return new clNumberDataSerie(column_name)
		    
		  case "clIntegerDataSerie"
		    return new clIntegerDataSerie(column_name)
		    
		  case "clStringDataSerie"
		    return new clStringDataSerie(column_name)
		    
		  else
		    return new clDataSerie(column_name)
		    
		  end select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function string_array(paramarray  items as string) As string()
		  var ret() As String
		  
		  For Each item As String In items
		    ret.append(item)  
		    
		  Next
		  
		  Return ret
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function variant_array(paramarray  items as variant) As variant()
		  var ret() As variant
		  
		  For Each item As variant In items
		    ret.append(item)
		    
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
