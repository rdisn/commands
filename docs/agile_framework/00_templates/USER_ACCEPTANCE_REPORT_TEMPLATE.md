# User Acceptance Report: UAR-XXX [Feature Name]

**User Story:** US-XXX [Link to user story]
**Implementation Plan:** IMPL-XXX [Link to implementation plan]
**Validation Report:** VAL-XXX [Link to validation report]
**Sprint:** [Sprint Number]
**Tester:** [Human Tester Name / LLM-QA]
**Test Date:** YYYY-MM-DD
**Test Environment:** [Staging/Production]

---

## Executive Summary

**Overall Status:** [PASSED / FAILED / PASSED WITH MINOR ISSUES]

**Decision:**
- [ ] **ACCEPTED** - Feature meets all acceptance criteria, approved for Done
- [ ] **REJECTED** - Critical issues found, return to Implementation Pool
- [ ] **ACCEPTED WITH CONDITIONS** - Minor issues, create bugs for next sprint

**Test Duration:** [X hours / X days]
**Test Cycles:** [Number of times through feedback loop]

---

## Manual Testing Environment

**URL Tested:** [Exact URL]
**Browser(s):** [Chrome, Firefox, Safari, Edge - specify versions]
**Device(s):** [Desktop, Mobile, Tablet - specify models]
**Operating System(s):** [Windows, Mac, Linux, iOS, Android]
**Test Account:** [Username/role used for testing]
**Test Data:** [Description of test data used]

---

## Acceptance Criteria Verification

**From User Story US-XXX:**

### Criterion 1: [Description from US]
- [ ] **PASS** - Works as specified
- [ ] **FAIL** - Does not work as specified
- [ ] **PARTIAL** - Works but with issues

**Test Steps Performed:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Expected Behavior:** [From acceptance criteria]
**Actual Behavior:** [What actually happened]
**Evidence:** [Screenshot link / screen recording]

**Issues Found:**
- [ ] None
- [ ] [Issue description]

---

### Criterion 2: [Description from US]
- [ ] **PASS** - Works as specified
- [ ] **FAIL** - Does not work as specified
- [ ] **PARTIAL** - Works but with issues

**Test Steps Performed:**
1. [Step 1]
2. [Step 2]

**Expected Behavior:** [From acceptance criteria]
**Actual Behavior:** [What actually happened]
**Evidence:** [Screenshot link / screen recording]

**Issues Found:**
- [ ] None
- [ ] [Issue description]

---

### Criterion 3: [Description from US]
- [ ] **PASS** - Works as specified
- [ ] **FAIL** - Does not work as specified
- [ ] **PARTIAL** - Works but with issues

**Test Steps Performed:**
1. [Step 1]
2. [Step 2]

**Expected Behavior:** [From acceptance criteria]
**Actual Behavior:** [What actually happened]
**Evidence:** [Screenshot link / screen recording]

**Issues Found:**
- [ ] None
- [ ] [Issue description]

---

### Criterion 4: [Description from US]
- [ ] **PASS** - Works as specified
- [ ] **FAIL** - Does not work as specified
- [ ] **PARTIAL** - Works but with issues

**Test Steps Performed:**
1. [Step 1]
2. [Step 2]

**Expected Behavior:** [From acceptance criteria]
**Actual Behavior:** [What actually happened]
**Evidence:** [Screenshot link / screen recording]

**Issues Found:**
- [ ] None
- [ ] [Issue description]

---

## Exploratory Testing Results

**Beyond Acceptance Criteria - Real-world usage testing:**

### Test Scenario 1: [Description]
**Steps:** [What you tried]
**Result:** [What happened]
**Status:** [PASS / FAIL]
**Notes:** [Any observations]

### Test Scenario 2: [Description]
**Steps:** [What you tried]
**Result:** [What happened]
**Status:** [PASS / FAIL]
**Notes:** [Any observations]

### Test Scenario 3: [Description]
**Steps:** [What you tried]
**Result:** [What happened]
**Status:** [PASS / FAIL]
**Notes:** [Any observations]

---

## Edge Cases Tested

### Edge Case 1: [Description]
- **Scenario:** [What edge case was tested]
- **Expected:** [What should happen]
- **Actual:** [What actually happened]
- **Status:** [PASS / FAIL]

### Edge Case 2: [Description]
- **Scenario:** [What edge case was tested]
- **Expected:** [What should happen]
- **Actual:** [What actually happened]
- **Status:** [PASS / FAIL]

