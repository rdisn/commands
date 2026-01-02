# Common Pitfalls & Quick Fixes

**Version:** 1.1
**Last Updated:** 2025-12-12
**Purpose:** Quick reference for avoiding common implementation errors

---

## ⚠️ Top 7 Most Common Issues

### 1. ❌ Using `save()` method on BaseModel

**Error:**
```php
$model = new Model();
$model->property = $value;
$model->save();  // ❌ save() doesn't exist!
```

**Fix:**
```php
// For creating new records
$model = new Model();
$data = ['property' => $value];
$record = $model->create($data);  // ✅ Returns array

// For updating existing records
$model = new Model();
$record = $model->update($id, ['property' => $value]);  // ✅ Returns array
```

**Verification:**
```bash
grep -n "public function save" dev/app/Models/BaseModel.php
# Should return: (nothing - method doesn't exist)
```

---

### 2. ❌ Missing `setFlashMessage()` in Controllers

**Error:**
```
Fatal error: Call to undefined method Controller::setFlashMessage()
```

**Fix:**
Add to controller:
```php
private function setFlashMessage(string $type, string $message): void
{
    $_SESSION['flash_message'] = $message;
    $_SESSION['flash_type'] = $type;
}
```

**Note:** `validateCSRFToken()` and `redirect()` ARE in base Controller - don't duplicate them!

---

### 3. ❌ Missing `#[\AllowDynamicProperties]` on Models

**Error:**
```
Deprecated: Creation of dynamic property Model::$property is deprecated
```

**Fix:**
```php
#[\AllowDynamicProperties]  // ✅ Add this attribute
class ModelName extends BaseModel
{
    // Model code
}
```

---

### 4. ❌ Wrong Namespace for BaseModel

**Error:**
```php
use App\Core\Database\BaseModel;  // ❌ WRONG!
```

**Fix:**
```php
use App\Models\BaseModel;  // ✅ CORRECT
use App\Core\Database\QueryBuilder;  // ✅ CORRECT
use App\Core\Database\Database;  // ✅ CORRECT
```

---

### 5. ❌ QueryBuilder Closure-based WHERE

**Error:**
```php
$query->where(function($q) {  // ❌ NOT SUPPORTED
    $q->where('col1', '=', $val1)
      ->orWhere('col2', '=', $val2);
});
```

**Fix - Option 1: PHP Filtering**
```php
$results = $query->get();
$filtered = array_filter($results, function($item) use ($val1, $val2) {
    return $item['col1'] === $val1 || $item['col2'] === $val2;
});
```

**Fix - Option 2: Raw SQL**
```php
$pdo = Database::getInstance()->getConnection();
$stmt = $pdo->prepare("
    SELECT * FROM table
    WHERE col1 = :val1 OR col2 = :val2
");
$stmt->execute(['val1' => $val1, 'val2' => $val2]);
$results = $stmt->fetchAll(\PDO::FETCH_ASSOC);
```

---

### 6. ❌ Database Queries in Views

**Error:**
```php
<!-- In view.php -->
<?php
$query = new QueryBuilder($pdo);  // ❌ WRONG!
$data = $query->table('users')->get();
?>
```

**Fix:**
```php
// In Controller
public function index()
{
    $users = $this->userModel->all();
    $this->render('users/index', ['users' => $users]);  // ✅ CORRECT
}

// In view.php
<?php foreach ($users as $user): ?>  // ✅ Use pre-fetched data
    <div><?php echo View::escape($user['name']); ?></div>
<?php endforeach; ?>
```

---

### 7. ❌ QueryBuilder JOIN with WHERE on Aliased Columns

**Error:**
```php
$count = $query->table('assignments AS a')
    ->join('types AS t', 't.id', '=', 'a.type_id')
    ->where('t.is_active', '=', 1)  // ❌ May cause "Unknown column" error
    ->count();
```

