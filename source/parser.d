module parser;

import dlangui;
import std.string;
import std.conv;
import std.algorithm.sorting;

enum E_Operation
{
    Add,
    Sub,
    Mul,
    Div,
    Unk
}

struct OperationData
{
    double a;
    double b;
    E_Operation op;
}


class Parser
{
    public static OperationData ParseString(dstring InString, Window W) // @suppress(dscanner.style.phobos_naming_convention)
    {
        OperationData* Od = new OperationData;

        int[] OpIndex = [-1, -1, -1, -1];
        OpIndex[0] = to!int(InString.indexOf('+'));
        OpIndex[1] = to!int(InString.indexOf('-'));
        OpIndex[2] = to!int(InString.indexOf('*'));
        OpIndex[3] = to!int(InString.indexOf('/'));
        OpIndex.sort();


        Od.op = Parser.GetOperation(InString[OpIndex[3]]);
       
        Od.a = to!double(InString[0..OpIndex[3]]);
        Od.b = to!double(InString[OpIndex[3]+1..InString.length]);
        
        return *Od;
    }
    private static E_Operation GetOperation(dchar c) // @suppress(dscanner.style.phobos_naming_convention)
    {
        switch(c)
        {
          case '+': return E_Operation.Add;
          case '-': return E_Operation.Sub;
          case '*': return E_Operation.Mul;
          case '/': return E_Operation.Div;
          default:  return E_Operation.Unk;
        }
    }
}