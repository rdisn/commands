# Validation Report: VAL-XXX [Feature Name]

**Implementation Plan:** IMPL-XXX
**User Story:** US-XXX
**Developer:** LLM-DEV
**Validator:** LLM-CR (acting as QA+CR combined)
**Date:** YYYY-MM-DD

---

## Purpose

Combined Code Review and Functional Testing validation. Replaces separate Code Review and QA artifacts with single streamlined validation gate.

**Time Estimate:** 25-35 minutes total

---

## Part A: Code Review (15-20 minutes)

### Common Pitfalls Check

**CRITICAL: Check for repeated errors documented in COMMON_PITFALLS.md**

- [ ] No `save()` calls used (use `create()` or `update()`)
- [ ] Correct Auth namespace imported (`App\Core\Security\Auth`)
- [ ] Routes registered in public/index.php
- [ ] `#[\AllowDynamicProperties]` added to models if needed
- [ ] No QueryBuilder closure-based WHERE clauses
- [ ] No JOIN+COUNT combinations
- [ ] BaseModel methods used correctly (returns arrays, not objects)

**Issues Found:** [None / List issues]

### Standards Compliance

**CSS Standards:**
- [ ] Uses ONLY CSS variables (no hardcoded colors/spacing/fonts)
- [ ] Follows BEM naming with feature prefix
- [ ] Includes dark mode support
- [ ] Mobile responsive styles included

**PHP Standards:**
- [ ] All user input escaped with `View::escape()`
- [ ] All queries use QueryBuilder (no SQL concatenation)
- [ ] CSRF tokens included in all forms
- [ ] Docblocks on all functions
- [ ] No undefined method calls

**Security:**
- [ ] XSS prevention (output escaping)
- [ ] SQL injection prevention (QueryBuilder)
- [ ] CSRF protection implemented
- [ ] Authentication/authorization working

**Issues Found:** [None / List issues]

### Implementation vs Plan Adherence

**Does the code match the approved implementation plan?**
- [ ] All steps from plan completed
- [ ] Code snippets match plan exactly
- [ ] No deviations from plan
- [ ] No extra features added
- [ ] No missing features

**Deviations Found:** [None / List deviations]

---

## Part B: Functional Testing (10-15 minutes)

### Acceptance Criteria Verification

**From User Story US-XXX:**

- [ ] Criterion 1: [Description] - **PASS / FAIL**
- [ ] Criterion 2: [Description] - **PASS / FAIL**
- [ ] Criterion 3: [Description] - **PASS / FAIL**
- [ ] Criterion 4: [Description] - **PASS / FAIL**

**Failures:** [None / List failures]

### Manual Testing

**Test Cases Executed:**

1. **Test Case 1:** [Description]
   - Steps: [Steps taken]
   - Expected: [Expected result]
   - Actual: [Actual result]
   - Status: **PASS / FAIL**

2. **Test Case 2:** [Description]
   - Steps: [Steps taken]
   - Expected: [Expected result]
   - Actual: [Actual result]
   - Status: **PASS / FAIL**

3. **Test Case 3:** [Description]
   - Steps: [Steps taken]
   - Expected: [Expected result]
   - Actual: [Actual result]
   - Status: **PASS / FAIL**

**Testing Notes:**
- Browser tested: [Chrome/Firefox/Safari]
- Mobile responsive tested: [Yes/No]
- Dark mode tested: [Yes/No]
- Edge cases tested: [List edge cases]

**Issues Found:** [None / List issues]

### Bug Discovery

**New bugs discovered during testing:**

- [ ] None
- [ ] BUG-XXX: [Bug description] - Severity: [Critical/Major/Minor]

---

## Combined Decision

### Validation Result

- [ ] **APPROVED for Done** - Code is compliant and functional
- [ ] **NEEDS FIXES** - Issues identified, must be fixed before approval

### If Fixes Required

**Code Review Issues:**
1. [Issue 1]
2. [Issue 2]

**Functional Testing Issues:**
1. [Issue 1]
2. [Issue 2]

**Return to Developer:**
- Update implementation to address issues
- Resubmit for validation

---

## Validation Summary

**Code Review:** [PASS / FAIL]
**Functional Testing:** [PASS / FAIL]
**Overall:** [APPROVED / NEEDS FIXES]

**Quality Assessment:**
- Code Quality: [Excellent / Good / Fair / Poor]
- Standards Compliance: [100% / XX%]
- Test Coverage: [Complete / Partial / Minimal]
- Security Posture: [Strong / Acceptable / Weak]

**Recommendations:**
[Any suggestions for improvement or future considerations]

---

## Learning & Improvement

### 🎯 Success Patterns Found

**If code demonstrates excellent patterns that should be reused:**
- [Pattern 1] - [Brief description]
- [Pattern 2] - [Brief description]

**Action:**
- Document these patterns in `PATTERN_LIBRARY.md`
- Share with team for reuse

### ⚠️ Issues for Learning Log

**If issues found that could help others learn:**
- [Issue 1] - [Description]
- [Issue 2] - [Description]

**Action:**
- Add to `COMMON_PITFALLS.md` if new error type
- Include fix and prevention steps

---

## Approval

**Validator Sign-off:**
- [ ] Code review completed
- [ ] Functional testing completed
- [ ] All critical issues resolved
- [ ] Approved for Done

**Signed:** [LLM-CR] **Date:** [YYYY-MM-DD]

---

## Change Log

| Date | Changed By | Change Description |
|------|------------|-------------------|
| YYYY-MM-DD | LLM-CR | Initial validation |
