# Plan Review: CR-XXX-PLAN [Feature Name]

**Implementation Plan:** IMPL-XXX
**User Story:** US-XXX
**Tech Lead:** LLM-TL
**Plan Reviewer:** LLM-CR
**Review Date:** YYYY-MM-DD
**Status:** [PLAN APPROVED / PLAN NEEDS CHANGES]

---

## Review Purpose

This is a **PLAN REVIEW** - reviewing the implementation plan BEFORE development begins.

**Goal:** Catch technical issues, schema mismatches, and architectural problems before the developer invests time implementing incorrect code.

---

## Plan Review Summary

**Overall Assessment:** [Brief summary of plan quality]

**Decision:** [PLAN APPROVED / PLAN NEEDS CHANGES]

**Time to Review:** [X hours]

---

## Database Schema Verification

### Schema Checks Performed

**Tables Referenced in Plan:**
- [ ] `[table_name_1]` - Schema verified
- [ ] `[table_name_2]` - Schema verified
- [ ] `[table_name_3]` - Schema verified

**Commands Used:**
```bash
# WSL/Linux:
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 freeconomy_dev -e "DESCRIBE table_name;"

# Windows:
"C:\xampp\mysql\bin\mysql.exe" -u root -pmindseye@41 freeconomy_dev -e "DESCRIBE table_name;"
```

### Schema Issues Found

**Issue 1: [Description]**
```
Plan says: column_name (type)
Actual DB: different_column_name (different_type)

File: IMPL-XXX
Section: Step X
Fix Required: Update plan to use correct column name
```

**Issue 2: [Description]**
```
[Details of issue]
```

**Total Schema Issues:** [X]

---

## Code Syntax Verification

### Controller/Model Methods

**Methods Referenced in Plan:**
- [ ] `[ClassName]::methodName()` - Exists: ✅/❌
- [ ] `[ClassName]::anotherMethod()` - Exists: ✅/❌

**Files Checked:**
- `app/Controllers/[Controller].php` - Lines [X-Y]
- `app/Models/[Model].php` - Lines [X-Y]

### QueryBuilder Syntax

**Queries in Plan:**
```php
// Query 1: [Location in plan]
$query->table('table_name')
      ->select(['columns'])
      ->where('column', '=', $value)
      ->get();

Status: ✅ Syntax correct / ❌ Syntax error
Issue: [Description if error]
```

```php
// Query 2: [Location in plan]
[Query code]

Status: ✅/❌
Issue: [Description]
```

**Total Query Issues:** [X]

---

## CSS Variables Verification

### CSS Code in Plan

**Variables Used:**
- [ ] `var(--color-primary)` - Exists in variables.css: ✅
- [ ] `var(--space-4)` - Exists in variables.css: ✅
- [ ] `var(--font-size-base)` - Exists in variables.css: ✅

**Hardcoded Values Found:**
```css
/* Issue 1 */
Line: [Plan section/step]
Code: color: #228B22;
Should be: color: var(--color-primary);
```

**Total CSS Issues:** [X]

---

## Standards Compliance Check

### CSS Standards
- [ ] ✅/❌ Plan uses only CSS variables
- [ ] ✅/❌ BEM naming convention specified
- [ ] ✅/❌ Dark mode styles included
- [ ] ✅/❌ Mobile responsive breakpoints included
- [ ] ✅/❌ Glassmorphism pattern used correctly

**CSS Issues:** [Count]

### PHP Standards
- [ ] ✅/❌ Proper namespace usage
- [ ] ✅/❌ QueryBuilder used for all queries
- [ ] ✅/❌ View::escape() used for all output
- [ ] ✅/❌ CSRF protection in forms
- [ ] ✅/❌ Docblocks included in examples

**PHP Issues:** [Count]

### Security Standards
- [ ] ✅/❌ XSS prevention addressed
- [ ] ✅/❌ SQL injection prevention (no concatenation)
- [ ] ✅/❌ CSRF tokens specified
- [ ] ✅/❌ Authentication/authorization considered

**Security Issues:** [Count]

---

## Technical Approach Validation

### Architecture Review
- [ ] ✅/❌ Approach follows MVC pattern
- [ ] ✅/❌ Business logic in appropriate layer
- [ ] ✅/❌ No duplicate functionality
- [ ] ✅/❌ Integrates well with existing code

**Architectural Concerns:**
```
[List any architectural issues or suggestions]
```

### Performance Considerations
- [ ] ✅/❌ Queries are efficient
- [ ] ✅/❌ No N+1 query problems
- [ ] ✅/❌ Appropriate use of indexes
- [ ] ✅/❌ Caching considered where needed

**Performance Concerns:**
```
[List any performance issues]
```

---

## File Path Verification

### Files to Create
- [ ] `[path/to/new/file1]` - Path valid: ✅/❌
- [ ] `[path/to/new/file2]` - Path valid: ✅/❌

