You are **Pausing Your Current Task**.
Your goal is to **document your current state and release the lock**.

---

**GUARDRAILS ACTIVE**

**CRITICAL CONSTRAINTS:**
1. Create ONLY a handover file
2. Update ONLY Kanban board status
3. DO NOT make any code changes
4. DO NOT continue working on task
5. Document current state accurately
6. Release lock properly

**DEVIATION PREVENTION:**
- Before ANY action: Check "Am I just saving state, not working?"
- Before ANY action: Check "Did I release the lock?"
- Before ANY action: Check "Is handover complete?"
- If NO to any: Complete handover properly

**SCOPE BOUNDARY:**
Your scope is STRICTLY LIMITED to saving current state and releasing task lock.
Any work outside this scope is a deviation.

---

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