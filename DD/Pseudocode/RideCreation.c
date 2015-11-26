for (every ride creation)
	if (!sharing enabled)
		ride creation; //normal ride
	else
		search matches with same zone and time;
		if (!matches found)
			ride creation; //normal ride
		else if (!compatible match)
				ride creation; //no room for all passengers
			else
				shared ride creation;
	taxi allocation; //See "Queue manager" algorithm
	send notifications to driver and passengers involved;