### Files to Edit
- [ ] `[path/to/existing/file1]` - Exists: ✅/❌
- [ ] `[path/to/existing/file2]` - Exists: ✅/❌

**File Path Issues:** [Count]

---

## Detailed Findings

### Critical Issues (MUST Fix Before Approval)

**Issue 1: [Title]**
- **Location:** IMPL-XXX, Step [X]
- **Severity:** Critical
- **Problem:** [What's wrong]
- **Evidence:** [DB output, file check, etc.]
- **Fix Required:** [Exact fix needed]

**Issue 2: [Title]**
- **Location:** IMPL-XXX, Step [X]
- **Severity:** Critical
- **Problem:** [What's wrong]
- **Fix Required:** [Exact fix needed]

### High Priority Issues

**Issue 1: [Title]**
- **Location:** IMPL-XXX, Step [X]
- **Severity:** High
- **Problem:** [What's wrong]
- **Recommendation:** [Suggested fix]

### Medium Priority Issues

**Issue 1: [Title]**
- **Location:** IMPL-XXX, Step [X]
- **Severity:** Medium
- **Suggestion:** [Improvement suggestion]

### Low Priority / Suggestions

**Suggestion 1: [Title]**
- **Context:** [Why this might be useful]

---

## Positive Findings

**What's Good About This Plan:**
- [Strength 1: e.g., "Thorough documentation"]
- [Strength 2: e.g., "Good error handling"]
- [Strength 3: e.g., "Clear step-by-step instructions"]

---

## Completeness Check

### Required Plan Elements
- [ ] ✅/❌ Prerequisites section complete
- [ ] ✅/❌ Database schema verified
- [ ] ✅/❌ Step-by-step instructions clear
- [ ] ✅/❌ Code examples provided
- [ ] ✅/❌ CSS code complete with variables
- [ ] ✅/❌ Security considerations addressed
- [ ] ✅/❌ Testing requirements defined
- [ ] ✅/❌ Verification checklist included

**Missing Elements:** [List any gaps]

---

## Prescriptiveness Assessment

**Is this plan prescriptive enough for a developer to follow without making decisions?**

- [ ] ✅ Yes - Developer can implement exactly as written
- [ ] ❌ No - Ambiguities require developer decisions

**Ambiguities Found:**
```
Location: Step [X]
Ambiguity: [What's unclear]
Fix: [Make it more specific]
```

---

## Decision Rationale

### Why PLAN APPROVED:
[If approved, explain why plan is ready for development]

**Confirmed:**
- All database schemas verified and correct
- All methods/classes exist in codebase
- QueryBuilder syntax is valid
- CSS variables used correctly
- Security considerations complete
- Technical approach is sound
- Plan is prescriptive and complete

### Why PLAN NEEDS CHANGES:
[If changes needed, explain what must be fixed]

**Must Address:**
1. [Critical issue 1]
2. [Critical issue 2]
3. [High priority issue]

---

## Required Plan Changes (If Not Approved)

### Must Fix (Blocking Approval)
1. **[Change description]**
   - File: IMPL-XXX
   - Section: Step [X]
   - Current: [What it says now]
   - Should be: [What it should say]
   - Reason: [Why this change is needed]

2. **[Change description]**
   - [Details]

### Should Fix (Recommended)
1. [Recommendation 1]
2. [Recommendation 2]

### Nice to Have (Optional)
1. [Suggestion 1]
2. [Suggestion 2]

---

## Next Steps

**If Plan Approved:**
1. Tech Lead marks plan as "Approved for Development"
2. Developer (LLM-DEV) can begin implementation
3. Developer must follow approved plan exactly

**If Plan Needs Changes:**
1. Tech Lead updates IMPL-XXX based on feedback
2. Tech Lead resubmits plan for review
3. Plan Reviewer re-reviews updated plan
4. Development CANNOT start until plan approved

---

## Verification Commands Run

**Database Schema Checks:**
```bash
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 freeconomy_dev -e "DESCRIBE table1;"
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 freeconomy_dev -e "DESCRIBE table2;"
```

**File Existence Checks:**
```bash
ls -la app/Controllers/ControllerName.php
ls -la app/Models/ModelName.php
```

**CSS Variables Check:**
```bash
grep "variable-name" assets/css/core/variables.css
```

---

## Reviewer Notes

[Any additional context, observations, or recommendations]

---

## Approval Sign-off

**Plan Reviewer:** [LLM-CR]
**Date:** [YYYY-MM-DD]
**Decision:** [PLAN APPROVED / PLAN NEEDS CHANGES]

**If Approved, Developer May Proceed:** [YES / NO]

---

## Change Log

| Date | Action | Notes |
|------|--------|-------|
| YYYY-MM-DD | Initial plan review | [Notes] |
| YYYY-MM-DD | Re-review after changes | [Notes if re-reviewed] |
