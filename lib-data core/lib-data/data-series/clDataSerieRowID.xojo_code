#tag Class
Protected Class clDataSerieRowID
Inherits clDataSerie
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Sub AddElement(the_item as Variant)
		  
		  Self.last_index  = Self.last_index  + 1
		  
		  Super.AddElement(self.last_index)
		  
		  // Super.AddElement(Str(Self.last_index ))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone(NewName as string = "") As clDataSerieRowID
		  
		  var tmp As New clDataSerieRowID(StringWithDefault(NewName, self.name))
		  
		  self.CloneInfo(tmp)
		  
		  tmp. AddSourceToMetadata("clone from " + self.FullName)
		  
		  For Each v As variant In Self.items
		    tmp.AddElement(v)
		    
		  Next
		  
		  Return tmp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(the_label as string)
		  // Calling the overridden superclass constructor.
		  Super.Constructor(the_label)
		  Self.last_index = -1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetElements()
		  
		  self.Metadata = new clMetadata
		  self.Metadata.Add("type","index")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetElement(ElementIndex as integer, the_item as Variant)
		  Return
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetLength(the_length as integer, DefaultValue as variant)
		  While items.LastIndex < the_length-1
		    Self.last_index  = Self.last_index  +1
		    items.Add(Str(Self.last_index ))
		    
		  Wend
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		last_index As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="DisplayTitle"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
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
			Name="last_index"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
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
			Name="name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
