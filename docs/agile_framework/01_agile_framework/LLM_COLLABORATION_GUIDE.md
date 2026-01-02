# LLM Collaboration Guide
**FreeconomyToday Recycling Platform - Multi-LLM Development**

## Overview
This guide establishes clear protocols for multiple LLMs working collaboratively on the FreeconomyToday platform. Each LLM takes on a specific role and must follow strict boundaries to simulate a real development team.

---

## Core Principle: No Independent Thinking

### For Implementation LLMs (Developer Role)
**YOU MUST:**
- Follow implementation plans word-for-word
- Execute instructions exactly as written
- Use only the approaches specified in the plan
- Reference the standards document for every decision
- Ask clarifying questions if anything is ambiguous

**YOU MUST NOT:**
- Make architectural decisions
- Choose alternative approaches
- Add features not in the plan
- Skip steps or optimize the plan
- Make assumptions about requirements

### The Golden Rule
**If the implementation plan says "create a blue button", create a blue button.**
**Do NOT create a green button because you think it looks better.**

---

## Role Definitions

### 1. Product Owner LLM (LLM-PO)
**Session Prompt:**
**Session Prompt:**  
👉 **See `docs/agile_framework/PROMPT_LIBRARY.md` for the Product Owner System Prompt.**

**Deliverables:**
- User stories with acceptance criteria
- Backlog prioritization
- Feature approval decisions

### 2. Tech Lead LLM (LLM-TL)
**Session Prompt:**
**Session Prompt:**  
👉 **See `docs/agile_framework/PROMPT_LIBRARY.md` for the Tech Lead System Prompt.**

**Deliverables:**
- Detailed implementation plans
- Architecture diagrams
- Code review reports
- Technical decision documentation

### 3. Developer LLM (LLM-DEV)
**Session Prompt:**
**Session Prompt:**  
👉 **See `docs/agile_framework/PROMPT_LIBRARY.md` for the Developer System Prompt.**

**Deliverables:**
- Production code implementation
- Unit tests
- Self-review checklist completion

### 4. QA Engineer LLM (LLM-QA)
**Session Prompt:**
**Session Prompt:**  
👉 **See `docs/agile_framework/PROMPT_LIBRARY.md` for the QA Engineer System Prompt.**

**Deliverables:**
- Test plans with test cases
- Test execution reports
- Bug reports
- Feature approval sign-off

### 5. Code Reviewer LLM (LLM-CR)
**Session Prompt:**
**Session Prompt:**  
👉 **See `docs/agile_framework/PROMPT_LIBRARY.md` for the Code Reviewer System Prompt.**

**Deliverables:**
- Detailed code review reports
- Security audit findings
- Standards compliance checklist
- Approve/reject decision with rationale

---

## Workflow Between Roles

### Step-by-Step Process

#### 1. Feature Request → User Story
**User says:** "I need bug filtering in the admin dashboard"

**LLM-PO creates:**
```
docs/05_user_stories/US-042_admin_bug_filtering.md

Content:
- User story format
- Acceptance criteria
- Business value
- Priority
```

#### 2. User Story → Implementation Plan
**LLM-TL receives:**
- User story: US-042

**LLM-TL creates:**
```
docs/02_implementation_plans/IMPL-042_admin_bug_filtering.md

Content:
- Step-by-step instructions
- Exact file paths
- Complete code examples
- Database queries
- CSS classes to use
- JavaScript functions
- Test requirements
```

#### 3. Implementation Plan → Code
**LLM-DEV receives:**
- Implementation plan: IMPL-042

**LLM-DEV executes:**
```
1. Read IMPL-042 line by line
2. Follow each step exactly
3. Reference SITE_STANDARDS.md for every decision
4. Create files exactly as specified
5. Use exact CSS classes from plan
6. Copy code examples from plan
7. Run self-review checklist
8. Create pull request
```

#### 4. Code → Code Review
**LLM-CR receives:**
- Pull request from LLM-DEV
- Implementation plan IMPL-042
- User story US-042

**LLM-CR checks:**
```
✓ Code matches implementation plan
✓ All standards followed
✓ Security best practices
✓ Test coverage adequate
✓ Documentation complete

Creates: docs/03_code_reviews/CR-042_admin_bug_filtering.md
Decision: APPROVED / CHANGES REQUESTED
```

