#tag Module
Protected Module temp_store
	#tag Method, Flags = &h0
		Function doSomething(proc as MakeObject) As object()
		  
		  var obj() as object
		  obj.Add(proc.Invoke("2"))
		  obj.Add(proc.Invoke("1"))
		  
		  return obj
		  
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function MakeObject(ObjName as string) As object
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function objGen(n as string) As object
		  if n="1" then return new cl1
		  if n="2" then return new cl2
		  
		  return nil
		  
		End Function
	#tag EndMethod


	#tag Note, Name = example
		
		var k() as object = doSomething(addressof objgen)
	#tag EndNote


	#tag Property, Flags = &h0
		v As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		w As Integer
	#tag EndProperty


End Module
#tag EndModule
