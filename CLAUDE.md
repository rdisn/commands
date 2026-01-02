# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This repository contains **Claude Code command skills** for the FreeconomyToday project. Each `.md` file in the root directory defines a custom slash command (skill) that can be invoked within Claude Code.

## Command Architecture

This is a **skill definitions repository**, not a traditional code repository. The files here are prompt templates that define specialized workflows for an Agile development framework.

### Skill Files

Each markdown file represents a Claude Code skill with these components:

1. **Role Definition** - Specifies the persona/role the AI should adopt (e.g., LLM-PO, LLM-TL, Developer)
2. **Context Protocol** - Instructions to read specific project documentation files
3. **Execution Steps** - Detailed workflow the AI should follow
4. **State Updates** - Instructions to modify project tracking files (KANBAN.md, user stories, etc.)

### Available Skills

| Skill File | Purpose | Role |
|------------|---------|------|
| `continue-agile.md` | Entry point for all Agile workflow commands | Auto-Task Dispatcher |
| `Auto-Task-Dispatcher.md` | Claims next available task based on role | Task Coordinator |
| `create-user-story.md` | Creates new User Story artifacts | Product Owner |
| `Update-User-Story.md` | Modifies existing User Stories | Product Owner |
| `create-bug.md` | Files bug reports | Tester/Reporter |
| `promote-to-stage.md` | Dev-to-Stage deployment with DB migration | DevOps |
| `Pause-Task.md` | Saves current work state | Any Role |

## Framework Conventions

### Kanban Board State Management

The framework uses a **concurrency control system** with task locking:

- `[ ]` - Unclaimed task (available)
- `[Active:LOCK_ID]` - Task claimed and in progress (locked)
- `[Paused]` - Task temporarily paused with handover
- `[Rejected]` - Task rejected, needs rework
- `[x]` - Completed

**Critical Rule**: When claiming tasks, always verify the lock ID after updating to prevent race conditions.

### Project Structure References

Skills reference these external locations (not in this repo):

- `docs/agile_framework/KANBAN.md` - Project state tracking
- `docs/agile_framework/05_user_stories/` - User Story artifacts
- `docs/agile_framework/04_testing/bug_reports/` - Bug reports
- `docs/agile_framework/00_templates/` - Document templates
- `docs/agile_framework/PROMPT_LIBRARY.md` - Role-specific prompts (optimized system prompts for each role)
- `docs/agile_framework/handovers/` - Task pause/resume state
- `docs/agile_framework/06_standards/SITE_STANDARDS.md` - Mandatory coding standards
- `docs/agile_framework/06_standards/COMMON_PITFALLS.md` - Record of repeated errors to avoid
- `docs/02_implementation_plans/` - Technical implementation plans (created by TL)

### Development Workflow

```
KANBAN.md (check first)
    ↓
Product Owner creates User Story (US-XXX)
    ↓
Tech Lead creates Implementation Plan (IMPL-XXX)
    ↓
Code Reviewer reviews PLAN (CR-XXX-PLAN) → validates DB schema, methods, standards compliance
    ↓
Developer implements approved plan EXACTLY
    ↓
Code Reviewer reviews CODE (CR-XXX) → verifies plan adherence
    ↓
QA Engineer tests (TEST-XXX)
    ↓
Deploy
```

**Key Principle**: Developers MUST follow implementation plans word-for-word. No independent architectural decisions.

### Database Deployment

The `promote-to-stage.md` skill implements a rigorous database migration protocol:

1. **Schema Comparison** - Complete table structure comparison between dev/stage
2. **Dependency Analysis** - Foreign key creation order
3. **Transaction Safety** - Rollback-capable migrations
4. **Data Integrity** - Orphaned record detection

Database credentials are embedded in the skill (XAMPP MySQL on Windows).

## Development Environment Commands

### Database Schema Verification (MANDATORY before coding)
```bash
# WSL/Linux
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 freeconomy_dev -e "DESCRIBE table_name;"

# Windows Command Prompt/PowerShell
"C:\xampp\mysql\bin\mysql.exe" -u root -pmindseye@41 freeconomy_dev -e "DESCRIBE table_name;"
```

### PHP Syntax Check
```bash
"/mnt/c/xampp/php/php.exe" -l app/Controllers/ControllerName.php
```

### View Site
```
http://localhost:8080/freeconomy-recycling/
```

## Critical Standards Summary

### CSS (MANDATORY)
- Use ONLY CSS variables from `assets/css/core/variables.css` - NEVER hardcode colors/spacing/fonts
- BEM naming with feature prefix: `.feature-block__element--modifier`
- Glassmorphism design pattern everywhere
- Dark mode support required
- Mobile-first responsive design

### PHP (MANDATORY)
- Escape ALL output: `View::escape($userInput)`
- Use QueryBuilder for ALL database queries - NEVER concatenate SQL
- Include CSRF tokens: `View::csrfField()` in all forms
- Docblocks on all functions
- Verify schema with DESCRIBE before writing queries

### Common Pitfalls (CRITICAL - Check COMMON_PITFALLS.md)
- BaseModel does NOT have `save()` method - use `create($data)` or `update($id, $data)`
- Models return arrays, NOT objects
- QueryBuilder does NOT support closure-based WHERE clauses
- Use `#[\AllowDynamicProperties]` on models that set properties

## Skill Invocation

1. **Start with `/continue-agile`** - Routes to Auto-Task Dispatcher
2. **Provide role context** - Specify "Developer", "Tester", "PO", "TL", or "CR" if needed
3. **Follow the workflow** - Each skill loads context, executes steps, updates state
4. **Pause with `/Pause-Task`** - Creates handover file for interruption

## Important Notes

- Skills are **read-only** regarding the command definitions themselves
- Skills **write to** the FreeconomyToday project docs directory
- The framework assumes a multi-agent concurrent development environment
- All state is persisted in markdown files for transparency
- Full framework documentation available in `docs/agile_framework/README.md`
