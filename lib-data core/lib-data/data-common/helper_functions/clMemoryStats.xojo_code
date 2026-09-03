#tag Class
Class clMemoryStats
	#tag Method, Flags = &h0
		Sub Add(obj as object)
		  
		  
		  if obj isa clDataTable then
		    tables.add(new clMemoryStatEntry( _
		    Introspection.GetType(obj).name _
		      ,clDataTable(obj).Name _
		    ))
		    
		  elseif obj isa clAbstractDataSerie then
		    series.add(new clMemoryStatEntry( _
		    Introspection.GetType(obj).name _
		    , clAbstractDataSerie(obj).FullName(true)) _
		    )
		    
		  elseif obj isa clDataPool then
		    Pools.add(new clMemoryStatEntry( _
		    Introspection.GetType(obj).name _
		    ,"" _
		    ))
		    
		  elseif obj isa clAbstractTransformer then
		    Transformers.add(new clMemoryStatEntry( _
		    Introspection.GetType(obj).name _
		      ,clAbstractTransformer(obj).GetLabel _
		    ))
		    
		  else
		    
		  end if
		  
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NumberOfDataPools() As integer
		  Return Pools.count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NumberOfDataSeries() As integer
		  Return Series.count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NumberOfTables() As integer
		  Return Tables.count
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NumberOfTransformers() As integer
		  Return Transformers.count
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Pools() As clMemoryStatEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		Series() As clMemoryStatEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		Tables() As clMemoryStatEntry
	#tag EndProperty

	#tag Property, Flags = &h0
		Transformers() As clMemoryStatEntry
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
