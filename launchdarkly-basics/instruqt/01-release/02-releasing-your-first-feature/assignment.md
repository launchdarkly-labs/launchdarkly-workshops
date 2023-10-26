---
slug: releasing-your-first-feature
id: x68ivx2klrcz
type: challenge
title: Releasing Your First Feature
teaser: Our new flag will new be put to use in real code
notes:
- type: text
  contents: Now that we have a feature flag, let's add it into some code and see how
    this works. You'll learn how to initialize the LaunchDarkly client-side SDK using
    React and how to get flag values in the code.
tabs:
- title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- title: Toggle Outfitters
  type: service
  hostname: workstation
  port: 3000
- title: VS Code
  type: service
  hostname: workstation
  port: 8080
- title: Code Editor
  type: code
  hostname: workstation
  path: /opt/ld/talkin-ship-workshop-app
- title: Shell
  type: terminal
  hostname: workstation
difficulty: basic
timelimit: 1200
---

# Dark-Launching our Feature

Now that we've successfully created our flag, we are ready to use that flag to launch our new feature. In order to release a feature with LaunchDarkly there are two things we need to do:

1. Import the flag value from LaunchDarkly
1. Run specific code depending on that value of that flag

# Edit the Code

**Step 1:** Open the [Code Editor](#tab-2), and locate the `/src/pages/index.tsx` file

**Step 2:** Remove the comments from the start of line 12 (the comments are the // symbols on the front). This will allow the LaunchDarkly SDK to receive the values for this feature flag.

```js
const {storeEnabled} = useFlags();
```

**Step 3:** Add the following line of code in the appropriate place and save the file. Within our application code - you can see the commented lines around line 26 that indicate where to place this updated code:

```js
{
  storeEnabled ? <StoreLaunch /> : <StorePreview />
}
```

**Step 4:** Save the file

Switch to the [Toggle Outfitters](#tab-1) tab, and you should see no change on our page, why? Well because we haven't enabled the flag. This is what we mean by testing in production. The code is currently in place, but its disabled behind our feature flag.

# Flags in Action

1. Switch to the [LaunchDarkly](#tab-0) tab.
1. Click the On/Off toggle to turn the flag **On**.
1. Click **Review and save**, then **Save changes**.
1. Now switch to the [Toggle Outfitters](#tab-1) tab and you should see our new brand new webstore!

While this is great, and we can disable it immediately if there are any issues, we want to be able to test this with a small group of users before we release it to everyone.

1. Switch to the [LaunchDarkly](#tab-0) tab.
1. Click the On/Off toggle to turn the flag **Off**.
1. Click **Review and save**, then **Save changes**.

Great job! You've successfully added a LaunchDarkly feature flag to our application!