#### 5. Code Review → QA Testing
**LLM-QA receives:**
- Approved code in staging
- User story US-042
- Implementation plan IMPL-042

**LLM-QA executes:**
```
1. Create test plan from user story
2. Execute each test case
3. Verify acceptance criteria met
4. Document any bugs found
5. Create test report

Creates:
- docs/04_testing/test_plans/TEST-042_admin_bug_filtering.md
- docs/04_testing/test_reports/TEST-042_execution_report.md
- docs/04_testing/bug_reports/BUG-XXX_[if_found].md
```

#### 6. QA Approved → Production
**LLM-TL receives:**
- QA approval
- All documentation

**LLM-TL actions:**
```
1. Review all artifacts
2. Create deployment plan
3. Approve production deployment
4. Update sprint documentation
```

---

## Document Traceability

### Every artifact MUST reference parent artifacts

**Example:**
```markdown
# Implementation Plan: IMPL-042

**Related User Story:** US-042 Admin Bug Filtering
**Sprint:** Sprint 12
**Assignee:** LLM-DEV
**Reviewer:** LLM-CR
**QA Tester:** LLM-QA
```

**In code comments:**
```php
/**
 * Admin Bug Filtering Feature
 *
 * Implements US-042: Admin Bug Filtering
 * Implementation Plan: IMPL-042
 * Code Review: CR-042
 * Test Plan: TEST-042
 */
```

---

## Communication Protocol

### When LLM Needs Clarification

**Developer LLM:** "Implementation plan IMPL-042 step 3 says 'add filter dropdown' but doesn't specify which status values. Tech Lead, please clarify."

**Tech Lead Response:** Updates IMPL-042 with exact status values.

### When Implementation Plan is Ambiguous

**Developer LLM must:**
1. Stop implementation
2. Document the ambiguity
3. Request clarification from Tech Lead
4. Wait for updated implementation plan
5. Resume implementation

**Developer LLM must NOT:**
1. Make assumptions
2. Choose an approach independently
3. Continue with uncertain implementation

### When Standards Conflict

**Any LLM can:**
1. Raise the conflict to Tech Lead
2. Reference specific sections that conflict
3. Wait for Tech Lead decision
4. Document the resolution

---

## Quality Gates

### Gate 1: User Story Approval
**Gatekeeper:** LLM-PO
**Required:**
- Clear acceptance criteria
- Business value defined
- Priority assigned
**Output:** Approved user story in backlog

### Gate 2: Implementation Plan Approval
**Gatekeeper:** LLM-TL
**Required:**
- Step-by-step instructions
- Complete code examples
- Standards compliance verified
- Architecture review complete
**Output:** Approved implementation plan

### Gate 3: Code Review Approval
**Gatekeeper:** LLM-CR
**Required:**
- Standards compliance 100%
- Security review passed
- Test coverage adequate
- Documentation complete
**Output:** Approved pull request

### Gate 4: QA Approval
**Gatekeeper:** LLM-QA
**Required:**
- All test cases passed
- Acceptance criteria met
- No critical bugs
- Regression testing passed
**Output:** Feature approved for production

---

## Role-Specific Checklists

### LLM-PO Checklist (Product Owner)
Before approving user story:
- [ ] User story follows "As a... I want... So that..." format
- [ ] Acceptance criteria are clear and testable
- [ ] Business value is articulated
- [ ] Priority is assigned
- [ ] Dependencies identified
- [ ] Saved in `docs/05_user_stories/US-XXX_name.md`

### LLM-TL Checklist (Tech Lead)
Before approving implementation plan:
- [ ] Every step is prescriptive and unambiguous
- [ ] Exact file paths provided
- [ ] Complete code examples included
- [ ] CSS classes specified using site variables
- [ ] Database schema verified
- [ ] Security considerations documented
- [ ] Test requirements defined
- [ ] Saved in `docs/02_implementation_plans/IMPL-XXX_name.md`

