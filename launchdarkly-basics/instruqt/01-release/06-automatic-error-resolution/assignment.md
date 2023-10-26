---
slug: automatic-error-resolution
type: challenge
title: Automatic Error Resolution
teaser: Learn how to automate error resolution with flag triggers
notes:
- type: text
  contents: We've shown how we can release features quickly, and recover with the
    flip of a toggle. But how can we let the system recover itself in the event of
    a problem?
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
timelimit: 600
---

# Immediate Resolution

Unfortunately, issues with technology migrations don't always play nice with work schedules. Usually they wait until the wee hours of the morning or the weekend to have a hiccup and the unfortunate SRE on call has to scramble to take care of the fallout. Does it have to be? As you might have suspected, the answer is, "No, you don't need to wake someone up at 2:00am on a Saturday to take care of a broken API!"

Let's see this in action!

# Update Our Code

First, we need to update our application to take action when something goes wrong. In a production environment, this is normally handled by your monitoring/incident tools. But for simplicity in this lab, we'll have our code handle this for us.

**Step 1:** Open the [Code Editor](#tab-2), and locate the `/src/hooks/useErrorHandling.ts` file.

**Step 2:** Replace ALL contents with the following:
```js
// hooks/useErrorHandling.ts
import { useState } from 'react';
import { useShoppingCart } from 'use-shopping-cart';

const useErrorHandling = () => {
  const triggerUrl = 'PASTE_URL_TRIGGER_HERE';
  const [errorState, setErrorState] = useState(false);

  const { clearCart } = useShoppingCart();

  const Trigger = async () => {
    try {
      const response = await fetch(
        triggerUrl,  
        {
          method: "POST",
          body: JSON.stringify({
            eventName: "There was an error with the API",
          }),
        }
      );
      return response.status;
    } catch (error) {
      console.log("the fetch did not work");
    }
  };

  const errorTesting = async () => {
    try {
      const response = await fetch("/api/checkout", {
        method: "GET",
        headers: { "Content-Type": "application/json" },
      });
      const jsonData = await response.json();
      if (jsonData == "the API is unreachable") {
        setErrorState(true);
         clearCart()
         Trigger()
        return 502;
      } else {
        setErrorState(false);
      }
    } catch (e) {
      console.log("is it running?");
      console.log(e)
    }
  };

  return { errorState, setErrorState, errorTesting };
};

export default useErrorHandling;
```

**Step 3:** Go ahead and save the file, but we're not quite done with it yet. We need to setup the trigger in the flag settings before we come back to it.

# Update Flag Settings

1. Switch over to the [LaunchDarkly](#tab-0) tab.
1. Click **Feature Flags** in the left mavigation menu.
1. Click **Updated Billing IU**.
1. In the upper navigation menu, click **Settings**
1. In the **Triggers** section, click **+ Add trigger**
1. Select the following values:
   1. **Trigger type**: Generic trigger
   1. **Trigger action**: Update flag targeting to *Off*
1. Click **Save Trigger**
1. Click the generated URL to copy it to the clipboard.

# Connect the Code to the Trigger

1. Switch back over to the [Code Editor](#tab-2) tab.
1. On line 6, replace `PASTE_URL_TRIGGER_HERE` with the copied URL
1. Save the file

# Testing Our Trigger

With our trigger in place, let's reproduce the error we encountered in our fourth challenge.

1. Switch back over to the [LaunchDarkly](#tab-0) tab.
1. Click **Feature Flags** in the left mavigation menu.
1. Locate the **Migrate to Stripe API** flag and toggle the flag to **Off**
1. Click **Save changes**
1. Finally, switch over to the [Toggle Outfitters](#tab-1) tab.
1. Click *Add to Cart*

You'll see the error like we did in Challenge 4, except when you dismiss the error this time, you can see the error UI changes were reverted.

This is a great way to mitigate errors when we have unforeseen issues, but we still have the issue of one flag relying on another. In the next challenge, we'll see how to create dependencies with flags to avoid these types of errors to begin with.