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
		  self.PivotColumnName = prmPivotColumn
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
		  self.PivotColumnName = prmPivotColumn
		  self.PivotValues = prmPivotValues
		  
		  self.ColumnNameFunction = prmColumnNameFunction
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GenerateDefaultColumnName(SourceColumnName as String, PivotValue as String) As String
		  if PivotValue = "" then
		    return "Other_" + SourceColumnName.trim
		    
		  else
		    return PivotValue.Trim + "_" + SourceColumnName.Trim
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Transform() As Boolean
		  // Calling the overridden superclass method.
		  
		  var source as clDataTable = self.GetInputTable(self.cInputConnectorName) 
		  
		  var dimensionColumns() as clAbstractDataSerie = source.GetColumns(ColumnsToRetain, false)
		  var pivotColumn as clAbstractDataSerie = source.GetColumn(PivotColumnName)
		  
		  var tempMeasureColumns() as clAbstractDataSerie = source.GetColumns(ColumnsToPivot, false)
		  
		  var measurePairs() as pair
		  var measureMapping() as Dictionary
		  
		  for each col as clAbstractDataSerie in tempMeasureColumns
		    var d as new Dictionary
		    
		    for each pvl as string in PivotValues
		      d.value(pvl) = ColumnNameFunction.Invoke(col.name, pvl)
		      
		    next
		    
		    measurePairs.Add(col:mdEnumerations.AggMode.Sum)
		    measureMapping.add(d)
		    
		  next
		  
		  var connector as clTransformerConnector
		  
		  var cg1 as new clSeriesGroupAndPivot(dimensionColumns, measurePairs, pivotColumn, measureMapping)
		  
		  connector = self.GetOutputConnector(cOutputConnectorName)
		  
		  var t as new clDataTable(connector.GetTableName(false), cg1.Flattened)
		  
		  t.AddMetaData("Transformation","Pivotting  " + source.Name + " on " + String.FromArray(ColumnsToRetain,","))
		  
		  Self.SetOutputTable(cOutputConnectorName, t)
		  
		  return t <> nil
		  
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
		PivotColumnName As string
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
			Name="PivotColumnName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
