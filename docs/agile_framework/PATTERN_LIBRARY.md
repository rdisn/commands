# 🧠 Pattern Library - Approved Solutions

**Version:** 1.0
**Last Updated:** 2026-01-03
**Purpose:** Collection of proven, working patterns for common problems

---

## 📚 What This Is

Unlike COMMON_PITFALLS.md (what NOT to do), this file documents **what TO do** - working solutions that have been validated and should be reused.

## 🎯 How to Use This

**When planning or implementing:**
1. Search here first for your problem
2. Copy the approved pattern
3. Adapt to your specific use case
4. Document new patterns when you find working solutions

---

## 🔄 Controller Patterns

### Standard Controller with Authentication

**When:** Creating a new controller that needs authentication

**Pattern:**
```php
<?php

use App\Core\Controller;
use App\Core\Security\Auth;

#[\AllowDynamicProperties]
class MyController extends Controller
{
    public function __construct($route_params = [])
    {
        parent::__construct($route_params);

        // Check authentication
        if (!Auth::check()) {
            $this->redirect('auth/login');
            exit;
        }

        // Check authorization
        if (!Auth::hasPermission('my_permission')) {
            $this->redirect('dashboard');
            exit;
        }
    }

    public function index()
    {
        // Pre-fetch all data here
        $items = $this->myModel->getAll();

        $this->render('my/index', ['items' => $items]);
    }

    // Flash message helper (if needed)
    private function setFlashMessage(string $type, string $message): void
    {
        $_SESSION['flash_message'] = $message;
        $_SESSION['flash_type'] = $type;
    }
}
```

**Why This Works:**
- Correct constructor signature
- Authentication check
- Authorization check
- No database queries in views
- Proper helper methods

---

## 🗄️ Database Query Patterns

### Simple SELECT with WHERE

**When:** Fetching records with simple conditions

**Pattern:**
```php
$query = new QueryBuilder($pdo);
$results = $query->table('table_name')
                ->where('column', '=', $value)
                ->get();
```

### SELECT with OR Logic (PHP Filter)

