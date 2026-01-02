# FreeconomyToday Site Standards
**Version 1.0 - Mandatory Compliance Document**

## Purpose
This document defines mandatory standards for ALL new development on the FreeconomyToday Recycling Platform. These standards MUST be followed exactly - no exceptions. This ensures consistency, maintainability, and seamless LLM collaboration.

---

## CSS Standards (MANDATORY)

### Rule 1: Use CSS Variables ONLY
**NEVER hardcode colors, spacing, or font sizes.**

**✅ CORRECT:**
```css
.my-component {
  color: var(--color-primary);
  padding: var(--space-4);
  font-size: var(--font-size-base);
  border-radius: var(--radius-md);
}
```

**❌ WRONG:**
```css
.my-component {
  color: #228B22;              /* NEVER hardcode colors */
  padding: 16px;               /* NEVER hardcode spacing */
  font-size: 16px;             /* NEVER hardcode font sizes */
  border-radius: 6px;          /* NEVER hardcode radius */
}
```

### Rule 2: Component-Scoped CSS Files
**Each feature/page MUST have its own CSS file.**

**File Naming Convention:**
- Admin features: `assets/css/admin-[feature].css`
- User features: `assets/css/user-[feature].css`
- Public pages: `assets/css/[page]-page.css`
- Components: `assets/css/components/[component].css`

**Examples:**
```
assets/css/admin-bugs.css          ✅ Correct
assets/css/admin-quotes.css        ✅ Correct
assets/css/user-dashboard.css      ✅ Correct
assets/css/about-page.css          ✅ Correct
assets/css/components/navigation.css ✅ Correct
```

### Rule 3: CSS Class Naming Convention
**Use BEM-style naming with feature prefix.**

**Pattern:** `.{feature}-{block}__{element}--{modifier}`

**Examples:**
```css
/* Admin Bug Feature */
.bugs-hero { }                    /* Block */
.bugs-table { }                   /* Block */
.bugs-table__row { }              /* Element */
.bugs-table__row--pending { }     /* Modifier */
.bugs-status-badge { }            /* Block */
.bugs-status-badge--critical { }  /* Modifier */

/* Quote Management Feature */
.quote-card { }
.quote-card__header { }
.quote-card__header--highlighted { }
.quote-status { }
.quote-status--approved { }
```

### Rule 4: CSS File Structure
**All CSS files MUST follow this exact structure:**

```css
/**
 * [Feature Name] Styles
 *
 * Description of what this file styles
 *
 * @package FreeconomyToday
 * @subpackage CSS\[Section]
 */

/* =================================================================
   SECTION 1: LAYOUT & STRUCTURE
   ================================================================= */

.feature-hero {
  /* Container styles using variables */
}

.feature-header {
  /* Header styles using variables */
}

/* =================================================================
   SECTION 2: COMPONENTS
   ================================================================= */

.feature-card {
  /* Component styles using variables */
}

.feature-table {
  /* Table styles using variables */
}

/* =================================================================
   SECTION 3: STATE & MODIFIERS
   ================================================================= */

.feature-card--active {
  /* Active state styles */
}

.feature-card--disabled {
  /* Disabled state styles */
}

/* =================================================================
   SECTION 4: RESPONSIVE DESIGN
   ================================================================= */

@media (max-width: 768px) {
  /* Mobile styles */
}

@media (min-width: 769px) and (max-width: 1024px) {
  /* Tablet styles */
}

/* =================================================================
   SECTION 5: DARK MODE
   ================================================================= */

[data-theme="dark"] .feature-card {
  /* Dark mode overrides */
}
```

### Rule 5: Available CSS Variables
**Reference:** `assets/css/core/variables.css`