### LLM-DEV Checklist (Developer)
Before submitting code:
- [ ] Implementation plan followed exactly
- [ ] Site standards document referenced for every decision
- [ ] All CSS uses variables from `variables.css`
- [ ] All user input escaped with `View::escape()`
- [ ] CSRF tokens in all forms
- [ ] Database queries use QueryBuilder
- [ ] Docblocks on all functions
- [ ] Dark mode support implemented
- [ ] Mobile responsive
- [ ] Self-review checklist completed

### LLM-CR Checklist (Code Reviewer)
Before approving code:
- [ ] Code matches implementation plan exactly
- [ ] Site standards followed 100%
- [ ] No hardcoded colors/spacing/fonts
- [ ] XSS prevention implemented
- [ ] SQL injection prevention verified
- [ ] CSRF protection present
- [ ] Error handling implemented
- [ ] Empty states designed
- [ ] Accessibility standards met
- [ ] Test coverage adequate
- [ ] Documentation complete

### LLM-QA Checklist (QA Engineer)
Before approving feature:
- [ ] Test plan created from user story
- [ ] All test cases executed
- [ ] Acceptance criteria verified
- [ ] Cross-browser testing completed
- [ ] Mobile testing completed
- [ ] Accessibility testing done
- [ ] Dark mode tested
- [ ] Error scenarios tested
- [ ] No critical bugs
- [ ] Test report documented

---

## Example Session Transcripts

### Session 1: Product Owner Creating User Story

**User Request:**
"I want admin users to be able to filter bugs by status and severity"

**LLM-PO Response:**
```
I'll create a user story for this feature request.

Creating: docs/05_user_stories/US-042_admin_bug_filtering.md

# User Story: US-042 Admin Bug Filtering

**As an** admin user
**I want** to filter bugs by status and severity
**So that** I can quickly find and manage specific types of bugs

## Acceptance Criteria
1. Admin bug page displays filter dropdowns for status and severity
2. Status filter includes: Open, In Progress, Resolved, Closed
3. Severity filter includes: Low, Medium, High, Critical
4. Filters can be combined (e.g., High severity + Open status)
5. Filter results update without page reload
6. Filter state persists during session
7. "Clear Filters" button resets all filters
8. Results count displays: "Showing X of Y bugs"

## Business Value
- Reduces time to find specific bugs by 80%
- Improves admin workflow efficiency
- Enables better bug prioritization

## Priority: High
## Story Points: 5
## Sprint: 12

## Dependencies
- Admin bug listing page must exist (US-031)
- Database must have status and severity fields

## Notes
- Consider adding search by bug ID in future iteration
- May want to save filter preferences in user settings
```

**User approves, LLM-PO adds to backlog**

---

### Session 2: Tech Lead Creating Implementation Plan

**LLM-TL Prompt:**
"Create implementation plan for US-042 Admin Bug Filtering"

**LLM-TL Response:**
```
I'll create a detailed implementation plan following the site standards.

Creating: docs/02_implementation_plans/IMPL-042_admin_bug_filtering.md

# Implementation Plan: IMPL-042 Admin Bug Filtering

**User Story:** US-042
**Developer:** LLM-DEV
**Reviewer:** LLM-CR
**QA:** LLM-QA

## Step 1: Verify Database Schema
Before starting, verify the bugs table has the correct columns:

Command:
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 freeconomy_dev -e "DESCRIBE bugs;"

Expected columns:
- status (enum or varchar)
- severity (enum or varchar)

## Step 2: Update AdminBugsController

File: app/Controllers/AdminBugsController.php

Add to index() method at line 25 (after authentication check):

```php
// Get filter parameters
$statusFilter = $_GET['status'] ?? '';
$severityFilter = $_GET['severity'] ?? '';

// Build query with filters
$query = new QueryBuilder();
$query = $query->table('bugs')
               ->select([
                   'bugs.*',
                   'users.username as reporter_name',
                   'tc.objective as test_case_title'
               ])
               ->join('users', 'bugs.reported_by', '=', 'users.id')
               ->join('test_cases tc', 'bugs.test_case_id', '=', 'tc.id');

// Apply status filter
if (!empty($statusFilter)) {
    $query = $query->where('bugs.status', '=', $statusFilter);
}

// Apply severity filter
if (!empty($severityFilter)) {
    $query = $query->where('bugs.severity', '=', $severityFilter);
}

