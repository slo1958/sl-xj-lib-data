#tag Class
Protected Class clDataRow
Implements Xojo.Core.Iterable
	#tag Method, Flags = &h0
		Sub Constructor(the_row_label as string = "")
		  my_storage = New Dictionary
		  mutable_flag = False
		  my_label = the_row_label
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetIterator() As Xojo.Core.Iterator
		  // Part of the Xojo.Core.Iterable interface.
		  
		  Dim iteration_keys() As String
		  
		  For Each s As String In my_storage.Keys
		    iteration_keys.Append(s)
		    
		  Next
		  
		  Dim tmp_row_iterator As New clDataRowIterator(iteration_keys)
		  Return tmp_row_iterator 
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function get_cell(the_cell_name as String) As variant
		  If my_storage.HasKey(the_cell_name) Then
		    Return  my_storage.Value(the_cell_name) 
		    
		  Else
		    Return ""
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function namexxx() As string
		  Return my_label
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set_cell(the_cell_name as string, the_cell_value as Variant)
		  If my_storage.HasKey(the_cell_name) And Not mutable_flag Then
		    Raise New clDataException("Cannot update a non mutable element")
		    
		  Else
		    my_storage.Value(the_cell_name) = the_cell_value
		    
		  End If
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mutable_flag As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected my_label As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected my_storage As Dictionary
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
