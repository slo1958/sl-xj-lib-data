#tag Module
Protected Module mdEnumerations
	#tag Enum, Name = AggMode, Type = Integer, Flags = &h0
		Sum
		  Average
		  AverageNonZero
		  Count
		  CountNonZero
		  StandartDeviationPopulation
		  StandartDeviationPopulationNonZero
		  SumSquared
		  StandardDeviationSample
		  StandardDeviationSampleNonZero
		  Min
		Max
	#tag EndEnum

	#tag Enum, Name = FilterMode, Type = Integer, Flags = &h0
		IncludeSelected
		ExcludeSelected
	#tag EndEnum

	#tag Enum, Name = JoinMode, Flags = &h0
		OuterJoin
		  InnerJoin
		LeftJoin
	#tag EndEnum

	#tag Enum, Name = SortOrder, Flags = &h0
		Ascending
		Descending
	#tag EndEnum


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
