#tag Class
Protected Class clDataType
	#tag Method, Flags = &h0
		Shared Function CreateDataSerieFromClassName(SerieName as string, serie_type as String) As clAbstractDataSerie
		  
		  select case serie_type
		    
		  case  "clStringDataSerie"
		    return new clStringDataSerie(SerieName)
		    
		  case "clNumerDataSerie" 
		    return new clNumberDataSerie(SerieName)
		    
		  case "clIntegerDataSerie"
		    return new clIntegerDataSerie(SerieName)
		    
		  case "clDateDataSerie"
		    return new clDateDataSerie(SerieName)
		    
		  case "clDateTimeDataSerie"
		    return new clDateTimeDataSerie(SerieName)
		    
		  else
		    return new clDataSerie(SerieName)
		    
		  end select
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateDataSerieFromType(SerieName as string, serie_type as String) As clAbstractDataSerie
		  
		  select case serie_type
		    
		  case  StringValue
		    return new clStringDataSerie(SerieName)
		    
		  case NumberValue 
		    return new clNumberDataSerie(SerieName)
		    
		  case IntegerValue
		    return new clIntegerDataSerie(SerieName)
		    
		  case DateValue
		    return new clDateDataSerie(SerieName)
		    
		  case VariantValue
		    return new clDataSerie(SerieName)
		    
		  else
		    return new clDataSerie(SerieName)
		    
		  end select
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function TranslateFromSerieToClassName(serie as clAbstractDataSerie) As string
		  
		  Var t As Introspection.TypeInfo
		  t = Introspection.GetType(serie)
		  
		  return t.name
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function TranslateFromSerieToType(serie as clAbstractDataSerie) As string
		  
		  Var t As Introspection.TypeInfo
		  t = Introspection.GetType(serie)
		  
		  select case t.Name
		  case "clStringDataSerie"
		    return StringValue
		    
		  case "clNumberDataSerie"
		    return NumberValue
		    
		  case "clIntegerDataSerie"
		    return IntegerValue
		    
		  case "clDateDataSerie"
		    return DateValue
		    
		  else
		    return VariantValue
		    
		  end select
		  
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = DateValue, Type = String, Dynamic = False, Default = \"Date", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IntegerValue, Type = String, Dynamic = False, Default = \"Integer", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NumberValue, Type = String, Dynamic = False, Default = \"Number", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StringValue, Type = String, Dynamic = False, Default = \"string", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VariantValue, Type = String, Dynamic = False, Default = \"Generic", Scope = Public
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
	#tag EndViewBehavior
End Class
#tag EndClass
