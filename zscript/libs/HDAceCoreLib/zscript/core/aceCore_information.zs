extend class AceCore
{
	static clearscope double, double GetSectorSize(Sector sec)
	{
		if (sec.lines.Size())
		{
			double secArea = 0;
			double lineLength = 0;
			foreach (ln : sec.lines) {
				secArea += ((ln.v1.p.x * ln.v2.p.y) - (ln.v1.p.y * ln.v2.p.x));
				lineLength += ln.delta.length();
			}
			
			return abs(secArea / 2.0), lineLength / sec.lines.Size();
		}
		else
		{
			return 0, 0;
		}
	}

	static clearscope double PitchTo(Actor a, Actor b, int type = 0)
	{
		vector3 diff = level.Vec3Diff(a.pos, b.pos);
		double pitch = atan2(diff.z, diff.xy.length());
		switch (type)
		{
			default: return pitch; // [Ace] This works. No idea about the rest. It seems to work, but...
			case 1: return pitch + a.pitch;
			case 2: return abs(pitch + a.pitch);
		}
	}

	static clearscope int GetActivePlayerCount()
	{
		int total = 0;
		for (int i = 0; i < MAXPLAYERS; ++i)
		{
			if (PlayerInGame[i])
			{
				total++;
			}
		}
		return total;
	}

	static clearscope double GetPlanePitch(Sector sec, SecPlane plane)
	{
		vector3 lowestPos = (0, 0, int.max);
		vector3 highestPos = (0, 0, int.min);

		foreach (ln : sec.lines)
		{
			double z = plane.ZAtPoint(ln.v1.p);
			if (z < lowestPos.z) lowestPos = (ln.v1.p, z);
			if (z > highestPos.z) highestPos = (ln.v1.p, z);

			z = plane.ZAtPoint(ln.v2.p);
			if (z < lowestPos.z) lowestPos = (ln.v2.p, z);
			if (z > highestPos.z) highestPos = (ln.v2.p, z);
		}

		vector3 diff = level.Vec3Diff(lowestPos, highestPos);
		return atan2(diff.z, diff.xy.length());
	}

	static bool IsSkyAbove(Actor a)
	{
		FLineTraceData data;
		a.LineTrace(0, a.ceilingz - a.floorz + 64, -90, flags: TRF_NOSKY | TRF_THRUACTORS, data: data);
		return data.HitType == data.TRACE_HitNone;
	}

	static clearscope bool CheckForItem(Actor other, Name item, int amt = 1)
	{
		class<HDWeapon> cls = item;
		return cls && other && other.CountInv(cls) >= amt;
	}
}