**Colors (ALWAYS use these):**
```css
/* Primary Brand Colors */
--color-primary: #228B22;
--color-primary-light: #32CD32;
--color-primary-dark: #006400;
--color-accent: #90EE90;

/* Semantic Colors */
--color-text: #1a1a1a;
--color-text-light: #4a5568;
--color-text-muted: #718096;
--color-background: #ffffff;
--color-background-secondary: #f7fafc;
--color-border: #e2e8f0;

/* Status Colors */
--color-success: #38a169;
--color-warning: #d69e2e;
--color-error: #e53e3e;
--color-info: #3182ce;
```

**Spacing (ALWAYS use these):**
```css
--space-1: 0.25rem;   /* 4px */
--space-2: 0.5rem;    /* 8px */
--space-3: 0.75rem;   /* 12px */
--space-4: 1rem;      /* 16px */
--space-5: 1.25rem;   /* 20px */
--space-6: 1.5rem;    /* 24px */
--space-8: 2rem;      /* 32px */
--space-10: 2.5rem;   /* 40px */
--space-12: 3rem;     /* 48px */
--space-16: 4rem;     /* 64px */
```

**Typography (ALWAYS use these):**
```css
/* Fonts */
--font-primary: 'Inter', sans-serif;
--font-headings: 'Poppins', sans-serif;

/* Sizes */
--font-size-xs: 0.75rem;    /* 12px */
--font-size-sm: 0.875rem;   /* 14px */
--font-size-base: 1rem;     /* 16px */
--font-size-lg: 1.125rem;   /* 18px */
--font-size-xl: 1.25rem;    /* 20px */
--font-size-2xl: 1.5rem;    /* 24px */
--font-size-3xl: 1.875rem;  /* 30px */
--font-size-4xl: 2.25rem;   /* 36px */

/* Weights */
--font-weight-light: 300;
--font-weight-normal: 400;
--font-weight-medium: 500;
--font-weight-semibold: 600;
--font-weight-bold: 700;
```

**Border Radius (ALWAYS use these):**
```css
--radius-sm: 0.125rem;   /* 2px */
--radius-base: 0.25rem;  /* 4px */
--radius-md: 0.375rem;   /* 6px */
--radius-lg: 0.5rem;     /* 8px */
--radius-xl: 0.75rem;    /* 12px */
--radius-2xl: 1rem;      /* 16px */
--radius-full: 9999px;
```

**Shadows (ALWAYS use these):**
```css
--shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
--shadow-base: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
--shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
--shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
--shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
```

### Rule 6: Glassmorphism Design Pattern
**The site uses glassmorphism design EVERYWHERE.**

**Standard Glassmorphism Component:**
```css
.my-component {
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.18);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow-lg);
}
```

**Dark Mode Glassmorphism:**
```css
[data-theme="dark"] .my-component {
  background: rgba(30, 41, 59, 0.85);
  border: 1px solid rgba(148, 163, 184, 0.18);
}
```

### Rule 7: Dark Mode Support
**EVERY component MUST support dark mode.**

**Implementation:**
```css
/* Light mode (default) */
.my-component {
  background: var(--color-background);
  color: var(--color-text);
  border-color: var(--color-border);
}

/* Dark mode (automatic via variables) */
[data-theme="dark"] .my-component {
  /* Only override if needed - variables handle most cases */
}
```

### Rule 8: Responsive Design
**Mobile-first approach MANDATORY.**

**Breakpoint Usage:**
```css
/* Mobile first (default) */
.my-component {
  padding: var(--space-4);
  font-size: var(--font-size-sm);
}

/* Tablet and up */
@media (min-width: 768px) {
  .my-component {
    padding: var(--space-6);
    font-size: var(--font-size-base);
  }
}

/* Desktop and up */
@media (min-width: 1024px) {
  .my-component {
    padding: var(--space-8);
    font-size: var(--font-size-lg);
  }
}
```

---

## PHP Standards (MANDATORY)

### Rule 1: File Structure
**All PHP files MUST start with this exact header:**

```php
<?php
/**
 * [File Purpose - One Line Description]
 *
 * [Detailed description of what this file does]
 *
 * @package FreeconomyToday
 * @subpackage [Controllers|Models|Views|Services]
 * @author [Your Name/LLM Role]
 * @version 1.0
 */

namespace App\[Namespace];

use App\Core\[RequiredClass];
// ... other imports
```

