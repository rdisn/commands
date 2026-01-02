# Promote to stage environment

Prepare to migrate changed files from Dev to stage environments with comprehensive database validation

## Command Purpose

Create a comprehensive deployment package to update the stage environment with ZERO database migration errors

## Actions to Perform

### 1. Commit and push the branch to github
- **Commit and push the branch to github**
- Ensure all changes are committed and tagged appropriately

### 2. Analyze Current branch Work
- **Review all modified files in the current branch** using git status and git diff
- Identify any new database migration files in `dev/database/migrations/`
- Check for any model changes that might affect database structure

### 3. COMPREHENSIVE Database Schema Analysis

#### 3.1. Database Structure Comparison
**CRITICAL: Execute ALL these checks before proceeding**

```bash
# Set database connection variables
DEV_DB="freeconomy_dev"
STAGE_DB="freeconomy_stage"
MYSQL_PATH="/mnt/c/xampp/mysql/bin/mysql.exe"
MYSQL_USER="root"
MYSQL_PASS="mindseye@41"

# 1. Get ALL tables from both databases
$MYSQL_PATH -u $MYSQL_USER -p$MYSQL_PASS -e "SHOW TABLES FROM $DEV_DB;"
$MYSQL_PATH -u $MYSQL_USER -p$MYSQL_PASS -e "SHOW TABLES FROM $STAGE_DB;"

# 2. For EACH table, compare complete structure:
for table in $(list_all_tables); do
    echo "=== TABLE: $table ==="

    # Check if table exists in both databases
    $MYSQL_PATH -u $MYSQL_USER -p$MYSQL_PASS -e "SHOW CREATE TABLE $DEV_DB.$table;"
    $MYSQL_PATH -u $MYSQL_USER -p$MYSQL_PASS -e "SHOW CREATE TABLE $STAGE_DB.$table;"

    # Compare detailed column information
    $MYSQL_PATH -u $MYSQL_USER -p$MYSQL_PASS -e "DESCRIBE $DEV_DB.$table;"
    $MYSQL_PATH -u $MYSQL_USER -p$MYSQL_PASS -e "DESCRIBE $STAGE_DB.$table;"

    # Check indexes and keys
    $MYSQL_PATH -u $MYSQL_USER -p$MYSQL_PASS -e "SHOW INDEX FROM $DEV_DB.$table;"
    $MYSQL_PATH -u $MYSQL_USER -p$MYSQL_PASS -e "SHOW INDEX FROM $STAGE_DB.$table;"

    # Check foreign key constraints
    $MYSQL_PATH -u $MYSQL_USER -p$MYSQL_PASS -e "SELECT CONSTRAINT_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA='$DEV_DB' AND TABLE_NAME='$table' AND REFERENCED_TABLE_NAME IS NOT NULL;"
    $MYSQL_PATH -u $MYSQL_USER -p$MYSQL_PASS -e "SELECT CONSTRAINT_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA='$STAGE_DB' AND TABLE_NAME='$table' AND REFERENCED_TABLE_NAME IS NOT NULL;"
done
```

#### 3.2. Dependency Analysis
**MUST identify creation order for:**
- Tables with foreign key dependencies
- Tables referenced by indexes
- Tables with unique constraints
- Tables involved in cascading operations

**Document dependency chains:**
```
Parent_Table → Child_Table (FK relationship)
Table_A ← Table_B (Table_B references Table_A)
```

#### 3.3. Data Integrity Validation
```bash
# Check data counts for all existing tables
for table in $(common_tables); do
    echo "=== DATA COMPARISON: $table ==="
    $MYSQL_PATH -u $MYSQL_USER -p$MYSQL_PASS -e "SELECT COUNT(*) as dev_count FROM $DEV_DB.$table;"
    $MYSQL_PATH -u $MYSQL_USER -p$MYSQL_PASS -e "SELECT COUNT(*) as stage_count FROM $STAGE_DB.$table;"
done

# Check for orphaned records in stage database
$MYSQL_PATH -u $MYSQL_USER -p$MYSQL_PASS -e "
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA='$STAGE_DB'
AND REFERENCED_TABLE_NAME IS NOT NULL;
"
```

