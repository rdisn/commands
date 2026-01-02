# Database Migration Protocol for Agentic LLM
**Purpose:** Standardized instructions for generating database migration plans between environments
**Version:** 1.0
**Date:** 2025-11-09

---

## Overview

This document provides instructions for an agentic LLM to perform deep schema comparisons and generate comprehensive migration plans for promoting features between development environments.

---

## Environment Structure

### Database Naming Convention
```
freeconomy_dev        → Development database
freecono_staging      → Staging database
freeconomy_prod       → Production database
```

### Directory Structure
```
/freeconomy-recycling/
├── dev/                  # Development environment
├── stage/                # Staging environment
├── prod/                 # Production environment
└── docs/                 # Documentation
```

### Database Connection Details
```bash
# MySQL Connection
Host: localhost
User: root
Password: mindseye@41

# MySQL Client Path
"/mnt/c/xampp/mysql/bin/mysql.exe"
"/mnt/c/xampp/mysql/bin/mysqldump.exe"
```

---

## Migration Types

### Type 1: Feature Promotion (Dev → Stage)
**Command Pattern:** "Create a stage migration plan for [feature1] & [feature2]"
- **Source:** `freeconomy_dev`
- **Target:** `freecono_staging`
- **Goal:** Add specific features without affecting others.
- **Strategy:** Additive only (CREATE/ALTER). No DROPs unless critical.

### Type 2: Production Release (Stage → Prod)
**Command Pattern:** "Create a prod migration plan for [feature1]..."
- **Source:** `freecono_staging`
- **Target:** `freecono_prod`
- **Goal:** Safe promotion of tested features.
- **Strategy:** Additive only. High safety checks.

### Type 3: Full Synchronization (Schema Mirroring)
**Command Pattern:** "Create a one-shot sync script to make [Target] exactly like [Source]"
- **Source:** (e.g., `freeconomy_dev`)
- **Target:** (e.g., `freecono_staging`)
- **Goal:** **EXACT STRUCTURAL MATCH**. Target must become a clone of Source schema.
- **Strategy:** Bidirectional.
    - **ADD** missing items.
    - **UPDATE** mismatched items.
    - **DROP** extra items (tables/columns/indexes in Target but not Source).
- **Use Case:** Resetting staging environments OR ensuring prod compliance.

---

## Step-by-Step Migration Process

## PHASE 1: DEEP SCHEMA ANALYSIS (Bidirectional)

To ensure an **Exact Match**, we must identify what to ADD, what to MODIFY, and what to REMOVE.

### Step 1.1: Table Existence Analysis

```bash
# 1. Get Source Tables
mysql -N -e "SELECT table_name FROM information_schema.tables WHERE table_schema = '[SOURCE_DB]' ORDER BY table_name" > source_tables.txt

# 2. Get Target Tables
mysql -N -e "SELECT table_name FROM information_schema.tables WHERE table_schema = '[TARGET_DB]' ORDER BY table_name" > target_tables.txt

# 3. Analyze Differences
# Tables to CREATE (In Source, not Target)
comm -23 source_tables.txt target_tables.txt > tables_to_create.txt

# Tables to DROP (In Target, not Source - SYNC MODE ONLY)
comm -13 source_tables.txt target_tables.txt > tables_to_drop.txt

# Common Tables (Check for structure updates)
comm -12 source_tables.txt target_tables.txt > tables_common.txt
```

### Step 1.2: Column Definition Analysis (For Common Tables)

For each table in `tables_common.txt`, compare column definitions.

```bash
# Query for deterministic column signatures
# Run this for both Source and Target:
SELECT
    column_name,
    column_type,
    is_nullable,
    column_default,
    extra -- handles auto_increment
FROM information_schema.columns
WHERE table_schema = '[DB_NAME]' AND table_name = '[TABLE_NAME]'
ORDER BY column_name;
```

**Comparison Logic:**
1.  **Missing in Target:** Generate `ADD COLUMN`.
2.  **Extra in Target:** Generate `DROP COLUMN` (Sync Mode).
3.  **Mismatch:**
    - If Type is different (e.g., `INT` vs `BIGINT`) → Generate `MODIFY COLUMN`.
    - If Nullable/Default differs → Generate `MODIFY COLUMN`.

### Step 1.3: Index Analysis

```bash
# Metric: index_name + column_sequence
SELECT
    index_name,
    non_unique,
    GROUP_CONCAT(column_name ORDER BY seq_in_index) as col_seq
FROM information_schema.statistics
WHERE table_schema = '[DB_NAME]' AND table_name = '[TABLE_NAME]'
GROUP BY index_name, non_unique;
```

**Comparison Logic:**
1.  **Missing in Target:** Generate `ADD INDEX`.
2.  **Extra in Target:** Generate `DROP INDEX` (Sync Mode).
3.  **Modified:** Drop and Re-create.

### Step 1.4: Foreign Key Analysis

```bash
# Metric: constraint_name + source_col + target_table + target_col
SELECT
    constraint_name,
    column_name,
    referenced_table_name,
    referenced_column_name,
    match_option,
    update_rule,
    delete_rule
FROM information_schema.referential_constraints rc
JOIN information_schema.key_column_usage kcu
  USING (constraint_schema, constraint_name)
WHERE constraint_schema = '[DB_NAME]' AND table_name = '[TABLE_NAME]';
```

**Comparison Logic:**
1.  **Missing in Target:** Generate `ADD CONSTRAINT`.
2.  **Extra in Target:** Generate `DROP FOREIGN KEY`.
3.  **Modified (e.g., ON DELETE rule changed):** Drop and Re-add.

---

