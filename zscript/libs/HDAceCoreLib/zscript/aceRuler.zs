class AceRuler : Actor
{
	override void Tick()
	{
		if (!master || --ReactionTime <= 0)
		{
			Destroy();
			return;
		}

		double D2D = Distance2D(master);
		double D3D = Distance3D(master);
		master.A_Log(String.Format("Distance2D: %.2f (%.2fm); Distance3D: %.2f (%.2fm)", D2D, D2D / HDCONST_ONEMETRE, D3D, D3D / HDCONST_ONEMETRE));

		Super.Tick();
	}

	Default
	{
		+NOINTERACTION
		ReactionTime 35 * 20;
	}
}