# Implementation Plan: IMPL-XXX [Feature Name]

**User Story:** US-XXX [Link to user story]
**Sprint:** [Sprint Number]
**Developer:** LLM-DEV
**Validator:** LLM-CR (QA+CR combined)
**Estimated Time:** [X hours]
**Complexity:** [Low/Medium/High]

---

## Overview

**Purpose:** [Brief description of what will be implemented]
**Approach:** [High-level technical approach]

---

## Prerequisites

### Required Reading
- [ ] docs/06_standards/SITE_STANDARDS.md
- [ ] CLAUDE.md (project instructions)
- [ ] User Story US-XXX

### Context Files (For Developer LLM)
<!-- List files that MUST be in the context window for implementation -->
- `[path/to/relevant/file.php]`
- `[path/to/relevant/view.php]`
- `[path/to/relevant/css.css]`
- `docs/06_standards/SITE_STANDARDS.md` (MANDATORY)

---

## Step-by-Step Implementation

### Step 1: [First Task Title]

**File:** `[exact/path/to/file.php]`
**Action:** [Specific action: Create/Edit/Delete]
**Line Number:** [If editing, specify line number or section]

**Instructions:**
[Extremely detailed, prescriptive instructions]

**Code to add:**
```php
[EXACT code to add - copy/paste ready]
```

**Explanation:**
[Why this code is needed and how it works]

---

### Step 2: [Second Task Title]

**File:** `[exact/path/to/file.php]`
**Action:** [Create/Edit/Delete]

**Instructions:**
[Extremely detailed, prescriptive instructions]

**Code to add:**
```php
[EXACT code to add - copy/paste ready]
```

---

### Step 3: [CSS Styling]

**File:** `assets/css/[feature-name].css`
**Action:** [Create new file / Edit existing]

**Instructions:**
[Detailed CSS instructions]

**CSS Code:**
```css
/* =================================================================
   SECTION TITLE
   ================================================================= */

/* MUST use CSS variables - see assets/css/core/variables.css */
.[feature]-[element] {
  background: var(--color-background);
  color: var(--color-text);
  padding: var(--space-4);
  border-radius: var(--radius-md);
}

/* Dark Mode Support - MANDATORY */
[data-theme="dark"] .[feature]-[element] {
  /* Dark mode overrides if needed */
}

/* Mobile Responsive - MANDATORY */
@media (max-width: 768px) {
  .[feature]-[element] {
    /* Mobile styles */
  }
}
```

---

### Step 4: [JavaScript Functionality]

**File:** `assets/js/[feature-name].js`
**Action:** [Create new file / Edit existing]

**Instructions:**
[Detailed JavaScript instructions]

**JavaScript Code:**
```javascript
/**
 * [Feature Name] JavaScript
 */
(function() {
    'use strict';

    // [Exact JavaScript code]

})();
```

---

### Step 5: [View Template]

**File:** `app/Views/[section]/[feature]/[view].php`
**Action:** [Create/Edit]

**Instructions:**
[Detailed view instructions]

**View Code:**
```php
<?php
/**
 * [Feature Name] View
 */
use App\Core\View;
?>

[EXACT view code with proper escaping and structure]
```

**Security Requirements:**
- All user input escaped with `View::escape()`
- CSRF token included in forms
- No raw HTML output from user data

---

### Step 6: [Controller Logic]

**File:** `app/Controllers/[ControllerName].php`
**Action:** [Edit method / Add new method]

**Instructions:**
[Detailed controller instructions]

**Controller Code:**
```php
/**
 * [Method description]
 *
 * @return void
 */
public function methodName()
{
    // [EXACT controller code with QueryBuilder examples]
}
```

---

### Step 7: [Routing]

**File:** `public/index.php`
**Action:** Add route
**Line Number:** [Approximate location in routes section]

**Route to Add:**
```php
$router->add('[route/path]', [
    'controller' => '[ControllerName]',
    'action' => '[methodName]',
    'middleware' => 'AuthMiddleware',  // if authentication required
    'permission' => '[permission_name]' // if permission required
]);
```

---

## Database Changes

### Migrations Required
[Yes/No]

**If Yes:**
```sql
-- Migration: [migration_name]
-- Description: [what this changes]

[EXACT SQL statements]
```

### Queries to Use

**Query 1: [Description]**
```php
$query = new QueryBuilder();
$result = $query->table('[table_name]')
                ->select(['[columns]'])
                ->where('[column]', '=', $value)
                ->get();
```

---

## Dependencies

**Blocks:**
- [Any user stories this blocks]

**Blocked By:**
- [Any user stories that must be completed first]

**Related:**
- [Related user stories or features]

---

## Parallelization Strategy

**Independent Sub-Features:**
- Sub-feature 1: [Name] - Files: [list]
- Sub-feature 2: [Name] - Files: [list]
- Sub-feature 3: [Name] - Files: [list]

**Conflict Analysis:**
- File conflicts: None / [list conflicts]
- Database conflicts: None / [list conflicts]
- Safe to parallelize: Yes / No

**If Safe:**
- Sub-feature 1 can be implemented independently
- Sub-feature 2 can be implemented independently
- Sub-feature 3 can be implemented independently
- Sub-Agent Dispatcher can spawn parallel workers

---

## File Checklist

**Files to Create:**
- [ ] `[path/to/file1]`
- [ ] `[path/to/file2]`

**Files to Edit:**
- [ ] `[path/to/existing/file1]`
- [ ] `[path/to/existing/file2]`

**Total Files Changed:** [X files]

---

## Notes for Developer

[Triage verification completed: Schema verified, syntax validated, feasibility confirmed]

[Any additional context, gotchas, or helpful information]

---

## Approval

**Tech Lead Sign-off:**
- [ ] Plan is complete and prescriptive
- [ ] All steps are unambiguous
- [ ] Ready for Triage

**Triage Sign-off:**
- [ ] Schema verified (all columns exist)
- [ ] Syntax validated (PHP/JS valid)
- [ ] Feasibility confirmed (standards compliant)
- [ ] Approved for Implementation

**Signed:** [LLM-TL] **Triage:** [LLM-CR] **Date:** [YYYY-MM-DD]

---

## Change Log

| Date | Changed By | Change Description |
|------|------------|-------------------|
| YYYY-MM-DD | LLM-TL | Initial creation |