### Rule 2: Controller Standards
**Location:** `app/Controllers/[ControllerName].php`

**Template:**
```php
<?php
namespace App\Controllers;

use App\Core\Controller;
use App\Core\View;
use App\Models\[ModelName];

class [FeatureName]Controller extends Controller
{
    /**
     * Display the feature index page
     *
     * @return void
     */
    public function index()
    {
        // 1. Check authentication/permissions
        if (!$this->requireAuth()) {
            return;
        }

        // 2. Get data from model
        $model = new [ModelName]();
        $data = $model->getAll();

        // 3. Prepare view data
        $viewData = [
            'pageTitle' => '[Page Title]',
            'pageDescription' => '[SEO description]',
            'bodyClass' => '[feature]-page',
            'data' => $data
        ];

        // 4. Render view
        $this->render('[section]/[feature]/index.php', $viewData);
    }
}
```

### Rule 3: Model Standards
**Location:** `app/Models/[ModelName].php`

**Template:**
```php
<?php
namespace App\Models;

use App\Core\Database\QueryBuilder;
use App\Core\Database;

class [ModelName]
{
    private $db;
    private $table = '[table_name]';

    public function __construct()
    {
        $this->db = Database::getInstance()->getConnection();
    }

    /**
     * Get all records
     *
     * @return array
     */
    public function getAll()
    {
        $query = new QueryBuilder();
        return $query->table($this->table)
                    ->select()
                    ->get();
    }

    /**
     * Get record by ID
     *
     * @param int $id
     * @return array|null
     */
    public function find($id)
    {
        $query = new QueryBuilder();
        return $query->table($this->table)
                    ->select()
                    ->where('id', '=', $id)
                    ->first();
    }
}
```

### Rule 4: View Standards
**Location:** `app/Views/[section]/[feature]/[view].php`

**Template:**
```php
<?php
/**
 * [Feature Name] - [View Purpose]
 *
 * [Description of what this view displays]
 *
 * @package FreeconomyToday
 * @subpackage Views\[Section]
 */

use App\Core\View;
?>

<section class="[feature]-hero">
    <div class="container">
        <div class="[feature]-header">
            <h1 class="[feature]-title"><?php echo View::escape($pageTitle); ?></h1>
            <p class="[feature]-subtitle"><?php echo View::escape($pageDescription); ?></p>
        </div>

        <?php if (empty($data)): ?>
            <div class="[feature]-empty-state">
                <div class="empty-state-icon">📭</div>
                <h3 class="empty-state-title">No [Items] Found</h3>
                <p class="empty-state-text">
                    Get started by creating your first [item].
                </p>
            </div>
        <?php else: ?>
            <div class="[feature]-content">
                <!-- Content here -->
            </div>
        <?php endif; ?>
    </div>
</section>
```

### Rule 5: Security Standards (MANDATORY)

**XSS Prevention:**
```php
<!-- ALWAYS escape output -->
<?php echo View::escape($userInput); ?>
<?php echo View::escape($data['field'] ?? ''); ?>

<!-- NEVER output raw user data -->
<?php echo $userInput; ?> ❌ WRONG - XSS VULNERABILITY
```

**SQL Injection Prevention:**
```php
// ✅ CORRECT - Use QueryBuilder or prepared statements
$query = new QueryBuilder();
$result = $query->table('users')
                ->where('id', '=', $userId)
                ->first();

// ❌ WRONG - Direct SQL concatenation
$sql = "SELECT * FROM users WHERE id = " . $userId; // SQL INJECTION RISK
```

**CSRF Protection:**
```php
<!-- ALWAYS include CSRF token in forms -->
<form method="POST" action="<?php echo View::url('[route]'); ?>">
    <?php echo View::csrfField(); ?>
    <!-- form fields -->
</form>
```

### Rule 6: Database Query Standards

