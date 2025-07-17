class AceCore play
{
	static void Tether(Actor puller, Actor other, double speed = 1.0)
	{
		other.A_Face(puller, 0, 0);
		other.A_ChangeVelocity(speed, 0, -speed * sin(other.pitch), CVF_RELATIVE | CVF_REPLACE);
		vector3 dir = puller.Vec3To(other);
		dir.z -= puller.height / 4;
		vector3 unit = dir.unit();
		for (double i = 0; i < puller.Distance3D(other); i += 0.75)
		{
			puller.A_SpawnParticle(0x00CCCC, SPF_FULLBRIGHT, 1, 1.5, 0, unit.x * i, unit.y * i, puller.height / 2 + unit.z * i);
		}
	}

	// [Ace] If split is false, return amount is the same as amt. Otherwise it returns how much each player received.
	static int GiveToPlayers(class<Inventory> cls, int amt, bool split = true)
	{
		if (!cls || amt <= 0)
		{
			return 0;
		}

		if (split)
		{
			amt = int(ceil(amt / double(GetActivePlayerCount())));
		}

		for (int i = 0; i < MAXPLAYERS; ++i)
		{
			if (players[i].mo)
			{
				players[i].mo.A_GiveInventory(cls, amt);
			}
		}
		return amt;
	}
}