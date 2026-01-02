# Code Review: CR-XXX [Feature Name]

**Implementation Plan:** IMPL-XXX
**User Story:** US-XXX
**Developer:** LLM-DEV
**Reviewer:** LLM-CR
**Review Date:** YYYY-MM-DD
**Status:** [APPROVED / CHANGES REQUESTED / REJECTED]

---

## Review Summary

**Overall Assessment:** [Brief summary of review findings]

**Decision:** [APPROVED / CHANGES REQUESTED / REJECTED]

**Time to Review:** [X hours]

---

## Common Pitfalls Check (MANDATORY)

**These are the most common issues - check FIRST:**

### 1. BaseModel Usage
- [ ] ✅/❌ No `save()` method calls (use `create()` or `update()` instead)
- [ ] ✅/❌ Models use `create($data)` for new records
- [ ] ✅/❌ Models use `update($id, $data)` for existing records
- [ ] ✅/❌ Code handles array returns from model methods (not objects)
- [ ] ✅/❌ Instance methods use `$model->id = $id` pattern when needed

**BaseModel Issues Found:** [Count]

**Details:**
```
File: [path/to/file:line]
Issue: [Tried to call $model->save()]
Fix: [Use $model->create($data) instead]
```

### 2. Controller Helper Methods
- [ ] ✅/❌ Controllers have `setFlashMessage()` if they call it
- [ ] ✅/❌ No duplicate `validateCSRFToken()` (inherited from parent)
- [ ] ✅/❌ No duplicate `redirect()` (inherited from parent)
- [ ] ✅/❌ Helper method signatures match requirements

**Controller Method Issues Found:** [Count]

**Details:**
```
File: [path/to/file:line]
Issue: [Missing setFlashMessage() method]
Fix: [Add private setFlashMessage() method to controller]
```

### 3. PHP 8.2+ Dynamic Properties
- [ ] ✅/❌ All models have `#[\AllowDynamicProperties]` attribute
- [ ] ✅/❌ Models that set properties declare the attribute

**Dynamic Property Issues Found:** [Count]

**Details:**
```
File: [path/to/file:line]
Issue: [Model missing #[\AllowDynamicProperties]]
Fix: [Add attribute before class declaration]
```

### 4. Namespace Correctness
- [ ] ✅/❌ Models use `App\Models\BaseModel` (not `App\Core\Database\BaseModel`)
- [ ] ✅/❌ QueryBuilder uses `App\Core\Database\QueryBuilder`
- [ ] ✅/❌ Database uses `App\Core\Database\Database`
- [ ] ✅/❌ All namespace imports are correct

**Namespace Issues Found:** [Count]

**Details:**
```
File: [path/to/file:line]
Issue: [Using wrong namespace for BaseModel]
Fix: [Change to use App\Models\BaseModel]
```

### 5. QueryBuilder Limitations
- [ ] ✅/❌ No closure-based WHERE clauses
- [ ] ✅/❌ No JOIN with WHERE on aliased columns (or uses raw SQL)
- [ ] ✅/❌ No COUNT() with complex JOINs (or uses raw SQL)
- [ ] ✅/❌ OR logic uses PHP filtering, not WHERE closures

**QueryBuilder Issues Found:** [Count]

**Details:**
```
File: [path/to/file:line]
Issue: [Using closure in WHERE clause]
Fix: [Use PHP filtering with array_filter() instead]
```

### 6. View Architecture
- [ ] ✅/❌ No database queries in views
- [ ] ✅/❌ No QueryBuilder usage in views
- [ ] ✅/❌ No Database::getInstance() in views
- [ ] ✅/❌ All data prepared in controller/model

**View Architecture Issues Found:** [Count]

**Details:**
```
File: [path/to/file:line]
Issue: [View contains database query]
Fix: [Move query to controller, pass data to view]
```

### 7. Method Existence Verification
- [ ] ✅/❌ All called methods exist in target classes
- [ ] ✅/❌ No calls to non-existent parent methods
- [ ] ✅/❌ Method signatures match calls

**Method Existence Issues Found:** [Count]

**Details:**
```
File: [path/to/file:line]
Issue: [Calling non-existent method]
Fix: [Add method or use correct method name]
```

### 8. Controller Pattern Compliance (NEW - CRITICAL)