$bugs = $query->orderBy('bugs.created_at', 'DESC')->get();

// Get total count for "X of Y" display
$totalQuery = new QueryBuilder();
$totalCount = $totalQuery->table('bugs')->count();
$filteredCount = count($bugs);
```

Add to view data array:

```php
$viewData = [
    // existing data...
    'currentFilters' => [
        'status' => $statusFilter,
        'severity' => $severityFilter
    ],
    'totalCount' => $totalCount,
    'filteredCount' => $filteredCount,
    'statusOptions' => ['open', 'in_progress', 'resolved', 'closed'],
    'severityOptions' => ['low', 'medium', 'high', 'critical']
];
```

## Step 3: Update View Template

File: app/Views/admin/bugs/index.php

Add filter form after line 15 (after the header div):

```php
<div class="bugs-filters">
    <form method="GET" action="<?php echo View::url('admin/bugs'); ?>" class="filters-form" id="bugFiltersForm">
        <div class="filters-row">
            <!-- Status Filter -->
            <div class="filter-group">
                <label for="status" class="filter-label">Status</label>
                <select id="status" name="status" class="filter-select">
                    <option value="">All Statuses</option>
                    <?php foreach ($statusOptions as $status): ?>
                        <option value="<?php echo View::escape($status); ?>"
                                <?php echo ($currentFilters['status'] === $status) ? 'selected' : ''; ?>>
                            <?php echo View::escape(ucfirst(str_replace('_', ' ', $status))); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <!-- Severity Filter -->
            <div class="filter-group">
                <label for="severity" class="filter-label">Severity</label>
                <select id="severity" name="severity" class="filter-select">
                    <option value="">All Severities</option>
                    <?php foreach ($severityOptions as $severity): ?>
                        <option value="<?php echo View::escape($severity); ?>"
                                <?php echo ($currentFilters['severity'] === $severity) ? 'selected' : ''; ?>>
                            <?php echo View::escape(ucfirst($severity)); ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <!-- Filter Actions -->
            <div class="filter-group filter-actions">
                <button type="submit" class="filter-btn filter-apply">
                    🔍 Apply Filters
                </button>
                <a href="<?php echo View::url('admin/bugs'); ?>" class="filter-btn filter-clear">
                    Clear Filters
                </a>
            </div>
        </div>
    </form>

    <!-- Results Count -->
    <div class="bugs-count">
        Showing <strong><?php echo $filteredCount; ?></strong> of
        <strong><?php echo $totalCount; ?></strong> bugs
    </div>
</div>
```

## Step 4: Add CSS Styles

File: assets/css/admin-bugs.css

Add at line 200 (after existing table styles):

```css
/* =================================================================
   BUG FILTERS
   ================================================================= */

.bugs-filters {
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.18);
  border-radius: var(--radius-xl);
  padding: var(--space-6);
  margin-bottom: var(--space-6);
}

.filters-form {
  width: 100%;
}

.filters-row {
  display: flex;
  gap: var(--space-4);
  align-items: flex-end;
  flex-wrap: wrap;
}

.filter-group {
  display: flex;
  flex-direction: column;
  gap: var(--space-2);
  flex: 1;
  min-width: 200px;
}

.filter-label {
  font-size: var(--font-size-sm);
  font-weight: var(--font-weight-medium);
  color: var(--color-text-light);
}

.filter-select {
  padding: var(--space-3) var(--space-4);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  font-size: var(--font-size-base);
  background: var(--color-background);
  color: var(--color-text);
  cursor: pointer;
  transition: var(--transition-fast);
}

.filter-select:hover {
  border-color: var(--color-primary);
}

.filter-select:focus {
  outline: none;
  border-color: var(--color-primary);
  box-shadow: 0 0 0 3px rgba(34, 139, 34, 0.1);
}

.filter-actions {
  display: flex;
  gap: var(--space-3);
  flex-direction: row;
}

.filter-btn {
  padding: var(--space-3) var(--space-6);
  border-radius: var(--radius-md);
  font-size: var(--font-size-sm);
  font-weight: var(--font-weight-medium);
  cursor: pointer;
  transition: var(--transition-fast);
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  gap: var(--space-2);
}

