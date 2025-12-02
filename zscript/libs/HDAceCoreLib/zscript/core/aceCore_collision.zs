extend class AceCore
{
	static void DrawCollisionBox(Actor a, Color col = 0xFF0000, double density = 0.25, double psize = 0.5)
	{
		HDCore.log('AceCoreLib', LOGGING_WARN, "AceCore.DrawCollisionBox() is deprecated, contact developer to update!");

		// [Ace] Dots.
		a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, 0, 0, a.Height);
		a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, a.Radius, 0, a.Height / 2);
		a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, 0, a.Radius, a.Height / 2);
		a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, 0, 0, a.Height / 2);
		a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, 0, -a.Radius, a.Height / 2);
		a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, -a.Radius, 0, a.Height / 2);
		a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, 0, 0, 0);

		// [Ace] Horizontal lines.
		for (double i = -a.Radius; i <= a.Radius; i += density)
		{
			a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, a.Radius, i, 0);
			a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, -a.Radius, i, 0);
			a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, i, a.Radius, 0);
			a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, i, -a.Radius, 0);
			a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, a.Radius, i, a.Height);
			a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, -a.Radius, i, a.Height);
			a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, i, a.Radius, a.Height);
			a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, i, -a.Radius, a.Height);
		}

		// [Ace] Vertical lines.
		for (double i = 0; i <= a.Height; i += density)
		{
			a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, a.Radius, a.Radius, i);
			a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, a.Radius, -a.Radius, i);
			a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, -a.Radius, a.Radius, i);
			a.A_SpawnParticle(col, SPF_FULLBRIGHT, 1, psize, 0, -a.Radius, -a.Radius, i);
		}
	}
	
	static void DrawXYZ(Actor a, double lengthx = 128, Color col = 0xFF0000, bool fromCenter = false)
	{
		HDCore.log('AceCoreLib', LOGGING_WARN, "DrawXYZ is Deprecated, contact developer to update!");

		for (double i = 0; i < (fromCenter ? a.Height / 2 : a.Height); i += 0.5)
		{
			a.A_SpawnParticle(col, SPF_FULLBRIGHT | SPF_RELATIVE, 1, 2, 0, i * sin(a.pitch), 0, (fromCenter ? a.Height / 2 : 0) + i * cos(a.pitch));
		}
		for (double i = 0; i < a.Radius; i += 0.5)
		{
			a.A_SpawnParticle(col, SPF_FULLBRIGHT | SPF_RELATIVE, 1, 2, 0, 0, i, (fromCenter ? a.Height / 2 : 0));
		}
		for (double i = 0; i < lengthx; i += 0.50)
		{
			a.A_SpawnParticle(col, SPF_FULLBRIGHT | SPF_RELATIVE, 1, 2, 0, i * cos(a.pitch), 0, (fromCenter ? a.Height / 2 : 0) + i * sin(-a.pitch));
		}
	}
}