**Constructor Pattern:**
- [ ] ✅/❌ Constructor accepts `$route_params = []` parameter
- [ ] ✅/❌ Constructor calls `parent::__construct($route_params)`
- [ ] ✅/❌ No hardcoded constructor calls without parameters

**Constructor Issues Found:** [Count]

**Details:**
```
File: [path/to/file:line]
Issue: [Constructor missing $route_params parameter]
Fix: [Add: public function __construct($route_params = []) { parent::__construct($route_params); }]
```

### 9. Auth Class Usage Verification (NEW - CRITICAL)

**Auth Import:**
- [ ] ✅/❌ Uses `use App\Core\Security\Auth;` (NOT `App\Core\Auth`)
- [ ] ✅/❌ Auth class imported at top of file

**Auth Method Usage:**
- [ ] ✅/❌ Uses `Auth::check()` (NOT `Auth::isLoggedIn()`)
- [ ] ✅/❌ Uses `$_SESSION['user_id']` (NOT `Auth::userId()`)
- [ ] ✅/❌ Uses `Auth::hasPermission()` for authorization
- [ ] ✅/❌ Uses `Auth::hasRole()` for role checking
- [ ] ✅/❌ No calls to non-existent Auth methods

**Auth Issues Found:** [Count]

**Details:**
```
File: [path/to/file:line]
Issue: [Using Auth::isLoggedIn() which doesn't exist]
Fix: [Change to Auth::check()]

File: [path/to/file:line]
Issue: [Using Auth::userId() which doesn't exist]
Fix: [Change to $_SESSION['user_id']]

File: [path/to/file:line]
Issue: [Wrong namespace: App\Core\Auth]
Fix: [Change to: use App\Core\Security\Auth;]
```

### 10. Route Registration Verification (NEW - CRITICAL)

**Route Completeness:**
- [ ] ✅/❌ All controller actions have routes in `dev/public/index.php`
- [ ] ✅/❌ Route controller names match (without "Controller" suffix)
- [ ] ✅/❌ Namespace specified for namespaced controllers
- [ ] ✅/❌ Route paths match intended URLs
- [ ] ✅/❌ Middleware added for protected routes
- [ ] ✅/❌ Permissions added for authorized routes

**Route Issues Found:** [Count]

**Details:**
```
Controller: [ControllerName]
Action: [methodName]
Issue: [No route defined for this action]
Fix: [Add route: $router->add('path', ['controller' => 'Name', 'action' => 'method', 'namespace' => 'X'])]

Route: [route/path]
Issue: [Missing namespace parameter for Contractor controller]
Fix: [Add 'namespace' => 'Contractor' to route definition]
```

**Route Verification Command:**
```bash
# Verify route exists for controller action
grep -n "contractor/feature" dev/public/index.php
```

### 11. Helper Methods Verification (NEW)

**Required Helper Methods (if used):**
- [ ] ✅/❌ `setFlashMessage()` implemented if called
- [ ] ✅/❌ `getValidationErrors()` implemented if called
- [ ] ✅/❌ `setValidationErrors()` implemented if called
- [ ] ✅/❌ Helper method signatures correct

**Helper Method Issues Found:** [Count]

**Details:**
```
File: [path/to/file:line]
Issue: [Calls setFlashMessage() but method not defined in controller]
Fix: [Add private setFlashMessage() method to controller]
```

---

## Standards Compliance Checklist

### CSS Standards
- [ ] ✅/❌ All CSS uses variables from `variables.css`
- [ ] ✅/❌ No hardcoded colors
- [ ] ✅/❌ No hardcoded spacing values
- [ ] ✅/❌ No hardcoded font sizes
- [ ] ✅/❌ BEM naming convention followed
- [ ] ✅/❌ Dark mode styles implemented
- [ ] ✅/❌ Mobile responsive styles included
- [ ] ✅/❌ Glassmorphism design pattern used correctly

**CSS Issues Found:** [Count]

**Details:**
```
[List specific CSS violations with file/line numbers]
```

---

### PHP Standards
- [ ] ✅/❌ File headers present with docblocks
- [ ] ✅/❌ Proper namespace usage
- [ ] ✅/❌ PSR-4 autoloading compliance
- [ ] ✅/❌ All functions have docblocks
- [ ] ✅/❌ Consistent code formatting
- [ ] ✅/❌ No debug code or var_dumps
- [ ] ✅/❌ Error handling implemented

