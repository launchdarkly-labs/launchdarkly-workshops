---
slug: target-rules
id: r7cygcoemkel
type: challenge
title: Targeting Rules
teaser: Understanding targeting rules
notes:
- type: text
  contents: Simple targeting works for some scenarios, but in a production environment,
    we often need to target based on more detailed information. In this challenge,
    we'll take a look at targeting rules.
tabs:
- title: LaunchDogly
  type: service
  hostname: workstation
  port: 8080
- title: Code Editor
  type: code
  hostname: workstation
  path: /root/launchdogly
- title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- title: Shell
  type: terminal
  hostname: workstation
difficulty: basic
timelimit: 600
---

# Targeting Rules

Individual targeting is great for development and test environments, but when it comes to production, we need flexible targeting options.

Targeting Rules allows us to target users based on specific criteria, but in a way which allows us to scale. For the sake of this workshop, we're going to keep the criteria simple.

1. Navigate to **Feature flags** in the menu on the left
1. Click on the flag named **New App Name**
1. The **Targeting** submenu is selected by default. In the **Rules** section, click **+ Add rules**
1. For the four dropdowns in the **If** (first) row, enter the following selections:
  1. *user*
  1. *userType*
  1. *is one of*
  1. *beta*
1. From the single dropdown in the second row, select *true*
1. Click **Review and save**, then **Save changes**

Navigate to the **LaunchDogly** tab and you will notice the name of the app at the top of the web app is "LaunchBarkly" instead of "LaunchDogly." Let's inspect the code to see how this is working.

Switch to the **Code Editor** tab, and open the *static/main.js* file. On line 123 of the file, you'll see the following:
```js,nocopy
newContext = {
    kind: 'user',
    key: mainUserName,
    name: mainUserName + '-user',
    userType: 'beta',
    location: 'CA'
};
```

`mainUserName` is set when you enter a *Username* in the web app. `key` and `kind` must be a unique combination. All other key-value pairs are customizable. You can provide as many key-value pairs as needed in order to target specific users. In this application, we've added *userType* and *location* as custom attributes.

If you remember, we used the *userType* attribute in our targeting rule. This is why we saw the title change.

Now let's change the userType in our code (*static/main.js*, line 127) to `ga-only`. Save the file and reload the **LaunchDogly** tab. Our web app name is now back to *LaucnhDogly*.

From within the rules engine, we can also perform percentage rollouts to specific groups. We will not tackle progressive rollouts in this workshop, but you can try that on your own!