**Fix - Use Raw SQL:**
```php
$pdo = Database::getInstance()->getConnection();
$stmt = $pdo->prepare("
    SELECT COUNT(*) as count
    FROM assignments AS a
    JOIN types AS t ON t.id = a.type_id
    WHERE t.is_active = 1
");
$stmt->execute();
$result = $stmt->fetch(\PDO::FETCH_ASSOC);
$count = (int)$result['count'];
```

---

### 8. ❌ Controller Constructor Missing `$route_params`

**Error:**
```
ArgumentCountError: Too few arguments to function App\Core\Controller::__construct(),
0 passed in ContractorRateController.php on line 24 and exactly 1 expected
```

**Wrong:**
```php
class MyController extends Controller
{
    public function __construct()  // ❌ Missing parameter
    {
        parent::__construct();  // ❌ Not passing parameter
    }
}
```

**Fix:**
```php
class MyController extends Controller
{
    public function __construct($route_params = [])  // ✅ Accept parameter
    {
        parent::__construct($route_params);  // ✅ Pass to parent

        // Your constructor code here
    }
}
```

**Prevention:**
Always check existing controllers in same namespace for constructor pattern:
```bash
grep -A 3 "public function __construct" dev/app/Controllers/Contractor/*.php
```

---

### 9. ❌ Wrong Auth Class Namespace or Methods

**Error 1: Wrong Namespace**
```
Fatal error: Class "App\Core\Auth" not found
```

**Error 2: Wrong Method Names**
```
Fatal error: Call to undefined method App\Core\Security\Auth::isLoggedIn()
Fatal error: Call to undefined method App\Core\Security\Auth::userId()
```

**Wrong:**
```php
use App\Core\Auth;  // ❌ Wrong namespace!

if (!Auth::isLoggedIn()) {  // ❌ Method doesn't exist
    // ...
}
$userId = Auth::userId();  // ❌ Method doesn't exist
```

**Fix:**
```php
use App\Core\Security\Auth;  // ✅ Correct namespace

if (!Auth::check()) {  // ✅ Correct method
    $this->redirect('auth/login');
    exit;
}

if (!Auth::hasPermission('contractor')) {  // ✅ Check permission
    $this->redirect('dashboard');
    exit;
}

$userId = $_SESSION['user_id'];  // ✅ Get user ID from session
```

**Available Auth Methods:**
- ✅ `Auth::check()` - Check if logged in
- ✅ `Auth::user()` - Get user array
- ✅ `Auth::hasPermission($name)` - Check permission
- ✅ `Auth::hasRole($name)` - Check role
- ✅ `Auth::getUserRoles()` - Get all roles
- ❌ `Auth::isLoggedIn()` - Does NOT exist
- ❌ `Auth::userId()` - Does NOT exist

**Verification:**
```bash
# Check available Auth methods
grep -n "public static function" dev/app/Core/Security/Auth.php
```

---

### 10. ❌ Missing Route Registration

**Error:**
```
Fatal error: Controller class App\Controllers\Contractor not found
```
(Error message is misleading - real issue is missing route!)

**Problem:**
Created controller `ContractorRateController` but forgot to add routes in `dev/public/index.php`

**Fix:**
Add routes for ALL controller actions:
```php
// In dev/public/index.php (around line 320-330 for Contractor routes)

// Contractor Rate Management
$router->add('contractor/rates', [
    'controller' => 'ContractorRateController',  // Without "Controller" would also work
    'action' => 'index',
    'namespace' => 'Contractor',  // ⚠️ CRITICAL for namespaced controllers
    'middleware' => 'AuthMiddleware'
]);

$router->add('contractor/rates/create', [
    'controller' => 'ContractorRateController',
    'action' => 'create',
    'namespace' => 'Contractor',
    'middleware' => 'AuthMiddleware'
]);

$router->add('contractor/rates/store', [
    'controller' => 'ContractorRateController',
    'action' => 'store',
    'namespace' => 'Contractor',
    'middleware' => 'AuthMiddleware'
]);

// ... etc for edit, update, destroy
```

