extend class AceCore
{
	static clearscope string MakeOxfordComma(Array<string> str)
	{
		string fullStr = "";
		int size = str.Size();
		for (int i = 0; i < size; ++i)
		{
			fullStr = fullStr..str[i];

			if (i + 2 == size)
			{
				fullStr = fullStr..(size > 2 ? "," : "").." and ";
			}
			else if (i + 2 < size)
			{
				fullStr = fullStr..", ";
			}
		}
		return fullStr;
	}
}