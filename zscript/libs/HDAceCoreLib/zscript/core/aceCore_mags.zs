extend class AceCore
{
	static clearscope int GetLowestMag(HDMagAmmo stack, int minAmt)
	{
		if (!stack)
		{
			return -1;
		}

		int lowestIndex = stack.Mags.Size() - 1;
		int lowestCharge = stack.MaxPerUnit;
		for (int i = lowestIndex; i >= 0; --i)
		{
			if (stack.Mags[i] >= minAmt && stack.Mags[i] <= lowestCharge)
			{
				lowestIndex = i;
				lowestCharge = stack.Mags[i];
			}
		}

		// [Ace] Do a final check to see if the battery fulfills the conditions.
		// If there is only one mag and the amt is < minAmt, the loop above won't do much.
		if (stack.Mags[lowestIndex] >= minAmt)
		{
			return lowestIndex;
		}

		return -1;
	}

	static clearscope int GetHighestMag(HDMagAmmo stack, int maxAmt)
	{
		if (!stack)
		{
			return -1;
		}
		
		int minAmt = 0, lastIndex = -1; 
		for (int i = 0; i < stack.Mags.Size(); ++i)
		{
			if (stack.Mags[i] >= minAmt && stack.Mags[i] < maxAmt)
			{
				minAmt = stack.Mags[i];
				lastIndex = i;
			}
		}

		return lastIndex;
	}

	static clearscope int GetRealBatteryCharge(int curBattery, double div, bool useUpper)
	{
		if (curBattery == -1)
		{
			return -1;
		}
		double FracCharge = curBattery / div;
		return int(useUpper ? ceil(FracCharge) : floor(FracCharge));
	}

	static clearscope string, int, Color GetBatteryColor(int charge)
	{
		if (charge > 13)
		{
			return "CELLA0", Font.CR_GREEN, Color(255, 0, 255, 0);
		}
		else if (charge > 6)
		{
			return "CELLB0", Font.CR_YELLOW, Color(255, 255, 255, 0);
		}
		else if (charge > 0)
		{
			return "CELLC0", Font.CR_RED, Color(255, 255, 0, 0);
		}
		else
		{
			return "CELLD0", Font.CR_GRAY, Color(255, 64, 64, 64);
		}
	}
}