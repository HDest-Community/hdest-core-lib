extend class AceCore
{
	enum LiquidType
	{
		LType_Solid,
		LType_Normal,
		LType_Dissolving
	}

	static const string LiquidTextures[] = { "FWATER", "F_HWATR", "F_PWATR", "P_VWATR", "F_WATR",  "OWATER" "BLOOD", "SLIME", "FLATHUH", "FLTFLWW", "FLTWAWA", "FLTSLUD", "X_", "GRAYSLM", "SLUDGE", "OTAR__", "OBLODA", "OICYWA", "OSLIME", "NUKAGE", "ONUKEA", "LAVA", "FLTLAVA", "OLAVAC", "OLAVAD", "OSLUDG", "OGOOPY" };

	static LiquidType CheckTextureType(Sector sec, string filter = "")
	{
		string FTex = TexMan.GetName(sec.GetTexture(0)).MakeUpper();

		if (filter != "") // [Ace] Search floor texture for a specific combination.
		{
			Array<string> SplitFilter;
			filter = filter.MakeUpper();
			filter.Replace(" ", "");
			filter.Split(SplitFilter, "|");
			for (int i = 0; i < SplitFilter.Size(); ++i)
			{
				if (FTex.IndexOf(SplitFilter[i]) != -1)
				{
					return sec.damageamount > 0 ? LType_Dissolving : LType_Normal;
				}
			}
		}
		else // [Ace] Search against the list above.
		{
			for (int i = 0; i < AceCore.LiquidTextures.Size(); ++i)
			{
				if (FTex.IndexOf(AceCore.LiquidTextures[i]) != -1)
				{
					return sec.damageamount > 0 ? LType_Dissolving : LType_Normal;
				}
			}
		}

		return LType_Solid;
	}
}