**PHP Issues Found:** [Count]

**Details:**
```
[List specific PHP violations with file/line numbers]
```

---

### Security Review

#### XSS Prevention
- [ ] ✅/❌ All user input escaped with `View::escape()`
- [ ] ✅/❌ No raw HTML output from user data
- [ ] ✅/❌ Proper output encoding

**XSS Vulnerabilities Found:** [Count]

**Details:**
```
File: [path/to/file]
Line: [line number]
Issue: [description of vulnerability]
Severity: [Critical/High/Medium/Low]
Fix: [how to fix]
```

#### SQL Injection Prevention
- [ ] ✅/❌ All queries use QueryBuilder
- [ ] ✅/❌ No direct SQL concatenation
- [ ] ✅/❌ Prepared statements used correctly

**SQL Injection Vulnerabilities Found:** [Count]

**Details:**
```
[List specific vulnerabilities]
```

#### CSRF Protection
- [ ] ✅/❌ Forms include `View::csrfField()`
- [ ] ✅/❌ POST requests validate CSRF token
- [ ] ✅/❌ State-changing operations protected

**CSRF Issues Found:** [Count]

#### Authentication/Authorization
- [ ] ✅/❌ Routes have middleware where required
- [ ] ✅/❌ Permission checks in controllers
- [ ] ✅/❌ Session handling secure

**Auth Issues Found:** [Count]

---

### Database Review

#### Query Quality
- [ ] ✅/❌ Efficient query structure
- [ ] ✅/❌ Proper use of joins
- [ ] ✅/❌ Appropriate indexes used
- [ ] ✅/❌ No N+1 query problems

**Database Issues Found:** [Count]

**Details:**
```
[List query optimization opportunities]
```

#### Schema Compliance
- [ ] ✅/❌ Verified schema before implementation
- [ ] ✅/❌ Column names match database
- [ ] ✅/❌ Foreign key constraints respected

---

### Implementation Plan Compliance

- [ ] ✅/❌ All steps in IMPL-XXX completed
- [ ] ✅/❌ Code matches plan exactly
- [ ] ✅/❌ No deviations from plan
- [ ] ✅/❌ No undocumented changes

**Plan Deviations Found:** [Count]

**Details:**
```
Step: [Step number from plan]
Expected: [What plan specified]
Actual: [What was implemented]
Reason: [Why deviation occurred - should be "none" for approved code]
```

---

### Functionality Review

#### Core Features
- [ ] ✅/❌ Feature works as intended
- [ ] ✅/❌ All acceptance criteria met
- [ ] ✅/❌ Error handling works correctly
- [ ] ✅/❌ Edge cases handled

#### User Experience
- [ ] ✅/❌ Empty states designed
- [ ] ✅/❌ Success messages implemented
- [ ] ✅/❌ Error messages user-friendly
- [ ] ✅/❌ Loading states handled

---

### Accessibility Review

- [ ] ✅/❌ Semantic HTML used
- [ ] ✅/❌ ARIA labels on interactive elements
- [ ] ✅/❌ Keyboard navigation works
- [ ] ✅/❌ Focus states visible
- [ ] ✅/❌ Color contrast meets WCAG AA
- [ ] ✅/❌ Screen reader friendly

**Accessibility Issues Found:** [Count]

**Details:**
```
[List accessibility violations]
```

---

### Browser Compatibility

#### Tested Browsers
- [ ] ✅/❌ Chrome (latest)
- [ ] ✅/❌ Firefox (latest)
- [ ] ✅/❌ Safari (latest)
- [ ] ✅/❌ Edge (latest)

#### Responsive Design
- [ ] ✅/❌ Mobile (320px-767px)
- [ ] ✅/❌ Tablet (768px-1023px)
- [ ] ✅/❌ Desktop (1024px+)

**Browser Issues Found:** [Count]

---

### Dark Mode Support

- [ ] ✅/❌ Dark mode styles implemented
- [ ] ✅/❌ All components support dark mode
- [ ] ✅/❌ Theme switching works correctly
- [ ] ✅/❌ Colors readable in both modes

**Dark Mode Issues Found:** [Count]

---

### Testing Review

#### Unit Tests
- [ ] ✅/❌ Unit tests exist
- [ ] ✅/❌ Tests cover key functionality
- [ ] ✅/❌ Tests pass
- [ ] ✅/❌ Edge cases tested

