---
slug: flag-prerequisites
id: suril9mgvk7w
type: challenge
title: Preventing Misconfiguration With Flag Prerequisites
teaser: Use prerequisites to enforce the correct order of flag enablement
notes:
- type: text
  contents: |-
    Sometimes flags have dependencies — one feature can only work if another
    is already on. Flag prerequisites let you enforce these relationships
    directly in LaunchDarkly, so operators can't accidentally enable a feature
    that isn't ready to run.
tabs:
- id: ueg1aoljhdyv
  title: LaunchDarkly
  type: browser
  hostname: launchdarkly
- id: d2qk1hvbly6x
  title: Coffee Supply Co.
  type: service
  hostname: workstation
  port: 3000
difficulty: ""
timelimit: 600
enhanced_loading: null
---

# Lab 5

# The Problem: Dependent Features

In the last lab, you added two promotional flags. In this scenario, **Coffee Promo 2** ("15% Off House Espresso Beans") is a follow-up promotion that only makes business sense if **Coffee Promo 1** ("Buy 5 Syrups, Get 1 Free") is already running.

If an operator enables Promo 2 without Promo 1 being on, the promotions section renders in an odd, incomplete state. We want to make this impossible.

# Set a Prerequisite

1. Switch to [LaunchDarkly](#tab-0).
1. Click **Flags** in the left navigation menu.
1. Click **Coffee Promo 2**.
1. Under Targeting Configuration for Test, click **View targeting rules**.
1. Click **+ Add prerequisites**.
1. From the flag dropdown, select **Coffee Promo 1**.
1. From the variation dropdown, select **Promo Visible** (the `true` variation — meaning Promo 1 must be **on**).
1. Click **Review and save**, then **Save changes**.

# See It Work

Now try enabling Coffee Promo 2 without Coffee Promo 1:

1. Make sure **Coffee Promo 1** is **Off**.
1. Try to turn **Coffee Promo 2** **On**.

LaunchDarkly will warn you that the prerequisite isn't met — Promo 2 cannot serve its `true` variation while Promo 1 is off. This eliminates an entire category of operational mistakes.

Turn both flags on to verify both promotions appear correctly on the [Coffee Supply Co.](#tab-1) site.
