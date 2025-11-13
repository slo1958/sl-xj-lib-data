#tag Class
Protected Class clDataType
	#tag Method, Flags = &h0
		Shared Function ConvertSerieTypeToCommonType(serie as clAbstractDataSerie) As string
		  
		  Var t As Introspection.TypeInfo
		  t = Introspection.GetType(serie)
		  
		  select case t.Name
		    
		  case "clBooleanDataSerie"
		    return BooleanValue
		    
		  case  "clCompressedDataSerie"
		    return StringValue
		    
		  case "clCurrencyDataSerie"
		    return CurrencyValue
		    
		  case "clDateDataSerie"
		    return DateValue
		    
		  case "clDateTimeDataSerie"
		    return DateTimeValue
		    
		  case "clIntegerDataSerie"
		    return IntegerValue
		    
		  case "clNumberDataSerie"
		    return NumberValue
		    
		  case "clStringDataSerie" 
		    return StringValue
		    
		  else
		    return VariantValue
		    
		  end select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ConvertVariantTypeToCommonType(v as variant) As string
		  select case v.Type
		    
		  case variant.TypeBoolean
		    return BooleanValue
		    
		  case variant.TypeCurrency
		    return CurrencyValue
		    
		  case variant.TypeDateTime
		    return DateTimeValue
		    
		  case variant.TypeDouble
		    return NumberValue
		    
		  case variant.TypeInt32
		    return IntegerValue
		    
		  case variant.TypeInt64
		    return IntegerValue
		    
		  case variant.TypeSingle
		    return NumberValue
		    
		  case variant.TypeString 
		    return StringValue
		    
		  else
		    return VariantValue
		    
		  end select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateDataSerieFromClassName(SerieName as string, serie_type as String) As clAbstractDataSerie
		  
		  select case serie_type
		    
		  case "clBooleanDataSerie"
		    return new clBooleanDataSerie(SerieName)
		    
		  case "clCompressedDataSerie"
		    return new clCompressedDataSerie(SerieName)
		    
		  case "clCurrencyDataSerie"
		    return new clCurrencyDataSerie(SerieName)
		    
		  case "clDateDataSerie"
		    return new clDateDataSerie(SerieName)
		    
		  case "clDateTimeDataSerie"
		    return new clDateTimeDataSerie(SerieName)
		    
		  case "clIntegerDataSerie"
		    return new clIntegerDataSerie(SerieName)
		    
		  case "clNumerDataSerie" 
		    return new clNumberDataSerie(SerieName)
		    
		  case  "clStringDataSerie"
		    return new clStringDataSerie(SerieName)
		    
		  else
		    return new clDataSerie(SerieName)
		    
		  end select
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateDataSerieFromType(SerieName as string, serie_type as String) As clAbstractDataSerie
		  
		  select case serie_type
		    
		  case BooleanValue
		    return new clBooleanDataSerie(SerieName)
		    
		  case DateValue
		    return new clDateDataSerie(SerieName)
		    
		  case DateTimeValue
		    return new clDateTimeDataSerie(SerieName)
		    
		  case IntegerValue
		    return new clIntegerDataSerie(SerieName)
		    
		  case NumberValue 
		    return new clNumberDataSerie(SerieName)
		    
		  case  StringValue
		    return new clStringDataSerie(SerieName)
		    
		  case CurrencyValue
		    return new clCurrencyDataSerie(SerieName)
		    
		  case UndefinedType
		    return new clDataSerie(SerieName)
		    
		  case VariantValue
		    return new clDataSerie(SerieName)
		    
		  else
		    return new clDataSerie(SerieName)
		    
		  end select
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateDataSerieFromVariantType(SerieName as string, v as Variant) As clAbstractDataSerie
		  select case v.Type
		    
		  case variant.TypeBoolean
		    return new clBooleanDataSerie(SerieName)
		    
		  case variant.TypeCurrency
		    return new clCurrencyDataSerie(SerieName)
		    
		  case variant.TypeDateTime
		    return new clDateTimeDataSerie(SerieName)
		    
		  case variant.TypeDouble
		    return new clNumberDataSerie(SerieName)
		    
		  case variant.TypeInt32
		    return new clIntegerDataSerie(SerieName)
		    
		  case variant.TypeInt64
		    return new clIntegerDataSerie(SerieName)
		    
		  case variant.TypeSingle
		    return new clNumberDataSerie(SerieName)
		    
		  case variant.TypeString 
		    return new clStringDataSerie(SerieName)
		    
		  else
		    return new clDataSerie(SerieName)
		    
		  end select
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetClassName(serie as clAbstractDataSerie) As string
		  
		  Var t As Introspection.TypeInfo
		  t = Introspection.GetType(serie)
		  
		  return t.name
		  
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = BooleanValue, Type = String, Dynamic = False, Default = \"Boolean", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CurrencyValue, Type = String, Dynamic = False, Default = \"Currency", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DateTimeValue, Type = String, Dynamic = False, Default = \"DateTime", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DateValue, Type = String, Dynamic = False, Default = \"Date", Scope = Public
	#tag EndConstant

	#tag Constant, Name = IntegerValue, Type = String, Dynamic = False, Default = \"Integer", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NumberValue, Type = String, Dynamic = False, Default = \"Number", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StringValue, Type = String, Dynamic = False, Default = \"string", Scope = Public
	#tag EndConstant

	#tag Constant, Name = UndefinedType, Type = String, Dynamic = False, Default = \"Undefined", Scope = Public
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
