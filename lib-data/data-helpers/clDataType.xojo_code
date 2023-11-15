#tag Class
Protected Class clDataType
	#tag Method, Flags = &h0
		Shared Function CreateDataSerie(serie_name as string, serie_type as String) As clAbstractDataSerie
		  
		  select case serie_type
		    
		  case  StringValue
		    return new clStringDataSerie(serie_name)
		    
		  case NumberValue 
		    return new clNumberDataSerie(serie_name)
		    
		  case IntegerValue
		    return new clIntegerDataSerie(serie_name)
		     
		  case DateValue
		    return new clDateDataSerie(serie_name)
		    
		  case VariantValue
		    return new clDataSerie(serie_name)
		    
		  else
		    return new clDataSerie(serie_name)
		    
		  end select
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function TranslateFromSerie(serie as clAbstractDataSerie) As string
		  
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
