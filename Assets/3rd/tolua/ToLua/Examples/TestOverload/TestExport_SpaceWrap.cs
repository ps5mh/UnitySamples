﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class TestExport_SpaceWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(TestExport.Space));
		L.RegVar("World", get_World, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<TestExport.Space>.Check = CheckType;
		StackTraits<TestExport.Space>.Push = Push;
	}

	static void Push(IntPtr L, TestExport.Space arg)
	{
		ToLua.Push(L, arg);
	}

	static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(TestExport.Space), L, pos);
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_World(IntPtr L)
	{
		ToLua.Push(L, TestExport.Space.World);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int IntToEnum(IntPtr L)
	{
		int arg0 = (int)LuaDLL.lua_tonumber(L, 1);
		TestExport.Space o = (TestExport.Space)arg0;
		ToLua.Push(L, o);
		return 1;
	}
}