### 4. Migration Script Generation

#### 4.1. Script Creation Requirements
**Generate SQL migration script with:**

1. **Proper Execution Order:**
   - Create new tables (no dependencies first)
   - Add columns to existing tables
   - Create indexes after tables exist
   - Add foreign keys after referenced tables exist
   - Drop old foreign keys before dropping columns
   - Drop old tables last

2. **Transaction Safety:**
   ```sql
   START TRANSACTION;

   -- Add new columns
   ALTER TABLE table_name ADD COLUMN new_column VARCHAR(255);

   -- Migrate data if needed
   UPDATE table_name SET new_column = old_column WHERE condition;

   -- Add constraints
   ALTER TABLE table_name ADD CONSTRAINT fk_name FOREIGN KEY (column) REFERENCES other_table(id);

   COMMIT;
   ```

3. **Rollback Support:**
   ```sql
   -- Save rollback statements
   -- ALTER TABLE table_name DROP COLUMN new_column;
   -- ALTER TABLE table_name DROP FOREIGN KEY fk_name;
   ```

#### 4.2. Validation Queries
**Include these validation checks in the script:**
```sql
-- Verify all tables exist
SELECT table_name FROM information_schema.tables WHERE table_schema = 'freeconomy_stage';

-- Verify all foreign keys are valid
SELECT COUNT(*) as invalid_fks
FROM information_schema.key_column_usage
WHERE table_schema = 'freeconomy_stage'
AND referenced_table_name IS NOT NULL
AND referenced_table_name NOT IN (
    SELECT table_name FROM information_schema.tables WHERE table_schema = 'freeconomy_stage'
);

-- Verify no orphaned records
[Add specific queries for each foreign key relationship]
```

#### 4.3. Data Migration Requirements
**For any data migrations:**
- Export data from dev with proper escaping
- Include INSERT statements with proper column ordering
- Handle NULL values appropriately
- Validate data integrity after migration
- Include data verification queries

### 5. Testing and Verification

#### 5.1. Pre-Migration Testing
```bash
# Test migration script on copy of stage database
$MYSQL_PATH -u $MYSQL_USER -p$MYSQL_PASS -e "CREATE DATABASE freeconomy_stage_test AS SELECT * FROM freeconomy_stage;"
$MYSQL_PATH -u $MYSQL_USER -p$MYSQL_PASS freeconomy_stage_test < migration_script.sql

# Run validation queries
$MYSQL_PATH -u $MYSQL_USER -p$MYSQL_PASS freeconomy_stage_test -e "SELECT 'Migration validation queries here';"
```

#### 5.2. Post-Migration Verification
- All application features work correctly
- No orphaned data exists
- Performance is maintained
- All foreign key constraints are valid
- Indexes are properly created and being used

### 6. Documentation Creation

#### 6.1. Migration Summary Document (MIGRATION_SUMMARY_v[X.X].md)
**Must include:**
- List of all files to copy to stage
- Database changes summary with BEFORE/AFTER states
- Migration script execution steps
- Rollback procedures
- Testing checklist
- Contact information for issues

#### 6.2. Database Changes Documentation
**Detail every change:**
- New tables: `CREATE TABLE` statements
- Modified tables: `ALTER TABLE` statements
- Dropped tables: `DROP TABLE` statements
- Index changes: `CREATE/DROP INDEX` statements
- Foreign key changes: `ALTER TABLE` with constraints
- Data migrations: Source/target mappings

#### 6.3. Update CLAUDE.md
- Document any new database patterns
- Update project structure if new models added
- Add any new development standards learned

#### 6.4. User Guides
- Create/update guides for new functionality
- Include screenshots from development environment
- Document any user interface changes

### 7. Final Validation Checklist

**Before proceeding with deployment:**

- [ ] All database differences documented
- [ ] Migration script tested on staging copy
- [ ] All foreign key dependencies verified
- [ ] Data integrity checks pass
- [ ] Rollback procedure documented and tested
- [ ] All files identified for deployment
- [ ] Documentation complete and accurate
- [ ] Team review completed

**NO PROCEEDING until ALL checks pass!** 