## PHASE 2: FEATURE IDENTIFICATION

### Step 2.1: Map Tables to Features

Based on the prompt's feature list, identify which tables belong to each feature:

**Feature Mapping Template:**
```
Feature: [Feature Name]
Tables:
  - [table_name_1] (NEW | MODIFIED | EXISTING)
  - [table_name_2] (NEW | MODIFIED | EXISTING)

Related Tables (Dependencies):
  - [dependent_table_1]
  - [dependent_table_2]

Status: APPROVED | NOT_APPROVED
```

### Step 2.2: Verify Feature Completeness

For each requested feature, verify:
- [ ] All required tables exist in source
- [ ] No missing dependencies
- [ ] Foreign key relationships are complete
- [ ] Related models/controllers exist in source codebase

**If incomplete:** Flag in the migration plan with warnings

---

## PHASE 3: MIGRATION SCRIPT GENERATION (Exact Match)

To guarantee "Exact Match" while handling dependencies, statements MUST be generated in this order:

1.  **Disable Checks:** `SET FOREIGN_KEY_CHECKS=0`
2.  **Sanitize (Drops):** Remove orphaned items (FKs -> Indexes -> Tables -> Columns).
3.  **Structure (Core):** Create Tables, Add/Modify Columns (No constraints yet).
4.  **Constraints:** Add Indexes and FKs (Now that all tables/cols exist).
5.  **Enable Checks:** `SET FOREIGN_KEY_CHECKS=1`

### Template Structure

```sql
-- ============================================================================
-- [SOURCE] TO [TARGET] SYNC MIGRATION
-- Date: [YYYY-MM-DD]
-- Mode: EXACT MATCH (Includes DROPs for orphaned items)
-- ============================================================================

USE [TARGET_DB];

-- 1. SAFETY: Disable FK checks to allow dropping/altering tables freely
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';

-- ============================================================================
-- SECTION 1: DESTRUCTIVE CLEANUP (REMOVE EXTRA ITEMS)
-- ============================================================================

-- 1.1: DROP Extra Foreign Keys in Target
-- ALTER TABLE `[table]` DROP FOREIGN KEY `[fk_name]`;

-- 1.2: DROP Extra Indexes in Target
-- ALTER TABLE `[table]` DROP INDEX `[index_name]`;

-- 1.3: DROP Extra Tables (Tables in Target but not Source)
-- DROP TABLE IF EXISTS `[table_name]`;

-- 1.4: DROP Extra Columns (Columns in Target but not Source)
-- ALTER TABLE `[table]` DROP COLUMN `[column_name]`;

-- ============================================================================
-- SECTION 2: STRUCTURAL UPDATES (MODIFIES & ADDS)
-- ============================================================================

-- 2.1: CREATE Missing Tables (Structure Only - No FKs yet)
-- CREATE TABLE IF NOT EXISTS `[table_name]` ( ... );

-- 2.2: MODIFY Existing Columns (Type/Default/Null Changes)
-- ALTER TABLE `[table]` MODIFY COLUMN `[col]` [NEW_DEF];

-- 2.3: ADD New Columns
-- ALTER TABLE `[table]` ADD COLUMN `[col]` [DEF] AFTER `[prev_col]`;

-- ============================================================================
-- SECTION 3: CONSTRAINT APPLICATION
-- ============================================================================

-- 3.1: ADD Missing Indexes
-- ALTER TABLE `[table]` ADD INDEX `[idx_name]` ([cols]);

-- 3.2: ADD Missing Foreign Keys
-- ALTER TABLE `[table]` ADD CONSTRAINT `[fk_name]` FOREIGN KEY ...;

-- ============================================================================
-- SECTION 4: RESTORE SETTINGS
-- ============================================================================

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET SQL_MODE=@OLD_SQL_MODE;

-- COMPLETED
```

---

## PHASE 4: DOCUMENTATION GENERATION

### Document 1: Migration Plan (Primary Document)

**Filename:** `[ENV]_MIGRATION_PLAN_[FEATURES]_[DATE].md`

**Template:**

