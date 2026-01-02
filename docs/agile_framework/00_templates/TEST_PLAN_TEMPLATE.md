# Test Plan: TEST-XXX [Feature Name]

**User Story:** US-XXX [Link to user story]
**Implementation Plan:** IMPL-XXX [Link to implementation plan]
**Sprint:** [Sprint Number]
**QA Engineer:** LLM-QA
**Test Date:** YYYY-MM-DD

---

## Test Overview

**Feature Description:** [Brief description of feature being tested]
**Test Scope:** [What will be tested]
**Out of Scope:** [What won't be tested]

---

## Test Environment

**Environment:** [Staging/Production]
**URL:** [Test environment URL]
**Database:** [Database name]
**Browser(s):** [Chrome, Firefox, Safari, Edge]
**Devices:** [Desktop, Mobile, Tablet]

---

## Acceptance Criteria from US-XXX

[Copy acceptance criteria from user story - these will become test cases]

1. [ ] [Acceptance Criterion 1]
2. [ ] [Acceptance Criterion 2]
3. [ ] [Acceptance Criterion 3]

---

## Test Cases

### Test Case 1: [Test Name]
**Priority:** [High/Medium/Low]
**Type:** [Functional/UI/Security/Performance]

**Preconditions:**
- [Condition 1: e.g., "User must be logged in as admin"]
- [Condition 2: e.g., "Database has at least 5 test records"]

**Test Steps:**
1. Navigate to [URL/page]
2. Click on [element]
3. Enter [data] in [field]
4. Click [button]
5. Observe [result]

**Expected Result:**
[Detailed description of expected behavior]

**Actual Result:**
[To be filled during testing]

**Status:** [Pass/Fail/Blocked/Skipped]

**Screenshots/Evidence:**
[Attach screenshots if needed]

**Notes:**
[Any observations or issues]

---

### Test Case 2: [Test Name]
**Priority:** [High/Medium/Low]
**Type:** [Functional/UI/Security/Performance]

**Preconditions:**
- [List preconditions]

**Test Steps:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Expected Result:**
[Expected behavior]

**Actual Result:**
[To be filled]

**Status:** [Pass/Fail/Blocked/Skipped]

---

### Test Case 3: Error Handling - [Scenario]
**Priority:** High
**Type:** Functional

**Preconditions:**
- [Setup for error scenario]

**Test Steps:**
1. [Steps to trigger error]
2. [Observe error handling]

**Expected Result:**
- User-friendly error message displayed
- System remains stable
- User can recover from error

**Actual Result:**
[To be filled]

**Status:** [Pass/Fail/Blocked/Skipped]

---

## Edge Case Testing

### Edge Case 1: Empty Data
**Scenario:** [Description]
**Expected:** [Behavior with no data]
**Status:** [Pass/Fail]

### Edge Case 2: Maximum Data
**Scenario:** [Description]
**Expected:** [Behavior with maximum data]
**Status:** [Pass/Fail]

### Edge Case 3: Invalid Input
**Scenario:** [Description]
**Expected:** [Validation error handling]
**Status:** [Pass/Fail]

---

## Browser Compatibility Testing

| Browser | Version | Desktop | Mobile | Status | Notes |
|---------|---------|---------|--------|--------|-------|
| Chrome | Latest | ✅/❌ | ✅/❌ | Pass/Fail | |
| Firefox | Latest | ✅/❌ | ✅/❌ | Pass/Fail | |
| Safari | Latest | ✅/❌ | ✅/❌ | Pass/Fail | |
| Edge | Latest | ✅/❌ | ✅/❌ | Pass/Fail | |

---

## Responsive Design Testing

| Viewport | Resolution | Status | Issues Found |
|----------|-----------|--------|--------------|
| Mobile | 320px-767px | Pass/Fail | |
| Tablet | 768px-1023px | Pass/Fail | |
| Desktop | 1024px+ | Pass/Fail | |

---

## Dark Mode Testing

- [ ] All components render correctly in dark mode
- [ ] Color contrast meets WCAG AA standards
- [ ] Theme switching works without page reload
- [ ] Dark mode state persists across sessions

**Status:** [Pass/Fail]
**Issues:** [List any dark mode issues]

---

## Accessibility Testing

### Keyboard Navigation
- [ ] All interactive elements reachable via Tab key
- [ ] Tab order is logical
- [ ] Enter/Space keys activate buttons
- [ ] Escape key closes modals/dropdowns
- [ ] Focus indicators visible

**Status:** [Pass/Fail]

### Screen Reader Testing
- [ ] All images have alt text
- [ ] Form labels properly associated
- [ ] ARIA labels on custom controls
- [ ] Error messages announced
- [ ] Status updates announced

**Screen Reader:** [NVDA/JAWS/VoiceOver]
**Status:** [Pass/Fail]

### Color Contrast
- [ ] Text meets WCAG AA standard (4.5:1)
- [ ] Large text meets AA standard (3:1)
- [ ] Interactive elements distinguishable

**Status:** [Pass/Fail]

---

## Security Testing

### XSS Testing
**Test:** [Inject script tags in form fields]
**Expected:** Input sanitized, no script execution
**Status:** [Pass/Fail]

### SQL Injection Testing
**Test:** [Input SQL commands in form fields]
**Expected:** Input sanitized, no database access
**Status:** [Pass/Fail]

### CSRF Testing
**Test:** [Submit form without CSRF token]
**Expected:** Request rejected
**Status:** [Pass/Fail]

### Authentication Testing
**Test:** [Access protected routes without login]
**Expected:** Redirect to login page
**Status:** [Pass/Fail]

### Authorization Testing
**Test:** [Access admin features as regular user]
**Expected:** Access denied
**Status:** [Pass/Fail]

---

## Performance Testing

### Load Time
**Metric:** Page load time
**Target:** < 2 seconds
**Actual:** [X seconds]
**Status:** [Pass/Fail]

### Database Queries
**Metric:** Number of queries per page load
**Target:** < 20 queries
**Actual:** [X queries]
**Status:** [Pass/Fail]

### Response Time
**Metric:** AJAX request response time
**Target:** < 500ms
**Actual:** [X ms]
**Status:** [Pass/Fail]

---

## Regression Testing

**Previously Working Features to Verify:**
- [ ] [Feature 1] - [Status]
- [ ] [Feature 2] - [Status]
- [ ] [Feature 3] - [Status]

**Regression Issues Found:** [Count]

---

## Test Data

**Test Accounts:**
| Role | Username | Password | Purpose |
|------|----------|----------|---------|
| Admin | [username] | [password] | Admin testing |
| User | [username] | [password] | User testing |

**Test Records:**
- [Description of test data created]
- [IDs of specific test records]

---

## Bugs Found During Testing

### BUG-XXX: [Bug Title]
**Severity:** [Critical/High/Medium/Low]
**Description:** [What went wrong]
**Steps to Reproduce:**
1. [Step 1]
2. [Step 2]
**Expected:** [What should happen]
**Actual:** [What actually happened]
**Status:** [Open/Fixed/Wont Fix]

---

## Test Summary

### Test Statistics
- **Total Test Cases:** [X]
- **Passed:** [X]
- **Failed:** [X]
- **Blocked:** [X]
- **Skipped:** [X]
- **Pass Rate:** [X%]

### Bugs Summary
- **Total Bugs Found:** [X]
- **Critical:** [X]
- **High:** [X]
- **Medium:** [X]
- **Low:** [X]

---

## Risk Assessment

**High Risk Areas:**
- [Area 1: Description and mitigation]
- [Area 2: Description and mitigation]

**Medium Risk Areas:**
- [Area 1: Description]
- [Area 2: Description]

---

## Test Conclusion

**Overall Status:** [PASS / FAIL / PASS WITH ISSUES]

**Summary:**
[Brief summary of testing results]

**Blockers:**
[Any issues preventing full testing]

**Recommendations:**
- [Recommendation 1]
- [Recommendation 2]

---

## Sign-off

### QA Approval

**Approved for Production:** [YES / NO / WITH CONDITIONS]

**Conditions (if any):**
- [Condition 1]
- [Condition 2]

**QA Engineer:** [LLM-QA]
**Date:** [YYYY-MM-DD]
**Signature:** [Digital signature/approval]

---

## Attachments

- [ ] Screenshots of passed tests
- [ ] Screenshots of failed tests
- [ ] Bug reports (BUG-XXX)
- [ ] Test execution video (if applicable)
- [ ] Performance reports

---

## Change Log

| Date | Action | Notes |
|------|--------|-------|
| YYYY-MM-DD | Initial test plan created | |
| YYYY-MM-DD | Testing completed | |
| YYYY-MM-DD | Retesting after bug fixes | |
