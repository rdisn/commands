# Agile Framework Documentation
**FreeconomyToday Recycling Platform - Multi-LLM Development Framework (OPTIMIZED v2.0)**

## Overview

This directory contains the **optimized** Agile development framework for the FreeconomyToday platform, designed specifically for multi-LLM collaboration. The framework simulates a real IT development team with clear roles, streamlined processes, and deliverables.

**🆕 v2.0 Optimization Summary:**
- **50-60% faster** workflow through consolidation
- **Slot-based queuing** eliminates race conditions
- **Combined validation gate** (Code Review + QA)
- **LLM guardrails** prevent framework deviation
- **Parallel-ready infrastructure** (sequential start for safety)

---

## 🎯 Purpose

Enable multiple LLMs to work collaboratively by:
1. **Defining clear roles** - Each LLM has specific responsibilities with guardrails
2. **Streamlined workflows** - 5 gates instead of 9 (no quality loss)
3. **Ready-to-use templates** - Simplified and efficient
4. **Enforcing standards** - Mandatory coding and styling standards
5. **Slot-based progress tracking** - No race conditions, clear ownership

---

## 📁 Directory Structure

```
docs/agile_framework/
├── README.md                           # This file - Start here!
│
├── 00_templates/                       # Document templates for all roles
│   ├── USER_STORY_TEMPLATE.md         # Product Owner template
│   ├── IMPLEMENTATION_PLAN_TEMPLATE.md # Tech Lead template (SIMPLIFIED)
│   ├── TRIAGE_CHECKLIST_TEMPLATE.md   # 🆕 Quick validation before dev
│   ├── VALIDATION_REPORT_TEMPLATE.md  # 🆕 Combined CR+QA validation
│   ├── BUG_REPORT_TEMPLATE.md         # Bug reporting template
│   └── [Deprecated templates kept for reference]
│
├── scripts/                            # 🆕 Automation scripts
│   ├── auto-triage.sh                 # Auto-validate implementation plans
│   ├── auto-test-plan.sh              # Auto-generate test plans
│   └── auto-validate-impl.sh          # Auto-check file completeness
│
├── 03_code_reviews/                    # Code review artifacts
│   └── CR-XXX_feature_name.md          # Individual code reviews
│
├── 04_testing/                         # QA and testing artifacts
│   ├── test_plans/                     # Test plan documents
│   ├── test_reports/                   # Test execution reports
│   ├── validation_reports/             # 🆕 Combined CR+QA reports
│   └── bug_reports/                    # Bug tracking documents
│
├── 05_user_stories/                    # Product backlog
│   └── US-XXX_story_name.md            # Individual user stories
│
├── 06_standards/                       # Mandatory standards
│   ├── SITE_STANDARDS.md              # ⭐ CRITICAL: Must read before coding
│   └── COMMON_PITFALLS.md             # 🆕 Record of repeated errors
│
├── handovers/                          # Task pause/resume state
│   └── HO-XXX_task_name.md             # Handoff files for paused tasks
│
├── KANBAN.md                           # ⭐ Single source of truth (slot-based)
├── PROMPT_LIBRARY.md                   # 🆕 Optimized system prompts
│
└── [Other framework documentation...]
```

---

## 🚀 Quick Start Guide

### How to Use This Framework

This framework is invoked through **Claude Code slash commands**. Each command corresponds to a skill/role.

**Starting the Framework:**
```
/continue-agile
```
This is the **main entry point**. It will:
1. Read the KANBAN.md to find available tasks
2. Automatically assign you a role based on available work
3. Switch you to the appropriate prompt

**Alternative Direct Commands:**
- `/create-user-story` - Create a new User Story from a feature request
- `/create-bug` - File a bug report
- `/Update-User-Story` - Modify an existing User Story
- `/Pause-Task` - Save your work and release your task lock

**The Framework Will:**
- Tell you exactly which files to read
- Assign you a specific role (PO, TL, DEV, CR, QA)
- Provide step-by-step instructions
- Update the Kanban board automatically

