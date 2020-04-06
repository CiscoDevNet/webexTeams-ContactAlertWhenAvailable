-- WebEx Meeting - Alert when user becoms available
--
-- Copyright (c) 2020 Cisco and/or its affiliates.
-- This software is licensed to you under the terms of the Cisco Sample
-- Code License, Version 1.1 (the "License"). You may obtain a copy of the
-- License at https://developer.cisco.com/docs/licenses
-- All use of the material herein must be in accordance with the terms of
-- the License. All rights not expressly granted by the License are
-- reserved. Unless required by applicable law or agreed to separately in
-- writing, software distributed under the License is distributed on an "AS
-- IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
-- or implied.

set userName to text returned of (display dialog "Enter a CEC User Name (e.g., ymeloch)" default answer "" with title "WebEx Teams - Active User Notification" with icon note)
set theAlertText to "WebbEx Teams - Active User Notification"
set theAlertMessage to "" & userName & " User is now active"
set n to 1
repeat
	delay 10
	set theName to do shell script "curl -s --request GET --url 'https://api.ciscospark.com/v1/people?email=" & userName & "%40cisco.com' --header 'Authorization: Bearer [TOKEN]' | json_pp | grep status | awk '{print $3}' | tr -dc '[:alnum:]'"
	if theName = "active" then (display dialog theAlertMessage with title "WebEx Teams - Active User Notification" with icon stop buttons {"Exit"} default button "Exit" cancel button "Exit")
end repeat
