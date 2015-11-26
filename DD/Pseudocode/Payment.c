for (every request || reservation)
	if (request || reservation deleted before ride generation)
		collect(nothing); //no penalty fee
	else
		ride generated
		if (ride cancelled)
			collect(penalty fee);
		else
			ride completed;
			collect(regular fare);