**Test Coverage:** [X%]

#### Test Quality
- [ ] ✅/❌ Tests are meaningful
- [ ] ✅/❌ Tests follow AAA pattern (Arrange, Act, Assert)
- [ ] ✅/❌ No brittle tests

---

### Documentation Review

- [ ] ✅/❌ All functions have docblocks
- [ ] ✅/❌ Complex logic is commented
- [ ] ✅/❌ README updated if needed
- [ ] ✅/❌ API documentation updated if needed

---

## Detailed Findings

### Critical Issues (Must Fix Before Approval)
[Issues that prevent approval]

1. **Issue:** [Description]
   - **File:** [path/to/file:line]
   - **Severity:** Critical
   - **Impact:** [What could go wrong]
   - **Fix:** [How to fix]

### High Priority Issues (Should Fix)
[Important issues that should be addressed]

1. **Issue:** [Description]
   - **File:** [path/to/file:line]
   - **Severity:** High
   - **Impact:** [What could go wrong]
   - **Fix:** [How to fix]

### Medium Priority Issues (Nice to Fix)
[Improvements that would be beneficial]

1. **Issue:** [Description]
   - **File:** [path/to/file:line]
   - **Severity:** Medium
   - **Suggestion:** [Improvement suggestion]

### Low Priority / Future Improvements
[Minor issues or future enhancements]

1. **Suggestion:** [Description]
   - **Context:** [Why this might be useful]

---

## Positive Findings

**What Went Well:**
- [List things developer did excellently]
- [Good practices followed]
- [Clean code examples]

---

## Code Smells Detected

- [ ] Duplicated code
- [ ] Long methods (>50 lines)
- [ ] Too many parameters (>4)
- [ ] Deep nesting (>3 levels)
- [ ] Magic numbers
- [ ] TODO comments

**Details:**
```
[List code smells with suggestions]
```

---

## Performance Considerations

- [ ] No obvious performance issues
- [ ] Database queries optimized
- [ ] No excessive loops
- [ ] Caching used where appropriate

**Performance Notes:**
```
[Any performance observations]
```

---

## Files Reviewed

| File | Lines Changed | Issues Found | Status |
|------|--------------|--------------|--------|
| [path/to/file1] | [+X/-Y] | [Count] | ✅/❌ |
| [path/to/file2] | [+X/-Y] | [Count] | ✅/❌ |

**Total Files:** [X]
**Total Lines Changed:** [+X/-Y]

---

## Test Results

### Automated Tests
```
[Paste test output]

Tests Passed: X/Y
Coverage: Z%
```

### Manual Testing
- [ ] Feature tested manually
- [ ] Edge cases tested
- [ ] Error scenarios tested
- [ ] Browser testing completed

---

## Decision Rationale

**Why APPROVED:**
[If approved, explain why code is ready for production]

**Why CHANGES REQUESTED:**
[If changes requested, explain what must be fixed]

**Why REJECTED:**
[If rejected, explain fundamental issues]

---

## Required Changes (If Not Approved)

### Must Fix (Blocking Issues)
1. [Change 1 with specific file/line/fix]
2. [Change 2 with specific file/line/fix]

### Should Fix (Recommended)
1. [Change 1]
2. [Change 2]

### Nice to Have (Optional)
1. [Suggestion 1]
2. [Suggestion 2]

---

## Next Steps

**If Approved:**
1. Merge to staging branch
2. Proceed to QA testing (TEST-XXX)
3. Update sprint board

**If Changes Requested:**
1. Developer addresses required changes
2. Developer re-submits for review
3. Reviewer re-reviews changes

**If Rejected:**
1. Tech Lead reviews implementation plan
2. Plan updated if needed
3. Developer re-implements from updated plan

---

## Reviewer Notes

[Any additional context, concerns, or observations]

---

## Approval Sign-off

**Code Reviewer:** [LLM-CR]
**Date:** [YYYY-MM-DD]
**Decision:** [APPROVED / CHANGES REQUESTED / REJECTED]

**Approved for:** [Production / Staging / Further Review]

---

## Change Log

| Date | Action | Notes |
|------|--------|-------|
| YYYY-MM-DD | Initial review | [Notes] |
| YYYY-MM-DD | Re-review | [Notes if re-reviewed] |