**Prevention Checklist:**
- [ ] Route registered for EVERY public controller method
- [ ] Route controller name matches class (with or without "Controller" suffix)
- [ ] `namespace` parameter added for namespaced controllers (Admin, Contractor, Fleet, etc.)
- [ ] `middleware` added if authentication required
- [ ] `permission` added if authorization required
- [ ] Route parameters match method signatures (e.g., `{id:\d+}`)

**Verification:**
```bash
# Check if route exists
grep -n "contractor/rates" dev/public/index.php

# Should return: Line numbers where routes are defined
# If empty: Route is missing!
```

---

### 11. ❌ Missing Helper Methods in Controllers

**Error:**
```
Fatal error: Call to undefined method Controller::setFlashMessage()
Fatal error: Call to undefined method Controller::getValidationErrors()
Fatal error: Call to undefined method Controller::setValidationErrors()
```

**Problem:**
Controller calls helper methods that don't exist in base Controller

**Fix:**
Add these methods to your controller:

```php
/**
 * Set flash message in session
 */
private function setFlashMessage(string $type, string $message): void
{
    $_SESSION['flash_message'] = $message;
    $_SESSION['flash_type'] = $type;
}

/**
 * Get validation errors from session
 */
private function getValidationErrors(): array
{
    $errors = $_SESSION['validation_errors'] ?? [];
    unset($_SESSION['validation_errors']);
    return $errors;
}

/**
 * Set validation errors in session
 */
private function setValidationErrors(array $errors): void
{
    $_SESSION['validation_errors'] = $errors;
}
```

**Note:** `redirect()` and `validateCSRFToken()` ARE in base Controller - don't duplicate!

**Verification:**
```bash
# Check which methods exist in base Controller
grep -n "protected function" dev/app/Core/Controller.php

# Should show: redirect(), validateCSRFToken(), etc.
# Should NOT show: setFlashMessage(), getValidationErrors(), setValidationErrors()
```

---

## 📋 Pre-Implementation Checklist

**Run BEFORE writing ANY code:**

```bash
# 1. Verify database schema
"/mnt/c/xampp/mysql/bin/mysql.exe" -u root -pmindseye@41 freeconomy_dev -e "DESCRIBE table_name"

# 2. Check BaseModel methods
grep -n "public function" dev/app/Models/BaseModel.php

# 3. Check Controller methods
grep -n "protected function" dev/app/Core/Controller.php

# 4. Verify file exists
ls -la dev/app/Path/To/File.php

# 5. Check for similar patterns
grep -rn "similar_pattern" dev/app/
```

---

## 🔍 Code Review Checklist

**Check these FIRST during code review:**

- [ ] No `save()` calls on models (use `create()`/`update()`)
- [ ] Controllers have `setFlashMessage()` if they call it
- [ ] Models have `#[\AllowDynamicProperties]` attribute
- [ ] Namespaces are correct (BaseModel is in `App\Models`, Auth in `App\Core\Security`)
- [ ] No closure-based WHERE clauses
- [ ] No database queries in views
- [ ] No JOIN + WHERE + COUNT without raw SQL
- [ ] **NEW:** Controller constructors accept `$route_params = []`
- [ ] **NEW:** Auth methods use `check()` not `isLoggedIn()`, `$_SESSION['user_id']` not `userId()`
- [ ] **NEW:** All controller actions have routes in `dev/public/index.php`
- [ ] **NEW:** Routes for namespaced controllers include `'namespace' => 'X'` parameter
- [ ] **NEW:** Component variables passed correctly (check `$componentData` extraction)
- [ ] **NEW:** Database column names verified with `DESCRIBE table_name`
- [ ] **NEW:** QueryBuilder queries executed with `->get()`, `->first()`, etc.
- [ ] **NEW:** JSON responses use `exit;` to prevent contamination
- [ ] **NEW:** Route registration order puts specific routes before general ones
- [ ] **NEW:** Modal handling consistent (Bootstrap OR custom, not both)