.filter-apply {
  background: var(--gradient-primary);
  color: white;
  border: none;
}

.filter-apply:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-md);
}

.filter-clear {
  background: var(--color-background-secondary);
  color: var(--color-text);
  border: 1px solid var(--color-border);
}

.filter-clear:hover {
  background: var(--color-background-dark);
}

.bugs-count {
  margin-top: var(--space-4);
  font-size: var(--font-size-sm);
  color: var(--color-text-muted);
  text-align: center;
}

/* Dark Mode */
[data-theme="dark"] .bugs-filters {
  background: rgba(30, 41, 59, 0.85);
  border-color: rgba(148, 163, 184, 0.18);
}

[data-theme="dark"] .filter-select {
  background: var(--color-background-secondary);
  border-color: var(--color-border);
}

/* Mobile Responsive */
@media (max-width: 768px) {
  .filters-row {
    flex-direction: column;
  }

  .filter-group {
    width: 100%;
    min-width: unset;
  }

  .filter-actions {
    width: 100%;
  }

  .filter-btn {
    flex: 1;
    justify-content: center;
  }
}
```

## Step 5: Add JavaScript for AJAX Filtering (Optional Enhancement)

File: assets/js/admin-bugs.js

Add at end of file:

```javascript
// Auto-submit form on filter change
document.addEventListener('DOMContentLoaded', function() {
    const filterSelects = document.querySelectorAll('.filter-select');

    filterSelects.forEach(select => {
        select.addEventListener('change', function() {
            document.getElementById('bugFiltersForm').submit();
        });
    });
});
```

## Step 6: Test Requirements

Create test cases for:
1. Filter by status only
2. Filter by severity only
3. Filter by both status and severity
4. Clear filters button
5. Results count accuracy
6. Empty state when no results
7. URL parameter persistence
8. Mobile responsive behavior
9. Dark mode appearance

## Verification Checklist

Before submitting for code review, verify:
- [ ] Database schema verified
- [ ] Controller code matches exactly
- [ ] View template matches exactly
- [ ] CSS uses only variables from variables.css
- [ ] Dark mode styles included
- [ ] Mobile responsive styles included
- [ ] All user input escaped
- [ ] QueryBuilder used for all queries
- [ ] Docblocks added to new methods
- [ ] JavaScript auto-submit working
- [ ] Self-review completed

## Security Notes
- All filter inputs are validated through QueryBuilder
- No direct SQL concatenation
- View::escape() used on all output
- No XSS vulnerabilities

## Estimated Time: 3 hours
```

---

### Session 3: Developer Implementing Feature

**LLM-DEV Prompt:**
"Implement IMPL-042 Admin Bug Filtering"

**LLM-DEV Response:**
```
I will implement IMPL-042 exactly as specified.

Step 1: Verifying database schema...

[Runs database command from plan]

Database verified. Columns exist:
- status: enum('open','in_progress','resolved','closed')
- severity: enum('low','medium','high','critical')

Step 2: Updating AdminBugsController...

[Edits app/Controllers/AdminBugsController.php exactly as specified in plan]

Step 3: Updating view template...

[Edits app/Views/admin/bugs/index.php exactly as specified in plan]

Step 4: Adding CSS styles...

[Edits assets/css/admin-bugs.css exactly as specified in plan]

Step 5: Adding JavaScript...

[Edits assets/js/admin-bugs.js exactly as specified in plan]

Step 6: Running verification checklist...

✓ Database schema verified
✓ Controller code matches plan
✓ View template matches plan
✓ CSS uses only variables
✓ Dark mode styles included
✓ Mobile responsive styles included
✓ All user input escaped
✓ QueryBuilder used
✓ Docblocks added
✓ JavaScript working

Implementation complete. Ready for code review CR-042.
```

---

## Common Pitfalls to Avoid

### ❌ Pitfall 1: Developer Making Design Decisions
**Wrong:**
```
"The implementation plan specifies a dropdown, but I think a checkbox
would be better UX, so I'll use checkboxes instead."
```

**Correct:**
```
"The implementation plan specifies a dropdown. I will implement a dropdown
exactly as specified. If I have concerns about UX, I'll note them in the
pull request for the Tech Lead to consider for future iterations."
```

