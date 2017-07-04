# Reconfigure cmp-nodes
salt 'cmp*' cmd.run "sed -i 's/firewall_driver = neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver/\
firewall_driver = openvswitch/g' /etc/neutron/plugins/ml2/openvswitch_agent.ini"
salt 'cmp*' service.restart "neutron-openvswitch-agent"
# check results
salt 'cmp*' cmd.run "grep -r 'firewall_driver' /etc/neutron/* | grep -v '#'"


# Reconfigure gtw-nodes
salt 'gtw*' cmd.run "sed -i 's/firewall_driver = neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver/\
firewall_driver = openvswitch/g' /etc/neutron/plugins/ml2/openvswitch_agent.ini"
salt 'gtw*' service.restart "neutron-openvswitch-agent"
# check results
salt 'gtw*' cmd.run "grep -r 'firewall_driver' /etc/neutron/* | grep -v '#'"


# Reconfigure ctl-nodes
salt 'ctl*' cmd.run "sed -i 's/firewall_driver = neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver/\
firewall_driver = openvswitch/g' /etc/neutron/plugin.ini"
salt 'ctl*' cmd.run "sed -i 's/firewall_driver = neutron.agent.linux.iptables_firewall.OVSHybridIptablesFirewallDriver/\
firewall_driver = openvswitch/g' /etc/neutron/plugins/ml2/ml2_conf.ini"
salt 'ctl*' service.restart "neutron-server"
# check results
salt 'ctl*' cmd.run "grep -r 'firewall_driver' /etc/neutron/* | grep -v '#'"