---

## 🛠️ Common Error Messages & Fixes

| Error Message | Cause | Fix |
|---------------|-------|-----|
| `Call to undefined method Model::save()` | BaseModel doesn't have save() | Use `create($data)` or `update($id, $data)` |
| `Call to undefined method Controller::setFlashMessage()` | Method not in controller | Add `setFlashMessage()` method to controller |
| `Creation of dynamic property is deprecated` | PHP 8.2+ dynamic props | Add `#[\AllowDynamicProperties]` to model |
| `Class 'App\Core\Database\BaseModel' not found` | Wrong namespace | Change to `App\Models\BaseModel` |
| `Unknown column 'alias.column' in 'where clause'` | QueryBuilder JOIN issue | Use raw SQL for complex JOINs |
| `Access level to Controller::validateCSRFToken() must be protected` | Duplicate method | Remove duplicate (inherited from parent) |
| `Too few arguments to Controller::__construct()` | Missing $route_params | Add `public function __construct($route_params = [])` |
| `Class 'App\Core\Auth' not found` | Wrong Auth namespace | Change to `use App\Core\Security\Auth` |
| `Call to undefined method Auth::isLoggedIn()` | Method doesn't exist | Use `Auth::check()` instead |
| `Call to undefined method Auth::userId()` | Method doesn't exist | Use `$_SESSION['user_id']` instead |
| `Controller class App\Controllers\Contractor not found` | Missing route registration | Add route in `dev/public/index.php` with `'namespace' => 'Contractor'` |
| `service_id` is 0 in modal | Variable not passed correctly | Extract from `$componentData['serviceId']` not direct `$serviceId` |
| `Column not found: 1054 Unknown column 'field_options'` | Wrong column name | Use `DESCRIBE table_name` to verify actual column names |
| `Cannot use QueryBuilder as array` | Query not executed | Add `->first()`, `->get()`, or `->count()` to execute query |
| `unexpected token... is not valid JSON` | Response contaminated | Use `exit;` after JSON output, check for PHP errors |
| `404 No route matched` with parameters | Route order issue | Register specific routes before general ones |
| Modal cancel button not working | Bootstrap/custom conflict | Use consistent modal handling approach |

---

## 📚 Reference Documentation

- **Full Details:** [CLAUDE.md - Common Pitfalls & Prevention](/CLAUDE.md)
- **Implementation Template:** [00_templates/IMPLEMENTATION_PLAN_TEMPLATE.md](../00_templates/IMPLEMENTATION_PLAN_TEMPLATE.md)
- **Code Review Template:** [00_templates/CODE_REVIEW_TEMPLATE.md](../00_templates/CODE_REVIEW_TEMPLATE.md)
- **Site Standards:** [SITE_STANDARDS.md](SITE_STANDARDS.md)

---

## 🔄 Quick Decision Tree

```
Creating a controller?
├── Extends Controller? → Add __construct($route_params = [])
├── Calls parent::__construct()? → Pass $route_params
├── Needs authentication? → Use Auth::check() (not isLoggedIn())
├── Needs user ID? → Use $_SESSION['user_id'] (not Auth::userId())
├── Needs flash messages? → Add setFlashMessage() method
└── Has public methods? → Add routes in dev/public/index.php

Adding routes?
├── Namespaced controller? → Add 'namespace' => 'ControllerNamespace'
├── Needs auth? → Add 'middleware' => 'AuthMiddleware'
├── Needs permission? → Add 'permission' => 'permission_name'
└── Has parameters? → Use {id:\d+} pattern

Need to save a model?
├── New record? → Use create($data)
└── Existing record? → Use update($id, $data)

Need to query with OR logic?
├── Simple query? → Use QueryBuilder + PHP filter
└── Complex JOINs? → Use raw prepared SQL

Need to show data in view?
├── Query in view? → ❌ WRONG - Move to controller
└── Pre-fetched data? → ✅ CORRECT - Use from controller

Creating a model?
└── → Add #[\AllowDynamicProperties] attribute

Using Auth class?
├── Check if logged in? → Auth::check()
├── Get user ID? → $_SESSION['user_id']
├── Check permission? → Auth::hasPermission('name')
└── Import? → use App\Core\Security\Auth;

Need JOIN with WHERE on alias?
└── → Use raw prepared SQL (not QueryBuilder)
```

