#tag Module
Protected Module clDataSerie_tests
	#tag Method, Flags = &h0
		Function filter01(the_row as integer, the_row_count as integer, the_column as string, the_value as variant, paramarray function_param as variant) As Boolean
		  Return True
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub tests()
		  
		  
		  test_001
		  test_003
		  test_004
		  test_005
		  test_006
		  test_007
		  test_008
		  test_009
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_001()
		  Dim test  As clDataSerie
		  
		  
		  test = New clDataSerie("test")
		  
		  test.append_element("hello")
		  test.append_element("world")
		  
		  
		  System.DebugLog("return " + Str(test.row_count))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_003()
		  Dim test  As clDataSerie
		  
		  
		  test = New clDataSerie("test", variant_array("aaa",123,True))
		  
		  Dim k As Integer =1
		  
		  
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
		  
		  c1.append_element("aaa1")
		  c1.append_element("bb1")
		  c1.append_element("cccc1")
		  c1.append_element("aaa2")
		  c1.append_element("bb2")
		  c1.append_element("cccc2")
		  c1.append_element("aaa3")
		  c1.append_element("bb3")
		  c1.append_element("cccc3")
		  c1.append_element("aaa4")
		  c1.append_element("bb4")
		  c1.append_element("cccc4")
		  
		  c2.append_element(12)
		  c2.append_element(345)
		  c2.append_element(5678)
		  
		  Dim f1() As variant
		  Dim f2() As variant
		  Dim f3() As Variant
		  
		  f1 = c1.apply_filter(AddressOf filter01)
		  
		  f2 = c1.apply_filter(AddressOf retain_serie_head, 7)
		  
		  f3 = c1.apply_filter(AddressOf retain_serie_tail)
		  
		  Dim c3 As New clDataSerie("test001", f1)
		  Dim c4 As New clDataSerie("test002", f1)
		  
		  
		  c1.debug_dump
		  
		  c2.debug_dump
		  
		  c3.debug_dump
		  
		  c4.debug_dump
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_007()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim c1 As New clDataSerie("premier") 
		  Dim c2 As New clDataSerie("second") 
		  
		  c1.append_element("123.4")
		  c1.append_element(140.5)
		  
		  c2.append_element("123.4")
		  c2.append_element(140.5)
		  c2.append_element("yoyo")
		  
		  Dim d1 As Double
		  Dim d2 As Double
		  
		  d1 = c1.sum
		  d2 = c2.sum
		  
		  
		  c1.debug_dump
		  
		  c2.debug_dump
		  
		  System.DebugLog(Str(d1))
		  System.DebugLog(str(d2))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_008()
		  System.DebugLog("START "+CurrentMethodName)
		  
		  Dim c1 As New clDataSerie("premier") 
		  Dim c2 As New clDataSerie("second") 
		  Dim c3 As New clDataSerie("parent")
		  Dim c4 As New clDataSerie("grand-parent")
		  
		  c1.append_element("123.4")
		  c1.append_element(140.5)
		  
		  c2.append_element("123.4")
		  c2.append_element(140.5)
		  c2.append_element("yoyo")
		  
		  
		  c3.append_element(c1)
		  c3.append_element(c2)
		  
		  c4.append_element(c3)
		  
		  Dim d1 As Double
		  Dim d2 As Double
		  
		  
		  c1.debug_dump
		  
		  c2.debug_dump
		  
		  c3.debug_dump 
		  
		  c4.debug_dump 
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test_009()
		  
		  Dim c1 As New clDataSerieMultiValued(Array("aaaa","bbbb"))
		  
		  System.DebugLog(c1.name)
		  
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