### Edge Case 3: [Description]
- **Scenario:** [What edge case was tested]
- **Expected:** [What should happen]
- **Actual:** [What actually happened]
- **Status:** [PASS / FAIL]

---

## UI/UX Assessment

### Visual Design
- [ ] **PASS** - Matches design specifications
- [ ] **FAIL** - Visual issues found
- [ ] **PARTIAL** - Minor visual issues

**Issues:**
- [ ] None
- [ ] [Issue description with screenshots]

### Responsive Design
- [ ] **Desktop (1024px+)** - [PASS / FAIL]
- [ ] **Tablet (768px-1023px)** - [PASS / FAIL]
- [ ] **Mobile (320px-767px)** - [PASS / FAIL]

**Issues:**
- [ ] None
- [ ] [Issue description with screenshots]

### Dark Mode
- [ ] **PASS** - Dark mode works correctly
- [ ] **FAIL** - Dark mode issues

**Issues:**
- [ ] None
- [ ] [Issue description with screenshots]

### Accessibility (Manual Check)
- [ ] **Keyboard Navigation** - [PASS / FAIL] - All features accessible via keyboard
- [ ] **Focus Indicators** - [PASS / FAIL] - Visible focus states
- [ ] **Color Contrast** - [PASS / FAIL] - Text is readable
- [ ] **Screen Reader** - [PASS / FAIL / NOT TESTED]

**Issues:**
- [ ] None
- [ ] [Issue description]

---

## Performance Assessment

### Load Time
- **Perceived Load Speed:** [Fast / Acceptable / Slow]
- **Actual Load Time:** [~X seconds]
- **Status:** [PASS / FAIL]

### Responsiveness
- **Button Clicks:** [Immediate / Slight Delay / Laggy]
- **Form Submissions:** [Immediate / Slight Delay / Laggy]
- **AJAX Requests:** [Fast / Acceptable / Slow]
- **Status:** [PASS / FAIL]

### Data Handling
- **Large Dataset:** [How did it perform with many records?]
- **Concurrent Users:** [Any issues with multiple users?]
- **Status:** [PASS / FAIL / NOT TESTED]

---

## Security Testing (Manual)

### Authentication
- [ ] **Login Works** - [PASS / FAIL]
- [ ] **Logout Works** - [PASS / FAIL]
- [ ] **Session Timeout** - [PASS / FAIL / NOT TESTED]

### Authorization
- [ ] **Access Control** - [PASS / FAIL] - Cannot access unauthorized areas
- [ ] **Role-Based Permissions** - [PASS / FAIL] - Correct permissions per role

### Input Validation
- [ ] **Form Validation** - [PASS / FAIL] - Invalid input rejected appropriately
- [ ] **XSS Prevention** - [PASS / FAIL / NOT TESTED] - No script injection
- [ ] **SQL Injection** - [PASS / FAIL / NOT TESTED] - No SQL injection

---

## Integration Testing

### Related Features Still Working
- [ ] [Feature 1] - [PASS / FAIL]
- [ ] [Feature 2] - [PASS / FAIL]
- [ ] [Feature 3] - [PASS / FAIL]

**Regression Issues Found:**
- [ ] None
- [ ] [Issue description]

---

## Bugs Found During Manual Testing

### Bug 1: [Bug Title]
**Severity:** [Critical / High / Medium / Low]
**Type:** [Functional / UI/UX / Performance / Security]

**Description:**
[Detailed description of the bug]

**Steps to Reproduce:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Expected:** [What should happen]
**Actual:** [What actually happens]

**Frequency:** [Always / Sometimes / Once]
**Impact:** [How does this affect the user?]

**Evidence:**
- [Screenshot]
- [Screen recording]
- [Console errors]

**Recommendation:**
- [ ] **BLOCKER** - Must fix before acceptance
- [ ] **HIGH** - Should fix before acceptance
- [ ] **MEDIUM** - Can create bug for next sprint
- [ ] **LOW** - Minor issue, can defer

---

### Bug 2: [Bug Title]
**Severity:** [Critical / High / Medium / Low]
**Type:** [Functional / UI/UX / Performance / Security]

**Description:**
[Detailed description of the bug]

**Steps to Reproduce:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Expected:** [What should happen]
**Actual:** [What actually happens]

**Frequency:** [Always / Sometimes / Once]
**Impact:** [How does this affect the user?]

