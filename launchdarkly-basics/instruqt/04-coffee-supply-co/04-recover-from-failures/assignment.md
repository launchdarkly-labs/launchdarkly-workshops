---
slug: recover-from-failures
id: dsyjlccgssbv
type: challenge
title: Recovering From Release Failures
teaser: Fix a bad release in seconds — no redeployment needed
notes:
- type: text
  contents: |-
    Even well-tested features can cause problems in production. When they do,
    the traditional fix is a rollback deploy — which takes time and causes
    extended downtime. With LaunchDarkly, recovery takes seconds.
tabs:
- id: lnstz8t4zxp0
  title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- id: 8ylpnvrwshth
  title: Coffee Supply Co.
  type: service
  hostname: workstation
  port: 3000
- id: 356fp0llim6o
  title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: basic
timelimit: 600
enhanced_loading: null
---

# Lab 4

# Launch Two New Promotions

The marketing team wants to run two limited-time promotions on the home page. You'll create flags for both and wire them into the application.

# Create the Flags

First, create flags for both promotions.

**Flag 1:**
1. Switch to [LaunchDarkly](#tab-0), click **Flags**, then **Create flag**.
1. For **Name**, enter:
```
Coffee Promo 1
```
3. Click **Create flag**.

**Flag 2:**
1. Click **Create flag** again.
1. For **Name**, enter:
```
Coffee Promo 2
```
3. Click **Create flag**.

# Add the Flags to the Code

1. Open the [Code Editor](#tab-2) and navigate to `/opt/ld/ld-sample-app-node/app.js`.
1. In the home route, add the following two lines alongside the existing `homePageSlider` evaluation:

```js
var coffeePromo1 = await ldclient.variation('coffee-promo-1', context, false);
var coffeePromo2 = await ldclient.variation('coffee-promo-2', context, false);
```

3. Update the `res.render` call to pass both values:

```js
res.render('index.html', {
    currentRouteRule: currentRouteRule,
    homePageSlider: homePageSlider,
    coffeePromo1: coffeePromo1,
    coffeePromo2: coffeePromo2
});
```

4. Save the file and restart the application:

```bash
pm2 restart ld-sample-app-node
```

# Simulate a Bad Release

Switch to [LaunchDarkly](#tab-0):

1. Click **Coffee Promo 1** and toggle it **On**. Save changes.

Switch to [Coffee Supply Co.](#tab-1) and reload — you should see the **"Buy 5 Syrups, Get 1 Free"** promotion.

Now imagine the promo went out with the wrong pricing. Customers are getting syrups for free instead of discounted. Every second costs money.

# Recover in Seconds

1. Switch back to [LaunchDarkly](#tab-0).
1. Toggle **Coffee Promo 1** **Off** and save.

Switch back to [Coffee Supply Co.](#tab-1) and reload — the promo is gone. No redeploy. No downtime. That's the power of a feature flag as a kill switch.

You've now added a second flag (`coffee-promo-2`) to the code as well. You'll use it in the next lab to explore flag dependencies.
