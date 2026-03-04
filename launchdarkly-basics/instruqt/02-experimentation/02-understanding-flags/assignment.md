---
slug: understanding-flags
id: noydjrthnzox
type: challenge
title: Understanding Feature Flags
teaser: Feature flags are an important part of running proper experiments
notes:
- type: text
  contents: Using feature flags as a foundation for experiments gives us ultimate
    control. Features created for the experiment can be deployed to production at
    any time, then toggled on when the experiment is ready!
tabs:
- id: jq9djsmqcn9s
  title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- id: yreqyyl78ukw
  title: Galaxy Marketplace
  type: service
  hostname: workstation
  port: 3000
- id: oew0ykq9gus3
  title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: basic
timelimit: 600
---

# Lab 2

When experiments are built on top of flags, it gives
us a great deal of flexibility. In this lab, we'll create
a basic feature flag for releasing a new site banner.

We're not quite ready to build our experiment, but this
exercise will help us understand how to implement a flag
inside our code.

# Create the First Flag

Our first flag is a simple boolean flag meant for turning on
and off a feature within the application. From the [LaunchDarkly](#tab-0) tab, follow the steps below.

1. From the left-hand navigation menu, click **Flags**
2. Click the **Create flag** button in the upper right-hand corner
3. For **Name**, enter:
```text
Featured Store Headers
```
4. For **Description**, enter:
```text
Headers to drive engagement on stores
```
5. Under **Configuration**, select **Release**
6. Click **Create flag** in the lower right-hand side of the screen.

# Implementing the Flag

The first thing we need to do in our application is initialize the
LaunchDarkly client. First, we import the library. In the
[Code Editor](#tab-2) tab, navigate to the following file.

File: `/pages/_app.tsx`

Line 5:
```javascript,nocopy
import { asyncWithLDProvider } from "launchdarkly-react-client-sdk";
```

Then we initialize the client. Make note of the `useCamelCaseFlagKeys`
option. We'll come back to that later.

Line 23:
```javascript,nocopy
23  const LDProvider = await asyncWithLDProvider({
24    clientSideID: process.env.NEXT_PUBLIC_LD_CLIENT_KEY || "",
25    reactOptions: {
26      useCamelCaseFlagKeys: true,
27    },
    ...
55  });
```

Next, we obtain our flag evaluations and use those values to enable
features in our code.

File: `/components/ui/marketcomponents/stores/ProductInventoryComponent.tsx`

Line 55:
```javascript,nocopy
55    const { storeHighlightText, featuredStoreHeaders } = useFlags();
```

Line 68:
```javascript,nocopy
67    onClick={() => {
68      featuredStoreHeaders ? storeOpened() : null;
69    }}
```

Line 72:
```javascript,nocopy
72    {featuredStoreHeaders && (
73      <motion.div ... >
        ...
90      </motion.div>
91    )}

```

On lines 68 and 72, you'll see where our flag key is referenced
as `featuredStoreHeaders`. The LaunchDarkly React SDK automatically converted
our default key of `featured-store-headers` to camelCase based on the option
`useCamelCaseFlagKeys` we set to `true`.

# Testing the Flag

Now let's see what this flag is doing for us. Switch back to the
[LaunchDarkly](#tab-0) tab, and turn the flag on. You should still
be on the flag's property page.

1. At the top-left of the flag's page, toggle the flag to **On**
2. At the bottom of the page, click **Review and save**, then **Save changes**.

Back over to the [Galaxy Marketplace](#tab-1), under the **Popular Shops**
section, you won't see any changes! Why?

By default, Release flags are evaluated to `false` regardless of the flag's
state--whether **On** or **Off**. That's to ensure that no content will be
served if someone accidentally turns this flag on before it's ready.

Switch back to the [LaunchDarkly](#tab-0) tab. Scroll to the end of the
flag's property page and let's roll this new feature out.

1. In the last section, titled **Default rule**, click **Edit** on the right side.
2. Under **Variation** change **Serve** to **Available**.
3. At the bottom, click **Review and save**, the **Save changes**.

Now, when we view the [Galaxy Marketplace](#tab-1) tab and look under **Popular Shops**,
we see a bright ribbon on the top right of each store's icon.

Great work! You've successfully created and implemented a feature flag! Next,
we'll begin optimizing our customers' experience by using LaunchDarkly's
experimentation feature.