**Evidence:**
- [Screenshot]
- [Screen recording]
- [Console errors]

**Recommendation:**
- [ ] **BLOCKER** - Must fix before acceptance
- [ ] **HIGH** - Should fix before acceptance
- [ ] **MEDIUM** - Can create bug for next sprint
- [ ] **LOW** - Minor issue, can defer

---

## Comparison with Validation Report (VAL-XXX)

**The automated validation found:**
- [Summary of what VAL-XXX found]

**Manual testing found:**
- [Summary of what manual testing found that VAL-XXX missed]

**Gaps Analysis:**
- [What did automated testing miss that manual testing caught?]
- [Why did automated testing not catch this?]

---

## Tester Feedback

### What Works Well
- [Aspect 1 that works well]
- [Aspect 2 that works well]
- [Aspect 3 that works well]

### What Needs Improvement
- [Aspect 1 that needs work]
- [Aspect 2 that needs work]
- [Aspect 3 that needs work]

### User Experience Assessment
- **Intuitiveness:** [Very Intuitive / Intuitive / Somewhat Confusing / Confusing]
- **Ease of Use:** [Very Easy / Easy / Moderate / Difficult]
- **Likely to Satisfy Users:** [Yes / Maybe / No]

**Comments:**
[Free-form feedback on user experience]

---

## Test Evidence

**Screenshots:**
- [ ] [Screenshot 1 - Main functionality]
- [ ] [Screenshot 2 - Edge case]
- [ ] [Screenshot 3 - UI issue if applicable]

**Screen Recordings:**
- [ ] [Recording 1 - User journey]
- [ ] [Recording 2 - Bug reproduction]

**Console Logs:**
- [ ] [Console errors if any]

**Network Requests:**
- [ ] [Network issues if any]

---

## Final Decision

### Recommendation: [ACCEPTED / REJECTED / ACCEPTED WITH CONDITIONS]

**If ACCEPTED:**
- All acceptance criteria met
- No critical or high severity bugs
- Ready for Done status

**If REJECTED:**
- Critical or high severity bugs found
- Acceptance criteria not met
- Return to Implementation Pool for fixes

**If ACCEPTED WITH CONDITIONS:**
- Core functionality works
- Minor issues found
- Create bug reports for next sprint
- Can proceed to Done

---

## Action Items

### If ACCEPTED:
- [ ] Move US-XXX to Done in KANBAN.md
- [ ] Deploy to production
- [ ] Update feature documentation

### If REJECTED:
- [ ] Move US-XXX back to Implementation Pool in KANBAN.md
- [ ] Create bug reports for all issues found
- [ ] Developer fixes issues
- [ ] Resubmit to Validation Queue
- [ ] Retest after fixes

### If ACCEPTED WITH CONDITIONS:
- [ ] Move US-XXX to Done in KANBAN.md
- [ ] Create bug reports for minor issues
- [ ] Add bugs to next sprint backlog
- [ ] Deploy to production

---

## Sign-off

**Tester:** [Name]
**Date:** [YYYY-MM-DD]
**Signature:** [Digital signature]

**Product Owner Review:**
- [ ] **AGREES** with test results and recommendation
- [ ] **DISAGREES** - overrides with notes

**PO Comments:**
[If PO disagrees, explain why]

**PO Signature:** [Name] **Date:** [YYYY-MM-DD]

---

## Rework History (Track Feedback Loops)

**Cycle 1:**
- **Test Date:** [YYYY-MM-DD]
- **Result:** [PASSED / FAILED]
- **Issues Found:** [X critical, X high, X medium, X low]
- **Returned to Implementation:** [Yes / No]

**Cycle 2:**
- **Test Date:** [YYYY-MM-DD]
- **Result:** [PASSED / FAILED]
- **Issues Found:** [X critical, X high, X medium, X low]
- **Returned to Implementation:** [Yes / No]

**Cycle 3:**
- **Test Date:** [YYYY-MM-DD]
- **Result:** [PASSED / FAILED]
- **Issues Found:** [X critical, X high, X medium, X low]
- **Escalation Required:** [Yes - if failed 3 times, escalate to Tech Lead]

---

## Change Log

| Date | Changed By | Change Description |
|------|------------|-------------------|
| YYYY-MM-DD | [Tester] | Initial user acceptance test |
| YYYY-MM-DD | [Tester] | Retest after fixes (Cycle X) |
| YYYY-MM-DD | [Tester] | Final acceptance |
