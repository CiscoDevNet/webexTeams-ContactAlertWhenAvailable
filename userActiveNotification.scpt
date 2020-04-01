set userName to text returned of (display dialog "Enter a CEC User Name (e.g., ymeloch)" default answer "" with title "WebEx Teams - Active User Notification" with icon note)
set theAlertText to "WebbEx Teams - Active User Notification"
set theAlertMessage to "" & userName & " User is now active"
-- set theName to do shell script "curl -s --request GET --url 'https://api.ciscospark.com/v1/people?email=" & userName & "%40cisco.com' --header 'Authorization: Bearer MmJiZDIyMWUtZTcxZC00NTJmLWJiMTMtMzAyMDk0ZjQ2Mzk1MzNiYzM2ZmEtMjZj_PF84_1eb65fdf-9643-417f-9974-ad72cae0e10f' | json_pp | grep status | awk '{print $3}' | tr -dc '[:alnum:]'"
set n to 1
repeat
	delay 10
	set theName to do shell script "curl -s --request GET --url 'https://api.ciscospark.com/v1/people?email=" & userName & "%40cisco.com' --header 'Authorization: Bearer [TOKEN]' | json_pp | grep status | awk '{print $3}' | tr -dc '[:alnum:]'"
	if theName = "active" then (display dialog theAlertMessage with title "WebEx Teams - Active User Notification" with icon stop buttons {"Exit"} default button "Exit" cancel button "Exit")
end repeat
