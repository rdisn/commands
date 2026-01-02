# Agile Development Framework
**FreeconomyToday Recycling Platform**

## Overview
This framework establishes a weekly sprint cycle with clear roles, ceremonies, and deliverables designed for multi-LLM collaboration.

---

## Sprint Structure

### Sprint Duration
- **1 Week Sprints** (Monday to Friday)
- Sprint Planning: Monday 9:00 AM
- Daily Standup: Every day 9:00 AM (async via documentation updates)
- Sprint Review: Friday 2:00 PM
- Sprint Retrospective: Friday 3:00 PM

### Sprint Artifacts Location
```
docs/08_sprint_planning/
├── sprint_XX_plan.md           # Sprint goals and user stories
├── sprint_XX_backlog.md        # Prioritized work items
└── sprint_XX_velocity.md       # Velocity tracking

docs/09_retrospectives/
├── sprint_XX_retrospective.md  # What worked, what didn't
└── sprint_XX_improvements.md   # Action items for next sprint
```

---

## State Management (Active Work)

**The Single Source of Truth for "What is happening now" is:**
👉 `docs/agile_framework/KANBAN.md`

### Using the Kanban Board
- **Backlog**: Work waiting to be started.
- **Planning**: Tech Lead is creating Implementation Plan.
- **Plan Review**: Plan is waiting for approval.
- **Implementation**: Developer is writing code.
- **Code Review**: Code is waiting for review.
- **QA**: Feature is being verified.
- **Done**: Deployed and verified.

**Rule**: When you change the state of a User Story (e.g., finish planning), you **MUST** update `KANBAN.md` immediately.

---

## Simulated Team Roles

### 1. Product Owner (LLM-PO)
**Responsibilities:**
- Define feature requirements and acceptance criteria
- Prioritize backlog items
- Write user stories with clear acceptance criteria
- Review completed work against acceptance criteria

**Deliverables:**
- User stories in `docs/05_user_stories/`
- Feature requests in `docs/02_implementation_plans/feature_requests/`
- Acceptance criteria checklists

### 2. Tech Lead (LLM-TL)
**Responsibilities:**
- Create detailed implementation plans
- Define technical architecture
- Review code quality and standards compliance
- Approve technical decisions

**Deliverables:**
- Implementation plans in `docs/02_implementation_plans/`
- Architecture diagrams in `docs/07_diagrams/`
- Code review reports in `docs/03_code_reviews/`

### 3. Developer (LLM-DEV)
**Responsibilities:**
- Implement features following implementation plans
- Write clean, documented code
- Follow coding standards strictly
- Create unit tests

**Deliverables:**
- Code implementation
- Self-review checklist completion
- Unit test coverage

### 4. QA Engineer (LLM-QA)
**Responsibilities:**
- Create test plans from user stories
- Execute test cases
- Document bugs with reproduction steps
- Verify bug fixes

**Deliverables:**
- Test plans in `docs/04_testing/test_plans/`
- Test execution reports in `docs/04_testing/test_reports/`
- Bug reports in `docs/04_testing/bug_reports/`

### 5. Code Reviewer (LLM-CR)
**Responsibilities:**
- Review code against standards
- Check for security vulnerabilities
- Verify test coverage
- Approve/reject pull requests

**Deliverables:**
- Code review reports in `docs/03_code_reviews/`
- Security audit findings
- Refactoring recommendations

---

## Workflow Process

### Phase 1: Feature Request → User Story
**Input:** User/stakeholder feature request
**Process:**
1. Product Owner creates user story using template
2. Tech Lead adds technical notes and estimates
3. Story added to backlog with priority

**Output:** `docs/05_user_stories/US-XXX_story_name.md`

### Phase 2: User Story → Implementation Plan
**Input:** Prioritized user story
**Process:**
1. Tech Lead analyzes requirements
2. Creates detailed implementation plan
3. Identifies dependencies and risks
4. Defines database changes, API endpoints, UI components

**Output:** `docs/02_implementation_plans/IMPL-XXX_feature_name.md`

### Phase 3: Implementation Plan → Code
**Input:** Approved implementation plan
**Process:**
1. Developer receives prescriptive instructions
2. Developer implements exactly as specified
3. Developer runs self-review checklist
4. Developer creates pull request

**Output:** Working code + test coverage

### Phase 4: Code → Code Review
**Input:** Pull request with code changes
**Process:**
1. Code Reviewer checks against standards document
2. Reviewer runs automated tests
3. Reviewer verifies security best practices
4. Reviewer provides feedback or approval

