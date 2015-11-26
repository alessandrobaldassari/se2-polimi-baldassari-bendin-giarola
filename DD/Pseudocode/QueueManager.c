for (every incoming request)
	search first taxi in queue;
	send proposal to taxi;
	while (job is not accepted) do
		move first taxi in bottom of queue;
		search first taxi in queue;
		send proposal to taxi;
	confirm job assignation;
	set second taxi in queue as new first;