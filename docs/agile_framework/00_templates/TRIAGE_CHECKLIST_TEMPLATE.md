# Triage Checklist: TR-XXX [Feature Name]

**Implementation Plan:** IMPL-XXX
**User Story:** US-XXX
**Tech Lead:** LLM-TL
**Triage Officer:** LLM-CR
**Date:** YYYY-MM-DD

---

## Purpose

Quick validation of implementation plan before development begins. Replaces detailed Plan Review with focused verification.

**Time Estimate:** 5-10 minutes

---

## Schema Verification

**CRITICAL: Verify database schema before approving**

```bash
# Run these commands to verify all referenced tables/columns exist
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 freeconomy_dev -e "DESCRIBE [table1];"
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 freeconomy_dev -e "DESCRIBE [table2];"
```

**Verification:**
- [ ] All referenced columns exist
- [ ] Column types match expectations
- [ ] Foreign keys are valid
- [ ] Indexes confirmed

**Issues Found:** [None / List issues]

---

## Syntax Verification

**Verify code snippets are valid:**

- [ ] PHP code is syntactically valid
- [ ] JavaScript code is syntactically valid
- [ ] No undefined method calls
- [ ] Namespaces are correct
- [ ] Class references exist

**Issues Found:** [None / List issues]

---

## Feasibility Check

**Verify the approach is sound:**

### Standards Compliance
- [ ] Follows SITE_STANDARDS.md requirements
- [ ] Uses QueryBuilder (no raw SQL concatenation)
- [ ] Includes proper security (XSS, CSRF, SQL injection prevention)
- [ ] Uses CSS variables (no hardcoded values)
- [ ] Includes dark mode support
- [ ] Mobile responsive

### No Reinventing the Wheel
- [ ] Reuses existing components where possible
- [ ] Follows established patterns
- [ ] Doesn't duplicate existing functionality

**Issues Found:** [None / List issues]

---

## Completeness Check

**Verify plan has all required sections:**

- [ ] Overview section present
- [ ] Context Files listed
- [ ] Step-by-Step Implementation detailed
- [ ] Code snippets provided
- [ ] File Checklist complete
- [ ] Dependencies identified
- [ ] Parallelization Strategy included

**Missing Sections:** [None / List missing]

---

## Decision

### Triage Result

- [ ] **APPROVED for Implementation** - Plan is valid and ready for development
- [ ] **NEEDS REVISION** - Issues identified, must be fixed before implementation

### If Revision Required

**Issues to Fix:**
1. [Issue 1]
2. [Issue 2]
3. [Issue 3]

**Return to Tech Lead for corrections:**
- Update IMPL-XXX with fixes
- Resubmit for Triage

---

## Triage Notes

[Any additional observations, concerns, or suggestions]

**Complexity Assessment:** [Low/Medium/High]
**Risk Level:** [Low/Medium/High]

---

## Approval

**Triage Officer Sign-off:**
- [ ] Schema verified
- [ ] Syntax validated
- [ ] Feasibility confirmed
- [ ] Approved for Implementation

**Signed:** [LLM-CR] **Date:** [YYYY-MM-DD]

---

## Change Log

| Date | Changed By | Change Description |
|------|------------|-------------------|
| YYYY-MM-DD | LLM-CR | Initial triage |