### ❌ Pitfall 2: Code Reviewer Rewriting Code
**Wrong:**
```
"The code works but I would have written it differently.
I'll reject this and provide my preferred approach."
```

**Correct:**
```
"The code matches the implementation plan and follows all standards.
Approved. I've noted some alternative approaches for future consideration
in the review report."
```

### ❌ Pitfall 3: QA Changing Requirements
**Wrong:**
```
"The acceptance criteria says to filter by status and severity,
but it would be better to also filter by date. I'll test the date
filter I've requested the developer add."
```

**Correct:**
```
"I've tested all acceptance criteria from US-042. All passed.
I've created a new user story US-043 for date filtering as
a future enhancement."
```

### ❌ Pitfall 4: Incomplete Implementation Plans
**Wrong:**
```
"Step 3: Add some CSS to make it look good"
```

**Correct:**
```
"Step 3: Add CSS styles to assets/css/admin-bugs.css at line 200.
Use the following exact code:

[Complete CSS code provided with exact selectors, properties, and values]
```

### ❌ Pitfall 5: Assuming Instead of Asking
**Wrong (Developer):**
```
"The plan doesn't specify button color, so I'll use blue since
that's a common button color."
```

**Correct (Developer):**
```
"Tech Lead, IMPL-042 Step 4 specifies 'Add submit button' but doesn't
specify the button color. Please update the plan with the exact CSS
classes or color variable to use."
```

---

## Handoff Protocol

### When Passing Work to Next Role

**Include:**
1. Artifact ID (US-XXX, IMPL-XXX, etc.)
2. Status (Complete/Needs Review/Has Issues)
3. Location of all files created/modified
4. Any blockers or questions
5. Next role that should pick it up

**Example:**
```
Handoff: US-042 → LLM-TL for Implementation Plan

Status: Complete
Artifact: docs/05_user_stories/US-042_admin_bug_filtering.md
Priority: High
Story Points: 5
Sprint: 12

Next Action: LLM-TL create implementation plan IMPL-042

Notes:
- Database schema needs verification before implementation
- Consider mobile UX carefully for filter dropdowns
```

---

## Session Start Checklist

### Every LLM Session Should Start With:

1. **Identify your role:** "I am LLM-[ROLE]"
2. **Read required docs:**
   - CLAUDE.md (project context)
   - docs/06_standards/SITE_STANDARDS.md (standards)
   - docs/01_agile_framework/AGILE_DEVELOPMENT_FRAMEWORK.md (process)
   - docs/01_agile_framework/LLM_COLLABORATION_GUIDE.md (this doc)
   - Role-specific artifacts from previous roles

3. **Confirm understanding:**
   - "I understand I must follow [implementation plan/standards/etc] exactly"
   - "I will not make independent decisions outside my role"
   - "I will ask for clarification if anything is ambiguous"

4. **Check dependencies:**
   - Required artifacts from previous roles exist
   - Quality gates passed
   - No blockers

5. **Begin work:**
   - Follow templates
   - Reference standards for every decision
   - Document as you go

---

## Success Metrics

### For Individual Roles

**LLM-PO:**
- User stories have 100% clear acceptance criteria
- 0 stories sent back for clarification

**LLM-TL:**
- Implementation plans are 100% prescriptive
- 0 developer questions during implementation
- 0 "I wasn't sure so I chose..." comments in code review

**LLM-DEV:**
- 100% code matches implementation plan
- 100% standards compliance
- First-time code review approval rate >90%

**LLM-CR:**
- 100% standards violations caught
- 0 security issues reach production
- Clear, actionable feedback

**LLM-QA:**
- 100% acceptance criteria verified
- 0 bugs found in production that should have been caught in QA
- Complete test coverage

### For Overall Process

- Velocity consistency (±10% between sprints)
- Low rework rate (<15%)
- Fast handoffs (<1 day between roles)
- High documentation quality (peer-reviewed 5/5)
- Zero standards violations in production

---

## This Guide is Mandatory

All LLMs working on FreeconomyToday MUST follow this collaboration guide.

Any LLM that operates outside their defined role or makes independent decisions not authorized by their role will have their work rejected.

The goal is to simulate a real development team where each role has clear boundaries and responsibilities.
