---
slug: migrate-technologies
id: vuvyprvoibhk
type: challenge
title: Migrating Technologies with LaunchDarkly
teaser: Reduce your migration risks using feature flags
notes:
- type: text
  contents: Riky migrations are a thing of the past. Let LaunchDarkly help you safely
    and efficiently move from your legacy technology to your moderized workload.
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
It's always a good practice to create different flags for different frontend or backend components in our applications. Using LaunchDarkly lets you break your code into manageable pieces. In the case of the problem we've discovered here, for this migration, we are working with two components: our frontend UI code and backend API code. Let's work on the backend API code to resolve our issue.

# Create API Flag

1. From the left-hand navigation menu, click **Feature Flags**
1. Click the **Create flag** button in the upper right-hand corner
1. Select **Release**, then click **Next**
1. For **Name**, enter `Migrate to Stripe API`
1. For **Key**:
   1. Click the pencil
   1. Enter `enableStripe`
   1. Click **Next**
1. For **Flag variations**:
   1. Select **Boolean**
   1. For the first **Name**, enter `Stripe Checkout Enabled`
   1. For the second **Name**, enter `Stripe Checkout Disabled`
1. For **Default variations**, select *Stripe Checkout Disabled* for both **ON** and **OFF**
1. Click **Advanced configuration**, and check the **SDKs using Client-side ID** box
1. Click **Create flag**

As in previous challenges, our new code will be disabled whether the flag is on or off. In order to allow our Developers to test the new feature, let's add targeting to our new flag.

1. In the **Quick start** section, select *Target segments*
1. From the **Segments** dropdown, select *Developers*
1. From the **Rollout** dropdown, select *Stripe Checkout Enabled*
1. Toggle the flag **On** in the upper left
1. Click **Review and save**, then **Save changes**

# Update Our Code

To complete our migration and ship the new API, we need to update our code to enable the new functionality. The `/src/pages/api/checkout.ts` file handles the API calls for our checkout functionality.

**Step 1:** Open the [Code Editor](#tab-2), and locate the `/src/pages/api/checkout.ts` file

**Step 2:** Replace lines 47-52 with the following code:
```js
//in this code, we are first retrieving the value for the enableStripe flag,
// then, if it returns true, running a function that creates a checkout session in stripe.
//If you want to see how that works, take a look at the `/src/utils/checkout-helpers.ts` file.

  if (req.method === 'POST') {
  const enableStripe = await ldClient.variation("enableStripe", jsonObject, false);

    if (enableStripe) {
      createCheckoutForStripe(req, res)
    }
  } if (req.method === 'GET') {
    const enableStripe = await ldClient.variation("enableStripe", jsonObject, false);

    if (enableStripe) {
      try {
        res.send("You are good to go!");
      } catch (error: any) {
        console.error(error.message);
      }
    } else {
      return res.json("the API is unreachable");
    }
  }
```

Switch to the [Toggle Outfitters](#tab-1) tab, and you will now be able to click *Add to Cart* successfully!

Nice work!
