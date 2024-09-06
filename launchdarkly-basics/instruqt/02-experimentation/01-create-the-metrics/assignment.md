---
slug: create-the-metrics
id: gh2ckhorfabd
type: challenge
title: Getting Started using Metrics
teaser: Metrics are the foundation of every experiment
notes:
- type: text
  contents: Metrics help us track our users' interests and what guides them through
    using our app. This is challenge, we'll see just how simple metrics are to create!
tabs:
- id: luzujxycvfsv
  title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- id: vjwyrnkmdmk4
  title: Galaxy Marketplace
  type: service
  hostname: workstation
  port: 3000
- id: iwt86j8ytdck
  title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: basic
timelimit: 600
---

# Lab 1

Metrics are crucial for understanding application performance and usage. LaunchDarkly provides a few different types of metrics you can track. Let's take a look:

* **Custom events**: Used for custom conversion/binary metrics and custom numeric metrics. They track events when an end user takes a specific action, like completing a purchase or clicking a button.
* **Click events**: Used for custom click metrics. They track clicks on UI elements, which is perfect for knowing if that new button gets the attention it deserves.
* **Page view events**: Used for custom page view metrics. They track how many times a page is viewed, great for understanding user navigation.

In this lab, we're going to create two different metrics to track in our web app.

# Creating the first metric

Our first metric will keep track of the total price of all items the user has in their cart.

1. From the left-hand navigation menu, click **Metrics**
2. Click the **Create** button in the upper right-hand corner and select **Create metric**
3. For **Name**, enter:
```text
In-Cart Total Price
```
4. For **Description**, enter:
```text
Total Price of Items in Cart
```
5. For **Tags**, enter:
```text
experiment
```
6. Under **Event information**, select **Custom**
7. For the **Track event by creating your own settings** option, select **Numeric**
8. For **Event key**, enter:
```text
in-cart-total-price
```
9. For **Unit of measure**, enter:
```text
USD
```
10. For **Success criteria**, select **Higher than baseline**
11. Leave the next few options at default values, and scroll down to the last section titled **Randomization units**
12. Remove any values which might be in this field and select **audience** from the dropdown
13. Click **Create metric**

# Create our next metric

1. From the left-hand navigation menu, click **Metrics**
2. Click the **Create** button in the upper right-hand corner and select **Create metric**
3. For **Name**, enter:
```text
In-Cart Upsell
```
4. For **Description**, enter:
```text
Upsell opportunities in cart
```
5. For **Tags**, enter:
```text
funnel-experiment
```
6. Under **Event information**, select **Custom**
7. For the **Track event by creating your own settings** option, select **Conversion/binary**
8. For **Event key**, enter:
```text
upsell-tracking
```
9. For **Success criteria**, select **Higher than baseline**
10. Leave the next few options at default values, and scroll down to the last section titled **Randomization units**
11. Remove any values which might be in this field and select **audience** from the dropdown
12. Click **Create metric**

# What to do with these fancy new metrics!

These metrics are placed directly in strategic locations in your code using the LaunchDarkly SDK. These have already been added in the code. To see how they're used, switch over to the (Code Editor)[#tab-2] tab and review their placements in the following files and lines:

**/components/ui/marketcomponents/suggestedItems.tsx**, line 41:
```javascript
39    const addedSuggestedItemToCart = (item: InventoryItem) => {
40        setCart([...cart, item]);
41        LDClient?.track("upsell-tracking", LDClient.getContext());
42    }
```

**/components/ui/marketcomponents/stores/storecart.tsx**, line 61:
```javascript
60    const continueShopping = () => {
61      LDClient?.track("upsell-tracking", LDClient.getContext());
62
63      router.push("/marketplace");
64    };
```

Now that our metrics are setup and tracked in our code, we can move on to the next component: our flags!

