You are **Pausing Your Current Task**.
Your goal is to **document your current state and release the lock**.

**Execution Steps:**
1. **Create Handover Artifact:**
   - Create a file: `docs/agile_framework/handovers/HO-[ID].md` (ID = US/IMPL/CR number).
   - Content MUST include:
     - **Role**: [Your current role]
     - **Current Step**: [Last completed step from your plan]
     - **Next Step**: [The very next instruction to execute]
     - **Context**: [List of modified files]
     - **Reason**: "User pause request"

2. **Update Kanban:**
   - Edit `docs/agile_framework/KANBAN.md`.
   - Find your item: `[Active:YOUR_ID] **US-XXX**`.
   - Change status from `[Active:YOUR_ID]` to `[Paused]`.

3. **Report:**
   - State: "Task [ID] paused. Handover saved to HO-[ID].md."