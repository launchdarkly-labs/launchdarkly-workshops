---
slug: real-time-updates
id: cjtw07w7kijc
type: challenge
title: Real-time Updates
teaser: Getting changes to users without action on their part.
notes:
- type: text
  contents: The LaunchDarkly SDKs maintain a lightweight connection using server-sent
    events in order to listen for flag changes. In this challenge, you'll learn how
    to listen for those changes and act on them on your user's behalf.
tabs:
- title: LaunchDogly
  type: service
  hostname: workstation
  port: 8080
- title: Code Editor
  type: code
  hostname: workstation
  path: /root/launchdogly/track1
- title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- title: Shell
  type: terminal
  hostname: workstation
difficulty: basic
timelimit: 600
---

# Add an onChange Listener

So far, we've been able to alter the functionality of our web app using a feature flag. But it has also required action on our end-users' part--in this case to refresh the web app.

If we want our users to have a different experience, we want it to be delivered immediately--even if they don't refresh or reopen the app.

LaunchDarkly allows our platform to immediately deliver flag changes to every single client by using the HTML5 server-side events (SSE) API. The LaunchDarkly SDK will listen for those changes and we can act on them immediately.

Let's add the following code after the previous code block in the *static/main.js* file and refresh the **LaunchDogly** tab.

```js
client.on('change', (settings) => {
    console.log(settings);
    if (settings['enable-auto-rotate'].current == true) {
        flagAutoRotate = true;
        autoRotate();
    } else {
        flagAutoRotate = false;
        clearInterval(myTimer);
    }
})
```

Now when you toggle the *Enable Auto Rotate* flag, the changes are immediate without the user needing to refresh or reopen the application.
