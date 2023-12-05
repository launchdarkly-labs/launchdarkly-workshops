---
slug: recover-from-failures
id: 8twuyjs6k2ro
type: challenge
title: Recovering From Release Failures
teaser: Learn how to avoid rollbacks and data integrity issues
notes:
- type: text
  contents: Our initial version of our website is pretty basic. It allows visitors to 
    reach out to us to place an order, but customers now we want to enable customers to 
    directly from our website without the need to talk to a representative.
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

Instead of building our own shopping cart, let's use an existing framework. This will make it very easy to implement and maintain.

Let's start by creating a new flag to handle our new billing user interface:

1. From the left-hand navigation menu, click **Feature Flags**
1. Click the **Create flag** button in the upper right-hand corner
1. Select **Release**, then click **Next**
1. For **Name**, enter `Updated Billing UI`
1. For **Key**:
   1. Click the pencil
   1. Enter `billing`
   1. Click the **blue** checkmark to the right
   1. Click **Next**
1. For **Flag variations**:
   1. Select **Boolean**
   1. First **Name**: `Enable Stripe`
   1. Second **Name**: `Self-hosted Form`
1. For **Default variations**, select *Self-hosted Form* for both **ON** and **OFF**
1. Click **Advanced configuration**, and check the **SDKs using Client-side ID** box
1. Click **Create flag**

The settings we've created for this flag will prevent our new feature from being seen by everyone--whether the flag is on or off. But we do want our developers to begin testing the new feature, so let's add a targeting rule which just allows those in the Developers segment to use the new feature.

1. In the **Quick start** section, select *Target segments*
1. From the **Segments** dropdown, select *Developers*
1. From the **Rollout** dropdown, select *Enable Stripe*
1. Toggle the On/Off flag to **On** in the upper left
1. Click **Review and save**, then **Save changes**


# Next: Add the Code

Within our application, we need to implement the new feature that will be controlled via this **Updated Billing UI** feature flag.

1. Open the [Code Editor](#tab-2), and locate the `/src/components/inventory.tsx` file.
2. Scroll to close to the bottom of the file and locate the `\<ReserveButton /\>` object, around line 131. Replace the entire `\<ReserveButton /\>` code with the following:

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
3. Save the file (^+S or ⌘+S, though it should autosave)

Switch over the the [Toggle Outfitters](#tab-1) tab. Login as **ron**, **leslie**, **april**, or **andy**, and you will see the **Reserve Yours** button has changed to **Add to cart**.


# Finally: Run a Quick Test

Make sure you're logged in as **ron**, **leslie**, **april**, or **andy**, then click the **Add to Cart** button on one of the items.

Whoops! It looks like there's an error in our system!

No matter how much testing we do, sometime buggy code can make it into our production environment. Fortunately, LaunchDarkly allows you to recovery in just seconds!

1. Go back to the [LaunchDarkly](#tab-0) tab.
1. Toggle the On/Off flag to **Off** in the upper left
1. Click **Review and save**, then **Save changes**

Review the [Toggle Outfitters](#tab-1) site once more, and even though you're logged in as a developer, we can no longer see the new **Add to Cart** function since the entire feature is now off.

Great work! In the next challenge, we'll see how we can further automate recoveries and make migrations a cinch!
