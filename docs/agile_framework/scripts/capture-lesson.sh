#!/bin/bash
# =============================================================================
# Lesson Capture Script
# =============================================================================
# Purpose: Automatically capture lessons learned from validation reports
# Usage: bash scripts/capture-lesson.sh VAL-XXX
#
# This script extracts lessons from validation reports and updates:
# - PATTERN_LIBRARY.md (success patterns)
# - COMMON_PITFALLS.md (new issues)
#
# Goal: Build knowledge base from every validated feature
# =============================================================================

set -e

VAL_FILE="$1"
VAL_ID=$(echo "$VAL_FILE" | grep -oP 'VAL-\d+' || echo "")

if [ -z "$VAL_ID" ]; then
    echo "❌ Error: Invalid Validation Report ID. Usage: bash scripts/capture-lesson.sh VAL-XXX"
    exit 1
fi

# Find the actual file if just ID provided
if [ ! -f "$VAL_FILE" ]; then
    VAL_FILE=$(find docs/agile_framework/04_testing/validation_reports -name "${VAL_ID}_*.md" 2>/dev/null | head -1)
    if [ -z "$VAL_FILE" ]; then
        echo "❌ Error: Validation Report not found for $VAL_ID"
        exit 1
    fi
fi

echo "# 🧠 Capturing Lessons from $VAL_ID"
echo ""
echo "Report: $VAL_FILE"
echo "Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# =============================================================================
# Extract Success Patterns
# =============================================================================

echo "## 🎯 Extracting Success Patterns"
echo ""

# Look for "Success Patterns Found" section
PATTERNS_START=$(grep -n "Success Patterns Found" "$VAL_FILE" | cut -d: -f1)

if [ -n "$PATTERNS_START" ]; then
    echo "✅ Found success patterns in report"

    # Extract patterns (until next section or end)
    PATTERNS=$(tail -n +"$((PATTERNS_START + 2))" "$VAL_FILE" | sed -n '/^## /q;p')

    if [ -n "$PATTERNS" ]; then
        echo "Patterns to document:"
        echo "$PATTERNS"
        echo ""

        # Auto-generate pattern template
        cat >> docs/agile_framework/PATTERN_LIBRARY.md.tmp <<EOF

## Pattern from $VAL_ID

**Source:** Validation Report $VAL_ID
**Date:** $(date '+%Y-%m-%d')

**When to use:**
[Extracted from validation report]

**Pattern:**
$PATTERNS

**Why it works:**
[Validated during code review]

EOF

        echo "✅ Patterns extracted to PATTERN_LIBRARY.md.tmp"
        echo "   Review and merge into PATTERN_LIBRARY.md"
    fi
else
    echo "ℹ️  No success patterns section found in report"
    echo "   Consider documenting good patterns you found during validation"
fi

echo ""

# =============================================================================
# Extract Issues for Learning Log
# =============================================================================

echo "## ⚠️ Extracting Issues for Learning Log"
echo ""

# Look for "Issues for Learning Log" section
ISSUES_START=$(grep -n "Issues for Learning Log" "$VAL_FILE" | cut -d: -f1)

if [ -n "$ISSUES_START" ]; then
    echo "✅ Found issues section in report"

    # Extract issues (until next section or end)
    ISSUES=$(tail -n +"$((ISSUES_START + 2))" "$VAL_FILE" | sed -n '/^## /q;p')

    if [ -n "$ISSUES" ]; then
        echo "Issues to document:"
        echo "$ISSUES"
        echo ""

        # Check if these are new issues
        echo "Checking against COMMON_PITFALLS.md..."

        # For each issue, check if it's already documented
        while IFS= read -r line; do
            if [[ -n "$line" ]] && [[ "$line" =~ ^- ]]; then
                ISSUE_TEXT=$(echo "$line" | sed 's/^- //')

                # Search for similar issue in COMMON_PITFALLS.md
                if grep -qi "$ISSUE_TEXT" docs/agile_framework/06_standards/COMMON_PITFALLS.md; then
                    echo "  ✓ Already documented: $ISSUE_TEXT"
                else
                    echo "  ⚠️  NEW ISSUE: $ISSUE_TEXT"
                    echo "     → Add to COMMON_PITFALLS.md"

                    # Generate pitfall template
                    cat >> docs/agile_framework/06_standards/COMMON_PITFALLS.md.tmp <<EOF

## Issue from $VAL_ID

**Source:** Validation Report $VAL_ID
**Date:** $(date '+%Y-%m-%d')
**Type:** [Error Type - e.g., Database, Security, Logic]

**Issue:**
$ISSUE_TEXT

**Example:**
\`\`\`php
// Problematic code from validation
[Extract code snippet if available]
\`\`\`

**Fix:**
\`\`\`php
// Corrected code
[Provide fix]
\`\`\`

**Prevention:**
- [Prevention step 1]
- [Prevention step 2]

EOF
                fi
            fi
        done <<< "$ISSUES"

        echo ""
        echo "✅ New issues extracted to COMMON_PITFALLS.md.tmp"
        echo "   Review and merge into COMMON_PITFALLS.md"
    fi
else
    echo "ℹ️  No issues section found in report"
    echo "   Consider documenting issues you found during validation"
fi

echo ""

# =============================================================================
# Generate Summary
# =============================================================================

echo "## 📊 Learning Summary"
echo ""

# Count patterns captured
if [ -f docs/agile_framework/PATTERN_LIBRARY.md.tmp ]; then
    PATTERN_COUNT=$(grep -c "^## Pattern from" docs/agile_framework/PATTERN_LIBRARY.md.tmp || echo "0")
    echo "✅ Success Patterns: $PATTERN_COUNT"
    echo "   File: docs/agile_framework/PATTERN_LIBRARY.md.tmp"
else
    echo "✅ Success Patterns: 0 (no new patterns)"
fi

# Count issues captured
if [ -f docs/agile_framework/06_standards/COMMON_PITFALLS.md.tmp ]; then
    ISSUE_COUNT=$(grep -c "^## Issue from" docs/agile_framework/06_standards/COMMON_PITFALLS.md.tmp || echo "0")
    echo "⚠️  New Issues: $ISSUE_COUNT"
    echo "   File: docs/agile_framework/06_standards/COMMON_PITFALLS.md.tmp"
else
    echo "⚠️  New Issues: 0 (no new issues)"
fi

echo ""

# =============================================================================
# Next Steps
# =============================================================================

echo "## 📝 Next Steps"
echo ""
echo "1. Review the generated .tmp files"
echo "2. Edit and refine the extracted lessons"
echo "3. Merge into main files:"
echo "   - mv docs/agile_framework/PATTERN_LIBRARY.md.tmp docs/agile_framework/PATTERN_LIBRARY.md.append"
echo "   - mv docs/agile_framework/06_standards/COMMON_PITFALLS.md.tmp docs/agile_framework/06_standards/COMMON_PITFALLS.md.append"
echo "4. Manually merge .append files into main documents"
echo "5. Delete .tmp files after merging"
echo ""

echo "## 💡 Pro Tip"
echo ""
echo "To make future code generation better:"
echo "- Update PROMPT_LIBRARY.md prompts to reference new patterns"
echo "- Add pattern examples to IMPLEMENTATION_PLAN_TEMPLATE.md"
echo "- Share patterns in team retrospectives"
echo ""

echo "End of Lesson Capture"
