---
slug: guarded-rollouts
id: mjfcmw5oiawr
type: challenge
title: Guarded Releases
teaser: Automatically roll back when metrics regress
notes:
- type: text
  contents: |-
    Guardian Edition brings metric-based automation to your releases. Instead
    of relying on humans to notice a regression and manually roll back,
    LaunchDarkly monitors your custom metrics and can roll the flag back
    automatically the moment a threshold is breached.
tabs:
- id: 18dmf3dl6hzy
  title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- id: vllgu8fvaylf
  title: Coffee Supply Co.
  type: service
  hostname: workstation
  port: 3000
- id: qqvu6g8pfnd5
  title: Code Editor
  type: service
  hostname: workstation
  port: 8080
difficulty: ""
timelimit: 600
enhanced_loading: null
---

# Lab 6

A new `brand-new-rollout-feature` flag has been created for you. You'll set up metrics, attach them to this flag, and configure a guarded rollout that can automatically roll back if something goes wrong.

# Create the Metrics

First, create a metric to track **latency**.

1. From the left-hand navigation menu, click **Metrics**.
1. Click **Create**, then **Create metric**.
1. Leave **Event kind** as **Custom**.
1. For **Event key**, enter:
```
latency
```
5. For **What do you want to measure?**, select **Value / Size**.
1. For **aggregation**, select **Average**.
1. Set **lower is better**.
1. For **Units without events**, select **Exclude units that did not send any events**.
1. For **Unit of measure**, enter:
```
ms
```
10. For **Metric name**, enter:
```
Latency
```
11. Click **Create metric**.

Now create a metric to track **error rate**.

1. Click **Create**, then **Create metric**.
1. Leave **Event kind** as **Custom**.
1. For **Event key**, enter:
```
error-rate
```
4. For **What do you want to measure?**, select **Occurrence**.
1. Set **lower is better**.
1. For **Metric name**, enter:
```
Error Rate
```
7. Click **Create metric**.

# Attach Metrics to the Flag

1. From the left-hand navigation menu, click **Flags**.
1. Click **Brand New Rollout Feature**.
1. On the right-hand side, scroll down to **Guarded rollout metrics**.
1. Click **Add metrics** and add both **Latency** and **Error Rate**.

# What the Code Looks Like

Below is an example of how event tracking is implemented in a Node.js application using the LaunchDarkly server SDK. You don't need to edit any code — this is for reference.

```javascript
// Evaluate the flag
const flagValue = await ldclient.variation('brand-new-rollout-feature', context, false);

if (flagValue) {
    // New variation: simulates higher error rate and latency
    if (Math.random() < 0.75) {
        ldclient.track('error-rate', context);
    }
    const latency = Math.floor(Math.random() * (170 - 150 + 1)) + 150;
    ldclient.track('latency', context, latency);
} else {
    // Control variation: lower error rate and latency
    if (Math.random() < 0.25) {
        ldclient.track('error-rate', context);
    }
    const latency = Math.floor(Math.random() * (60 - 50 + 1)) + 50;
    ldclient.track('latency', context, latency);
}
```

Calling `ldclient.track()` sends a custom event to LaunchDarkly. Guardian Edition aggregates these events per variation and compares them against the thresholds you configure.

# Configure the Guarded Rollout

1. From the flag view, click **Edit** next to **Default rule**.
1. From the **Serve** dropdown, select **Guarded rollout**.
1. From the **Metrics to Monitor** dropdown, add **Error Rate** and **Latency**.
1. Check **Automatically roll back rule if a regression is detected** for both metrics.
1. Click **Review and save**, then **Save changes**.

LaunchDarkly is now listening. If your metrics breach their thresholds during a rollout, it will automatically revert the flag to the control variation.

Since this is a simulation, stop the rollout to wrap up:

1. In the purple monitoring notification, click **Stop rollout**.
1. Confirm the variation to serve.
1. Leave a comment (e.g., `testing`), then click **Stop**.
1. Click **Save changes**.

Congratulations — you now know how to guard a release with automated metric-based rollback!
