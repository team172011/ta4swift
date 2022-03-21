# Working Notes

---
## Cache

The cache is based on dates and date intervalls. It can be parameterized to define the size (`timeSpan`) and the amount of update iterations (`updateIntervall`).

### Example

The cache holds values for the following intervall (2022-03-19 -> 2022-03-26)
 - parameter `timeSpan` = **5** (days)
 - parameter `updateIntervall` = **10** (days)

This means the cache would be updated **every 10 days**. **Every 10 days** the timespan will get reduced so that the oldest entry in the cache is not older than **5 days**.



Cache: 2022-03-19, 2022-03-20, 2022-03-21, 2022-03-22, 2022-03-23, 2022-03-24, 2022-03-25, 2022-03-26 (last udpated 2022-03-09)

 - The cache gets updated with a value for 2022-03-27 the last updated date of the cache is 2022-03-09
 - `2022-03-27 - 2022-03-09 = 18` -> older than 10 days that means the following action will happen:
    - `2022-3-27 - 5 days = 2022-3-22` -> everything older than `2022-3-22` will be deleted

New Cache: 2022-03-22, 2022-03-23, 2022-03-24, 2022-03-25, 2022-03-26, 2022-03-27 (last updated 2022-03-27)

