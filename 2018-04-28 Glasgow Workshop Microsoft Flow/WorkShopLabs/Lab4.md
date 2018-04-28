
## Create a Flow triggered by webhook
* Create Flow from blank
* Use the following json template:
```
{
    "type": "object",
    "properties": {
        "Trigger": {
            "type": "string"
        }
    }
}
```
* Add an action (create file/send email)
* Add dynamic content from the trigger as content
* Save the Flow
* Trigger the flow with the following PowerShell command:
```
$Splat = @{
    Uri = 'https://<fill in your URL'
    Method = 'post'
    ContentType = 'application/json'
    Body = [pscustomobject]@{Trigger='Glasgow'} | ConvertTo-Json
}
Invoke-RestMethod @Splat
```
* Confirm the output of this Flow

## Trigger Flow from another Flow
* Create frrom blank template
* Manually trigger
* HTTP action
    * Post
    * Uri
    * Headers can be empty
    * Body with json object
* Save Flow and run button from Device