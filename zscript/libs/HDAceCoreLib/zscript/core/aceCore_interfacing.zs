// [Ace] I am not able to use Service because it's not the same as an event. I need these to fire at a very specific moment and be handled immediately.
// These are also one-time use. At least they *should* be. You're supposed to destroy requests after usage.
class InterfaceRequest play
{
	AceCoreHandler Handler;
	Name RequestName;
	Actor Caller;
	Actor Receiver;
	string Arg;

	void Remove()
	{
		if (Handler)
		{
			for (int i = 0; i < Handler.Requests.Size(); ++i)
			{
				if (Handler.Requests[i] == self)
				{
					Handler.Requests.Delete(i);
					Destroy();
					break;
				}
			}
		}
	}
}

extend class AceCoreHandler
{
	static void CreateRequest(Name reqName, Actor caller, Actor receiver, string arg = "")
	{
		let handler = AceCoreHandler(EventHandler.Find('AceCoreHandler'));
		if (reqName == "" || !caller || !receiver)
		{
			return;
		}

		for (int i = 0; i < handler.Requests.Size(); ++i)
		{
			// [Ace] It already exists. Don't allow duplicate requests.
			if (handler.Requests[i].RequestName == reqName && handler.Requests[i].Caller == caller && handler.Requests[i].Receiver == receiver)
			{
				return;
			}
		}

		let iface = new('InterfaceRequest');
		iface.Handler = handler;
		iface.RequestName = reqName;
		iface.Caller = caller;
		iface.Receiver = receiver;
		iface.Arg = arg;
		handler.Requests.Push(iface);
	}

	Array<InterfaceRequest> Requests;
}