---

## 📝 Notes

- These pitfalls were documented after real issues encountered in development
- Always check CLAUDE.md for the most up-to-date patterns
- When in doubt, look for similar existing implementations in the codebase
- Use `grep -r "pattern" dev/app/` to find examples

---

## 12. ❌ Dependency on Rejected User Stories

**Error:**
Implementation references a field type or feature from a User Story that has been rejected

**Example (CR-009):**
```php
// In QuoteController.php
if (isset($value['field_type']) && $value['field_type'] === 'location_pair') {
    // location_pair field type was defined in US-008 which is REJECTED
}
```

**Fix:**
1. **Option A:** Implement the required field type within the current story
   ```php
   // Define location field structure inline
   $locationData = json_decode($value['field_value'] ?? '[]', true);
   if (isset($locationData['pickup_address']) && isset($locationData['dropoff_address'])) {
       // Process location fields
   }
   ```

2. **Option B:** Check dependency status before implementation
   ```bash
   # Always verify dependencies before starting
   grep -A 2 "US-008" docs/agile_framework/KANBAN.md
   # If status is [Rejected], do not reference its features
   ```

**Prevention:**
- Always check Kanban board for dependency status
- If dependency is rejected, either implement required features inline or wait for dependency to be approved
- Document alternative approaches in implementation plan

---

## 13. ❌ JavaScript Syntax Errors in Dynamic Function Calls

**Error:**
Missing parenthesis in function call with dynamic argument

**Example (distance-calculator.js line 935):**
```javascript
const route = L.polyline polyline_decode(routeData.geometry, {
//                           ^ Missing opening parenthesis
```

**Fix:**
```javascript
const route = L.polyline(polyline_decode(routeData.geometry), {
//                           ^ Add opening parenthesis
```

**Prevention:**
- Use linters to catch syntax errors
- Test JavaScript in browser console during development
- Pay attention to function call syntax, especially with nested functions

---

## 14. ❌ Referencing Non-Existent Database Columns

**Error:**
Code references database columns that don't exist in the schema

**Example (DistanceCalculationService.php):**
```php
// getCachedCalculation method tries to access location_data column
$lat = json_decode($result['location_data'], true)['origin']['lat'] ?? null;
//           ^^^^^^^^^^^^ This column doesn't exist in distance_calculations table
```

**Fix:**
Remove references to non-existent columns or store required data separately:
```php
// Option 1: Remove these references
return [
    'origin' => [
        'address' => $result['origin_address'],
        // Remove lat/lng as they're not stored
    ],
    // ...
];

// Option 2: Store lat/lng in separate columns in distance_calculations table
```

**Prevention:**
- Always verify database schema before writing code
- Use `DESCRIBE table_name` to check actual column names
- Keep migration files and implementation in sync

---

## 15. ❌ Modal/Component Variable Passing Issues

**Error:**
Modal component receives undefined or incorrect variables, causing `service_id` to be 0 or missing

**Example (add-field-modal.php):**
```php
// Parent view passes data like this:
$componentData = [
    'serviceId' => $service['id'],  // Correct key
    'fieldTypes' => $fieldTypes
];

// But modal component tries to access:
$serviceId = $serviceId ?? 0;  // ❌ Wrong - looks for direct variable
```

