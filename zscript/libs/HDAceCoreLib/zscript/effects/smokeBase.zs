class ACESmokeBase : Actor abstract
{
	override void BeginPlay()
	{
		Super.BeginPlay();
		GrowSpeed = frandom(GSMin, GSMax);
		FadeSpeed = frandom(FSMin, FSMax);
		StopSpeed = frandom(SSMin, SSMax);
		MoveDir = randompick(-1, 1);
		A_SetRoll(random(0, 360));
		frame = 10;
	}

	override void Tick()
	{
		if (IsFrozen())
		{
			return;
		}

		if (pos.z > floorz || bSTANDSTILL)
		{
			vel *= StopSpeed;
			vel.z -= Gravity;
		}
		else if (vel.length() < 1 && !bSTANDSTILL)
		{
			A_ChangeVelocity(0, 0.15 * MoveDir, 0, CVF_RELATIVE | CVF_REPLACE);
		}
		Super.Tick();
	}

	private int MoveDir;

	private double GrowSpeed, GSMin, GSMax;
	property GrowSpeed: GSMin, GSMax;

	private double FadeSpeed, FSMin, FSMax;
	property FadeSpeed: FSMin, FSMax;

	private double StopSpeed, SSMin, SSMax;
	property StopSpeed: SSMin, SSMax;

	Default
	{
		ACESmokeBase.GrowSpeed 0.00275, 0.003;
		ACESmokeBase.FadeSpeed 0.00275, 0.003;
		ACESmokeBase.StopSpeed 0.95, 0.95;
		Radius 5;
		Height 10;
		Scale 0.02;
		Gravity 0.022;
		+NOGRAVITY
		+THRUACTORS
		+BRIGHT
		+NOBLOCKMAP
		+ROLLSPRITE
		+FORCEXYBILLBOARD
		MaxStepHeight 8;
		Scale 0.05;
		Alpha 0.35;
	}

	States
	{
		Spawn:
			GNSM # 1
			{
				A_FadeOut(FadeSpeed);
				A_SetScale(Scale.X + GrowSpeed);
			}
			Loop;
	}
}