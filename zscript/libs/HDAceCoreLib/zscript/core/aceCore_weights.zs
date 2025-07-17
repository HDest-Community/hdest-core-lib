extend class AceCore
{
	static int GetWeightedResult(out Array<int> weights, int defRet = 0)
	{
		int sum = 0;
		for (int i = 0; i < weights.Size(); ++i)
		{
			sum += weights[i];
		}

		int rng = random[weightrand](0, sum);
		for (int i = 0; i < weights.Size(); ++i)
		{
			if (rng < weights[i])
			{
				return i;
			}
			rng -= weights[i];
		}
		return defRet;
	}
}