# get configuration state before reconfiguration process
echo "Configuration STATE BEFORE reconfiguration procedure:"
salt -E 'cmp*|ctl*|gtw*' cmd.run "grep -r 'firewall_driver' /etc/neutron/* | grep -v '#'"


# Reconfigure cmp- and gtw-nodes 
salt -E 'cmp*|gtw*' cmd.run "sed -i 's/firewall_driver = neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver/\
firewall_driver = openvswitch/g' /etc/neutron/plugins/ml2/openvswitch_agent.ini"
salt -E 'cmp*|gtw*' service.restart "neutron-openvswitch-agent"


# Reconfigure ctl-nodes
salt 'ctl*' cmd.run "sed -i 's/firewall_driver = neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver/\
firewall_driver = openvswitch/g' /etc/neutron/plugin.ini"
salt 'ctl*' cmd.run "sed -i 's/firewall_driver = neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver/\
firewall_driver = openvswitch/g' /etc/neutron/plugins/ml2/ml2_conf.ini"
salt 'ctl*' service.restart "neutron-server"


# check results
echo "Configuration STATE AFTER reconfiguration procedure:"
salt -E 'cmp*|ctl*|gtw*' cmd.run "grep -r 'firewall_driver' /etc/neutron/* | grep -v '#'"