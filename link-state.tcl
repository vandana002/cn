#Create a simulator object
set ns [new Simulator]

#Open file for nam tracing
set nf [open mesh2.nam w]
$ns namtrace-all $nf

#Set up different colors for dataflow
$ns color 1 Red
$ns color 2 Blue
$ns color 3 Green
$ns color 4 Yellow
$ns color 5 Violet 
$ns color 6 Pink
$ns color 7 Brown
$ns color 8 White

#Define a 'finish' procedure
proc finish {} {
global ns nf
$ns flush-trace
#close the trace file
close $nf
#Execute nam on the trace file
exec nam mesh2.nam &
exit 0 }

#Create Nodes for the simulation
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

#Create a duplex link between the links
$ns duplex-link $n0 $n1 10Mbps 5ms DropTail
$ns duplex-link $n0 $n2 10Mbps 4ms DropTail
$ns duplex-link $n0 $n3 10Mbps 2ms DropTail
$ns duplex-link $n1 $n0 10Mbps 5ms DropTail
$ns duplex-link $n1 $n2 10Mbps 3ms DropTail
$ns duplex-link $n1 $n3 10Mbps 7ms DropTail
$ns duplex-link $n2 $n0 10Mbps 4ms DropTail
$ns duplex-link $n2 $n1 10Mbps 3ms DropTail
$ns duplex-link $n2 $n3 10Mbps 4ms DropTail
$ns duplex-link $n3 $n0 10Mbps 2ms DropTail
$ns duplex-link $n3 $n1 10Mbps 7ms DropTail
$ns duplex-link $n3 $n2 10Mbps 4ms DropTail


#Labelling the nodes
$ns at 0.0 "$n0 label Client1"
$ns at 0.0 "$n1 label Client2"
$ns at 0.0 "$n2 label Client3"
$ns at 0.0 "$n3 label Client4"

#Orient
$ns duplex-link-op $n0 $n1 orient right-up
$ns duplex-link-op $n0 $n2 orient right
$ns duplex-link-op $n0 $n3 orient right-down
$ns duplex-link-op $n1 $n0 orient left-down
$ns duplex-link-op $n1 $n2 orient right-down
$ns duplex-link-op $n1 $n3 orient down
$ns duplex-link-op $n2 $n0 orient left
$ns duplex-link-op $n2 $n1 orient left-up
$ns duplex-link-op $n2 $n3 orient left-down
$ns duplex-link-op $n3 $n0 orient left-up
$ns duplex-link-op $n3 $n1 orient up
$ns duplex-link-op $n3 $n2 orient right-up

#Coloring the link
$ns duplex-link-op $n0 $n1 color red
$ns duplex-link-op $n0 $n2 color yellow
$ns duplex-link-op $n0 $n3 color pink
$ns duplex-link-op $n1 $n0 color red
$ns duplex-link-op $n1 $n2 color blue
$ns duplex-link-op $n1 $n3 color black
$ns duplex-link-op $n2 $n0 color yellow
$ns duplex-link-op $n2 $n1 color blue
$ns duplex-link-op $n2 $n3 color purple
$ns duplex-link-op $n3 $n0 color pink
$ns duplex-link-op $n3 $n1 color black
$ns duplex-link-op $n3 $n2 color purple

#Setup a TCP connection 
set tcp [new Agent/TCP/Newreno] 
$ns attach-agent $n0 $tcp 
set sink [new Agent/TCPSink/DelAck] 
$ns attach-agent $n2 $sink 
$ns connect $tcp $sink 
$tcp set fid_ 2
$tcp set window_ 8000 
$tcp set packetSize_ 552 

#Setup a FTP over TCP connection 
set ftp [new Application/FTP] 
$ftp attach-agent $tcp 
$ftp set type_ FTP 

 
$ns at 1.0 "$ftp start" 

$ns rtmodel-at 2.0 down $n0 $n2
$ns rtmodel-at 2.8 up $n0 $n2

$ns rtproto LS
$ns at 4.0 "$ftp stop" 



#Specifying the start and stop time 
$ns at 5.0 "finish"

#Start simulation
$ns run
