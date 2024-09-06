---
slug: flag-prerequisites
id: 92jkin18ky9g
type: challenge
title: Flag Prerequisites
teaser: Avoid flag dependency issues by setting up Prerequisites
notes:
- type: text
  contents: Not all flags are standalone. As we've seen, sometimes the code behind
    one or more flags must be operational before code with another flag can work properly.
    Prerequisites makes sure we can set those dependencies to avoid accidents.
tabs:
- id: lkdos4z20o6s
  title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- id: gpba4d6lsyoa
  title: Toggle Outfitters
  type: service
  hostname: workstation
  port: 3000
- id: oyuojji502il
  title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: basic
timelimit: 600
---

# Lab 7

Let's begin by taking a look at our failed migration from earlier. We have these two components:

* **Updated Billing IU** flag: controls the frontend UI components
* **Migrate to Stripe API** flag: controls the API connection with Stripe

The frontend changes (made available by the **Updated Billing IU** flag) don't work properly if the backend capabilities aren't enabled (the **Migrate to Stripe API** flag). In order to prevent this misconfiguration from creating errors for customers in the future we are going to make one flag a prerequisite to the other.

# Add a Prerequisite

1. Switch to the [LaunchDarkly](#tab-0) tab.
1. From the left-hand navigation menu, click **Flags**
1. Click **Updated Billing UI**
1. Click **+ Add rule** and choose **Set prerequisites**
1. From the **Flag** dropdown, select *Migrate to Stripe API*
1. Make sure **Variation** is set to *Stripe Checkout Enabled*
1. Click **Review and save**, then **Save changes**

Both the **Updated Billing UI** and the **Migrate to Stripe API** flags should already be off. So let's try the same scenario we did in the previous challenge.

1. From the left-hand navigation menu, click **Flags**
1. Click **Updated Billing UI**.
1. Click the On/Off toggle at the top left to turn the flag **On**.
1. Click **Review and save**, then **Save changes**.
1. From the left-hand navigation menu, click **Flags** again.
1. Verify the **Migrate to Stripe API** flag is, in fact, set to **Off**
1. Switch over to the [Toggle Outfitters](#tab-1) tab.
1. Login as **ron**, **leslie**, **april**, or **andy**.

You can see that even though the new shopping cart is enabled, it's not showing on our site! Since we made it mandatory that the **Migrate to Stripe API** be on, the **Updated Billing UI** will be not even be evaluated until that condition is met.

1. Switch back to the [LaunchDarkly](#tab-0) tab.
1. Click **Migrate to Stripe API**.
1. Click the On/Off toggle at the top left to turn the flag **On**.
1. Click **Review and save**, then **Save changes**.
1. Finally, switch over to the [Toggle Outfitters](#tab-1) tab.

Now the shopping cart is available AND you are able to add an item to your cart!
