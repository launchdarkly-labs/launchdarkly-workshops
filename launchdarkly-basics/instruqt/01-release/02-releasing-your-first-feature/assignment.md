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
- title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: basic
timelimit: 1200
---

# Lab 2

# Dark-Launching our Feature

Now that we've successfully created our flag, we are ready to use that flag in our code to launch our new feature. In order to release a feature with LaunchDarkly there are two things we need to do:

1. Obtain the flag's state from LaunchDarkly.
1. Determine what code should run based on that flag's state.

# Edit the Code

The next step is to update our code to make use of our new flag.

1. Open the [Code Editor](#tab-2), and locate the `/src/pages/index.tsx` file
2. Replace line 12 with the following code. This allows the application to start receiving values for our feature flag.

```js
const {releaseUpdatedStorefront} = useFlags();
```

3. Replace line 26 with the following code. This will allow us to control what code gets run based on the state of the flag.

```js
{
  releaseUpdatedStorefront ? <StoreLaunch /> : <StorePreview />
}
```

4. Save the file (Cmd+S / Ctrl+S)

Switch to the [Toggle Outfitters](#tab-1) tab, and you should see no change on our page. Since we haven't turned the flag on, our original preview page is being shown. However, our new code is in place and ready for action!

# Flags in Action

1. Switch to the [LaunchDarkly](#tab-0) tab.
1. Click the On/Off toggle to turn the flag **On**.
1. Click **Review and save**, then **Save changes**.

Switch to the [Toggle Outfitters](#tab-1) tab and now you should see our new brand new online store!

Unfortunately, this code hasn't been tested by our developers, so for now, let's go ahead and turn this flag off for now.

1. Switch to the [LaunchDarkly](#tab-0) tab.
1. Click the On/Off toggle to turn the flag **Off**.
1. Click **Review and save**, then **Save changes**.

Great job! You've successfully added a LaunchDarkly feature flag to our application! In the next challenge, we'll provide a way for our developers to test the app in production without releasing it to the whole world.