```markdown
# [Source] to [Target] Migration Plan
**Date:** [YYYY-MM-DD]
**Features:** [Feature1, Feature2, Feature3]
**Source Database:** [source_db]
**Target Database:** [target_db]

---

## Executive Summary

[Brief overview of what's being migrated]

### Features Included
- ✅ [Feature1] - [brief description]
- ✅ [Feature2] - [brief description]
- ✅ [Feature3] - [brief description]

### Features Excluded
- ❌ [Feature] - [reason for exclusion]

---

## Current State Analysis

### Source Database ([source_db])
- **Total Tables:** [count]
- **Tables for Features:** [list]

### Target Database ([target_db])
- **Total Tables:** [count]
- **Tables to Add:** [count]
- **Tables to Modify:** [count]

---

## Schema Comparison Results

### Tables to Create ([count] new tables)

#### Feature: [Feature Name]
| Table Name | Columns | Indexes | Foreign Keys | Dependencies |
|------------|---------|---------|--------------|--------------|
| [table1]   | [count] | [count] | [count]      | [list]       |
| [table2]   | [count] | [count] | [count]      | [list]       |

### Tables to Modify ([count] tables)

#### Table: [table_name]
**Changes Required:**
- [ ] Add [count] new columns
- [ ] Modify [count] existing columns
- [ ] Add [count] indexes
- [ ] Add [count] foreign keys

**Columns to Add:**
| Column Name | Type | Nullable | Default | After |
|------------|------|----------|---------|-------|
| [column]   | [type] | [Y/N] | [value] | [col] |

**Indexes to Add:**
| Index Name | Type | Columns | Purpose |
|-----------|------|---------|---------|
| [idx_name] | [BTREE/UNIQUE] | [cols] | [purpose] |

**Foreign Keys to Add:**
| Constraint Name | Column | References | On Delete | On Update |
|----------------|--------|------------|-----------|-----------|
| [fk_name]      | [col]  | [table(col)] | [action] | [action] |

---

## Migration Execution Plan

### Pre-Migration Checklist
- [ ] Backup target database
- [ ] Backup target codebase
- [ ] Verify source database integrity
- [ ] Review migration script
- [ ] Verify feature approval status

### Backup Commands
\`\`\`bash
# Backup database
"/mnt/c/xampp/mysql/bin/mysqldump.exe" -u root -pmindseye@41 [TARGET_DB] > backups/[TARGET_DB]_backup_[DATE].sql

# Backup codebase
cp -r [target_env]/ [target_env]_backup_[DATE]/
\`\`\`

### Migration Execution
\`\`\`bash
# Execute migration script
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 [TARGET_DB] < [path_to_migration_script]
\`\`\`

### Post-Migration Verification
\`\`\`bash
# Verify table count
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 [TARGET_DB] -e "
SELECT COUNT(*) as total_tables
FROM information_schema.tables
WHERE table_schema = '[TARGET_DB]';"
# Expected: [expected_count]

# Verify new tables
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 [TARGET_DB] -e "SHOW TABLES LIKE '[pattern]%';"

# Verify foreign keys
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 -e "
SELECT
    table_name,
    constraint_name,
    referenced_table_name
FROM information_schema.key_column_usage
WHERE table_schema = '[TARGET_DB]'
AND referenced_table_name IS NOT NULL
ORDER BY table_name;"

# Verify indexes
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 -e "
SELECT
    table_name,
    index_name,
    GROUP_CONCAT(column_name ORDER BY seq_in_index) as columns
FROM information_schema.statistics
WHERE table_schema = '[TARGET_DB]'
AND table_name IN ([list_of_modified_tables])
GROUP BY table_name, index_name
ORDER BY table_name, index_name;"
\`\`\`

---

## File Synchronization Plan

### Controllers to Sync

#### [Feature1] Controllers
\`\`\`
[source]/app/Controllers/[Controller1].php → [target]/app/Controllers/
[source]/app/Controllers/[Controller2].php → [target]/app/Controllers/
\`\`\`

### Models to Sync

#### [Feature1] Models ([count] files)
\`\`\`
[source]/app/Models/[Model1].php → [target]/app/Models/
[source]/app/Models/[Model2].php → [target]/app/Models/
\`\`\`

### Views to Sync

#### [Feature1] Views
\`\`\`
[source]/app/Views/[feature]/ → [target]/app/Views/[feature]/
  ├── index.php
  ├── show.php
  ├── create.php
  └── edit.php
\`\`\`

### Assets to Sync

\`\`\`
[source]/assets/css/[feature].css → [target]/assets/css/
[source]/assets/js/[feature].js → [target]/assets/js/
\`\`\`

### File Sync Commands
\`\`\`bash
# Sync controllers
rsync -av --progress [source]/app/Controllers/[Feature]*.php [target]/app/Controllers/

# Sync models
rsync -av --progress [source]/app/Models/[Feature]*.php [target]/app/Models/

# Sync views
rsync -av --progress [source]/app/Views/[feature]/ [target]/app/Views/[feature]/

# Sync assets
rsync -av --progress [source]/assets/css/[feature]*.css [target]/assets/css/
rsync -av --progress [source]/assets/js/[feature]*.js [target]/assets/js/
\`\`\`

---

## Routing Configuration

### Routes to Add to `[target]/public/index.php`

\`\`\`php
// ============================================
// [FEATURE NAME] ROUTES
// ============================================

$router->add('[route]', [
    'controller' => '[Controller]',
    'action' => '[action]',
    'middleware' => 'AuthMiddleware',
    'permission' => '[permission]'
]);

$router->add('[route]/{id:\d+}', [
    'controller' => '[Controller]',
    'action' => '[action]',
    'middleware' => 'AuthMiddleware',
    'permission' => '[permission]'
]);
\`\`\`

---

## Configuration Updates

### [target]/config/config.php

\`\`\`php
// Feature flags for [Feature]
define('ENABLE_[FEATURE]', true);  // ✅ Enable after migration
\`\`\`

### [target]/config/database.php

\`\`\`php
// Verify correct database
return [
    'database' => '[TARGET_DB]',  // ← Ensure correct
    // ... other config
];
\`\`\`

---

## Testing Checklist

### Database Testing
- [ ] All new tables exist
- [ ] All modified tables have new columns
- [ ] All indexes created successfully
- [ ] All foreign keys linked correctly
- [ ] No orphaned data
- [ ] Existing data preserved

### Application Testing
- [ ] [Feature1] dashboard loads
- [ ] [Feature1] create functionality works
- [ ] [Feature1] read functionality works
- [ ] [Feature1] update functionality works
- [ ] [Feature1] delete functionality works
- [ ] Navigation menu items appear
- [ ] Permissions enforced correctly
- [ ] No PHP errors in logs
- [ ] No JavaScript console errors
- [ ] CSS/assets loading correctly

---

## Rollback Plan

If critical issues occur during or after migration:

### Emergency Rollback Steps

\`\`\`bash
# Step 1: Restore database
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 [TARGET_DB] < backups/[TARGET_DB]_backup_[DATE].sql

# Step 2: Restore codebase
rm -rf [target_env]
cp -r [target_env]_backup_[DATE]/ [target_env]/

# Step 3: Clear caches
rm -rf [target_env]/cache/*
rm -rf [target_env]/logs/*

# Step 4: Verify rollback
# Test application to confirm it's back to previous state
\`\`\`

---

## Success Criteria

### Database Success Criteria
✅ Table count matches expected ([expected_count])
✅ All new tables created with correct schema
✅ All modified tables have new columns/indexes/FKs
✅ No foreign key constraint errors
✅ No orphaned data
✅ All indexes created successfully

### Application Success Criteria
✅ [Feature1] fully functional
✅ [Feature2] fully functional
✅ [Feature3] fully functional
✅ No regressions in existing features
✅ All tests passing
✅ No errors in logs
✅ Performance within acceptable limits

---

## Migration Summary

| Metric | Count |
|--------|-------|
| **Tables Created** | [count] |
| **Tables Modified** | [count] |
| **Columns Added** | [count] |
| **Indexes Added** | [count] |
| **Foreign Keys Added** | [count] |
| **Controllers Added** | [count] |
| **Models Added** | [count] |
| **Views Added** | [count] |

**Before:** [current_count] tables
**After:** [new_count] tables
**Change:** +[difference] tables

---

## Files Generated

1. **Migration SQL Script:**
   `[env]/database/migration_[source]_to_[target]_[date].sql`

2. **Migration Plan:**
   `[ENV]_MIGRATION_PLAN_[FEATURES]_[DATE].md` (this document)

3. **Verification Report:**
   `[ENV]_MIGRATION_VERIFICATION_[DATE].md` (generated post-migration)

---

## Dependencies & Prerequisites

### Database Dependencies
- [ ] [Feature] depends on [parent_feature] (must be migrated first)
- [ ] [Table] requires [parent_table] to exist

### Code Dependencies
- [ ] [Controller] requires [Service] class
- [ ] [Model] requires [helper] function

### Configuration Dependencies
- [ ] Feature flag must be enabled in config
- [ ] Route must be added to router
- [ ] Permission must exist in database

---

## Risk Assessment

### Low Risk Changes
- New table additions (no existing data affected)
- New column additions with NULL defaults
- New index additions

### Medium Risk Changes
- Column type modifications
- Adding NOT NULL columns (requires default or data migration)
- Foreign key additions (requires referential integrity)

### High Risk Changes
- Column removals (DATA LOSS potential)
- Table removals (DATA LOSS potential)
- Data transformations

**Overall Risk Level:** [LOW | MEDIUM | HIGH]

---

## Contact & Support

For issues during migration:
1. Check error logs: `tail -f [env]/logs/error.log`
2. Verify database: Check foreign keys and indexes
3. Review configuration: Ensure correct database name
4. Consult troubleshooting section in this document

---

**Migration Plan Complete**
```

