class AceCoreGlobalStats : Thinker {

	int LevelsCompleted;

	static AceCoreGlobalStats Get() {
		HDCore.log('AceCoreLib', LOGGING_WARN, "AceCoreGlobalStats is Deprecated, contact developer to update!");

		ThinkerIterator it = ThinkerIterator.Create('AceCoreGlobalStats', STAT_STATIC);

        // If the thinker finds one, return it
		AceCoreGlobalStats t = null;
		while (t = AceCoreGlobalStats(it.Next())) return t;

        // Otherwise create a new one
		t = new('AceCoreGlobalStats');
		t.ChangeStatNum(STAT_STATIC);

		return t;
	}
}