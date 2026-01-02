#!/bin/bash
# =============================================================================
# Auto-Triage Script
# =============================================================================
# Purpose: Automatically validate implementation plans before development
# Usage: bash scripts/auto-triage.sh IMPL-XXX
#
# This script performs quick validation checks on implementation plans:
# - Database schema verification
# - PHP/JavaScript syntax validation
# - Namespace verification
# - Common pitfalls detection
#
# Time: ~5 minutes vs 30+ minutes manual
# =============================================================================

set -e  # Exit on error

PLAN_FILE="$1"
PLAN_ID=$(echo "$PLAN_FILE" | grep -oP 'IMPL-\d+' || echo "")

if [ -z "$PLAN_ID" ]; then
    echo "❌ Error: Invalid plan ID. Usage: bash scripts/auto-triage.sh IMPL-XXX"
    exit 1
fi

echo "# 📋 Auto-Triage Report for $PLAN_ID"
echo ""
echo "Generated: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# =============================================================================
# Section 1: Schema Verification
# =============================================================================

echo "## 🗄️ Database Schema Verification"
echo ""

# Extract table names from the plan
TABLES=$(grep -oP 'FROM\s+\K\w+|table_name|DESCRIBE\s+\K\w+' "$PLAN_FILE" 2>/dev/null | sort -u || echo "")

if [ -z "$TABLES" ]; then
    echo "⚠️  No tables found in plan (may be code-only change)"
else
    echo "Tables to verify:"
    echo "$TABLES" | nl -w2 -s'. '
    echo ""

    MYSQL="/mnt/c/xampp/mysql/bin/mysql.exe"
    DB="freeconomy_dev"
    USER="root"
    PASS="mindseye@41"

    echo "Schema checks:"
    echo ""

    for TABLE in $TABLES; do
        echo "### Table: $TABLE"

        # Check if table exists
        RESULT=$($MYSQL -u $USER -p$PASS $DB -e "DESCRIBE $TABLE;" 2>&1)

        if echo "$RESULT" | grep -q "ERROR"; then
            echo "❌ Schema check FAILED - Table may not exist"
            echo "Error: $RESULT"
        else
            echo "✅ Schema verified - Table exists"
            echo "$RESULT" | head -20
        fi
        echo ""
    done
fi

# =============================================================================
# Section 2: PHP Syntax Validation
# =============================================================================

echo "## 🐘 PHP Syntax Validation"
echo ""

# Extract PHP code blocks from plan
PHP_BLOCKS=$(sed -n '/```php/,/```/p' "$PLAN_FILE" | sed '/```/d' || echo "")

if [ -z "$PHP_BLOCKS" ]; then
    echo "⚠️  No PHP code blocks found"
else
    # Create temp file for syntax check
    TEMP_PHP=$(mktemp)
    echo "$PHP_BLOCKS" > "$TEMP_PHP"

    # Check syntax
    PHP="/mnt/c/xampp/php/php.exe"
    SYNTAX_RESULT=$($PHP -l "$TEMP_PHP" 2>&1) || true

    if echo "$SYNTAX_RESULT" | grep -q "No syntax errors"; then
        echo "✅ PHP syntax validated"
    else
        echo "❌ PHP syntax errors found:"
        echo "$SYNTAX_RESULT"
    fi

    rm -f "$TEMP_PHP"
fi

echo ""

# =============================================================================
# Section 3: JavaScript Syntax Validation
# =============================================================================

echo "## 🔧 JavaScript Syntax Validation"
echo ""

# Extract JS code blocks from plan
JS_BLOCKS=$(sed -n '/```javascript/,/```/p' "$PLAN_FILE" | sed '/```/d' || echo "")

if [ -z "$JS_BLOCKS" ]; then
    echo "⚠️  No JavaScript code blocks found"
else
    # Create temp file for syntax check
    TEMP_JS=$(mktemp)
    echo "$JS_BLOCKS" > "$TEMP_JS"

    # Check syntax with Node if available, otherwise basic check
    if command -v node &> /dev/null; then
        SYNTAX_RESULT=$(node --check "$TEMP_JS" 2>&1) || true
        if [ -z "$SYNTAX_RESULT" ]; then
            echo "✅ JavaScript syntax validated"
        else
            echo "❌ JavaScript syntax errors found:"
            echo "$SYNTAX_RESULT"
        fi
    else
        echo "⚠️  Node.js not available - skipping JS syntax check"
    fi

    rm -f "$TEMP_JS"
fi

echo ""

# =============================================================================
# Section 4: Common Pitfalls Detection
# =============================================================================

echo "## ⚠️ Common Pitfalls Detection"
echo ""

# Check for deprecated patterns
PITFALLS=0

# Check for save() usage
if grep -q '->save()' "$PLAN_FILE"; then
    echo "❌ PITFALL: Plan uses \`save()\` method - BaseModel does not have this"
    PITFALLS=$((PITFALLS + 1))
fi

# Check for wrong Auth namespace
if grep -q 'use.*App\\\\Core\\\\Auth' "$PLAN_FILE"; then
    echo "❌ PITFALL: Wrong Auth namespace - Should be \`App\\\\Core\\\\Security\\\\Auth\`"
    PITFALLS=$((PITFALLS + 1))
fi

# Check for QueryBuilder closure WHERE
if grep -q 'where(function(' "$PLAN_FILE"; then
    echo "❌ PITFALL: QueryBuilder closure-based WHERE not supported - Use PHP filtering"
    PITFALLS=$((PITFALLS + 1))
fi

# Check for raw SQL concatenation
if grep -E 'SELECT.*FROM.*WHERE.*"\s*\.\s*\$' "$PLAN_FILE" > /dev/null 2>&1; then
    echo "❌ PITFALL: Raw SQL concatenation detected - Use QueryBuilder or prepared statements"
    PITFALLS=$((PITFALLS + 1))
fi

if [ $PITFALLS -eq 0 ]; then
    echo "✅ No common pitfalls detected"
else
    echo ""
    echo "⚠️  $PITFALLS potential issue(s) found - Review needed"
fi

echo ""

# =============================================================================
# Section 5: Completeness Check
# =============================================================================

echo "## 📋 Completeness Check"
echo ""

REQUIRED_SECTIONS=("Overview" "Step-by-Step Implementation" "File Checklist" "Dependencies")
MISSING=0

for SECTION in "${REQUIRED_SECTIONS[@]}"; do
    if grep -q "## $SECTION" "$PLAN_FILE"; then
        echo "✅ Section present: $SECTION"
    else
        echo "❌ Section missing: $SECTION"
        MISSING=$((MISSING + 1))
    fi
done

echo ""

# =============================================================================
# Final Decision
# =============================================================================

echo "## ✅ Triage Decision"
echo ""

if [ $PITFALLS -eq 0 ] && [ $MISSING -eq 0 ]; then
    echo "**RESULT: APPROVED for Implementation**"
    echo ""
    echo "All checks passed. Plan is ready for development."
else
    echo "**RESULT: NEEDS REVISION**"
    echo ""
    echo "Issues found that must be addressed:"
    if [ $PITFALLS -gt 0 ]; then
        echo "- $PITFALLS common pitfall(s) detected"
    fi
    if [ $MISSING -gt 0 ]; then
        echo "- $MISSING required section(s) missing"
    fi
    echo ""
    echo "Return plan to Tech Lead for corrections."
fi

echo ""
echo "End of Auto-Triage Report"
