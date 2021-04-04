#tag Module
Protected Module clDataSerie_tests
	#tag Method, Flags = &h0
		Function filter01(the_row as integer, the_column as string, the_value as variant) As Boolean
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub test_001()
		  Dim test  As clDataSerie
		  
		  
		  test = New clDataSerie("test")
		  
		  test.append_element("hello")
		  test.append_element("world")
		  
		  
		  system.DebugLog("return " + str(test.row_count))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_004()
		  Dim k As Variant
		  
		  Dim fld_folder As New FolderItem
		  Dim fld_file As FolderItem
		  
		  fld_folder = fld_folder.Child("test-data")
		  
		  fld_file = fld_folder.Child("myfile3_10K_tab.txt")
		  
		  
		  Dim ss1 As New clDataSerie(fld_file)
		  
		  Dim k2 As Integer = 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_005()
		  Dim k As Variant
		  
		  Dim fld_folder As New FolderItem
		  Dim fld_file_in As FolderItem
		  Dim fld_file_out As FolderItem
		  
		  fld_folder = fld_folder.Child("test-data")
		  
		  fld_file_in = fld_folder.Child("myfile3_10K_tab.txt")
		  
		  fld_file_out =  fld_folder.Child("mytest.txt")
		  
		  Dim ss1 As New clDataSerie(fld_file_in)
		  
		  ss1.save_as_text(fld_file_out, True)
		  
		  Dim k2 As Integer = 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_006()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim c1 As New clDataSerie("premier") 
		  Dim c2 As New clDataSerie("second") 
		  
		  c1.append_element("aaa")
		  c1.append_element("bb")
		  c1.append_element("cccc")
		  
		  c2.append_element(12)
		  c2.append_element(345)
		  c2.append_element(5678)
		  
		  Dim f1() As variant
		  
		  f1 = c1.apply_filter(AddressOf filter01)
		  
		  Dim c3 As New clDataSerie("test", f1)
		  
		  
		  c1.debug_dump
		  
		  c2.debug_dump
		  
		  c3.debug_dump
		End Sub
	#tag EndMethod


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
End Module
#tag EndModule
