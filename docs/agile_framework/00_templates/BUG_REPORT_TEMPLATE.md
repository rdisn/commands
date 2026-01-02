# Bug Report: BUG-XXX [Bug Title]

**Reported By:** [LLM-QA / User Name]
**Report Date:** YYYY-MM-DD
**Related User Story:** US-XXX (if applicable)
**Test Plan:** TEST-XXX (if found during QA)
**Status:** [New/In Progress/Fixed/Wont Fix/Duplicate/Cannot Reproduce]
**Severity:** [Critical/High/Medium/Low]
**Priority:** [P0/P1/P2/P3]

---

## Bug Summary

**Brief Description:** [One-line summary of the bug]

**Detailed Description:**
[Detailed explanation of what's wrong and the impact]

---

## Severity Classification

**Severity:** [Critical/High/Medium/Low]

**Severity Definitions:**
- **Critical:** System crash, data loss, security vulnerability, blocks all users
- **High:** Major functionality broken, blocks core workflows, affects many users
- **Medium:** Feature not working as expected, workaround exists, affects some users
- **Low:** Minor issue, cosmetic problem, affects few users

**Why this severity:**
[Explain why you assigned this severity level]

---

## Environment Information

**Environment:** [Production/Staging/Development]
**URL:** [Exact URL where bug occurs]
**Database:** [Database name if relevant]

**Browser Information:**
- **Browser:** [Chrome/Firefox/Safari/Edge]
- **Version:** [Browser version]
- **OS:** [Windows/Mac/Linux/iOS/Android]
- **Device:** [Desktop/Mobile/Tablet]
- **Screen Resolution:** [e.g., 1920x1080 or iPhone 12]

---

## Steps to Reproduce

**Preconditions:**
- [Any setup required before reproducing]
- [User role/permissions needed]
- [Specific data or state required]

**Steps:**
1. Navigate to [URL/page]
2. Click on [specific element with ID or class if known]
3. Enter [specific data] into [field name]
4. Click [button name]
5. Observe [what happens]

**Reproducibility:** [Always/Sometimes/Once]
**How often:** [X out of Y attempts]

---

## Expected vs Actual Behavior

**Expected Result:**
[Detailed description of what should happen]

**Actual Result:**
[Detailed description of what actually happens]

**Visual Proof:**
[Screenshot or screen recording]
![Bug Screenshot](path/to/screenshot.png)

---

## Error Messages

**Console Errors:**
```
[Paste JavaScript console errors if any]
```

**PHP Errors:**
```
[Paste PHP error messages if any]
```

**Network Errors:**
```
[Paste network request failures if any]
```

---

## Technical Analysis

**Affected Files (if known):**
- `[path/to/file1.php]` - [Brief description of issue]
- `[path/to/file2.css]` - [Brief description of issue]
- `[path/to/file3.js]` - [Brief description of issue]

**Suspected Root Cause:**
[Your theory about what's causing the bug]

**Database Issues (if applicable):**
- Table: [table_name]
- Query: [problematic query if known]
- Data: [problematic data state]

---

## Impact Assessment

**User Impact:**
- **Number of Users Affected:** [All/Many/Some/Few]
- **Frequency:** [Every time/Often/Rarely]
- **Workaround Available:** [Yes/No]
- **Workaround:** [If yes, describe the workaround]

**Business Impact:**
- [ ] Blocks revenue
- [ ] Damages reputation
- [ ] Security risk
- [ ] Compliance issue
- [ ] UX degradation
- [ ] Performance issue

**Dependencies:**
[Does this bug block other features or user stories?]

---

## Workaround (If Available)

**Temporary Solution:**
[Steps users can take to work around the bug until it's fixed]

1. [Workaround step 1]
2. [Workaround step 2]

---

## Suggested Fix (Optional)

**Proposed Solution:**
[If you have an idea of how to fix this, describe it]

**Files to Modify:**
- `[file1]` - [Changes needed]
- `[file2]` - [Changes needed]

**Code Changes:**
```php
// Example of proposed fix
[Code snippet if you have one]
```

---

## Related Issues

**Duplicate Of:** [BUG-XXX if this is a duplicate]
**Related Bugs:** [BUG-XXX, BUG-YYY if related]
**Blocks:** [US-XXX or BUG-XXX if this blocks other work]
**Blocked By:** [US-XXX or BUG-XXX if this can't be fixed until something else is done]

---

## Testing Notes

**How to Verify Fix:**
1. [Step to verify fix works]
2. [Step to verify fix works]
3. [Verify no regressions]

**Regression Test Cases:**
- [ ] [Related feature 1 still works]
- [ ] [Related feature 2 still works]

---

## Additional Context

**Recent Changes:**
[Was this working before? What changed recently?]

**Related Code:**
[Link to relevant code sections if you know them]

**Stack Trace (if applicable):**
```
[Full stack trace if available]
```

---

## Attachments

- [ ] Screenshot of bug
- [ ] Screen recording demonstrating bug
- [ ] Console log export
- [ ] Network request/response data
- [ ] Database dump (if relevant)

**Files:**
- [Attachment 1: screenshot.png]
- [Attachment 2: video.mp4]

---

## Assignment

**Assigned To:** [Developer name or LLM-DEV]
**Assigned Date:** [YYYY-MM-DD]
**Target Fix Date:** [YYYY-MM-DD]
**Sprint:** [Sprint number if scheduled]

---

## Resolution

**Resolution Status:** [Fixed/Wont Fix/Duplicate/Cannot Reproduce/By Design]

**Resolution Details:**
[How was this bug resolved?]

**Fix Implemented:**
[Description of the fix]

**Files Changed:**
- `[file1]` - [What was changed]
- `[file2]` - [What was changed]

**Commit:** [Git commit hash/link]
**Pull Request:** [PR number/link]
**Code Review:** CR-XXX

---

## Verification

**Verified By:** [LLM-QA]
**Verification Date:** [YYYY-MM-DD]
**Verification Status:** [Pass/Fail]

**Verification Notes:**
[QA notes after verifying the fix]

**Regression Testing:**
- [ ] Original issue resolved
- [ ] No new issues introduced
- [ ] Related features still working

---

## Production Deployment

**Deployed To Production:** [Yes/No]
**Deployment Date:** [YYYY-MM-DD]
**Release Version:** [Version number]

**Post-Deployment Verification:**
- [ ] Bug confirmed fixed in production
- [ ] No user reports of issue
- [ ] Monitoring shows normal behavior

---

## Lessons Learned

**What Went Wrong:**
[Analysis of why this bug occurred]

**Prevention:**
[How can we prevent this type of bug in the future?]

**Process Improvements:**
[Any process changes recommended]

---

## Change Log

| Date | Action | By | Notes |
|------|--------|-----|-------|
| YYYY-MM-DD | Bug reported | LLM-QA | Initial report |
| YYYY-MM-DD | Bug triaged | LLM-TL | Assigned to dev |
| YYYY-MM-DD | Fix implemented | LLM-DEV | PR submitted |
| YYYY-MM-DD | Fix verified | LLM-QA | Ready for production |
