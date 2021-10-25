set ns [new Simulator]
set nf [open out.nam w]
$ns namtrace-all $nf
proc finish {} {
global ns nf
$ns flush-trace
close $nf
puts "running nam"
exec nam out.nam &
exit 0
}
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
$ns duplex-link $n0 $n1 10Mbps 10ms DropTail
$ns duplex-link $n0 $n2 10Mbps 10ms DropTail
$ns duplex-link $n0 $n3 10Mbps 10ms DropTail
$ns duplex-link $n1 $n0 10Mbps 10ms DropTail
$ns duplex-link $n1 $n2 10Mbps 10ms DropTail
$ns duplex-link $n1 $n3 10Mbps 10ms DropTail
$ns duplex-link $n2 $n0 10Mbps 10ms DropTail
$ns duplex-link $n2 $n1 10Mbps 10ms DropTail
$ns duplex-link $n2 $n3 10Mbps 10ms DropTail
$ns duplex-link $n3 $n0 10Mbps 10ms DropTail
$ns duplex-link $n3 $n1 10Mbps 10ms DropTail
$ns duplex-link $n3 $n2 10Mbps 10ms DropTail
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
$ns at 5.00 "finish"
$ns run