---

### Document 2: Verification Report Template

**Filename:** `[ENV]_MIGRATION_VERIFICATION_[DATE].md`

**Generated After Migration Execution**

```markdown
# Migration Verification Report
**Date:** [YYYY-MM-DD HH:MM:SS]
**Migration:** [Source] → [Target]
**Features:** [Feature List]

---

## Database Verification

### Table Count Verification
- **Expected:** [count]
- **Actual:** [count]
- **Status:** [✅ PASS | ❌ FAIL]

### New Tables Verification
| Table Name | Exists | Column Count | Index Count | FK Count | Status |
|------------|--------|--------------|-------------|----------|--------|
| [table1]   | ✅     | [count]      | [count]     | [count]  | ✅ PASS |
| [table2]   | ✅     | [count]      | [count]     | [count]  | ✅ PASS |

### Modified Tables Verification
| Table Name | Columns Added | Indexes Added | FKs Added | Status |
|------------|---------------|---------------|-----------|--------|
| [table1]   | [count]/[expected] | [count]/[expected] | [count]/[expected] | ✅ PASS |

### Foreign Key Verification
| Constraint Name | Source Table | Target Table | Status |
|----------------|--------------|--------------|--------|
| [fk_name]      | [table]      | [table]      | ✅ PASS |

### Index Verification
| Table Name | Index Name | Columns | Type | Status |
|-----------|-----------|---------|------|--------|
| [table]   | [idx_name] | [cols] | [type] | ✅ PASS |

---

## Application Verification

### Feature Testing Results
| Feature | Endpoint | Status Code | Response Time | Status |
|---------|----------|-------------|---------------|--------|
| [Feature1] Dashboard | /admin/[feature] | 200 | [ms] | ✅ PASS |
| [Feature1] List | /admin/[feature]/list | 200 | [ms] | ✅ PASS |
| [Feature1] Create | /admin/[feature]/create | 200 | [ms] | ✅ PASS |

### Error Log Check
- **PHP Errors:** [count]
- **SQL Errors:** [count]
- **JavaScript Errors:** [count]
- **Status:** [✅ CLEAN | ⚠️ WARNINGS | ❌ ERRORS]

---

## Issues Found

[If any issues were found, list them here]

### Issue 1: [Description]
- **Severity:** [LOW | MEDIUM | HIGH | CRITICAL]
- **Table/Feature:** [affected area]
- **Description:** [detailed description]
- **Resolution:** [how it was fixed]

---

## Overall Status

**Migration Status:** [✅ SUCCESS | ⚠️ SUCCESS WITH WARNINGS | ❌ FAILED]

**Ready for Production:** [YES | NO | WITH CAVEATS]

---

**Verification Complete**
```

---

## SPECIAL CASES & EDGE CASES

### Case 1: Feature with Image/File Storage

If a feature includes image tables (`[feature]_images` or `[feature]_photos`):