**ALWAYS verify schema first:**
```bash
# Before writing ANY query, run this:

# WSL/Linux:
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 freeconomy_dev -e "DESCRIBE table_name;"

# Windows Command Prompt/PowerShell:
"C:\xampp\mysql\bin\mysql.exe" -u root -pmindseye@41 freeconomy_dev -e "DESCRIBE table_name;"
```

**Use QueryBuilder for all queries:**
```php
// SELECT with conditions
$result = $query->table('bugs')
                ->select(['id', 'title', 'status'])
                ->where('status', '=', 'open')
                ->orderBy('created_at', 'DESC')
                ->get();

// JOIN queries
$result = $query->table('bugs')
                ->select(['bugs.*', 'users.username'])
                ->join('users', 'bugs.reported_by', '=', 'users.id')
                ->get();

// INSERT
$id = $query->table('bugs')
            ->insert([
                'title' => $title,
                'status' => 'open',
                'created_at' => date('Y-m-d H:i:s')
            ]);

// UPDATE
$query->table('bugs')
      ->where('id', '=', $id)
      ->update(['status' => 'resolved']);

// DELETE
$query->table('bugs')
      ->where('id', '=', $id)
      ->delete();
```

---

## JavaScript Standards (MANDATORY)

### Rule 1: File Organization
**Location:** `assets/js/[feature].js`

**File Structure:**
```javascript
/**
 * [Feature Name] JavaScript
 *
 * Description of functionality
 *
 * @package FreeconomyToday
 * @subpackage JavaScript
 */

(function() {
    'use strict';

    // Constants
    const API_ENDPOINT = '/api/[endpoint]';

    // State
    let currentState = null;

    // Initialization
    document.addEventListener('DOMContentLoaded', function() {
        init();
    });

    // Functions
    function init() {
        attachEventListeners();
        loadInitialData();
    }

    function attachEventListeners() {
        // Event listeners here
    }

    // ... other functions

})();
```

### Rule 2: AJAX Standards

**Template:**
```javascript
function updateRecord(id, data) {
    fetch(`/admin/bugs/${id}/update`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-Token': document.querySelector('input[name="csrf_token"]').value
        },
        body: JSON.stringify(data)
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        if (data.success) {
            showSuccessMessage(data.message);
            updateUI(data);
        } else {
            showErrorMessage(data.message);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showErrorMessage('An error occurred. Please try again.');
    });
}
```

---

## Component Standards (MANDATORY)

### Rule 1: Component File Location
**Location:** `app/Views/components/[component-name].php`

### Rule 2: Component Template
```php
<?php
/**
 * [Component Name] Component
 *
 * Description of what this component does
 *
 * @param array $data Component data
 * @package FreeconomyToday
 * @subpackage Components
 */

use App\Core\View;

// Extract component data with defaults
$title = $data['title'] ?? '';
$description = $data['description'] ?? '';
$items = $data['items'] ?? [];
?>

<div class="component-[name]">
    <?php if (!empty($title)): ?>
        <h3 class="component-[name]__title"><?php echo View::escape($title); ?></h3>
    <?php endif; ?>

    <?php if (!empty($items)): ?>
        <div class="component-[name]__content">
            <?php foreach ($items as $item): ?>
                <div class="component-[name]__item">
                    <?php echo View::escape($item['name']); ?>
                </div>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>
</div>
```

### Rule 3: Component Usage
```php
<!-- In any view file -->
<?php
View::component('component-name', [
    'title' => 'Component Title',
    'description' => 'Description text',
    'items' => $dataArray
]);
?>
```

---

## Routing Standards (MANDATORY)

### Rule 1: Route Definition Location
**Location:** `public/index.php`

### Rule 2: Route Template
```php
// Basic route
$router->add('feature/action', [
    'controller' => 'FeatureController',
    'action' => 'actionMethod'
]);

// Route with authentication
$router->add('admin/feature', [
    'controller' => 'FeatureController',
    'action' => 'index',
    'middleware' => 'AuthMiddleware',
    'permission' => 'admin'
]);

// Route with parameters
$router->add('feature/{id:\d+}', [
    'controller' => 'FeatureController',
    'action' => 'show'
]);
```

