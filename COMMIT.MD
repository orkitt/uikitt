
## **Format**

Dear contributor , please follow this commit format.

## **Commit Types**
- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, missing semi-colons, etc)
- **refactor**: Code refactoring
- **perf**: Performance improvements
- **test**: Adding or updating tests
- **chore**: Maintenance tasks, dependencies, build config
- **ci**: CI/CD pipeline changes
- **revert**: Revert previous commit

## **Professional Commit Examples**

### **1. Feature Implementation**
```
feat(theme): add dynamic theme switching with system preference support

- Implement ThemeManager with system brightness detection
- Add theme persistence using SharedPreferences
- Create theme toggle widget with smooth animations
- Support light/dark/system theme modes

Resolves: #45
```

### **2. Bug Fix**
```
fix(responsive): correct breakpoint calculation on tablet devices

- Fix media query breakpoint logic for tablet screens
- Update responsive builder to handle edge cases
- Add comprehensive test coverage for breakpoints

Fixes: #123
```

### **3. Documentation**
```
docs(components): add comprehensive usage examples for UI components

- Create detailed examples for all button variants
- Add code snippets for form components
- Document responsive behavior patterns
- Include accessibility guidelines

Closes: #67
```

### **4. Refactoring**
```
refactor(core): reorganize project structure for better maintainability

- Move theme-related files to dedicated theme directory
- Separate abstractions from implementations
- Update import paths across the project
- Improve package export structure

BREAKING CHANGE: Import paths have changed from 'src/core/abstract' to 'src/core/foundation/abstract'
```

### **5. Performance Improvement**
```
perf(animation): optimize logo animation performance

- Replace multiple AnimationControllers with single controller
- Implement lazy loading for asset images
- Reduce widget rebuilds with const constructors
- Improve frame rate on low-end devices

Benchmark: 40% reduction in animation jank
```

### **6. Testing**
```
test(error): add comprehensive error handler test coverage

- Add unit tests for ErrorHandlerService
- Create widget tests for error screens
- Mock platform exceptions for reliable testing
- Achieve 95% code coverage for error module

Related to: #89
```

## **Orkitt-Specific Commit Examples**

### **Theme System**
```
feat(theme-engine): implement OrkittThemeEngine with palette support

- Create abstract OrkittThemeEngine interface
- Implement ThemeMaker with caching mechanism
- Add BrandTypo abstraction for typography
- Support custom color palettes and typography

Closes: #12
```

### **Responsive Components**
```
feat(responsive): implement adaptive layout system with breakpoints

- Create ResponsiveScope entry point widget
- Add breakpoint constants (mobile, tablet, desktop)
- Implement responsive builder pattern
- Support orientation-based layouts

Resolves: #23
```

### **Error Handling**
```
feat(error): implement customizable error screen abstraction

- Create OrkittErrorScreen abstract base class
- Add multiple built-in error screen themes
- Implement error reporting and retry mechanisms
- Support custom error screen implementations

Fixes: #34
```

### **UI Components**
```
feat(components): add OrkittButton with multiple variants

- Implement primary, secondary, and outline button styles
- Add loading states and disabled appearances
- Support icon integration and custom themes
- Include comprehensive accessibility features

Related to: #56
```

## **Commit Body Best Practices**

**Good:**
```
feat(typography): implement brand typography system

- Create BrandTypo abstract class with font scaling
- Add responsive text size calculations
- Implement text theme generation from brand typography
- Support custom font families and weights

BREAKING CHANGE: TextTheme generation now requires ColorScheme parameter
```

**Avoid:**
```
feat: update text stuff
- fixed some things
- made it better
```

## **Commit Footer Tags**
- `Fixes: #123` - Closes an issue
- `Resolves: #45` - Resolves feature request
- `BREAKING CHANGE:` - Indicates breaking changes
- `Related to: #67` - Related to other issues
- `Signed-off-by: Name <email>` - For DCO

## **Git Workflow Example**

```bash
# Start new feature
git checkout -b feat/theme-manager

# Make changes, then commit
git add .
git commit -m "feat(theme): implement theme manager with persistence

- Add ThemeManager with ChangeNotifier
- Implement theme mode persistence
- Create theme switching utilities
- Add system theme detection

Resolves: #15"

# Push branch
git push origin feat/theme-manager
```

## **Commit Template** (add to `.gitmessage`)
```
# <type>(<scope>): <subject>
# |<----  Using a Maximum Of 50 Characters  ---->|


# Explain why this change is being made
# |<----   Try To Limit Each Line to a Maximum Of 72 Characters   ---->|

# Provide links or keys to the ticket, if any
# Fixes: #123
# Resolves: #456
```

