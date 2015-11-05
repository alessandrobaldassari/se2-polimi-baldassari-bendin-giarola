abstract sig Boolean {}
one sig True extends Boolean {}
one sig False extends Boolean {}
sig string {}

abstract sig User {}

sig Guest extends User {}

sig RegisteredUser extends User {
	id: Int,
	email: string,
	password: string,
	name: string,
	surname: string
}

sig SystemAdministrator extends RegisteredUser {}

sig Passenger extends RegisteredUser {
	phoneNumber: string,
	creditCardNumber: string
}

sig TaxiDriver extends RegisteredUser {
	licenseNumber: string,
	taxi: one Taxi
}

sig Taxi {
	serialNumber: string,
	capacity: Int,
	driver: one TaxiDriver,
	zone: one Zone,
	availability: Boolean,
	position: string
}{
	// Taxi Capacity is assigned to four
	capacity = 4
}

sig Zone {
	id: Int,
	queue: some Taxi
}{
	// All Taxi in the queue are available
	all taxi: queue | taxi.availability = True
}

sig Ride {
	id: Int,
	origin: string,
	destination: string,
	originZone: one Zone,
	destinationZone: one Zone,
	taxi: one Taxi,
	shared: Boolean,
	requests: some Request
}{
	// Sum of all the reserved seats in a ride must be less or equal to taxi capacity
}

sig Request {
	id: Int,
	origin: string,
	destination: string,
	originZone: one Zone,
	destinationZone: one Zone,
	passenger: one Passenger,
	reservedSeats: Int,
	ride: one Ride,
	shared: Boolean
}{
	// reservedSeats must be a non negative number
	reservedSeats > 0
}

// All Users of the system are either Passenger or TaxiDriver or SystemAdministrator
fact { SystemAdministrator + TaxiDriver + Passenger = RegisteredUser }

// Ride coming from a request have the same value for the share attribute
fact { all ride: Ride | all req: Request | req in ride.requests and ride.shared = req.shared }

// Ride must have the same originZone and destinationZone of their parent Request
fact { all ride: Ride | all req: Request | req in ride.requests and ride.originZone = req.originZone and ride.destinationZone = req.destinationZone }
	
// Every user has a different email address
fact { no u1,u2: RegisteredUser | u1 != u2 and u1.email = u2.email }

// Every Passenger has a different phone number
fact { no u1,u2: Passenger | u1 != u2 and u1.phoneNumber = u2.phoneNumber }

// Every Passenger has a different credit card number
fact { no u1,u2: Passenger | u1 != u2 and u1.creditCardNumber = u2.creditCardNumber }

// Every Taxi has a different driver
fact { no t1,t2: Taxi | t1 != t2 and t1.driver = t2.driver }

// A Taxi can be in just one queue
fact { no z1, z2: Zone | all t: Taxi | z1 != z2 and t in z1.queue and t in z2.queue }

pred show {}

run show for 1 string, 1 User, 1 SystemAdministrator, 5 TaxiDriver, 5 Passenger, 5 Taxi, 7 Request, 4 Ride, 2 Zone

