---

## Documentation Standards (MANDATORY)

### Rule 1: Code Comments
**Every function MUST have a docblock:**

```php
/**
 * Brief description of what function does
 *
 * Detailed description if needed
 *
 * @param string $param1 Description of param1
 * @param int $param2 Description of param2
 * @return array|null Return value description
 * @throws Exception When exception is thrown
 */
public function myFunction($param1, $param2)
{
    // Implementation
}
```

### Rule 2: Implementation Documentation
**Every feature MUST have implementation documentation in:**
`docs/02_implementation_plans/IMPL-XXX_feature_name.md`

---

## Accessibility Standards (MANDATORY)

### Rule 1: Semantic HTML
```html
<!-- ✅ CORRECT -->
<button type="button">Click Me</button>
<nav aria-label="Main navigation">...</nav>
<main id="main-content">...</main>
<h1>Page Title</h1>

<!-- ❌ WRONG -->
<div onclick="...">Click Me</div>
<div class="navigation">...</div>
<div id="main-content">...</div>
<div class="title">Page Title</div>
```

### Rule 2: ARIA Labels
```html
<!-- Form inputs -->
<label for="username">Username</label>
<input type="text" id="username" name="username" aria-required="true">

<!-- Icon buttons -->
<button type="button" aria-label="Close modal">
    <span aria-hidden="true">×</span>
</button>

<!-- Status messages -->
<div role="alert" aria-live="polite">
    Success message here
</div>
```

### Rule 3: Keyboard Navigation
```javascript
// All interactive elements must be keyboard accessible
element.addEventListener('click', handleClick);
element.addEventListener('keypress', function(e) {
    if (e.key === 'Enter' || e.key === ' ') {
        handleClick(e);
    }
});
```

---

## Testing Standards (MANDATORY)

### Rule 1: Test File Location
**PHPUnit Tests:** `tests/Unit/[Feature]Test.php`
**Integration Tests:** `tests/Integration/[Feature]Test.php`

### Rule 2: Test Template
```php
<?php
namespace Tests\Unit;

use PHPUnit\Framework\TestCase;
use App\Models\[ModelName];

class [Feature]Test extends TestCase
{
    /**
     * Test description
     */
    public function testFeatureFunctionality()
    {
        // Arrange
        $model = new [ModelName]();

        // Act
        $result = $model->someMethod();

        // Assert
        $this->assertNotNull($result);
        $this->assertEquals('expected', $result['field']);
    }
}
```

---

## Git Standards (MANDATORY)

### Rule 1: Commit Message Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `refactor`: Code refactoring
- `docs`: Documentation changes
- `style`: CSS/formatting changes
- `test`: Adding/updating tests
- `chore`: Maintenance tasks

**Examples:**
```
feat(admin): Add bug filtering to admin dashboard

Implemented search and filter functionality for admin bug management.
Includes status, severity, and assignee filters with AJAX updates.

Closes US-042
```

### Rule 2: Branch Naming
```
feature/[feature-name]
bugfix/[bug-description]
hotfix/[critical-issue]
refactor/[refactor-description]
docs/[documentation-update]
```

---

## Checklist for New Features

Before submitting ANY code, verify:

- [ ] CSS uses ONLY variables from `variables.css`
- [ ] CSS follows BEM naming with feature prefix
- [ ] Dark mode support implemented
- [ ] Mobile responsive design tested
- [ ] All user input escaped with `View::escape()`
- [ ] CSRF token included in all forms
- [ ] Database queries use QueryBuilder
- [ ] Schema verified before writing queries
- [ ] All functions have docblocks
- [ ] Component follows established patterns
- [ ] JavaScript uses fetch API correctly
- [ ] ARIA labels on interactive elements
- [ ] Keyboard navigation supported
- [ ] Error handling implemented
- [ ] Empty states designed
- [ ] Success/error messages implemented
- [ ] Implementation documentation created
- [ ] Test cases written
- [ ] Code reviewed against this standards doc