**Fix:**
Extract variables correctly from the component data array:
```php
// In modal component
$serviceId = $componentData['serviceId'] ?? $serviceId ?? 0;
$fieldTypes = $componentData['fieldTypes'] ?? $fieldTypes ?? [];
```

**Prevention:**
- Always check how data is being passed to components
- Use consistent variable naming between parent and component
- Add null coalescing operators with fallbacks

---

## 16. ❌ Database Column Name Mismatches

**Error:**
SQLSTATE[42S22]: Column not found: 1054 Unknown column 'field_options' in 'field list'

**Example:**
```php
// Controller tries to insert:
$fieldData = [
    'field_options' => $options,  // ❌ Column doesn't exist
    'default_value' => $value,    // ❌ Column doesn't exist
    'is_active' => 1              // ❌ Column doesn't exist
];
```

**Fix:**
Always verify database schema before writing insert/update code:
```bash
# Check actual column names
mysql -u root -p -e "DESCRIBE service_fields"
```

```php
// Correct column names:
$fieldData = [
    'options' => $options,  // ✅ Correct column name
    // Remove non-existent columns
];
```

**Prevention:**
- Run `DESCRIBE table_name` before ANY database operations
- Keep migration files and implementation in sync
- Don't assume column names - always verify

---

## 17. ❌ QueryBuilder Queries Not Executed

**Error:**
Cannot use object of type App\Core\Database\QueryBuilder as array

**Example (ServiceField.php):**
```php
$result = $this->getQueryBuilder()
    ->table($this->table)
    ->where('service_id', '=', $serviceId)
    ->orderBy('display_order', 'DESC')
    ->limit(1)
    ->select(['display_order']);  // ❌ Missing execution

return $result[0]['display_order'] ?? 0;  // Error: $result is QueryBuilder object
```

**Fix:**
Always execute the query with `->get()`, `->first()`, or `->count()`:
```php
$result = $this->getQueryBuilder()
    ->table($this->table)
    ->where('service_id', '=', $serviceId)
    ->orderBy('display_order', 'DESC')
    ->limit(1)
    ->select(['display_order'])
    ->first();  // ✅ Execute the query

return $result['display_order'] ?? 0;
```

**Prevention:**
- QueryBuilder builds queries - they must be executed
- Common execution methods: `get()`, `first()`, `find()`, `count()`
- If you get a QueryBuilder object when expecting an array, you forgot to execute

---

## 18. ❌ JSON Response Contamination

**Error:**
unexpected token... is not valid JSON

**Symptoms:**
- JSON response includes PHP errors, warnings, or HTML
- Response contains mixed content types

**Common Causes:**
1. PHP errors/warnings before JSON output
2. Missing `exit;` after JSON echo
3. HTML/output mixed with JSON

**Fix:**
```php
public function ajaxMethod(): void
{
    header('Content-Type: application/json');

    try {
        // Your logic here
        echo json_encode(['success' => true, 'data' => $data]);
        exit;  // ✅ Prevent additional output
    } catch (Exception $e) {
        echo json_encode(['success' => false, 'message' => $e->getMessage()]);
        exit;  // ✅ Prevent additional output
    }
}
```

**Prevention:**
- Always use `exit;` after JSON output
- Check for PHP errors in logs
- Use output buffering if necessary
- Set `display_errors = 0` in production

---

## 19. ❌ Route Registration Order Issues

**Error:**
404 No route matched for specific routes with parameters

**Example:**
```php
// Routes registered in wrong order:
$router->add('admin/services/fields/create', [...]);
$router->add('admin/services/field-options/{fieldType}', [...]);
//                       ^^^ This might match /fields/create incorrectly
```

**Fix:**
Register more specific routes before general ones:
```php
// Correct order - specific routes first:
$router->add('admin/services/field-options/{fieldType}', [...]);
$router->add('admin/services/fields/create', [...]);
```

