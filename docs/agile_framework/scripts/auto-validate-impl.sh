#!/bin/bash
# =============================================================================
# Auto-Implementation Validator
# =============================================================================
# Purpose: Validate that all files from implementation plan were created
# Usage: bash scripts/auto-validate-impl.sh IMPL-XXX
#
# This script checks implementation completeness by verifying all required
# files exist. Catches missing files instantly.
#
# Time: ~30 seconds vs 10+ minutes manual
# =============================================================================

set -e  # Exit on error

PLAN_FILE="$1"
PLAN_ID=$(echo "$PLAN_FILE" | grep -oP 'IMPL-\d+' || echo "")

if [ -z "$PLAN_ID" ]; then
    echo "❌ Error: Invalid plan ID. Usage: bash scripts/auto-validate-impl.sh IMPL-XXX"
    exit 1
fi

# Find the actual file if just ID provided
if [ ! -f "$PLAN_FILE" ]; then
    # Search for the file
    PLAN_FILE=$(find docs/02_implementation_plans -name "${PLAN_ID}_*.md" 2>/dev/null | head -1)
    if [ -z "$PLAN_FILE" ]; then
        echo "❌ Error: Implementation plan not found for $PLAN_ID"
        exit 1
    fi
fi

echo "# 🔍 Implementation Validation: $PLAN_ID"
echo ""
echo "**Plan File:** $PLAN_FILE"
echo "**Validated:** $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# =============================================================================
# Section 1: Files to Create
# =============================================================================

echo "## 📁 Files to Create (from plan)"
echo ""

# Extract "Files to Create" section
CREATE_START=$(grep -n "## File Checklist" "$PLAN_FILE" | cut -d: -f1)
if [ -z "$CREATE_START" ]; then
    # Try alternative section name
    CREATE_START=$(grep -n "Files to Create" "$PLAN_FILE" | cut -d: -f1)
fi

if [ -z "$CREATE_START" ]; then
    echo "❌ Error: File Checklist section not found in plan"
    exit 1
fi

# Extract files (look for checklist items or file paths)
FILES_TO_CREATE=$(tail -n +"$((CREATE_START + 1))" "$PLAN_FILE" | \
    grep -E '^\- \[[ x]\]|^.*\.(php|js|css|md)$' | \
    sed 's/^\- \[[ x]\]\s*//' | \
    sed 's/^\`*//' | \
    sed 's/\`*$//' | \
    grep -E '\.(php|js|css|md)$' || true)

if [ -z "$FILES_TO_CREATE" ]; then
    echo "⚠️  No files to create found (may be edits only)"
    CREATE_COUNT=0
else
    echo "$FILES_TO_CREATE" | nl -w2 -s'. '
    CREATE_COUNT=$(echo "$FILES_TO_CREATE" | wc -l)
    echo ""
    echo "**Total files to create:** $CREATE_COUNT"
fi

echo ""

# =============================================================================
# Section 2: Files to Edit
# =============================================================================

echo "## 📝 Files to Edit (from plan)"
echo ""

FILES_TO_EDIT=$(tail -n +"$((CREATE_START + 1))" "$PLAN_FILE" | \
    grep -E '^\- \[[ x]\].*edit|^\- \[[ x]\].*Edit' -i | \
    sed 's/^\- \[[ x]\]\s*//' | \
    sed 's/^\`*//' | \
    sed 's/\`*$//' | \
    grep -E '\.(php|js|css|md)$' || true)

if [ -z "$FILES_TO_EDIT" ]; then
    echo "⚠️  No files to edit found"
    EDIT_COUNT=0
else
    echo "$FILES_TO_EDIT" | nl -w2 -s'. '
    EDIT_COUNT=$(echo "$FILES_TO_EDIT" | wc -l)
    echo ""
    echo "**Total files to edit:** $EDIT_COUNT"
fi

echo ""

# =============================================================================
# Section 3: File Existence Check
# =============================================================================

echo "## ✅ File Existence Check"
echo ""

MISSING_COUNT=0
PRESENT_COUNT=0

if [ $CREATE_COUNT -gt 0 ]; then
    echo "### Files to Create"
    echo ""

    echo "$FILES_TO_CREATE" | while read -r FILE; do
        if [ -z "$FILE" ]; then
            continue
        fi

        # Remove leading path indicators
        FILE=$(echo "$FILE" | sed 's/^\[//' | sed 's/^\]//')

        # Handle both absolute and relative paths
        if [[ "$FILE" == /* ]]; then
            CHECK_PATH="$FILE"
        else
            CHECK_PATH="$FILE"
        fi

        if [ -f "$CHECK_PATH" ]; then
            echo "✅ EXISTS: $FILE"
            PRESENT_COUNT=$((PRESENT_COUNT + 1))
        else
            echo "❌ MISSING: $FILE"
            MISSING_COUNT=$((MISSING_COUNT + 1))
        fi
    done

    echo ""
fi

if [ $EDIT_COUNT -gt 0 ]; then
    echo "### Files to Edit"
    echo ""

    echo "$FILES_TO_EDIT" | while read -r FILE; do
        if [ -z "$FILE" ]; then
            continue
        fi

        # Remove leading path indicators
        FILE=$(echo "$FILE" | sed 's/^\[//' | sed 's/^\]//')

        if [[ "$FILE" == /* ]]; then
            CHECK_PATH="$FILE"
        else
            CHECK_PATH="$FILE"
        fi

        if [ -f "$CHECK_PATH" ]; then
            echo "✅ EXISTS: $FILE"
        else
            echo "⚠️  WARNING: File to edit doesn't exist: $FILE"
        fi
    done

    echo ""
fi

# =============================================================================
# Section 4: Summary
# =============================================================================

echo "## 📊 Validation Summary"
echo ""

# Re-count for summary
TOTAL_MISSING=0
TOTAL_PRESENT=0

if [ $CREATE_COUNT -gt 0 ]; then
    echo "$FILES_TO_CREATE" | while read -r FILE; do
        [ -z "$FILE" ] && continue
        FILE=$(echo "$FILE" | sed 's/^\[//' | sed 's/^\]//')
        CHECK_PATH="${FILE#/}"

        if [ -f "$CHECK_PATH" ] || [ -f "$FILE" ]; then
            TOTAL_PRESENT=$((TOTAL_PRESENT + 1))
        else
            TOTAL_MISSING=$((TOTAL_MISSING + 1))
        fi
    done
fi

echo "**Files to Create:** $CREATE_COUNT"
echo "**Files Created:** $TOTAL_PRESENT"
echo "**Files Missing:** $TOTAL_MISSING"
echo ""

if [ $TOTAL_MISSING -eq 0 ] && [ $CREATE_COUNT -eq $TOTAL_PRESENT ]; then
    echo "## ✅ VALIDATION PASSED"
    echo ""
    echo "All required files have been created."
    echo "Implementation is complete according to plan."
    exit 0
else
    echo "## ❌ VALIDATION FAILED"
    echo ""
    echo "Missing files detected. Implementation is incomplete."
    echo ""
    echo "**Action Required:**"
    echo "- Review missing files above"
    echo "- Complete implementation"
    echo "- Re-run validation"
    exit 1
fi