**Check Prompt for Explicit Approval:**
- If NOT explicitly mentioned → EXCLUDE from migration
- If mentioned → Include but note file storage requirements

**Additional Requirements:**
```markdown
### File Storage Requirements

**Directory Structure:**
\`\`\`
[env]/public/uploads/[feature]/
├── images/
├── thumbnails/
└── temp/
\`\`\`

**Permissions:**
\`\`\`bash
chmod -R 755 [env]/public/uploads/[feature]/
chown -R www-data:www-data [env]/public/uploads/[feature]/
\`\`\`

**Configuration:**
\`\`\`php
// config/config.php
define('[FEATURE]_UPLOAD_PATH', BASE_PATH . '/public/uploads/[feature]/');
define('[FEATURE]_MAX_FILE_SIZE', 5242880); // 5MB
\`\`\`
```

### Case 2: Feature Not Complete in Source

If schema comparison reveals incomplete feature:

**Flag in Migration Plan:**
```markdown
## ⚠️ WARNING: Incomplete Feature Detected

### Feature: [Feature Name]
**Status:** INCOMPLETE

**Missing Components:**
- [ ] Table: [missing_table] (referenced but doesn't exist)
- [ ] Foreign Key: [fk_name] (references non-existent table)
- [ ] Controller: [ControllerName].php (not found in source)
- [ ] Model: [ModelName].php (not found in source)

**Recommendation:**
❌ DO NOT MIGRATE until feature is complete in source environment

**Required Actions:**
1. Complete missing tables in [source] environment
2. Add missing controllers/models
3. Re-run migration plan generation
```

### Case 3: Breaking Changes Detected

If migration would break existing functionality:

**Flag in Migration Plan:**
```markdown
## 🚨 BREAKING CHANGES DETECTED

### Change: [Description]
**Affected Table:** [table_name]
**Type:** [COLUMN REMOVAL | TYPE CHANGE | CONSTRAINT CHANGE]
**Impact:** [description of impact]

**Existing Data:**
- **Rows affected:** [count]
- **Data loss risk:** [HIGH | MEDIUM | LOW]

**Migration Strategy:**
1. [Step 1: Backup affected data]
2. [Step 2: Transform data]
3. [Step 3: Apply schema change]
4. [Step 4: Restore transformed data]

**Rollback Plan:**
[Specific rollback steps for this change]
```

### Case 4: Data Migration Required

If data transformation is needed:

```sql
-- ============================================================================
-- SECTION 3: DATA MIGRATIONS
-- ============================================================================

-- ------------------------------------------------
-- Migration: [Description]
-- Reason: [Why data migration is needed]
-- ------------------------------------------------

-- Step 1: Create temporary table for transformation
CREATE TEMPORARY TABLE temp_migration AS
SELECT
    [columns],
    [transformations]
FROM [source_table]
WHERE [conditions];

-- Step 2: Verify data
SELECT COUNT(*) FROM temp_migration;
-- Expected: [count]

-- Step 3: Insert transformed data
INSERT INTO [target_table] ([columns])
SELECT [columns]
FROM temp_migration;

-- Step 4: Verify insertion
SELECT COUNT(*) FROM [target_table];
-- Expected: [count]

-- Step 5: Clean up
DROP TEMPORARY TABLE temp_migration;
```

---

## OUTPUT REQUIREMENTS

### Required Files to Generate

The LLM MUST generate the following 3 documents for every migration request:

#### 1. Migration SQL Script (REQUIRED)
**Filename:** `[env]/database/migration_[source]_to_[target]_[YYYYMMDD].sql`
**Template:** See "PHASE 3: MIGRATION SCRIPT GENERATION" above
**Must Include:**
- Header with date, features, source/target databases
- SET statements for safety
- ALTER TABLE statements (for modifications)
- CREATE TABLE statements (for new tables)
- Proper ordering (FKs after referenced tables)
- Restore settings
- Summary comment block

#### 2. Detailed Migration Plan (REQUIRED)
**Filename:** `[ENV]_MIGRATION_PLAN_[FEATURES]_[YYYYMMDD].md`
**Template:** See "Document 1: Migration Plan (Primary Document)" above
**Must Include:** All sections from the detailed template

#### 3. Migration Summary/Quick Reference (REQUIRED)
**Filename:** `MIGRATION_SUMMARY_[FEATURES]_[YYYYMMDD].md`
**Template:** See below
**Purpose:** Executive summary for quick execution and reference

---

## Document 3: Migration Summary Template (REQUIRED)

**Filename:** `MIGRATION_SUMMARY_[FEATURES]_[YYYYMMDD].md`

This is a **condensed, executive-level summary** for quick reference and execution. Think of it as the "TL;DR" version.

**Template:**

