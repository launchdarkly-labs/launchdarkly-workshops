Experimentation Workshop
LD Project: Instruqt Experiment

FEATURE EXPERIMENT:
1. Create metric: `In-Cart Total Price`
2. Create metric: `In-Cart Upsell`
3. Create flag: `Featured Store Headers`
4. Create flag: `Store Highlight Text`
5. Create flag: `Cart Suggested Items`

REVIEW CODE:
1. Init: `/pages/_app.tsx`, lines 23-55

ADD CODE:
-- Cart suggested items
1. `/components/ui/marketcomponents/stores/StoreCart.tsx`: line 38
add `const { cartSuggestedItems } = useFlags();`
2. `/components/ui/marketcomponents/stores/StoreCart.tsx`: line 138
replace `false` with `cartSuggestedItems`
-- Store Highlight Text
3. `/components/ui/marketcomponents/stores/ProductInventoryComponent.tsx`: line 57
add `const { storeHighlightText, featuredStoreHeaders } = useFlags();`
4. `/components/ui/marketcomponents/stores/ProductInventoryComponent.tsx`: line 87
replace `Sale` with:
```
{storeHighlightText?.split("").map((char, index) =>
 	char === " " ? <span key={index}>&nbsp;</span> : <span key={index}>{char}</span>
)}
```
-- Featured Store Headers
5. `/components/ui/marketcomponents/stores/ProductInventoryComponent.tsx`: line 69
replace `false` with `featuredStoreHeaders`
6. `/components/ui/marketcomponents/stores/ProductInventoryComponent.tsx`: line 73
replace `false` with `featuredStoreHeaders`

7. Create Feature Experiment: `Upsell tracking Experiment`
8. Turn on flag
9. Start

CODE UPDATE:
1. `in-cart-total-price` tracked:
  * `/components/ui/marketcomponents/FeatureExperimentGenerator.tsx`, line 44
  * `/components/ui/marketcomponents/FeatureExperimentGenerator.tsx`, line 52
  * `/components/ui/marketcomponents/FunnelExperimentGenerator.tsx`, line 81
  * `/components/ui/marketcomponents/stores/StoreCart.tsx`, line 69
2. `upsell-tracking` tracked:
  * `/components/ui/marketcomponents/FeatureExperimentGenerator.tsx`, line 42
  * `/components/ui/marketcomponents/FeatureExperimentGenerator.tsx`, line 50
  * `/components/ui/marketcomponents/SuggestedItems.tsx`, line 42
  * `/components/ui/marketcomponents/stores/StoreCart.tsx`, line 62



FUNNEL EXPERIMENT:
1. Create metric: `Store Accessed`
2. Create metric: `Item Added to Cart`
3. Create metric: `Cart Accessed`
4. Create metric: `Customer Checkout`
5. Create metric group: `Store Purchases`
6. Create experiment: `Grow engagement with key stores`

CODE UPDATE:
1. `store-accessed` tracked:
  * `/components/ui/marketcomponents/FunnelExperimentGenerator.tsx`, line 68
  * `/components/ui/marketcomponents/stores/ProductInventoryComponent.tsx`, line 60
2. `item-added-to-cart` tracked:
  * `/components/ui/marketcomponents/FunnelExperimentGenerator.tsx`, line 72
  * `/pages/marketplace.tsx`, line 52
3. `cart-accessed` tracked:
  * `/components/ui/marketcomponents/FunnelExperimentGenerator.tsx`, line 76
  * `/components/ui/marketcomponents/stores/StoreCart.tsx`, line 48
4. `customer-checkout` tracked:
  * `/components/ui/marketcomponents/FunnelExperimentGenerator.tsx`, line 80
  * `/components/ui/marketcomponents/stores/StoreCart.tsx`, line 68



NOTES:
storeAttentionCallout = storeHighlightText
storeHeaders = featuredStoreHeaders