**Prevention:**
- Routes are matched in registration order
- Put parameterized routes that could conflict before general routes
- Use specific patterns to avoid ambiguity

---

## 20. ❌ Modal Event Handling Conflicts

**Error:**
Cancel button not working in Bootstrap modal

**Cause:**
Mixing Bootstrap's `data-dismiss="modal"` with custom modal handling

**Example:**
```php
<button type="button" class="btn btn-secondary" data-dismiss="modal">
    Cancel
</button>
// JavaScript manually handles modal display/hiding
```

**Fix:**
Use consistent approach - either Bootstrap OR custom:
```javascript
// Option 1: Use Bootstrap properly
<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
$('#addFieldModal').modal('hide');

// Option 2: Use custom handling only
<button type="button" class="btn btn-secondary" id="cancelBtn">Cancel</button>
document.getElementById('cancelBtn').addEventListener('click', function() {
    modal.style.display = 'none';
});
```

**Prevention:**
- Don't mix Bootstrap modal JS with custom modal handling
- Choose one approach and stick with it
- Test all modal interactions

---

## 21. ❌ Incorrect CSRF View Method

**Error:**
Form submission fails with "Invalid request" or CSRF mismatch error

**Cause:**
Using `View::csrf()` which returns the token string, instead of `View::csrfField()` which creates the hidden input field.

**Example:**
```php
<form method="POST">
    <?php echo View::csrf(); ?>  <!-- ❌ Creates text, not an input -->
    <button type="submit">Submit</button>
</form>
```

**Fix:**
```php
<form method="POST">
    <?php echo View::csrfField(); ?>  <!-- ✅ Creates <input type="hidden" ...> -->
    <button type="submit">Submit</button>
</form>
```

---

## 22. ❌ CSRF Token Generation Before Session Start

**Error:**
CSRF token mismatch on first page load or new session.

**Cause:**
Generating CSRF token in `config.php` before `session_start()` is called, causing it to be lost or not associated with the session.

**Fix:**
Ensure `session_start()` is called BEFORE generating or accessing `$_SESSION` data.

```php
// ❌ Wrong Order
if (!isset($_SESSION['csrf_token'])) { ... }
session_start();

// ✅ Correct Order
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}
if (!isset($_SESSION['csrf_token'])) { ... }
```

---

## 23. ❌ QueryBuilder State Contamination

**Error:**
SQLSTATE[42S22]: Column not found: 1054 Unknown column 'alias.id' in 'field list'

**Cause:**
Reusing a `QueryBuilder` instance for a second query without resetting it. The SELECT columns or JOINs from the first query persist to the second.

**Example:**
```php
$query = new QueryBuilder($pdo);
$users = $query->table('users')->get();

// ... later ...
// ❌ WRONG: $query still has 'SELECT * FROM users' state
$posts = $query->table('posts')->get();
```

**Fix:**
Always instantiate a NEW QueryBuilder for distinct queries.

```php
$q1 = new QueryBuilder($pdo);
$users = $q1->table('users')->get();

$q2 = new QueryBuilder($pdo); // ✅ Fresh instance
$posts = $q2->table('posts')->get();
```

---

## 24. ❌ Database Schema Assumptions vs Reality

**Error:**
SQLSTATE[42S22]: Column not found: 1054 Unknown column 'xyz' in 'field list'

**Cause:**
Writing code based on a planned schema or assumption without verifying the actual database structure.

**Fix:**
Run `DESCRIBE table_name` BEFORE writing any query logic.

```bash
# Check actual columns
mysql -u root -p -e "DESCRIBE job_status_history"
```

**Prevention:**
- Do not assume column names match other tables (e.g., `job_id` vs `assignment_id`)
- Verify foreign keys and constraints

---

**Last Reviewed:** 2025-12-12
**Next Review:** Before each new major feature implementation