```markdown
# Migration Summary: [Features]
**Environment:** [Source] → [Target]
**Date:** [YYYY-MM-DD]
**Status:** READY FOR EXECUTION | NEEDS REVIEW | BLOCKED

---

## Quick Overview

### Features Being Migrated
✅ [Feature1] - [1-line description]
✅ [Feature2] - [1-line description]
✅ [Feature3] - [1-line description]

### Features Excluded
❌ [Feature] - [reason in 1 line]

### Migration Impact
| Metric | Before | After | Change |
|--------|--------|-------|--------|
| **Total Tables** | [count] | [count] | +[diff] |
| **[Feature1] Tables** | [count] | [count] | +[diff] |
| **[Feature2] Tables** | [count] | [count] | +[diff] |

---

## What's Being Changed

### New Tables ([count])
**[Feature1]:**
- `[table1]` - [brief purpose]
- `[table2]` - [brief purpose]

**[Feature2]:**
- `[table1]` - [brief purpose]
- `[table2]` - [brief purpose]

### Modified Tables ([count])
- `[table_name]` - [brief description of changes]
  - Added: [count] columns, [count] indexes, [count] FKs

---

## Quick Execution Guide

### Step 1: Backup (REQUIRED)
\`\`\`bash
"/mnt/c/xampp/mysql/bin/mysqldump.exe" -u root -pmindseye@41 [TARGET_DB] > backups/[TARGET_DB]_backup_$(date +%Y%m%d).sql
\`\`\`

### Step 2: Run Migration
\`\`\`bash
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 [TARGET_DB] < [path_to_sql_script]
\`\`\`

### Step 3: Verify
\`\`\`bash
# Verify table count (expect: [count])
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 [TARGET_DB] -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = '[TARGET_DB]';"

# Verify [Feature1] tables
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 [TARGET_DB] -e "SHOW TABLES LIKE '[pattern]%';"

# Verify [Feature2] tables
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 [TARGET_DB] -e "SHOW TABLES LIKE '[pattern]%';"
\`\`\`

---

## Files to Sync

### Controllers ([count] files)
\`\`\`
[source]/app/Controllers/[Feature1]*.php → [target]/app/Controllers/
[source]/app/Controllers/[Feature2]*.php → [target]/app/Controllers/
\`\`\`

### Models ([count] files)
\`\`\`
[source]/app/Models/[Feature1]*.php → [target]/app/Models/
[source]/app/Models/[Feature2]*.php → [target]/app/Models/
\`\`\`

### Views
\`\`\`
[source]/app/Views/[feature1]/ → [target]/app/Views/[feature1]/
[source]/app/Views/[feature2]/ → [target]/app/Views/[feature2]/
\`\`\`

### Assets
\`\`\`
[source]/assets/css/[feature].css → [target]/assets/css/
[source]/assets/js/[feature].js → [target]/assets/js/
\`\`\`

### One-Command Sync
\`\`\`bash
# Copy all necessary files
rsync -av --progress \
  --include='[Feature1]*.php' \
  --include='[Feature2]*.php' \
  [source]/app/ [target]/app/
\`\`\`

---

## Routes to Add

Add to `[target]/public/index.php`:

\`\`\`php
// [Feature1] Routes
$router->add('[route]', ['controller' => '[Controller]', 'action' => '[action]', 'middleware' => 'AuthMiddleware', 'permission' => '[perm]']);
$router->add('[route]/{id:\d+}', ['controller' => '[Controller]', 'action' => '[action]', 'middleware' => 'AuthMiddleware', 'permission' => '[perm]']);

// [Feature2] Routes
$router->add('[route]', ['controller' => '[Controller]', 'action' => '[action]', 'middleware' => 'AuthMiddleware', 'permission' => '[perm]']);
\`\`\`

---

## Configuration Changes

\`\`\`php
// [target]/config/config.php
define('ENABLE_[FEATURE1]', true);
define('ENABLE_[FEATURE2]', true);
define('ENABLE_[EXCLUDED_FEATURE]', false);
\`\`\`

---

## Testing Checklist

### Database
- [ ] Table count is [expected_count]
- [ ] All [Feature1] tables exist
- [ ] All [Feature2] tables exist
- [ ] Foreign keys linked correctly
- [ ] Indexes created successfully

### Application
- [ ] [Feature1] dashboard loads: `/admin/[feature1]`
- [ ] [Feature2] dashboard loads: `/admin/[feature2]`
- [ ] CRUD operations work for [Feature1]
- [ ] CRUD operations work for [Feature2]
- [ ] No PHP errors in logs
- [ ] No JavaScript errors in console

---

## Rollback Command

\`\`\`bash
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 [TARGET_DB] < backups/[TARGET_DB]_backup_[date].sql
\`\`\`

---

## ⚠️ Important Notes

[Include any critical warnings, dependencies, or special instructions]

**Example:**
- ⚠️ [Feature1] requires [dependency] to be installed
- ⚠️ [Feature2] depends on [Feature1] tables
- ⚠️ File upload directory must be created: `/uploads/[feature]/`

---

## Files Generated

1. **SQL Script:** `[path_to_sql_script]`
2. **Detailed Plan:** `[path_to_detailed_plan]`
3. **This Summary:** `[path_to_this_file]`

---

## Risk Level

**Overall Risk:** [LOW | MEDIUM | HIGH]

**Reasoning:** [1-2 sentence explanation]

**Mitigation:** [Brief mitigation strategy]

---

## Success Criteria

✅ Database has [expected] tables
✅ [Feature1] fully functional
✅ [Feature2] fully functional
✅ No regressions in existing features
✅ All tests passing

---

**Status:** Ready to execute
**Estimated Time:** [X] minutes
**Last Updated:** [timestamp]
```

---

## Example Output: Migration Summary

Here's a concrete example of what the Migration Summary should look like:

**Filename:** `MIGRATION_SUMMARY_FLEET_INVENTORY_20251109.md`

