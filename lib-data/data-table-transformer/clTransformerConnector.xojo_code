#tag Class
Protected Class clTransformerConnector
	#tag Method, Flags = &h0
		Sub Constructor(linkedTable as clDataTable)
		  
		  self.ConnectorLabel = GeneratedUniqueName
		  self.TableName = ""
		  self.Table = linkedTable
		  
		  self.EnableFlag = True
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(defaultTableName as string)
		  
		  self.ConnectorLabel =  GeneratedUniqueName
		  self.TableName = defaultTableName.trim
		  self.Table = nil
		  
		  self.EnableFlag = True
		  
		  return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GeneratedUniqueName() As string
		  
		  AnonymConnectorCounter = AnonymConnectorCounter + 1
		  
		  Return "connector" + Str(AnonymConnectorCounter)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetConnectorLabel() As String
		  return Self.ConnectorLabel
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetEmptyTable() As clDataTable
		  
		  self.Table = new clDataTable(self.TableName)
		  return self.Table
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetLabel() As string
		  
		  return self.ConnectorLabel
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetName(userName as string) As string
		  if userName.Trim.Length > 0 then
		    Return userName.Trim
		    
		  else
		    return GeneratedUniqueName
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTable() As clDataTable
		  
		  return self.Table
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTableName(AllowDefault as Boolean) As string
		  
		  if self.table <> nil then
		    return self.Table.Name
		    
		  elseif self.TableName.trim.Length > 0 then
		    return self.tableName.trim
		    
		  elseif AllowDefault then
		    return DefaultTableName
		    
		  else
		    return ""
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  
		  self.Table = nil 
		  return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetConnectorLabel(NewConnectorLabel as String)
		  Self.ConnectorLabel = NewConnectorLabel
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetTable(t as clDataTable)
		  
		  self.Table = t
		  
		  Return
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetTableName(n as String)
		  
		  self.TableName = n.trim
		  
		  Return
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Shared AnonymConnectorCounter As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			The label associated with the datatable used or produced by the connector.
			
			The label is expected to be unique across a set of transformers in a transformation pipeline.
		#tag EndNote
		Private ConnectorLabel As string
	#tag EndProperty

	#tag Property, Flags = &h0
		EnableFlag As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		SourceTransformer As clAbstractTransformer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Table As clDataTable
	#tag EndProperty

	#tag Property, Flags = &h21
		Private TableName As string
	#tag EndProperty


	#tag Constant, Name = DefaultTableName, Type = String, Dynamic = False, Default = \"Noname", Scope = Public
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
		#tag ViewProperty
			Name="EnableFlag"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
