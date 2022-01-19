import dlangui;
import std.conv;
import parser;

mixin APP_ENTRY_POINT;

/// Entry point for dlangui based application
extern (C) int UIAppMain(string[] args)
{
	// Create window
	// arguments: title, parent, flags = WindowFlag.Resizable, width = 0, height = 0
	Window window = Platform.instance.createWindow("My App", null);

	// Load layout from views/MainWindow.dml and show it
	// Use readText("views/MainWindow.dml") from std.file to allow dynamic layout editting without recompilation
	auto layout = parseML(import("MainWindow.dml"));
	window.mainWidget = layout;

	auto Expression = window.mainWidget.childById!EditLine("Expression");
	auto Result = window.mainWidget.childById!EditLine("Result");
	auto OperationButton = window.mainWidget.childById!Button("OperationButton");


	OperationButton.click = delegate(Widget w)
	{
		auto res = Parser.ParseString(Expression.text, window);
		double c = 0.0;

		switch(res.op)
		{
			case E_Operation.Add:
			{
				c = res.a + res.b;
			}break;
			case E_Operation.Sub:
			{
				c = res.a - res.b;
			}break;
			case E_Operation.Mul:
			{
				c = res.a * res.b;
			}break;
			case E_Operation.Div:
			{
				c = res.a / res.b;
			}break;
			default:
		    {
			    c = 0.0;
		    }
		}

		Result.text = to!dstring(c);

		return true;
	};

	// Show window
	window.show();

	// Run message loop
	return Platform.instance.enterMessageLoop();
}
