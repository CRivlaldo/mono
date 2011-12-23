using System;
using System.IO;
using System.Reflection;

namespace MonoTest
{
	public class Test
	{
		public static void RunTest(int stringCount)
		{
			string codeBaseURI = Assembly.GetCallingAssembly().CodeBase;
			string dirPath = Path.GetDirectoryName( codeBaseURI.Replace( "file://", "" ) );
			string fileName = Path.Combine(dirPath, "Test.txt");
			try
			{
				using( StreamWriter writer = new StreamWriter( fileName, true ) )
				{
					for(int i=0; i<stringCount; i++)
						writer.Write( "Some not short and not very long string #" + (i+1).ToString() + "\r\n" );
				}
			}
			catch { }
		}
	}
}

