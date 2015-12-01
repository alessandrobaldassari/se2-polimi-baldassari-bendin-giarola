for (every ride status changed)
	if (ride status == CANCELLED)
		collect(penalty fee);
	else
		get Ride type;
		if (Ride type == SHARED)
			compute shared fare;
		else 
			compute regular fare;
		collect(fare);
	process payment;