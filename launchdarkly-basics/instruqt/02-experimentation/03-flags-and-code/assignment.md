---
slug: flags-and-code
id: bhyrttdswfvo
type: challenge
title: Flags and Code
teaser: Learn how to
notes:
- type: text
  contents: TODO - Replace this text with your own text
tabs:
- id: yqnc68o3dezo
  title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- id: maidffea5lr4
  title: Galaxy Marketplace
  type: service
  hostname: workstation
  port: 3000
- id: zl0obykcmhxg
  title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: basic
timelimit: 600
---

# Lab 3

Up to this point, we've just had you create resources in LaunchDarkly while we've provided the code for you. Now let's create some flags and show you how to add the code yourself! There are still two more flags to create, so let's get started!

# First Additional Flag

1. From the left-hand navigation menu, click **Flags**
2. Click the **Create flag** button in the upper right-hand corner
3. For **Name**, enter:
```text
Cart Suggested items
```
4. For **Description**, enter:
```text
Show suggested cart component
```
5. Under **Configuration**, select **Release**
6. Under **Variations**, replace **Available** in the **Name** field with:
```text
Suggested Cart Component
```
7. Under **Variations**, replace **Unavailable** in the following **Name** field with:
```text
Continue Shopping Button
```
8. Click **Create flag** in the lower right-hand side of the screen.

# Second Additional Flag

1. From the left-hand navigation menu, click **Flags**
2. Click the **Create flag** button in the upper right-hand corner
3. For **Name**, enter:
```text
Store Highlight Text
```
4. For **Description**, enter:
```text
Header text for store headers
```
5. Under **Configuration**, select **Experiment**
6. Under **Variations**, enter the following names and values:
   a. **Name**:
```text
Control
```
   b. **Value**:
```text
New Item
```
   c. **Name**:
```text
Sale
```
   d. **Value**:
```text
Sale
```
   e. **Name**:
```text
Final Sale
```
   f. **Value**:
```text
Final Sale!
```
7. Click **Create flag** in the lower right-hand side of the screen.

# Add Flags to Our Code

Now that all of our flags for our A/B experiment are ready, let's add functionality to our code.

**NOTE**: When replacing lines in the code, it's important to make sure add or remove lines so that the subsequent line numbers aren't altered.

In the [Code Editor](#tab-2), locate the following file:
`/components/ui/marketcomponents/storecart.tsx`

1. Scroll to line 36. This will be a blank line.
2. **Replace** this line with the following code:
```javascript
const { cartSuggestedItems } = useFlags();
```

Remember that we've converted our flags keys to camelCase. This line we just added evaluates the `cartSuggestedItems` flag by calling `useFlags()` available in the SDK.

Next, we'll add a decision in our code as to whether or not to show suggested items based on that evaluation.

1. Scroll to line 136. This should currently read `{false ? (`
2. **Replace** just the keyword `false` with our flag variable:
```javascript
cartSuggestedItems
```

Still in the [Code Editor](#tab-2), locate the following file:
`/components/ui/marketcomponents/ProductInventoryComponent.tsx`

Notice in line 55 where we call the `useFlags()` SDK function to get our flag evaluations.

1. Scroll to line 68. This should currently read `false ? storeOpened() : null;`
2. **Replace** just the keyword `false` with our flag variable:
```javascript
featuredStoreHeaders
```

Next:

1. Scroll to line 72. This should currently read `{false && (`
2. **Replace** just the keyword `false` with our flag variable:
```javascript
featuredStoreHeaders
```

Finally:

1. Scroll to line 86. This should currently read `Sale`
2. **Replace** this line with the following code:
```javascript
{storeHighlightText?.split("").map((char, index) =>
 	char === " " ? <span key={index}>&nbsp;</span> : <span key={index}>{char}</span>
)}
```

Now that we have our feature flags and code ready, we can create our experiment. We'll tackle that in the next challenge!
