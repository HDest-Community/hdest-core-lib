extend class AceCore
{
	static int GetScaledChance(int lowest, int highest, int minLevel, int maxLevel)
	{
		if (level.MapName ~== "LOTSAGUN")
		{
			return highest;
		}
		
		int levelCount = AceCoreGlobalStats.Get().LevelsCompleted;

		if (minLevel <= 0 && maxLevel <= 0 || maxLevel < minLevel || levelCount >= maxLevel)
		{
			return highest;
		}

		if (levelCount <= minLevel)
		{
			return lowest;
		}

		double diff = abs(lowest - highest);
		double growthFac = (levelCount - minLevel) / double(maxLevel - minLevel);

		return int(clamp(ceil(lowest + diff * growthFac), 0, 256));
	}
}