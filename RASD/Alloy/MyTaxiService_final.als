open util/boolean

sig string{}

sig Date{}

// Model definition
sig User{}

sig Visitor extends User{}

sig RegisteredUser extends User{
	userId : one Int,
	name: one string,
	surname: one string,
	address: one string,
	cellphone:  one string,
	username: one string,
	password: one string,
	mail: one string
}

sig SystemAdministrator extends RegisteredUser{
	system: one System
}

sig TaxiDriver extends RegisteredUser{ 
	availability: one Bool,
	position: lone string,
	currentRide: lone Ride,
	taxi: one Taxi
}

sig Passenger extends RegisteredUser{
	paymentData : one string,
	position :  lone string,
	currentRide: lone Ride,
	requests:  set Request 
}

sig System{}

sig Taxi{
	taxiId: one Int,
	taxiName: one string,
	taxiDriver: one TaxiDriver,
	currentZone: one Zone,
	rides: set Ride
} 
{
	taxiId >0
}
	

sig Zone{
	zoneId: Int,
	taxis : set Taxi
}
{
	zoneId > 0
}

sig Ride{
	rideId: one Int,
	origin: one string,
	destination: one string,
	date : one Date,
	fair: one Int,
	originZone: one Zone,
	destinationZone: one Zone,
	shared: one Bool,
	associatedRequests: set Request, 
	associatedPassengers : set Passenger
}
{
	rideId > 0
	fair > 0
}

sig Request{
	requestId: one Int,
	origin: one string,
	destination: one string,
	originZone: one Zone,
	destinationZone: one Zone,
	date: one Date,
	passengers: set Passenger,
	shared: one Bool
}
{
	requestId > 0
}

sig Notification{
	notificationId: one Int
}

sig CreationNotification extends Notification{}

sig ModificationNotification extends Notification{}

sig DeletionNotification extends Notification{}


// Model constraints

fact noEmptyRegisteredUser{
	all u: RegisteredUser | (#u.userId=1) and (#u.name=1) and (#u.surname=1) and (#u.username=1) and(#u.password=1) and (#u.mail=1)
}

fact noEmptySystemAdministrator{
	all s : SystemAdministrator | (#s.system=1) 
}

fact noEmptyTaxiDriver{
	all t : TaxiDriver | (#t.availability=1) and (#t.taxi=1)
}

fact noEmptyPassenger{
	all p: Passenger | (#p.paymentData=1) 
}

fact noEmptyTaxi{
	all t : Taxi | (#t.taxiId=1) and (#t.taxiName=1) and (#t.taxiDriver=1)
}

fact noEmptyZone{
	all z : Zone | (#z.zoneId=1)
}

fact noEmptyRide{
	all r : Ride | (#r.rideId=1) and (#r.origin=1) and (#r.destination=1) and (#r.date=1) and (#r.fair=1) and (#r.originZone=1) and (#r.destinationZone =1) and (#r.shared=1)
}

fact noEmptyRequest{
 all r : Request | (#r.requestId=1) and (#r.originZone=1) and (#r.destinationZone=1)
}

fact noDuplicateRegisteredUser{
	no disj u1,u2 : RegisteredUser | (u1.username = u2.username) and (u1.mail = u2.mail)
}

fact noDuplicateTaxi{
	no disj t1,t2 : Taxi | (t1.taxiId = t2.taxiId) 
}

fact noDuplicateNotification{
	no disj n1,n2 : Notification | (n1.notificationId = n2.notificationId) 
}

fact noDuplicateRequest{
 	no disj r1,r2 : Request | (r1.requestId = r2.requestId)
}

fact noDuplicateRide{
	no disj r1,r2 : Ride | (r1.rideId = r2.rideId)
}

fact noDuplicateZone{
	no disj z1,z2 : Zone | (z1.zoneId = z2.zoneId)
}

fact NoMultipleTaxiPerTaxiDriver{
	no disj t1,t2 : Taxi | (t1.taxiDriver = t2.taxiDriver)
}

fact noMultipleCurrentRideForPassenger{
	all p1,p2 : Passenger | (p1=p2) implies (p1.currentRide = p2. currentRide)
}

fact noOriginEqualDestinationRequest{
	no disj r1,r2 : Request | (r1.origin = r2.destination)
}

fact noOriginEqualDestinationRide{
	no disj r1,r2 : Ride | (r1.origin = r2.destination)
}

pred show{}

run show for 5



