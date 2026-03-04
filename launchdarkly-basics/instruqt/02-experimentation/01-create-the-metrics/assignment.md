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

# Creating the First Metric

Our first metric will keep track of the total price of all items the user has in their cart.

1. From the left-hand navigation menu, click **Metrics**
2. Click the **Create** button in the upper right-hand corner and select **Create metric**
3. From the **Event kind** dropdown, select **Custom**
4. For the **Event key**, enter:
```text
in-cart-total-price
```
5. For **What do you want to measure**, select **Value / Size**:
6. For **Choose how multiple event values are aggregated per unit**, select **Average**
7. For **Metric definition**:
   1. From the first dropdown, select **Average**
   2. From the second dropdown, check **audience** and uncheck any other values
   3. From the third dropdown, select **higher is better**
8. For **Units without events**, select **Exclude units that did not send any events from the analysis**
9. For **Unit of measure**, enter:
```text
USD
```
10. For **Metric name**, enter:
```text
In-Cart Total Price
```
11. For **Tags**, enter:
```text
experiment
```
12. For **Description**, enter:
```text
Total Price of Items in Cart
```
13. Click **Create metric**

# Implementing Metrics

As we create metrics, we'll want to make sure we place them in our code. Using the LaunchDarkly SDK, we can easily track our metrics in meaningful locations. In our Galaxy Marketplace app, the metrics have already been added, but you can review their implementation in the following locations by clicking on the [Code Editor](#tab-2) tab.

Key: `in-cart-total-price`

File: `/components/ui/marketcomponents/featureexperimentgenerator.tsx`

Line 44:
```javascript,nocopy
38    if (cartSuggestedItems) {
39        totalPrice = Math.floor(Math.random() * (500 - 300 + 1)) + 300;
40        let probablity = Math.random() * 100;
41        if( probablity < 50 ) {
42            client?.track("upsell-tracking", client.getContext());
43        }
44        client?.track("in-cart-total-price", client.getContext(), totalPrice);
45    }
```

Line 52:
```javascript,nocopy
46    else {
47        totalPrice = Math.floor(Math.random() * (300 - 200 + 1)) + 200;
48        let probablity = Math.random() * 100;
49        if( probablity < 50 ) {
50            client?.track("upsell-tracking", client.getContext());
51        }
52        client?.track("in-cart-total-price", client.getContext(), totalPrice);
53    }
```

File: `/components/ui/marketcomponents/funnelexperimentgenerator.tsx`

Line 81:
```javascript,nocopy
79    if (stage4metric < metric4) {
80        client?.track("customer-checkout", client.getContext())
81        client?.track("in-cart-total-price", client.getContext(), totalPrice)
82
83    }
```

File: `/components/ui/marketcomponents/storecart.tsx`

Line 68:
```javascript,nocopy
66    const checkOutTracking = () => {
67      LDClient?.track("customer-checkout", LDClient.getContext(), 1);
68      LDClient?.track("in-cart-total-price", LDClient.getContext(), totalCost);
69    };
```

# Create Our Next Metric

Let's create our next metric, which will be used for in our funnel experiment. Switch back over to the [LaunchDarkly](#tab-0) tab to continue.

1. From the left-hand navigation menu, click **Metrics**
2. Click the **Create** button in the upper right-hand corner and select **Create metric**
3. From the **Event kind** dropdown, select **Custom**
4. For the **Event key**, enter:
```text
upsell-tracking
```
5. For **What do you want to measure**, select **Occurrence**
6. For **Metric definition**:
   1. From the first dropdown, check **audience** and uncheck any other values
   2. From the second dropdown, select **higher is better**
7. For **Metric name**, enter:
```text
In-Cart Upsell
```
8. For **Tags**, enter:
```text
funnel-experiment
```
9. For **Description**, enter:
```text
Upsell opportunities in cart
```
10. Click **Create metric**

# Implementing Our Second Metric

These metrics are placed directly in strategic locations in your code using the LaunchDarkly SDK. As before, these have already been added in the code. To see how they're used, switch over to the [Code Editor](#tab-2) tab and review their placements in the following files and lines.

Key: `upsell-tracking`

File: `/components/ui/marketcomponents/featureexperimentgenerator.tsx`

Line 42:
```javascript,nocopy
38    if (cartSuggestedItems) {
39        totalPrice = Math.floor(Math.random() * (500 - 300 + 1)) + 300;
40        let probablity = Math.random() * 100;
41        if( probablity < 50 ) {
42            client?.track("upsell-tracking", client.getContext());
43        }
44        client?.track("in-cart-total-price", client.getContext(), totalPrice);
45    }
```

Line 50:
```javascript,nocopy
46    else {
47        totalPrice = Math.floor(Math.random() * (300 - 200 + 1)) + 200;
48        let probablity = Math.random() * 100;
49        if( probablity < 50 ) {
50            client?.track("upsell-tracking", client.getContext());
51        }
52        client?.track("in-cart-total-price", client.getContext(), totalPrice);
53    }
```

File: `/components/ui/marketcomponents/suggestedItems.tsx`

Line 41:
```javascript,nocopy
39    const addedSuggestedItemToCart = (item: InventoryItem) => {
40        setCart([...cart, item]);
41        LDClient?.track("upsell-tracking", LDClient.getContext());
42    }
```

File: `/components/ui/marketcomponents/stores/storecart.tsx`
Line 61:
```javascript,nocopy
60    const continueShopping = () => {
61      LDClient?.track("upsell-tracking", LDClient.getContext());
62
63      router.push("/marketplace");
64    };
```

Now that our metrics are setup and tracked in our code, we can move on to the next component: our flags!

