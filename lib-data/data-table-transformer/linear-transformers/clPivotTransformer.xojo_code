#tag Class
Protected Class clPivotTransformer
Inherits clLinearTransformer
	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ColumnNameGenerator(SourceColumnName as String, PivotValue as String) As String
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, prmColumnsToRetain() as string, prmPivotColumn as string, prmPivotValues() as string, prmColumnsToPivot() as string)
		  // Calling the overridden superclass constructor.
		   
		  super.Constructor(MainTable)
		  
		  self.ColumnsToRetain = prmColumnsToRetain
		  self.ColumnsToPivot = prmColumnsToPivot
		  self.PivotColumn = prmPivotColumn
		  self.PivotValues = prmPivotValues
		  
		  self.ColumnNameFunction = AddressOf GenerateDefaultColumnName
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(MainTable as clDataTable, prmColumnsToRetain() as string, prmPivotColumn as string, prmPivotValues() as string, prmColumnsToPivot() as string, prmColumnNameFunction as ColumnNameGenerator)
		  // Calling the overridden superclass constructor.
		   
		  super.Constructor(MainTable)
		  
		  self.ColumnsToRetain = prmColumnsToRetain
		  self.ColumnsToPivot = prmColumnsToPivot
		  self.PivotColumn = prmPivotColumn
		  self.PivotValues = prmPivotValues
		  
		  self.ColumnNameFunction = prmColumnNameFunction
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GenerateDefaultColumnName(SourceColumnName as String, PivotValue as String) As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Transform() As Boolean
		  // Calling the overridden superclass method.
		  
		  var source as clDataTable = self.GetTable(self.cInputConnectionName)
		  
		  var distinctTable as clDataTable = source.Groupby(self.ColumnsToRetain)
		  
		   
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		ColumnNameFunction As ColumnNameGenerator
	#tag EndProperty

	#tag Property, Flags = &h0
		ColumnsToPivot() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		ColumnsToRetain() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		PivotColumn As string
	#tag EndProperty

	#tag Property, Flags = &h0
		PivotValues() As String
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
		#tag ViewProperty
			Name="ColumnsToRetain()"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
