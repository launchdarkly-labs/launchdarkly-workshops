---
slug: guarded-rollouts
id: kgs8tcmpwa1m
type: challenge
title: Guarded Releases
teaser: Say goodbye to downtime and release without the headaches
notes:
- type: text
  contents: Guardian Edition provides you with the capabilities to reduce the risk
    in your releases by getting ahead of potential rollout issues.
tabs:
- id: cynygvji8am5
  title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- id: 12r9dvhdw6d7
  title: Toggle Outfitters
  type: service
  hostname: workstation
  port: 3000
- id: ehbkzdjvuzgs
  title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: ""
timelimit: 600
enhanced_loading: null
---

# Lab 9

Traditional release methods lack integrated analysis of business and technical metrics, leaving teams blind to the broader impact of changes on customer experience and system performance. Without real-time data, teams rely on manual event instrumentation and threshold tuning, which is slow, error-prone, and offers only partial automation.

# Guardian Edition

Enter Guardian Edition!

Guardian Edition provides a suite of tools
to not only fine-tune automated rollbacks, but also lets you define
specific metrics to monitor and even run playback sessions. All of
this is tied directly to specific feature releases, bringing even
greater visibility than has been possible.

# Guarded Rollouts

Guarded rollouts let you release your new feature to a percentage
of users, measuring metrics from both variations to determine
if the release is successful. If a metric breaches a threshold,
the release can be automatically rolled back in a matter of
seconds.

Imagine measuring latency or error rates directly in the application
instead of relying on external tools to collect reactive data.

Let's jump on in and see what a guarded rollout looks like.

First we need some metrics to measure results. We'll create two:
one for latency and one for error rates.

1. From the left-hand navigation menu, scroll down and click **Metrics**.
2. Click the **Create** button in the middle.
3. Select **Create metric**
4. Leave **Event kind** as **Custom**
5. For **Event key**, enter:
```
latency
```
6. For **What do you want to measure?**, select **Value / Size**.
7. For **Choose how multiple event values are aggregated per unit**, select **Average**.
8. For **Metric definition**, selections should be:
  1. **Average**
  2. **user**
  3. **lower is better**
9. For **Units without events**, select **Exclude units that did not send any events from the analysis**.
10. For **Unit of measure**, enter:
```
ms
```
11. For **Metric name**, enter:
```
Latency
```
12. Click **Create metric**

As you guessed, this metric is designed to track latency.
Next, we'll create a metric to track the error rate.

1. From the left-hand navigation menu, click **Metrics**.
2. Click the **Create** button in upper-right.
3. Select **Create metric**
4. Leave **Event kind** as **Custom**
5. For **Event key**, enter:
```
error-rate
```
6. For **What do you want to measure?**, select **Occurrence**.
7. For **Metric definition**, selections should be:
  1. **user**
  2. **lower is better**
8. For **Metric name**, enter:
```
Error Rate
```
12. Click **Create metric**

Finally, we need to attach these metrics to our flag.

1. From the left-hand navigation menu, click **Flags**.
2. Click the flag named **Brand New Rollout Feature**.
3. On the right-hand side, scroll down to **Guarded rollout metrics**.
4. Click **Add metrics**.


# Implementation

Now that we have the ability to receive events, let's
take a look at what the a sample implementation of code looks like to send events.

```javascript
// Get flag evaluation
let { brandNewRolloutFeature } = useFlags();
const client = useLDClient();

if (brandNewRolloutFeature) {
    // if we get the new variation:
    //
    // Every time we get an error, let's track it!
    // In this example, we're simulating how the
    // new feaure is generating errors 75% of the time
    if (Math.random() < 0.75) {
        client.track("error-rate");
    }
    // Typically, latency will be calculated by
    // finding difference in ms between when a
    // procedure starts and when it stops. In this
    // example, we simulating higher latency than
    // the control variation
    dynamicValue = Math.floor(Math.random() * (170 - 150 + 1)) + 150;
    client.track("latency", undefined, dynamicValue);
  } else {
    // if we get the control variation:

    // The control variation is seeing significantly
    // less errors than the new variation
    if (Math.random() < 0.25) {
        client.track("error-rate");
    }
    // As we see here, the control variation performs
    // better than the new variation.
    dynamicValue = Math.floor(Math.random() * (60 - 50 + 1)) + 50;
    client.track("latency", undefined, dynamicValue);
}
```

In the code, tracking events is very simple and can quickly
be added alongside other events you track.

# Prepare to Release!

With our flag, metrics, and code in place, we're ready to
release our new feature! If it's not working correctly,
Guardian can automatically roll the flag back to it's
control variation.

1. From the [LaunchDarkly](#tab-0) tab, you should still
be viewing the **Brand New Rollout Feature** flag.
2. To the right of the **Default rule** heading, click
**Edit**.
3. In the **Default rule** section, from the dropdown next to **Serve**, select **Guarded rollout**
4. From the **Metrics to Monitor** dropdown, select **Error Rate**, and again **Latency**
5. Click **Save**
6.  Check the **Automatically roll back rule if a regression is detected** checkboxes.
7.   Click **Review and save**, then **Save changes**.

LaunchDarkly is now listening for events from your application.

Since this is just a simulation, we can stop the monitoring.

1. In the purple monitoring notification section, click **Stop rollout**.
2. Confirm the value for **Variation to serve**.
3. Leave a comment (like "testing"), then click **Stop**.
4. Click **Save changes**.

Congratulations! You've successfully learned how
to guard your releases with Guardian Edition!