**When:** Need OR conditions (QueryBuilder doesn't support closures)

**Pattern:**
```php
// Fetch all matching either condition
$results = $query->table('items')
                ->where('status', '=', 'active')
                ->get();

// Filter in PHP
$filtered = array_filter($results, function($item) use ($val1, $val2) {
    return $item['field1'] === $val1 || $item['field2'] === $val2;
});
```

### JOIN with WHERE on Aliased Columns

**When:** Complex JOIN with WHERE on alias

**Pattern:**
```php
$pdo = Database::getInstance()->getConnection();
$stmt = $pdo->prepare("
    SELECT t1.column1, t2.column2
    FROM table1 AS t1
    JOIN table2 AS t2 ON t2.id = t1.table2_id
    WHERE t2.status = :status
");
$stmt->execute(['status' => $active]);
$results = $stmt->fetchAll(\PDO::FETCH_ASSOC);
```

**Why This Works:**
- Raw prepared SQL prevents SQL injection
- Proper JOIN syntax
- WHERE on aliased columns works correctly

---

## 📝 Form Handling Patterns

### Standard Form with CSRF

**When:** Creating any form

**Pattern:**
```php
<form method="POST" action="/path/to/handler">
    <?php echo View::csrfField(); ?>

    <div class="form-group">
        <label for="fieldName">Field Label</label>
        <input type="text"
               id="fieldName"
               name="field_name"
               class="form-control"
               value="<?php echo View::escape($oldValue ?? ''); ?>">
    </div>

    <button type="submit" class="btn btn-primary">Submit</button>
</form>
```

**Why This Works:**
- CSRF protection included
- XSS prevention via View::escape()
- Proper form structure

### AJAX Form Handling

**When:** Submitting form via AJAX

**Pattern (PHP):**
```php
public function ajaxHandler(): void
{
    header('Content-Type: application/json');

    try {
        // Validate CSRF
        if (!View::validateCSRFToken($_POST['csrf_token'] ?? '')) {
            echo json_encode(['success' => false, 'message' => 'Invalid CSRF token']);
            exit;
        }

        // Process data
        $result = $this->model->create($_POST);

        echo json_encode(['success' => true, 'data' => $result]);
        exit; // CRITICAL: Prevent output contamination
    } catch (Exception $e) {
        echo json_encode(['success' => false, 'message' => $e->getMessage()]);
        exit;
    }
}
```

**Pattern (JavaScript):**
```javascript
fetch('/path/to/ajax-handler', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: new URLSearchParams(new FormData(form))
})
.then(response => response.json())
.then(data => {
    if (data.success) {
        // Handle success
    } else {
        // Handle error
        showError(data.message);
    }
});
```

**Why This Works:**
- CSRF validation
- Proper JSON headers
- `exit;` prevents contamination
- Error handling

---

## 🎨 CSS Patterns

### Standard Component Styles

**When:** Creating new UI components

**Pattern:**
```css
/* Use BEM naming with feature prefix */
.feature-name {
  /* MUST use CSS variables */
  background: var(--color-background);
  color: var(--color-text);
  padding: var(--space-4);
  border-radius: var(--radius-md);
  margin-bottom: var(--space-4);
}

/* Element */
.feature-name__title {
  font-size: var(--font-size-lg);
  font-weight: var(--font-weight-semibold);
  margin-bottom: var(--space-2);
}

/* Modifier */
.feature-name--highlighted {
  background: var(--color-primary);
  color: var(--color-white);
}

/* Dark mode support */
[data-theme="dark"] .feature-name {
  background: var(--color-background-dark);
  color: var(--color-text-dark);
}

/* Mobile responsive */
@media (max-width: 768px) {
  .feature-name {
    padding: var(--space-2);
    font-size: var(--font-size-base);
  }
}
```

**Why This Works:**
- Uses CSS variables only (no hardcoded values)
- BEM naming convention
- Dark mode support
- Mobile responsive
- Works with site theme switching

---

## 🔧 Model Patterns

### Standard Model

**When:** Creating a new model

**Pattern:**
```php
<?php

use App\Models\BaseModel;

#[\AllowDynamicProperties]  // CRITICAL for PHP 8.2+
class MyModel extends BaseModel
{
    protected $table = 'table_name';

    /**
     * Get all records
     */
    public function getAll(): array
    {
        $query = new QueryBuilder(Database::getInstance()->getConnection());
        return $query->table($this->table)
                    ->orderBy('created_at', 'DESC')
                    ->get();
    }

    /**
     * Find by ID
     */
    public function findById(int $id): ?array
    {
        $query = new QueryBuilder(Database::getInstance()->getConnection());
        $result = $query->table($this->table)
                    ->where('id', '=', $id)
                    ->first();

        return $result ?: null;
    }

    /**
     * Create new record
     */
    public function create(array $data): array
    {
        return $this->create($data); // Uses BaseModel::create()
    }

    /**
     * Update existing record
     */
    public function update(int $id, array $data): bool
    {
        return $this->update($id, $data); // Uses BaseModel::update()
    }
}
```

**Why This Works:**
- `#[\AllowDynamicProperties]` prevents PHP 8.2 warnings
- Uses BaseModel methods correctly
- Always returns arrays
- New QueryBuilder for each query (no state contamination)

---

## 🚀 Route Registration Patterns

### Standard Routes for Controller

**When:** Creating routes for a new controller

**Pattern:**
```php
// In dev/public/index.php

// For namespaced controllers (Admin, Contractor, etc.)
$router->add('my/path/index', [
    'controller' => 'MyController',
    'action' => 'index',
    'namespace' => 'MyNamespace',  // CRITICAL for namespaced controllers
    'middleware' => 'AuthMiddleware',
    'permission' => 'my_permission'
]);

$router->add('my/path/create', [
    'controller' => 'MyController',
    'action' => 'create',
    'namespace' => 'MyNamespace',
    'middleware' => 'AuthMiddleware'
]);

$router->add('my/path/store', [
    'controller' => 'MyController',
    'action' => 'store',
    'namespace' => 'MyNamespace',
    'middleware' => 'AuthMiddleware'
]);

$router->add('my/path/{id:\d+}/edit', [
    'controller' => 'MyController',
    'action' => 'edit',
    'namespace' => 'MyNamespace',
    'middleware' => 'AuthMiddleware'
]);

$router->add('my/path/{id:\d+}/update', [
    'controller' => 'MyController',
    'action' => 'update',
    'namespace' => 'MyNamespace',
    'middleware' => 'AuthMiddleware'
]);

$router->add('my/path/{id:\d+}/delete', [
    'controller' => 'MyController',
    'action' => 'destroy',
    'namespace' => 'MyNamespace',
    'middleware' => 'AuthMiddleware'
]);
```

**Why This Works:**
- All controller actions have routes
- Namespaced controllers have `namespace` parameter
- Protected routes have middleware
- Parameterized routes use `{id:\d+}` pattern

---

## 📊 View Patterns

### Standard View with Data Display

**When:** Creating a view to display data

**Pattern:**
```php
<?php
/**
 * My Feature View
 */
use App\Core\View;
?>

<div class="my-feature">
    <h1 class="my-feature__title">
        <?php echo View::escape($title); ?>
    </h1>

    <?php if (!empty($items)): ?>
        <table class="my-feature__table">
            <thead>
                <tr>
                    <th>Column 1</th>
                    <th>Column 2</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($items as $item): ?>
                    <tr>
                        <td><?php echo View::escape($item['column1']); ?></td>
                        <td><?php echo View::escape($item['column2']); ?></td>
                        <td>
                            <a href="/path/to/edit/<?php echo $item['id']; ?>">
                                Edit
                            </a>
                        </td>
                    </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    <?php else: ?>
        <p>No items found.</p>
    <?php endif; ?>
</div>
```

**Why This Works:**
- All output escaped with View::escape()
- No database queries in view
- Data pre-fetched by controller
- Proper empty state handling

---

## 🔐 Authentication Patterns

### Check User Logged In

**Pattern:**
```php
use App\Core\Security\Auth;

if (!Auth::check()) {
    $this->redirect('auth/login');
    exit;
}
```

### Get User ID

**Pattern:**
```php
$userId = $_SESSION['user_id'] ?? null;
```

### Check Permission

**Pattern:**
```php
if (!Auth::hasPermission('permission_name')) {
    $this->redirect('dashboard');
    exit;
}
```

**Why This Works:**
- Uses correct Auth namespace (`App\Core\Security\Auth`)
- Uses correct methods (`check()` not `isLoggedIn()`)
- Gets user ID from session directly
- Proper permission checking

---

## 📝 Contributing to This Library

**When you find a working solution:**

1. **Document it here** with:
   - When to use it
   - The complete pattern
   - Why it works

2. **Add cross-reference to COMMON_PITFALLS.md**
   - Link from the pitfall to the solution

3. **Update related templates**
   - Add pattern to IMPLEMENTATION_PLAN_TEMPLATE.md
   - Update PROMPT_LIBRARY.md

**Template for New Patterns:**
```markdown
### [Pattern Name]

**When:** [When to use this pattern]

**Pattern:**
[code here]

**Why This Works:**
[explanation]

**See Also:**
- COMMON_PITFALLS.md item #[number]
- [Related files]
```

---

**Last Updated:** 2026-01-03
**Maintained By:** Tech Lead (LLM-TL)
