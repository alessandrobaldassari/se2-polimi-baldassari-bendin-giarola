for (every taxi availability change detected)
	if (Availability:WAITING-->Availability:OFFLINE)
		remove driver from current queue;
		update queue;
	else
		proceed with the assignment of driver to zone;
		//see "Zone assignment" algorithm