```markdown
# Migration Summary: Fleet Management & Inventory Management
**Environment:** Dev → Stage
**Date:** 2025-11-09
**Status:** READY FOR EXECUTION

---

## Quick Overview

### Features Being Migrated
✅ Fleet Management - Vehicle tracking, driver management, compliance alerts
✅ Inventory Management - Item tracking, storage management, sales logging

### Features Excluded
❌ Quote Management - Feature not production-ready
❌ Image Features - Not approved in prompt

### Migration Impact
| Metric | Before | After | Change |
|--------|--------|-------|--------|
| **Total Tables** | 30 | 45 | +15 |
| **Fleet Tables** | 0 | 4 | +4 |
| **Inventory Tables** | 0 | 9 | +9 |
| **Support Tables** | 28 | 32 | +2 |

---

## What's Being Changed

### New Tables (15)
**Fleet Management:**
- `fleet_vehicles` - Vehicle registry (registration, MOT, insurance)
- `fleet_drivers` - Driver information and licensing
- `fleet_driver_vehicle_assignments` - Vehicle assignments
- `fleet_compliance_alerts` - MOT/insurance/tax expiry alerts

**Inventory Management:**
- `locations` - Warehouses, depots, yards
- `item_categories` - Hierarchical item categories
- `storage_options` - Storage areas within locations
- `items` - Main inventory tracking
- `item_storage` - Item location tracking
- `item_status_changes` - Audit trail for status changes
- `item_sales_log` - Sales history
- `acquisition_costs` - Cost tracking
- `vehicle_inventory` - Items loaded on vehicles

**Support:**
- `entity_addresses` - Generic address relationships
- `user_email_preferences` - Email notification settings

### Modified Tables (1)
- `addresses` - Added geocoding and validation fields
  - Added: 7 columns, 2 indexes

---

## Quick Execution Guide

### Step 1: Backup (REQUIRED)
\`\`\`bash
"/mnt/c/xampp/mysql/bin/mysqldump.exe" -u root -pmindseye@41 freecono_staging > backups/freecono_staging_backup_$(date +%Y%m%d).sql
\`\`\`

### Step 2: Run Migration
\`\`\`bash
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 freecono_staging < stage/database/migration_dev_to_stage_20251109.sql
\`\`\`

### Step 3: Verify
\`\`\`bash
# Verify table count (expect: 45)
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 freecono_staging -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'freecono_staging';"

# Verify fleet tables
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 freecono_staging -e "SHOW TABLES LIKE 'fleet_%';"

# Verify inventory tables
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 freecono_staging -e "SHOW TABLES LIKE 'item%';"
\`\`\`

---

## Files to Sync

### Controllers (4 files)
\`\`\`
dev/app/Controllers/AdminFleetController.php → stage/app/Controllers/
dev/app/Controllers/AdminInventoryController.php → stage/app/Controllers/
dev/app/Controllers/FleetController.php → stage/app/Controllers/
dev/app/Controllers/InventoryController.php → stage/app/Controllers/
\`\`\`

### Models (13 files)
\`\`\`
# Fleet Models
dev/app/Models/FleetVehicle.php → stage/app/Models/
dev/app/Models/FleetDriver.php → stage/app/Models/
dev/app/Models/FleetDriverVehicleAssignment.php → stage/app/Models/
dev/app/Models/FleetComplianceAlert.php → stage/app/Models/

# Inventory Models
dev/app/Models/Location.php → stage/app/Models/
dev/app/Models/ItemCategory.php → stage/app/Models/
dev/app/Models/StorageOption.php → stage/app/Models/
dev/app/Models/Item.php → stage/app/Models/
dev/app/Models/ItemStorage.php → stage/app/Models/
dev/app/Models/ItemStatusChange.php → stage/app/Models/
dev/app/Models/ItemSalesLog.php → stage/app/Models/
dev/app/Models/AcquisitionCost.php → stage/app/Models/
dev/app/Models/VehicleInventory.php → stage/app/Models/
\`\`\`

### Views
\`\`\`
dev/app/Views/admin/fleet/ → stage/app/Views/admin/fleet/
dev/app/Views/admin/inventory/ → stage/app/Views/admin/inventory/
\`\`\`

### Assets
\`\`\`
dev/assets/css/fleet-management.css → stage/assets/css/
dev/assets/js/fleet-management.js → stage/assets/js/
dev/assets/css/inventory.css → stage/assets/css/
dev/assets/js/inventory.js → stage/assets/js/
\`\`\`

---

## Routes to Add

Add to `stage/public/index.php`:

\`\`\`php
// Fleet Management Routes
$router->add('admin/fleet', ['controller' => 'AdminFleetController', 'action' => 'index', 'middleware' => 'AuthMiddleware', 'permission' => 'admin']);
$router->add('admin/fleet/vehicles', ['controller' => 'AdminFleetController', 'action' => 'vehicles', 'middleware' => 'AuthMiddleware', 'permission' => 'admin']);
$router->add('admin/fleet/drivers', ['controller' => 'AdminFleetController', 'action' => 'drivers', 'middleware' => 'AuthMiddleware', 'permission' => 'admin']);
$router->add('admin/fleet/compliance', ['controller' => 'AdminFleetController', 'action' => 'compliance', 'middleware' => 'AuthMiddleware', 'permission' => 'admin']);

// Inventory Management Routes
$router->add('admin/inventory', ['controller' => 'AdminInventoryController', 'action' => 'index', 'middleware' => 'AuthMiddleware', 'permission' => 'admin']);
$router->add('admin/inventory/items', ['controller' => 'AdminInventoryController', 'action' => 'items', 'middleware' => 'AuthMiddleware', 'permission' => 'admin']);
$router->add('admin/inventory/categories', ['controller' => 'AdminInventoryController', 'action' => 'categories', 'middleware' => 'AuthMiddleware', 'permission' => 'admin']);
$router->add('admin/inventory/locations', ['controller' => 'AdminInventoryController', 'action' => 'locations', 'middleware' => 'AuthMiddleware', 'permission' => 'admin']);
\`\`\`

---

## Configuration Changes

\`\`\`php
// stage/config/config.php
define('ENABLE_FLEET_MANAGEMENT', true);
define('ENABLE_INVENTORY_MANAGEMENT', true);
define('ENABLE_QUOTE_SYSTEM', false);  // Not ready
\`\`\`

---

## Testing Checklist

### Database
- [ ] Table count is 45
- [ ] All fleet tables exist (4 tables)
- [ ] All inventory tables exist (9 tables)
- [ ] Foreign keys linked correctly
- [ ] Indexes created successfully
- [ ] addresses table has new geocoding columns

### Application
- [ ] Fleet dashboard loads: `/admin/fleet`
- [ ] Inventory dashboard loads: `/admin/inventory`
- [ ] Can create/view vehicles
- [ ] Can create/view inventory items
- [ ] Compliance alerts display correctly
- [ ] No PHP errors in logs
- [ ] No JavaScript errors in console

---

## Rollback Command

\`\`\`bash
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 freecono_staging < backups/freecono_staging_backup_20251109.sql
\`\`\`

---

## ⚠️ Important Notes

- ⚠️ Address geocoding fields are nullable - will need manual population
- ⚠️ Vehicle inventory depends on both fleet_vehicles and items tables
- ⚠️ No image upload tables created (not approved)
- ⚠️ Quote management tables exist but were NOT modified

---

## Files Generated

1. **SQL Script:** `stage/database/migration_dev_to_stage_20251109.sql`
2. **Detailed Plan:** `DEV_TO_STAGE_MIGRATION_PLAN_FLEET_INVENTORY_20251109.md`
3. **This Summary:** `MIGRATION_SUMMARY_FLEET_INVENTORY_20251109.md`

---

## Risk Level

**Overall Risk:** LOW

**Reasoning:** Only adding new tables and columns with NULL defaults. No modifications to existing data structures.

**Mitigation:** Full database backup before migration, tested rollback procedure.

---

## Success Criteria

✅ Database has 45 tables (30 + 15)
✅ Fleet Management fully functional
✅ Inventory Management fully functional
✅ No regressions in existing features (bugs, users, auth)
✅ All tests passing

---

**Status:** Ready to execute
**Estimated Time:** 5 minutes
**Last Updated:** 2025-11-09 14:30:00
```

