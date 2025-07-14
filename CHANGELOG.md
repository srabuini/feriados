# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- **New Calendar Methods for Enhanced Functionality**
  - `holidays_in_year(year)` - Returns all holidays for a specific year
  - `holidays_between(start_date, end_date)` - Returns holidays within a date range
  - `next_holiday(from_date = Date.today)` - Finds the next holiday from a given date
  - All new methods return consistent hash format: `{date: Date, name: String}`
  - Added comprehensive test suite for new calendar methods (`calendar_methods_test.rb`)
  - Added practical usage examples in `examples/new_calendar_methods.rb`

- **Development Environment Improvements**
  - Added `Gemfile` for better dependency management
  - Added `Rakefile` with test tasks for easier development workflow
  - Enhanced `gemspec` with additional metadata (bug tracker, changelog, source code URIs)
  - Added development dependencies: `rake ~> 13.0`

- **Documentation Enhancements**
  - Updated README.md with documentation for new calendar methods
  - Added practical examples showing usage of `holidays_in_year`, `holidays_between`, and `next_holiday`
  - Enhanced code examples with real-world scenarios

### Fixed
- **Date Refinements Improvements**
  - Fixed class variable initialization issues in Date refinements
  - Improved refinement implementation using `class_variable_set` instead of direct assignment
  - Added proper error handling for undefined class variables
  - Fixed refinement scope issues that were causing test failures
  - Enhanced Date.singleton_class refinement with getter method for calendar

### Changed
- **Enhanced API Consistency**
  - All holiday query methods now return consistent data structures
  - Improved method naming conventions and documentation
  - Better error handling across calendar methods

### Technical Details

#### New Method Specifications:

**`holidays_in_year(year)`**
- Parameters: `year` (Integer) - The year to search for holidays
- Returns: Array of hashes `[{date: Date, name: String}, ...]`
- Example: `calendar.holidays_in_year(2025)` returns all 18 holidays for 2025

**`holidays_between(start_date, end_date)`**
- Parameters: `start_date` (Date), `end_date` (Date) - Date range to search
- Returns: Array of hashes `[{date: Date, name: String}, ...]`
- Example: `calendar.holidays_between(Date.new(2025,3,1), Date.new(2025,5,31))`

**`next_holiday(from_date = Date.today)`**
- Parameters: `from_date` (Date, optional) - Starting date for search (defaults to today)
- Returns: Hash `{date: Date, name: String}` or `nil` if no holidays found
- Search range: Up to 2 years from the starting date
- Example: `calendar.next_holiday` finds next holiday from today

#### Performance Characteristics:
- `holidays_in_year`: O(365 * n) where n is number of rules
- `holidays_between`: O(days * n) where days is the range and n is number of rules
- `next_holiday`: O(days * n) with maximum 2-year search limit

#### Test Coverage:
- 6 new test cases covering normal usage, edge cases, and error conditions
- Tests for empty calendars, years without specific holidays, and boundary conditions
- All existing tests continue to pass (39 total test cases, 99 assertions)

### Breaking Changes
None. All changes are backward compatible.

### Migration Guide
No migration needed. All existing code will continue to work unchanged. New methods are purely additive.

---

## [4.4.0] - Previous Release
- Existing functionality for holiday calendar management
- Support for DayOfMonth, FixWeekDay, Function, and FixDate rules
- YAML and Hash loading capabilities
- Date refinements for holiday checking
