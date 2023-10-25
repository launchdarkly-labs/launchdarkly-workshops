---
slug: recover-from-failures
id: 8twuyjs6k2ro
type: challenge
title: Recovering From Release Failures
teaser: Learn how to avoid rollbacks and data integrity issues
notes:
- type: text
  contents: Version 1 of our new webstore is pretty basic. It offers users a "contact
    us" form where they can inquire about specific toggles and get in touch with our
    toggle specialists. To respond to the ever growing demand of custom toggles in
    the market, we've decided to add a new feature to our webstore that will allow
    customers to purchase toggles directly from our website.
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

Adding a Shopping Cart
===

Rather than building a shopping cart on our own, we want to consume a cloud hosted payment service. Let's get started!

We'll create a new flag to handle our new billing user interface:

1. From the left-hand navigation menu, click **Feature Flags**
1. Click the **Create flag** button in the upper right-hand corner
1. Select **Release**, then click **Next**
1. For **Name**, enter `Updated Billing UI`
1. For **Key**:
   1. Click the pencil
   1. Enter `billing`
   1. Click **Next**
1. For **Flag variations**:
   1. Select **Boolean**
   1. For the first **Name**, enter `Enable Stripe`
   1. For the second **Name**, enter `Self-hosted Form`
1. For **Default variations**, select *Self-hosted Form* for both **ON** and **OFF**
1. Click **Advanced configuration**, and check the **SDKs using Client-side ID** box
1. Click **Create flag**

The settings we've created for this flag will prevent our new feature from being seen by everyone--whether the flag is on or off. But we do want our developers to begin testing the new feature, so let's add a targeting rule which just allows those in the Developers segment to use the new feature.

1. In the **Quick start** section, select *Target segments*
1. From the **Segments** dropdown, select *Developers*
1. From the **Rollout** dropdown, select *Enable Stripe*
1. Toggle the flag **On** in the upper left
1. Click **Review and save**, then **Save changes**


Next: Add the Code
===

Within our application, we need to implement the new feature that will be controlled via this `billing`` feature flag.

**Step 1:** Open the [Code Editor](#tab-2), and locate the `/src/components/inventory.tsx` file.

**Step 2:** Scroll to close to the bottom of the file and locate the `\<ReserveButton /\>` object. Replace the entire `\<ReserveButton /\>` code with the following:

```js
{
  billing ? (
    <AddToCartButton
      product={product}
      errorTesting={errorTesting}
      clickHandler={addToCartClickHandler}
    />
  ) : (
    <ReserveButton
      setHandleModal={setHandleModal}
      handleModal={handleModal}
      handleClickTest={handleClickTest}
      updateField={updateField}
      formData={{ name, email }}
      onButtonClick={onButtonClick}
    />
  )
}
{
  billing && (
    <ErrorDialog errorState={errorState} setErrorState={setErrorState} />
  )
}
```

After saving the file, we're ready to test this new feature!

**Step 3:** Switch over the the [Toggle Outfitters](#tab-1) tab, and if you're still logged in, you will see the **Reserve Yours** button has changed to **Add to cart**.

Verify only developers can see the new functionality by logging out. Then log back in as **ron**, **leslie**, or **april**.

Finally: Run a Quick Test...
===

Make sure you're logged in as **ron**, **leslie**, or **april**, then click the **Add to Cart** button on one of the items.

Whoops! It looks like there's an error in our system.

Unfortunately, buggy code sometimes makes it's way into production no matter how much you test. In traditional software delivery scenarios, if the bug is bad enough, this is a rollback or redeployment moment. Then it's sitting for a few hours hoping that rollback pipeline is successful. With LaunchDarkly, we can recover from this failure in seconds.

1. Go back to the [LaunchDarkly](#tab-0) tab.
1. Navigate to the Feature Flags, and toggle the **Updated Billing UI** flag to **Off**.
1. Click **Save changes**

Review the [Toggle Outfitters](#tab-1) site once more, and even though you're logged in as a developer, we can no longer see the new **Add to Cart** function since the entire feature is now off.

Great work!