### Quality Checklist

Before delivering migration plan, verify:

- [ ] All requested features have been analyzed
- [ ] Schema comparison is complete (tables, columns, indexes, FKs)
- [ ] Migration script uses `IF NOT EXISTS` clauses
- [ ] Migration script preserves existing data
- [ ] Foreign keys are added AFTER referenced tables
- [ ] Indexes are appropriate for table size
- [ ] File sync list is complete
- [ ] Route configuration is provided
- [ ] Testing checklist is comprehensive
- [ ] Rollback plan is clear and tested
- [ ] Success criteria are measurable
- [ ] Warnings for incomplete/risky changes

---

## EXAMPLE PROMPT & RESPONSE

### Example Prompt:
```
Create a stage migration plan for Fleet Management & Inventory Management & Bug Tracking
```

### Expected Response Workflow:

1. **Identify environments:**
   - Source: `freeconomy_dev`
   - Target: `freecono_staging`

2. **Run deep schema comparison:**
   - Extract tables, columns, indexes, FKs from both databases
   - Identify differences

3. **Map tables to features:**
   - Fleet Management: fleet_vehicles, fleet_drivers, fleet_driver_vehicle_assignments, fleet_compliance_alerts
   - Inventory Management: items, item_categories, locations, storage_options, item_storage, item_status_changes, item_sales_log, acquisition_costs, vehicle_inventory
   - Bug Tracking: bugs, bug_comments (check if already exist)

4. **Generate migration script:**
   - Create script with appropriate ALTER and CREATE statements
   - Include all indexes and foreign keys

5. **Generate migration plan:**
   - Complete plan following template above
   - Include all sections

6. **Generate verification steps:**
   - Specific commands to verify each table/feature

---

## CRITICAL RULES

### Must Follow:

1.  **NEVER drop tables** (Exception: Type 3 Sync with explicit confirmation)
2.  **NEVER delete columns** (Exception: Type 3 Sync with explicit confirmation)
3.  **ALWAYS use `FOREIGN_KEY_CHECKS=0`** during Type 3 Sync to prevent dependency locks.
4.  **ALWAYS add FKs AFTER referenced tables exist** - Order matters.
5.  **ALWAYS preserve existing data** - Use ADD COLUMN, not REPLACE (Unless Sync requires exact match).
6.  **ALWAYS include rollback plan** - Must be able to undo changes.
7.  **ALWAYS verify feature completeness** - Don't migrate incomplete features.
8.  **ALWAYS check for breaking changes** - Flag any risky modifications.

### Must NOT Do:

1.  ❌ Do NOT modify quote_requests if Quote System not in prompt.
2.  **❌ Do NOT Drop tables in Type 1 or Type 2 Migrations.**
3.  ❌ Do NOT migrate test/debug tables.
4.  ❌ Do NOT include temporary or _old tables.
5.  ❌ Do NOT add features not mentioned in prompt.
6.  ❌ Do NOT skip schema comparison - Always do bidirectional analysis for Sync.
7.  ❌ Do NOT use DROP statements without explicit approval (Type 3 Only).
8.  ❌ Do NOT assume - Always verify with database queries.

---

## FINAL CHECKLIST FOR LLM (SYNC MODE)

- [ ] Bidirectional Check: Source → Target AND Target → Source handled?
- [ ] Drop Order: FKs → Indexes → Columns → Tables?
- [ ] Create Order: Tables → Columns → Indexes → FKs?
- [ ] Data Check: Warned user about data loss in dropped columns?

---

**End of Database Migration Protocol**

*Version 1.1 - 2025-12-09*