---

## Enforcement

**This document is MANDATORY.**

Any code that violates these standards WILL BE REJECTED in code review.

Implementation LLMs must reference this document for EVERY feature implementation.

---


---

## Common Pitfalls & Prevention (MANDATORY CHECKS)

### Before Writing ANY Code

**These checks MUST be performed before planning or implementation:**

#### 1. BaseModel Usage Verification
```bash
# Check what methods BaseModel provides
grep -n "public function" dev/app/Models/BaseModel.php
```

**CRITICAL: BaseModel does NOT have:**
- ❌ `save()` method - Use `create($data)` for new records or `update($id, $data)` for existing
- ❌ ActiveRecord-style property setting - Models return arrays, not objects

**Correct patterns:**
```php
// ❌ WRONG - save() doesn't exist
$model = new Model();
$model->property = $value;
$model->save();

// ✅ CORRECT - Use create()
$model = new Model();
$data = ['property' => $value];
$record = $model->create($data);  // Returns array

// ✅ CORRECT - Use update()
$model = new Model();
$record = $model->update($id, ['property' => $value]);  // Returns array
```

#### 2. Controller Helper Methods Verification
```bash
# Check if controller has required helper methods
grep -n "function setFlashMessage\|function validateCSRFToken\|function redirect" dev/app/Controllers/ParentController.php
```

**Required methods in controllers:**
- `setFlashMessage()` - Must be implemented in controller (not in base Controller)
- `validateCSRFToken()` - Available in base Controller (protected)
- `redirect()` - Available in base Controller (protected)

#### 3. PHP 8.2+ Dynamic Properties
**ALWAYS add to models that set properties:**
```php
#[\AllowDynamicProperties]
class ModelName extends BaseModel
{
    // Model code
}
```

#### 4. Namespace Verification
**Check EVERY import statement:**
```bash
# Wrong
use App\Core\Database\BaseModel;  // ❌ BaseModel is NOT in Core\Database

# Correct
use App\Models\BaseModel;  // ✅ BaseModel is in Models
use App\Core\Database\QueryBuilder;  // ✅ QueryBuilder IS in Core\Database
use App\Core\Database\Database;  // ✅ Database IS in Core\Database
```

#### 5. QueryBuilder Limitations (CRITICAL)

**❌ NOT SUPPORTED:**
```php
// Closure-based WHERE clauses
$query->where(function($q) {
    $q->where('col1', '=', $val1)
      ->orWhere('col2', '=', $val2);
});

// JOIN with WHERE on aliased columns may fail
$query->join('table AS t', 't.id', '=', 'other.id')
      ->where('t.column', '=', $value)  // May cause "Unknown column" error
      ->count();  // Count() especially problematic with JOINs
```

**✅ CORRECT ALTERNATIVES:**
```php
// Use PHP filtering for OR logic
$results = $query->get();
$filtered = array_filter($results, function($item) use ($val1, $val2) {
    return $item['col1'] === $val1 || $item['col2'] === $val2;
});

// Use raw SQL for complex JOINs
$pdo = Database::getInstance()->getConnection();
$stmt = $pdo->prepare("
    SELECT t.*, o.*
    FROM table AS t
    JOIN other AS o ON o.id = t.other_id
    WHERE t.column = :value
");
$stmt->execute(['value' => $value]);
$results = $stmt->fetchAll(\PDO::FETCH_ASSOC);
```

#### 6. Method Existence Verification
```bash
# Before calling ANY method, verify it exists
grep -n "function methodName" dev/app/Path/To/Class.php

# If method doesn't exist, check parent class
grep -n "function methodName" dev/app/Core/ParentClass.php
```

---

## Questions?

If ANY part of these standards is unclear, ask the Tech Lead role LLM for clarification BEFORE implementing.

