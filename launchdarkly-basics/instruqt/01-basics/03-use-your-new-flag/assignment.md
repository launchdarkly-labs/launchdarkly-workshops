---
slug: use-your-new-flag
id: 9qafn3ezcuys
type: challenge
title: Use Your New Flag
teaser: Our new flag will new be put to use in real code
notes:
- type: text
  contents: Now that we have a feature flag, let's add it into some code and see how
    this works. You'll learn how to initialize the LaunchDarkly client-side SDK using
    JavaScript and how to get flag values in the code.
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
timelimit: 1200
---

# LaunchDogly

We have a simple client-side web app which we'll use for this first challenge. This app is called LaunchDogly, which as you might guess, gives us fun photos of dogs!

Right now, the application just simply uses an XMLHttpRequest object in JavaScript to get a new dog picture.

Go ahead and refresh the **LaunchDogly** tab to see a new picture.

# Initialize LaunchDarkly

First, we need to build provide context for the client. This object will contain a unique key for the end-user client. This key might be a customer ID, a UUID, or anything else which allows us to maintain a connection to this client.

In this block of code, we've defined the key as `my-unique-context-key`. This `key` is the only data point which is required, but it's important to add as many data points as necessary in order to make targeting useful (we'll dive into targeting in a later track). As such, we're going to add some attributes to help us identify this client.

We'll add a `userType` and a `location`. These attributes will be used later on.

For now, copy the code below and add it into the specified code block in the **Code Editor** tab in the `static/main.js` file.

1. Replace `YOUR_NAME` with your first and last name
1. Replace `YOUR_STATE` with your 2-letter state abbreviation
1. Be sure to save!

```js
const context = {
    kind: 'user',
    key: 'my-unique-context-key',
    name: 'YOUR_NAME',
    userType: 'beta',
    location: 'YOUR_STATE'
};
```

The above code is just a data object. It doesn't actually do anything. So let's go ahead and use this object to initialize our LaunchDarkly JavaScript SDK. Add the following code just after the `const context` block.

```js
const client = LDClient.initialize(clientKey, context);
```

# Incorporate Our Feature Flag

When you refresh the **LaunchDogly** tab, you still won't see anything different. However, LaunchDarkly now has the ability to communicate flag statuses to the application.

But we don't want to have to refresh the page every few seconds to see a new dog picture. So let's create a way for our dog picture to automatically rotate every few seconds. Fortunately, we already have some code which will do that for us. So now, let's have the application auto-rotate based on our *Enable Auto Rotate* flag value in your LaunchDarkly project.

Add the following code to the `static/main.js` just below the previous initilization code.

```js
client.on('ready', () => {
    if (client.variation('enable-auto-rotate', false) == true) {
        flagAutoRotate = true;
        autoRotate();
    }
})
```

Now when you refresh the page, if the *Enable Auto Rotate* flag is off, we must manually refresh the page to get a new dog picture. But if the flag is on, we'll get a new picture every few seconds.

Go ahead and toggle the flag a couple of times, refreshing the **LaunchDogly** tab after each toggle to see the update.

Great job! You've successfully added a LaunchDarkly feature flag to an application.
