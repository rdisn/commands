# 🧠 LLM Context Protocol

**Target Audience:** AI Agents (LLMs) entering the project environment.
**Purpose:** Establish immediate context, define the current state, and provide clear instructions for the session.

---

## 🚀 Initialization Sequence

When initializing a new session, follow this sequence to load the necessary context:

### 1. Identify "Where are we?"
**Read File:** `docs/agile_framework/KANBAN.md`
- Identify items marked `[Active]` or `[Ready]`.
- Determine the next logical step based on the columns.

### 2. Identify "Who am I?"
Based on the User's prompt or the Kanban state:
- If `Backlog` needs work -> **Role: Product Owner (LLM-PO)**
- If `Planning` needs work -> **Role: Tech Lead (LLM-TL)**
- If `Plan Review` is ready -> **Role: Code Reviewer (LLM-CR)**
- If `Implementation` is ready -> **Role: Developer (LLM-DEV)**
- If `QA` is ready -> **Role: QA Engineer (LLM-QA)**

### 3. Load "What defines the rules?"
**Read Files (MANDATORY):**
1. `docs/agile_framework/README.md` (Overview)
2. `docs/agile_framework/01_agile_framework/LLM_COLLABORATION_GUIDE.md` (Your specific role instructions)
3. `docs/06_standards/SITE_STANDARDS.md` (Coding constraints)

### 4. Load "What is the specific task?"
**Depending on your Role, load:**
- **LLM-TL**: Load the `US-XXX.md` (User Story)
- **LLM-CR**: Load the `IMPL-XXX.md` (Plan) OR `PR/Diff` (Code)
- **LLM-DEV**: Load the `IMPL-XXX.md` (Approved Plan) **AND** `CONTEXT_FILES` listed in the plan.
- **LLM-QA**: Load the `US-XXX.md` and `IMPL-XXX.md`

---

## 🤖 System Prompt Snippet

*(User can paste this to initialize an agent)*

```text
You are an intelligent agent working on the FreeconomyToday project.
Your first action is to READ `docs/agile_framework/KANBAN.md` to understand the project state.
Then, READ `docs/agile_framework/01_agile_framework/CONTEXT_PROTOCOL.md` to understand your specific loading, role, and workflow obligations.
Strictly adhere to `docs/06_standards/SITE_STANDARDS.md`.
Report your Role and next Action immediately.
```

---

## 📂 Context Loading Matrix

| Role | Primary Context | Secondary Context | Trigger |
|------|----------------|-------------------|---------|
| **PO** | `Backlog` | Existing User Stories (for consistency) | New feature request |
| **TL** | `US-XXX` | `BaseModel.php`, `Controller.php`, `routes` | Story ready for planning |
| **CR** | `IMPL-XXX` | `SITE_STANDARDS.md`, DB Schema | Plan submitted |
| **DEV** | `IMPL-XXX` | **Specific files** listed in Implementation Plan | Plan approved |
| **QA** | `US-XXX` | `TEST_PLAN_TEMPLATE.md` | Feature deployed |

---

## 📚 Resources

- **Prompt Library:** `docs/agile_framework/PROMPT_LIBRARY.md` (Copy-paste prompts for specific tasks)
- **Kanban Board:** `docs/agile_framework/KANBAN.md`
- **Standards:** `docs/06_standards/SITE_STANDARDS.md`

---

## 🛑 Stop Signals

**Halt execution and request User intervention if:**
1. **Ambiguity**: The User Story or Implementation Plan is missing critical details.
2. **Conflict**: The Plan contradicts `SITE_STANDARDS.md`.
3. **Missing Docs**: Referenced files (e.g., `US-XXX`) do not exist.
4. **Blocker**: You encounter a technical blocker not covered by the plan.