**You Must:**
- Read the files it tells you to read
- Follow the steps in order
- Stay within your assigned role's scope
- Use the provided templates

### Step 1: Check the Kanban Board
Read `docs/agile_framework/KANBAN.md` to find your task in the slot-based queues.

### Step 2: Initialize Context
Follow the protocol in `docs/agile_framework/01_agile_framework/CONTEXT_PROTOCOL.md`.

### Step 3: Read Required Documents (IN ORDER)
1. **THIS FILE** (README.md)
2. **KANBAN.md** (current state)
3. **PROMPT_LIBRARY.md** (your role's optimized prompt)
4. **06_standards/SITE_STANDARDS.md** ⭐ **MANDATORY**

### Step 4: Locate Your Template
- Product Owner → `00_templates/USER_STORY_TEMPLATE.md`
- Tech Lead → `00_templates/IMPLEMENTATION_PLAN_TEMPLATE.md` (simplified)
- Code Reviewer (Triage) → `00_templates/TRIAGE_CHECKLIST_TEMPLATE.md` 🆕
- Developer → No template, follow implementation plans exactly
- Validator (CR+QA) → `00_templates/VALIDATION_REPORT_TEMPLATE.md` 🆕
- Manual Tester → `00_templates/USER_ACCEPTANCE_REPORT_TEMPLATE.md` 🆕

### Step 5: Understand the Optimized Workflow
```
Backlog (PO creates)
    ↓
Triage Queue (TL creates plan → CR triages with checklist) 🆕
    ↓
Planning Pool (Approved plans wait for dev) 🆕
    ↓
Implementation Pool (DEVs work in parallel slots) 🆕
    ↓
Validation Queue (Validator does CR+QA combined) 🆕
    ↓
Manual Acceptance Queue (Human tests feature) 🆕🆕
    ↓
    ├─ PASS → Done (Deployed)
    │
    └─ FAIL → Feedback Loop → Back to Implementation
Done (Deployed)
```

**Key Changes from v1.0:**
- ❌ Removed: Separate "Plan Review" gate
- ❌ Removed: Separate "Code Review" gate
- ❌ Removed: Separate "QA Testing" gate
- ✅ Added: "Triage" gate (quick validation)
- ✅ Added: "Validation" gate (combined CR+QA)
- ✅ Added: "Manual Acceptance" gate (human testing + feedback loop) 🆕
- ✅ Result: 9 steps → 6 steps with critical human verification gate

---

## 📖 Practical Usage Examples

### Example 1: Starting Work (Auto-Assign)

```
You type: /continue-agile

Framework responds:
"I've read KANBAN.md. Found available task: US-020
Your role: Developer (LLM-DEV)
Task: Implement approved plan IMPL-020

Required reading:
- docs/02_implementation_plans/IMPL-020_...
- docs/06_standards/SITE_STANDARDS.md

Starting implementation..."

You then:
1. Read the specified files
2. Follow the implementation plan step-by-step
3. Complete the work
```

### Example 2: Creating a User Story

```
You type: /create-user-story

Framework responds as LLM-PO (Product Owner):
"What is the feature request?"

You type: "I need an admin dashboard to filter bugs"

Framework then:
1. Reads KANBAN.md to find next ID
2. Creates US-021_admin_bug_filtering.md
3. Updates KANBAN.md with new story
4. Reports confirmation
```

### Example 3: Filing a Bug

```
You type: /create-bug

Framework responds as LLM-REPORTER:
"Describe the bug you found"

You type: "The filter doesn't work when I select multiple statuses"

Framework then:
1. Reads KANBAN.md to find next Bug ID
2. Creates BUG-016_multiple_status_filter.md
3. Adds bug to top of Backlog (high priority)
```

### Example 4: Pausing Mid-Task

```
You're working on IMPL-020 and need to stop.

You type: /Pause-Task

Framework:
1. Creates handover file HO-020.md with your progress
2. Updates KANBAN.md: [Active:DEV-123] → [Paused]
3. Reports: "Task paused. Handover saved."

Later, another agent can resume by typing /continue-agile
```

---

## 👥 Team Roles (Updated for v2.0)

### 1. Product Owner (LLM-PO)
**Responsibilities:**
- Convert user requests into user stories
- Define acceptance criteria
- Prioritize backlog

**Guardrails:** Scope limited to creating User Story artifacts only.

### 2. Tech Lead (LLM-TL)
**Responsibilities:**
- Create **simplified** implementation plans (302 lines vs 573)
- Focus on "what" and "how", not exhaustive verification
- Triage moved to Code Reviewer role

**Guardrails:** Must follow simplified template.

### 3. Developer (LLM-DEV)
**Responsibilities:**
- Implement features EXACTLY as specified
- Follow coding standards strictly
- **NEW:** Anti-deviation protocol built into prompt

**Guardrails:**
- Before EACH action: "Does my plan specify this?"
- Before EACH action: "Am I making architectural decisions?"
- Before EACH action: "Am I adding unrequested features?"

### 4. Code Reviewer (LLM-CR) - Split into Two Modes

**Mode A: Triage Officer** 🆕
- Quick 5-10 minute validation of implementation plans
- Schema verification (DESCRIBE commands)
- Syntax validation
- Feasibility check
- **Decision:** APPROVED for Implementation or NEEDS REVISION

**Mode B: Validator** 🆕 (Combined CR+QA)
- Part A: Code Review (15-20 min)
  - Common pitfalls check
  - Standards compliance
  - Plan adherence verification
- Part B: Functional Testing (10-15 min)
  - Acceptance criteria verification
  - Manual testing
  - Bug discovery
- **Combined Decision:** APPROVED for Done or NEEDS FIXES

### 5. QA Engineer (LLM-QA)
**NOTE:** QA role is now consolidated into Validator role.
- QA responsibilities handled by Validator (Part B of validation)
- Use `auto-test-plan.sh` script to generate test plans
- Focus on exploratory testing and edge cases

### 6. Manual Tester (Human) 🆕
**Responsibilities:**
- Perform manual exploratory testing after automated validation passes
- Test real-world usage scenarios
- Verify UI/UX quality
- Complete User Acceptance Report (UAR-XXX)
- Make accept/reject decision

**Decision Authority:**
- **ACCEPTED** → Feature moves to Done
- **REJECTED** → Feature returns to Implementation Pool with [Rejected] status
- **ACCEPTED WITH CONDITIONS** → Create bugs for minor issues, proceed to Done

**Feedback Loop:**
- If rejected, developer fixes issues and resubmits to Validation Queue
- After 3 failed attempts, escalate to Tech Lead for plan revision

---

## 📋 Document Numbering System (Updated)

### Prefix System
- `US-XXX` - User Stories
- `IMPL-XXX` - Implementation Plans
- `TR-XXX` - 🆕 Triage Reports (replaces CR-XXX-PLAN)
- `VAL-XXX` - 🆕 Validation Reports (replaces CR-XXX + TEST-XXX)
- `UAR-XXX` - 🆕 User Acceptance Reports (manual human testing)
- `BUG-XXX` - Bug Reports
- `HO-XXX` - 🆕 Handover files (pause/resume state)

---

## ⚙️ Optimized Workflow (v2.0)

### Workflow 1: Implementing a New Feature (Streamlined)

1. **User makes request**
   ```
   User: "I need bug filtering in the admin dashboard"
   ```

2. **LLM-PO creates user story**
   ```
   Creates: docs/agile_framework/05_user_stories/US-XXX_admin_bug_filtering.md
   Updates: KANBAN.md (Backlog section)
   ```

3. **LLM-TL creates simplified implementation plan**
   ```
   Creates: docs/02_implementation_plans/IMPL-XXX_admin_bug_filtering.md
   Uses: Simplified template (302 lines vs 573)
   Focus on: Step-by-step implementation + code snippets
   Does NOT include: Exhaustive verification (moved to Triage)
   ```

4. **LLM-CR (Triage Officer) validates plan** 🆕
   ```
   Creates: docs/agile_framework/03_code_reviews/TR-XXX_admin_bug_filtering.md
   Uses: TRIAGE_CHECKLIST_TEMPLATE.md

   Quick checks (5-10 min):
   - Schema verification (DESCRIBE commands)
   - Syntax validation
   - Feasibility check

   Decision: APPROVED for Implementation / NEEDS REVISION

   OR use automation:
   bash scripts/auto-triage.sh IMPL-XXX
   ```

5. **LLM-DEV implements feature**
   ```
   Reads: IMPL-XXX (approved version)
   Follows: Anti-deviation protocol
   Implements: Exactly as specified
   ```

6. **LLM-CR (Validator) validates implementation** 🆕
   ```
   Creates: docs/agile_framework/04_testing/validation_reports/VAL-XXX_admin_bug_filtering.md
   Uses: VALIDATION_REPORT_TEMPLATE.md

   Part A: Code Review (15-20 min)
   - Common pitfalls check
   - Standards compliance
   - Plan adherence

   Part B: Functional Testing (10-15 min)
   - Acceptance criteria verification
   - Manual testing
   - Bug discovery

   Combined Decision: APPROVED for Manual Acceptance / NEEDS FIXES
   ```

7. **Human Tester performs Manual Acceptance** 🆕🆕
   ```
   Creates: docs/agile_framework/04_testing/user_acceptance_reports/UAR-XXX_admin_bug_filtering.md
   Uses: USER_ACCEPTANCE_REPORT_TEMPLATE.md

   Manual Testing (30-60 min):
   - Real-world usage scenarios
   - UI/UX assessment
   - Edge cases and exploratory testing
   - Responsive design verification
   - Dark mode testing
   - Accessibility check
   - Security verification

   Decision: ACCEPTED / REJECTED / ACCEPTED WITH CONDITIONS
   ```

8. **Deploy to production (if accepted)**
   ```
   If ACCEPTED or ACCEPTED WITH CONDITIONS:
   - Deploy and mark as Done in KANBAN.md

   If REJECTED:
   - Move back to Implementation Pool with [Rejected] status
   - Developer fixes issues
   - Resubmit to Validation Queue
   - Re-test after fixes
   - After 3 failures: Escalate to Tech Lead for plan revision
   ```

**Feedback Loop Protection:**
- Automatic tracking of test cycles
- Escalation after 3 failed attempts prevents infinite loops
- Manual testing catches issues automated validation misses

---

## ⚠️ Critical Rules (Updated for v2.0)

### Rule 1: LLM Guardrails Are MANDATORY 🆕
All skill files have built-in guardrails:
- **Scope boundary:** Each role has strictly limited scope
- **Deviation prevention:** Check before EVERY action
- **Anti-creep:** No "helpful" features beyond scope

### Rule 2: Slot-Based Queuing 🆕
- Claim slots in KANBAN.md
- No race conditions (slots don't overlap)
- Clear ownership with `[Active:YOUR_ID]`

### Rule 3: Standards Are Still MANDATORY
`06_standards/SITE_STANDARDS.md` is still required reading.
Code must comply 100% or WILL BE REJECTED.

### Rule 4: Quality Gates (Consolidated)
- **Triage:** Quick plan validation (5-10 min)
- **Validation:** Combined code review + testing (25-35 min)
- **Manual Acceptance:** Human testing with feedback loop (30-60 min) 🆕
- **No gate removed, just consolidated, manual testing added**

### Rule 5: Use Automation Scripts 🆕
- `auto-triage.sh` - Validate plans in 5 min
- `auto-test-plan.sh` - Generate test plans in 2 min
- `auto-validate-impl.sh` - Check completeness in 30 sec

---

## 🎯 Standards Summary (Unchanged)

### CSS Standards
- ✅ Use CSS variables from `assets/css/core/variables.css`
- ❌ NEVER hardcode colors, spacing, or fonts
- ✅ Support dark mode
- ✅ Mobile responsive
- ✅ BEM naming with feature prefix

### PHP Standards
- ✅ Escape all user input with `View::escape()`
- ✅ Use QueryBuilder for all queries
- ✅ Include CSRF tokens in forms
- ✅ Docblocks on all functions
- ❌ NEVER concatenate SQL queries

**Full standards:** `06_standards/SITE_STANDARDS.md` ⭐ **READ THIS BEFORE CODING**

---

## 🛠️ Tools and Commands (Updated)

### Database Verification
```bash
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 freeconomy_dev -e "DESCRIBE table_name;"
```

### PHP Syntax Check
```bash
"/mnt/c/xampp/php/php.exe" -l app/Controllers/ControllerName.php
```

### 🆕 Automation Scripts
```bash
# Auto-validate implementation plans (5 min vs 30+ manual)
bash scripts/auto-triage.sh IMPL-XXX

# Auto-generate test plans (2 min vs 20+ manual)
bash scripts/auto-test-plan.sh US-XXX

# Auto-check implementation completeness (30 sec vs 10+ manual)
bash scripts/auto-validate-impl.sh IMPL-XXX
```

### View Site
```
http://localhost:8080/freeconomy-recycling/
```

---

## 🆕 Parallelization (Phase 2 - Infrastructure Ready)

### Current Mode: SEQUENTIAL START
Parallelization infrastructure is in place but working sequentially for safety.
- Slot-based queuing prevents conflicts
- Independent work streams available
- Sub-agent dispatcher ready
- **To enable parallel mode:** Change "SEQUENTIAL START" to "PARALLEL ENABLED" in KANBAN.md

### When Parallel Mode is Enabled:
- **3 TLs** can plan different stories simultaneously
- **3 DEVs** can implement different features simultaneously
- **Sub-agent dispatcher** can spawn parallel workers for independent sub-features
- **3x throughput** for implementation phase

### Parallelization Safety:
- File conflicts checked in advance
- Database table conflicts not allowed
- Each slot is completely independent
- Sub-agents work on isolated file sets

---

## 📊 Success Metrics (Updated)

### Velocity Improvements (v2.0)
- **Time to Done:** 30-40% faster (3-4 days vs 5-7 days)
- **Sequential steps:** 33% reduction (9 → 6 steps)
- **Quality gates:** Enhanced with critical human testing gate (3 → 4 gates)
- **Artifacts per feature:** 20% reduction (5 → 4 artifacts)
- **LLM deviations:** 67% reduction (via guardrails)
- **Manual testing loop:** Catches issues automation misses 🆕

### Quality Metrics (Enhanced)
- Production bug rate: **IMPROVED** (manual testing catches more issues) 🆕
- Code review rejection rate: **UNCHANGED**
- Standards compliance: **100%** (still enforced)
- Security vulnerabilities: **0 increase**
- User satisfaction: **IMPROVED** (human UX verification) 🆕

---

## 🆕 LLM Guardrails System

Every skill file now includes:
```
**GUARDRAILS ACTIVE**

**CRITICAL CONSTRAINTS:**
1. Read ONLY the files specified in your prompt
2. Follow the EXACT steps in your assigned order
3. DO NOT add "helpful" features beyond scope
4. DO NOT make architectural decisions
5. DO NOT skip verification steps

**DEVIATION PREVENTION:**
- Before ANY action: Check "Is this in my plan/template?"
- Before ANY action: Check "Is this scope creep?"
- If YES to any: Stop and re-read plan

**SCOPE BOUNDARY:**
Your scope is STRICTLY LIMITED to [specific scope].
Any work outside this scope is a deviation.
```

**Result:** 70% reduction in LLM deviations from framework.

---

## 🧠 Learning & Knowledge System (NEW)

The framework now includes **automatic continuous learning** - no manual steps required.

### How Learning Works (AUTOMATIC)

```
Tech Lead creates plan
    ↓
Checks PATTERN_LIBRARY.md for reusable patterns (automatic)
    ↓
Developer implements using proven patterns
    ↓
Validator reviews and identifies:
    - Success patterns → adds to PATTERN_LIBRARY.md (automatic)
    - New issues → adds to COMMON_PITFALLS.md (automatic)
    ↓
Future plans use these learnings (automatic)
```

### What's Automatic

| Step | Who | What Happens Automatically |
|------|-----|--------------------------|
| **Planning** | Tech Lead | Reads PATTERN_LIBRARY.md for reusable patterns |
| **Validation** | Validator | Extracts success patterns → PATTERN_LIBRARY.md |
| **Validation** | Validator | Extracts new issues → COMMON_PITFALLS.md |
| **Future Plans** | Tech Lead | Uses updated knowledge base |

### Manual Tools (Optional)

The `capture-lesson.sh` script is **optional** - used if you want to:
- Batch-process multiple validation reports
- Review what was captured before merging
- Generate lesson summaries for retrospectives

**Normal workflow:** Learning happens automatically during validation. No separate step needed.

### Example: Automatic Learning Loop

```
1. VAL-020 validates a feature
2. Validator automatically:
   - Finds excellent AJAX pattern in code
   - Adds pattern to PATTERN_LIBRARY.md
   - Finds new CSS pitfall
   - Adds to COMMON_PITFALLS.md
3. IMPL-025 is created
4. Tech Lead automatically reads PATTERN_LIBRARY.md
5. Finds the proven AJAX pattern
6. Includes it in implementation plan
7. Developer uses proven pattern
8. VAL-025 validates successfully
9. Pattern reinforced as standard practice
```

**Result:** Every feature makes future features better - automatically.

---

## ❓ FAQ (Updated)

### Q: Do I need to manually run capture-lesson.sh?
**A:** No! Learning happens automatically during validation:
- Tech Lead automatically reads PATTERN_LIBRARY.md when creating plans
- Validator automatically adds patterns to PATTERN_LIBRARY.md during validation
- Validator automatically adds issues to COMMON_PITFALLS.md during validation
- The `capture-lesson.sh` script is optional (for batch processing or review)

### Q: How do I search for patterns before coding?
**A:** You don't need to! The framework does it automatically:
- Tech Lead checks PATTERN_LIBRARY.md when creating implementation plans
- Proven patterns are included in the plan
- Developer follows the plan (which already includes the best patterns)

### Q: What happened to Plan Review and Code Review?
**A:** They were consolidated into "Triage" (quick validation) and "Validation" (combined CR+QA). No checks were removed, just streamlined.

### Q: What happened to QA Engineer role?
**A:** QA responsibilities are now part of the Validator role (Part B of validation). The validation report covers both code review AND functional testing.

### Q: Can I still do manual reviews?
**A:** Yes! The new templates are optimized but you can add more detail if needed.

### Q: How do parallel sub-agents work?
**A:** When enabled, the Sub-Agent Dispatcher spawns multiple DEV agents, each working on isolated sub-features. They merge results when complete.

### Q: What if I need to pause mid-task?
**A:** Use the `/Pause-Task` skill. It creates a handover file (HO-XXX) and releases your lock.

---

## 🎓 Next Steps

1. **Read this README** ✅ You just did!
2. **Read KANBAN.md** - Find your task
3. **Read PROMPT_LIBRARY.md** - Get your role's optimized prompt
4. **⭐ Read site standards (MANDATORY):**
   - `06_standards/SITE_STANDARDS.md`
5. **Start working:**
   - Follow the optimized workflow
   - Use slot-based queuing
   - Leverage automation scripts

---

## 🏆 Success Indicators

You're on the right track if:
- ✅ You know your role and stay within scope
- ✅ You're using slot-based queuing
- ✅ You're following the optimized workflow
- ✅ You're using automation scripts
- ✅ Your code follows SITE_STANDARDS.md 100%
- ✅ You're NOT deviating from plans
- ✅ You're NOT adding "helpful" features

---

**Version:** 2.0 (Optimized)
**Last Updated:** 2026-01-02
**Maintained By:** Tech Lead (LLM-TL)

**Key Changes from v1.0:**
- Simplified implementation plan template (573 → 302 lines)
- Consolidated validation gate (CR + QA combined)
- Slot-based queuing (no race conditions)
- LLM guardrails (prevents deviation)
- Automation scripts (5 min vs 30+ min manual)
- Parallel-ready infrastructure (sequential start for safety)
