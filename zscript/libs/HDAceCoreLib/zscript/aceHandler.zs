class AceCoreHandler : EventHandler
{
	override void NetworkProcess(ConsoleEvent e)
	{
		let plr = players[e.Player].mo;
		if (e.Name ~== "ACL_Ruler")
		{
			plr.A_SpawnItemEx("AceRuler", flags: SXF_NOCHECKPOSITION | SXF_SETMASTER);
		}
		if (e.Name ~== "ACL_Linetracer")
		{
			FLineTraceData data;
			plr.LineTrace(plr.angle, HDCONST_ONEMETRE * 100, plr.pitch, TRF_ALLACTORS, plr.ViewHeight, data: data);
			Actor.Spawn('BulletPuff', data.HitLocation);
			/*if (data.HitSector)
			{
				Console.Printf("%i", AceCore.GetPlanePitch(data.HitSector, data.HitSector.floorplane));
			}*/
		}
	}

	override void WorldUnloaded(WorldEvent e)
	{
		AceCoreGlobalStats.Get().LevelsCompleted++;
	}
}