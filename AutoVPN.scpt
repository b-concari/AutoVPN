local password
set password to do shell script ("/usr/bin/security 2>&1 >/dev/null find-generic-password -gl cisco_vpn | cut -d \\\" -f 2")
if password is equal to "" then
	error "Password not found in the keychain"
end if

tell application "Cisco AnyConnect Secure Mobility Client" to activate
tell application "System Events"
	keystroke return
	delay 1
	keystroke password
end tell

tell application "VIP Access" to activate
tell application "System Events"
	set position of (first window of (first process whose name is "VIP Access")) to {0, 0}
	click at {200, 200}
end tell
tell application "VIP Access" to quit

tell application "Cisco AnyConnect Secure Mobility Client" to activate
tell application "System Events"
	keystroke return
	delay 0.75
	keystroke "v" using {command down}
	keystroke return
	delay 0.75
	keystroke return
end tell