**Output:** `docs/03_code_reviews/CR-XXX_review_report.md`

### Phase 5: Code Review → QA Testing
**Input:** Approved code merged to staging
**Process:**
1. QA Engineer executes test plan
2. QA verifies acceptance criteria met
3. QA performs regression testing
4. QA approves or logs bugs

**Output:** `docs/04_testing/test_reports/TEST-XXX_report.md`

### Phase 6: QA Approved → Production
**Input:** Tested and approved feature
**Process:**
1. Tech Lead creates deployment plan
2. Deploy to production
3. Monitor for issues
4. Update documentation

**Output:** Production release + release notes

---

## Key Ceremonies

### Sprint Planning (Monday)
**Duration:** 1 hour
**Participants:** All roles
**Activities:**
1. Review last sprint velocity
2. Select user stories from backlog
3. Break stories into tasks
4. Assign story points
5. Commit to sprint goal

**Output:** `docs/08_sprint_planning/sprint_XX_plan.md`

### Daily Standup (Async)
**Format:** Update standup document
**Questions:**
1. What did I complete yesterday?
2. What am I working on today?
3. What blockers do I have?

**Output:** `docs/08_sprint_planning/sprint_XX_standup.md`

### Sprint Review (Friday)
**Duration:** 30 minutes
**Participants:** All roles + stakeholders
**Activities:**
1. Demo completed features
2. Review against acceptance criteria
3. Gather feedback
4. Update product backlog

**Output:** `docs/08_sprint_planning/sprint_XX_review.md`

### Sprint Retrospective (Friday)
**Duration:** 30 minutes
**Participants:** Team roles only
**Activities:**
1. What went well?
2. What didn't go well?
3. What should we improve?
4. Action items for next sprint

**Output:** `docs/09_retrospectives/sprint_XX_retrospective.md`

---

## LLM Collaboration Rules

### Rule 1: No Independent Thinking
**Implementation LLMs (Developer role) must:**
- Follow implementation plans word-for-word
- Not make architectural decisions
- Not deviate from specified approach
- Ask clarifying questions if instructions unclear

### Rule 2: Role Adherence
**Each LLM must:**
- Stay within assigned role boundaries
- Only produce deliverables for their role
- Reference previous artifacts created by other roles
- Follow the workflow sequence

### Rule 3: Documentation First
**Before coding:**
- User story must exist
- Implementation plan must be approved
- Test plan must be created
- Standards must be reviewed

### Rule 4: Quality Gates
**Cannot proceed without:**
- Product Owner approval on user stories
- Tech Lead approval on implementation plans
- Code Reviewer approval on pull requests
- QA Engineer approval on test results

### Rule 5: Traceability
**Every artifact must reference:**
- Parent user story ID (US-XXX)
- Related implementation plan (IMPL-XXX)
- Associated test plan (TEST-XXX)
- Sprint number

---

## Document Numbering System

### User Stories
- Format: `US-XXX` (e.g., US-001, US-002)
- Location: `docs/05_user_stories/`
- Example: `US-042_admin_bug_filtering.md`

### Implementation Plans
- Format: `IMPL-XXX` (e.g., IMPL-001, IMPL-002)
- Location: `docs/02_implementation_plans/`
- Example: `IMPL-042_admin_bug_filtering.md`

### Code Reviews
- Format: `CR-XXX` (e.g., CR-001, CR-002)
- Location: `docs/03_code_reviews/`
- Example: `CR-042_admin_bug_filtering.md`

### Test Plans
- Format: `TEST-XXX` (e.g., TEST-001, TEST-002)
- Location: `docs/04_testing/test_plans/`
- Example: `TEST-042_admin_bug_filtering.md`

### Bug Reports
- Format: `BUG-XXX` (e.g., BUG-001, BUG-002)
- Location: `docs/04_testing/bug_reports/`
- Example: `BUG-042_filter_not_resetting.md`

---

## Success Metrics

### Velocity Tracking
- Story points completed per sprint
- Velocity trend over time
- Capacity planning accuracy

### Quality Metrics
- Bugs found in QA vs production
- Code review rejection rate
- Test coverage percentage
- Standards compliance score

### Process Metrics
- Time from story to production
- Rework percentage
- Documentation completeness
- LLM collaboration efficiency

---

## Next Steps

1. Review standards documentation: `docs/06_standards/SITE_STANDARDS.md`
2. Use templates in: `docs/00_templates/`
3. Start first sprint planning session
4. Create initial product backlog
5. Assign roles to LLM sessions
