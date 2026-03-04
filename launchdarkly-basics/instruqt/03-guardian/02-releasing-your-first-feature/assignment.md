---
slug: releasing-your-first-feature
id: cqgnyee9irvg
type: challenge
title: Releasing Your First Feature
teaser: Let's put our new flag to use in real code
notes:
- type: text
  contents: Now that we have a feature flag, let's add it into some code and see how
    this works. You'll learn how to initialize the LaunchDarkly client-side SDK using
    React and how to get flag values in the code.
tabs:
- id: waxvynbzrsyb
  title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- id: 08tn2auztyqm
  title: Toggle Outfitters
  type: service
  hostname: workstation
  port: 3000
- id: 6jv4yjqbynfz
  title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: ""
timelimit: 1200
enhanced_loading: null
---

# Lab 2

# Dark-Launching our Feature

Now that you've successfully created your flag, you are ready to use that flag in your code to launch the new feature. In order to release a feature with LaunchDarkly there are two things you need to do:

1. Obtain the flag's state from LaunchDarkly.
1. Determine what code should run based on that flag's state.

# Edit the Code

The next step is to update your code to make use of your new flag.

1. Open the [Code Editor](#tab-2), and locate the `/src/pages/index.tsx` file
2. Replace line 12 with the following code. This allows the application to start receiving values for your feature flag.

```js
const {releaseUpdatedStorefront} = useFlags();
```

3. Replace line 26 with the following code. This will allow you to control what code gets run based on the state of the flag.

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

Unfortunately, this code hasn't been tested so for now let's go ahead and turn this flag off.

1. Switch to the [LaunchDarkly](#tab-0) tab.
1. Click the On/Off toggle to turn the flag **Off**.
1. Click **Review and save**, then **Save changes**.

Great job! You've successfully added a LaunchDarkly feature flag to your application! In the next challenge, you'll learn a way to test the app in production without releasing it to the whole world.
