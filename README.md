# How To Improve WebEx Teams (IM) Productivity?

Do you know/remember this GREAT feature in the Jabber chat menu? <br />
![json](images/pic1-Jabber.png?raw=true "Import JSON") <br />

If not, a quick recap.. that option configures Jabber to notify you when your contacts are available (i.e., online). <br />
This makes it easier to know if other people are available to respond to your messages. <br /> <br />

Well, for some reason, this option is missing from the WebEx Teams chat menu. <br />
![json](images/pic2-WebExTeams.png?raw=true "Import JSON") <br />

So, without getting into a “Jabber vs. WebEx Teams” discussion... I was wondering, how can I add that missing functionality? I’m not a WebEx Teams developer… <br />
What can we do.. what can we do.. let’s think… <br /> <br />

# I GOT IT!

![json](images/pic2-IGotIt.png?raw=true "Import JSON") <br />


1. Does WebEx Teams expose its **[API](https://developer.webex.com/docs/platform-introduction)**? ***YES!***  <br />
2. Is there an **[API call](https://developer.webex.com/docs/api/v1/people/list-people)** to check a user connection status? ***YES!***  <br />
3. Can I use a **[CLI command](https://community.cisco.com/t5/data-center-blogs/getting-started-with-curl/ba-p/3837348)** to trigger an API call? ***YES!***  <br /> <br />

Interesting! But... <br />
  * How can I add a new option to the WebEx Teams chat menu? <br />
  * What about the WebEx Teams API tokens limitation? <br />
    - The **[personal](https://developer.webex.com/docs/api/getting-started)** token is limited for 12 hours <br />
    - The **[guest user](https://developer.webex.com/docs/guest-issuer)** token cannot access the “status” data as it isn’t part of the organization <br />
    - The **[integration](https://developer.webex.com/docs/integrations)** token (**[OAuth](https://developer.webex.com/blog/real-world-walkthrough-of-building-an-oauth-webex-integration)** grant using a **[web browser](https://github.com/marsh240sx/spark-auth-sample)**) isn’t applicable for a simple script <br /> <br />

4. True, I cannot modify the WebEx Teams chat menu… but, can AppleScript execute a CLI (cURL) command? ***YES!***  <br />
5. Since a **[WebEx Teams Bot](https://developer.webex.com/docs/bots)** is part of the organization, can I create a new Bot and use its (permanent) API token? ***YES!***  <br />

# Problem Solved!

I created a: <br />
  * New **[WebEx Teams Bot](https://developer.webex.com/docs/bots)** (for an “inside-org-permanent” API token)  <br />
  * cURL command & parsing statement to retrieve the user status  <br />
<details>
      <summary>Sample Command"</summary>

 ```concole
curl -s --request GET --url 'https://api.ciscospark.com/v1/people?email=ymeloch%40cisco.com' --header 'Authorization: Bearer [TOKEN]' | json_pp | grep status | awk '{print $3}' | tr -dc '[:alnum:]'
 ```
</details>

  * AppleScript to:  <br />
    - Query (via dialog box) for the user CEC ID  <br />
    - Execute (10 sec. loop) in the background the cURL command  <br />
    - Notify when the user becomes active :smiley:  <br />
<details>
      <summary>Sample Command"</summary>

 ```concole
 set userName to text returned of (display dialog "Enter a CEC User Name (e.g., ymeloch)" default answer "" with title "WebEx Teams - Active User Notification" with icon note)
 set theAlertText to "WebbEx Teams - Active User Notification"
 set theAlertMessage to "" & userName & " User is now active"
 set n to 1
 repeat
  	delay 10
 	set theName to do shell script "curl -s --request GET --url 'https://api.ciscospark.com/v1/people?email=" & userName & "%40cisco.com' --header 'Authorization: Bearer [TOKEN]' | json_pp | grep status | awk '{print $3}' | tr -dc '[:alnum:]'"
 	if theName = "active" then (display dialog theAlertMessage with title "WebEx Teams - Active User Notification" with icon stop buttons {"Exit"} default button "Exit" cancel button "Exit")
 end repeat
 ```
</details>


# And the results are:

![json](images/pic4-Blueprint.png?raw=true "Import JSON") <br />

# Script Initialization

## Repo Clone
5. Open a **Terminal** window (Press CMD + Space, type "Terminal" and hit return). <br />

6. Clone the code to your workstation (Copy & Paste the commands below). <br />

    ```concole
    cd /tmp
    git clone https://github.com/CiscoDevNet/webexTeams-ContactAlertWhenAvailable.git
    cd webexTeams-ContactAlertWhenAvailable.git
    ```

## Configuration & Usage
7. Using your preferred editor, edit the "userActiveNotification.scpt" file and replace the **TOKEN** entry with your WebEx Teams Bot Token ID. <br />

8. Save the file. <br />

9. Copy the modified file to AppleScript scripts folder (**`/Users/[user-ID]/Library/Scripts`** ). <br />

10. Run the script. <br />

11. If the "Show Script menu in menu bar" option is enabled, you can run the script from the menu bar. <br />

### Tools & Frameworks:
  * This code requires Mac OS

## Getting help & involved
Need help with the code? Got questions/concerns? Want to provide feedback? <br />
Please contact [Yossi Meloch](mailto:ymeloch@cisco.com) <br />

## Authors & Maintainers
:email: [Yossi Meloch](mailto:ymeloch@cisco.com) <br />

## Licensing info
This project is licensed to you under the terms of the **[Cisco Sample Code License](https://github.com/CiscoDevNet/webexTeams-ContactAlertWhenAvailable/LICENSE)**
