#for this script we are using as ASL switches 3560
puts [ open flash:Lab4 w+ ] {

#configure the trunk encapsulation in the ports 7 to 12. change the native VLAN 1 to VLAN 666. configure the interfaces to be trunk and unset the negotiation between ports
ios_config "interface range g1/0/7-12" "switchport trunk encapsulation dot1q" "switchpor trunk native vlan 666" "switchport mode trunk" "switchport nonegotiate" "no shutdown" "end"

#VTP version 3 configuration
ios_config "vtp domain SWLAB" "vtp version 3" "vtp mode server"

#from here we will apply a serie of command that will compare the congence between the no edge port and the portfast
#debug to obser the convergence of using a no edge port
debug spanning-tree events
ios_config "interface g1/0/6" "switchport mode access" "switchport access vlan 120" "no shutdown"

#activate the portfast 
ios_config "interface g1/0/6" "spanning-tree portfast" "shutdown"

#BPDU implemented in a prot connected to a host
ios_config "interface g1/0/6" "spanning-tree bpduguard enable" "exit"

#change the priority of the vlan to be the root
ios_config "spanning-tree vlan 100 priority 16384"

#After observe the changes. remove the previously commmand to clean the switch as we had before
ios_config "no spanning-tree vlan 100 priority 16384"

#implementing guard loop
ios_config "interface g1/0/11" "spanning-tree bpdufilter enable" "exit"

#after observe that the port was blocking disable
ios_config "interface g1/0/11" "spanning-tree bpdufilter disable" "exit"
}
