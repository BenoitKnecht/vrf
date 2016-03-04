# default task to management VRF if it exists and task is not running
# in a VRF context
[ -n "$VRF" ] && exit 0

MGMT_VRF=mgmt
[ -e /etc/vrf.conf ] && . /etc/vrf.conf

/usr/cumulus/bin/cl-vrf exists $MGMT_VRF
if [ $? -eq 0 ]; then
	VRF=$(/usr/cumulus/bin/cl-vrf identify)
	if [ -z "$VRF" ]; then
		/usr/cumulus/bin/cl-vrf task set $MGMT_VRF $$
	fi
fi

VRF=$(/usr/cumulus/bin/cl-vrf identify)
export VRF

PS1="\$(/usr/cumulus/bin/cl-vrf identify)\u@\h:\w\$ "
