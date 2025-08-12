extend class AceCore {
	static int GetScaledChance(int lowest, int highest, int minLevel, int maxLevel) {
		HDCore.log('AceCoreLib', LOGGING_WARN, "GetScaledChance is Deprecated, contact developer to update!");

		if (level.MapName ~== "LOTSAGUN" || minLevel <= 0 && maxLevel <= 0 || maxLevel < minLevel) return highest;
		
		int levelCount = HDCoreGlobalStatsHandler.get().getValue('LevelsCompleted');
		if (levelCount >= maxLevel) return highest;
		if (levelCount <= minLevel) return lowest;

		double diff = abs(lowest - highest);
		double growthFac = (levelCount - minLevel) / double(maxLevel - minLevel);

		return int(clamp(ceil(lowest + diff * growthFac), 0, 256));
	}
}