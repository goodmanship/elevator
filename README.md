elevator
========

elevator system, based on SCAN:
http://en.wikipedia.org/wiki/Elevator_algorithm

a request can be either a person inside the elevator pushing a button,
eg. [1,2] or a person pushing an arrow button outside the elevator, eg. [3,'up']
arrow button requests will be deleted as soon as the elevator reaches that floor
floor requests will be deleted when the elevator reaches the destination floor

definitely possible to use a different request object, for instance it would be
cleaner in some ways to use [origin, destination, direction] for each request,
with the possibility of origin being blank for arrow button requests, but I 
decided to go with the current design bc it feels more natural and works well with
the current program

