#tag Class
Protected Class clLibDataExample_017
Inherits clLibDataExample
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Method, Flags = &h0
		Function describe() As string()
		  
		  var returnValue() as string = Super.describe()
		  
		  returnValue.Add("- load a table from db")
		  returnValue.Add("- save table to db")
		  returnValue.Add("- repeat with another table")
		  returnValue.Add("- merge in memory using clDataTable")
		  returnValue.add("- merge in db using DBAppendWriter()")
		  
		  return returnValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function run(log as LogMessageInterface) As TableColumnReaderInterface()
		  
		  //  Example_016
		  //  - test date 
		  //  
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  log.start_exec(CurrentMethodName)
		  
		  
		  var db as new SQLiteDatabase
		  
		  Try
		    db.Connect
		    
		  Catch error As DatabaseException
		    System.DebugLog("DB Connection Error: " + error.Message)
		    
		  End Try
		  
		  var dbrow as  DatabaseRow
		  
		  //test1
		  db.ExecuteSQL("create table test1(ID INTEGER NOT NULL, aaa varchar(20), bbb integer, ccc float, PRIMARY KEY(ID))")
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="Belgium1"
		  dbrow.Column("bbb")= 32
		  dbrow.Column("ccc") = 10.3
		  db.AddRow("test1", dbrow)
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="France1"
		  dbrow.Column("bbb")= 3
		  dbrow.Column("ccc") = 14.6
		  db.AddRow("test1", dbrow)
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="Italy1"
		  dbrow.Column("bbb")= 39
		  dbrow.Column("ccc") = 12.7
		  db.AddRow("test1", dbrow)
		  
		  //db.CommitTransaction
		  
		  
		  
		  //test3
		  db.ExecuteSQL("create table test3(ID INTEGER NOT NULL, aaa varchar(20), bbb integer, ddd float, PRIMARY KEY(ID))")
		  
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="Belgium3"
		  dbrow.Column("bbb")= 32
		  dbrow.Column("ddd") = 30.3
		  db.AddRow("test3", dbrow)
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="France3"
		  dbrow.Column("bbb")= 3
		  dbrow.Column("ddd") = 34.6
		  db.AddRow("test3", dbrow)
		  
		  dbrow = new DatabaseRow
		  dbrow.Column("aaa")="Italy3"
		  dbrow.Column("bbb")= 39
		  dbrow.Column("ddd") = 32.7
		  db.AddRow("test3", dbrow)
		  
		  
		  var my_table1 as new clDataTable(new clDBReader(db.SelectSql("select * from test1")))
		  my_table1.rename("test2")
		  my_table1.save(new clDBWriter(new clSqliteDBAccess(db)))
		  
		  var my_table2 as new clDataTable(new clDBReader(db.SelectSql("select * from test2")))
		  
		  call check_table(log,"Test1/Test2", my_table1, my_table2)
		  
		  
		  
		  var my_table3 as new clDataTable(new clDBReader(db.SelectSql("select * from test3")))
		  my_table3.rename("test4")
		  my_table3.save(new clDBAppendWriter(new clSqliteDBAccess(db)))
		  
		  var my_table4 as new clDataTable(new clDBReader(db.SelectSql("select * from test4")))
		  
		  call check_table(log,"Test3/Test4", my_table3, my_table4)
		  
		  
		  var my_table5 as new clDataTable(new clDBReader(db.SelectSQL("select * from test1")))
		  
		  var my_table6 as new clDataTable(new clDBReader(db.SelectSQL("select * from test3")))
		  
		  // create expected ds
		  var my_table7 as clDataTable = my_table5.clone
		  my_table7.append_from_column_source(my_table6)
		  
		  
		  // add rows from test3 to test2
		  my_table6.rename("test2")
		  my_table6.save(new clDBAppendWriter(new clSqliteDBAccess(db)))
		  
		  
		  var my_table8 as new clDataTable(new clDBReader(db.SelectSQL("select * from test2")))
		  
		  call check_table(log,"Test7/Test8", my_table7, my_table8)
		  
		  my_table2.rename("test2:after save/load test1")
		  my_table4.rename("test4:after save/load test3")
		  
		  my_table7.rename("loaded from merged in memory data tables")
		  my_table8.rename("loaded from merged db tables")
		  
		  var ret() as TableColumnReaderInterface
		  
		  ret.add(my_table1)
		  ret.add(my_table2)
		  
		  ret.add(my_table3)
		  ret.add(my_table4)
		  
		  ret.add(my_table7)
		  ret.add(my_table8)
		  
		  return ret
		  
		End Function
	#tag EndMethod


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
