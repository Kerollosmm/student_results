# Results Screen Stability and Multi-Device Responsiveness Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fix the `GoRouterState` crash and ensure a seamless, responsive UI across Phone, Tablet, and Desktop.

**Architecture:** 
1. **Safety**: Move navigation redirects to `BlocListener` to avoid build-time routing errors.
2. **Adaptive Layout**: Use `LayoutBuilder` and `BoxConstraints` to dynamically adjust padding, font sizes, and component layouts based on screen width:
   - **Phone (< 600px)**: Compact padding, horizontal scroll for tables, stacked footer elements.
   - **Tablet (600px - 1024px)**: Moderate padding, wider tables, side-by-side footer actions.
   - **Desktop (> 1024px)**: Centered content with `maxWidth` (900px-1200px), generous padding, full-width headers.

**Tech Stack:** Flutter, flutter_bloc, go_router, Material 3

---

### Task 1: Fix GoRouterState Crash

**Files:**
- Modify: `lib/presentation/screens/results_screen.dart`

- [ ] **Step 1: Replace synchronous build-time redirect with BlocListener**

```dart
// lib/presentation/screens/results_screen.dart
return BlocListener<StudentResultsCubit, StudentResultsState>(
  listener: (context, state) {
    if (state is! StudentLoggedIn) {
      context.go('/');
    }
  },
  child: BlocBuilder<StudentResultsCubit, StudentResultsState>(
    builder: (context, state) {
      if (state is! StudentLoggedIn) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
      // ... rest of build
    },
  ),
);
```

- [ ] **Step 2: Remove the `WidgetsBinding.instance.addPostFrameCallback` block**

---

### Task 2: Implement Multi-Device Responsive UI

**Files:**
- Modify: `lib/presentation/screens/results_screen.dart`

- [ ] **Step 1: Wrap build content in LayoutBuilder**
Identify screen width breakpoints (e.g., 600 for tablet, 1024 for desktop).

- [ ] **Step 2: Adjust Layout for Header and Branding**
On small screens, use `Column` with centered alignment. On larger screens, use `Row` or `Wrap` with `spaceBetween`.

- [ ] **Step 3: Make DataTable fully responsive**
Wrap `DataTable` in a `SingleChildScrollView` with horizontal scrolling. Use `BoxConstraints` to ensure it doesn't force the parent width.

- [ ] **Step 4: Refactor Student Info and Footer Cards**
  - Use `Wrap` with `spacing` and `runSpacing`.
  - On Phone: Items take full width or stack.
  - On Tablet/Desktop: Items flow horizontally.

```dart
// Example responsive adjustment for info items:
final isMobile = constraints.maxWidth < 600;
// ...
Wrap(
  spacing: 24,
  runSpacing: 16,
  children: [
    SizedBox(
      width: isMobile ? double.infinity : null, // Stack on mobile
      child: _buildInfoItem(...),
    ),
    // ...
  ],
)
```

---

### Task 3: Final Verification and Cleanup

**Files:**
- Modify: `lib/presentation/screens/results_screen.dart`

- [ ] **Step 1: Run dart fix and format**
Run: `dart fix --apply && dart format .`

- [ ] **Step 2: Run final analysis**
Run: `flutter analyze`

- [ ] **Step 3: Commit changes**
```bash
git add lib/presentation/screens/results_screen.dart
git commit -m "fix(ui): resolve GoRouterState crash and implement multi-device responsiveness"
```
