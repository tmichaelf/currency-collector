# Currency Collector

A Rails application for collecting and managing currency denominations from around the world.

## Features

- **Currency Management**: Add and manage different currencies from various countries
- **Denomination Tracking**: Track individual currency denominations (coins and bills)
- **Collection Management**: Create and manage personal currency collections
- **Dark Mode**: Toggle between light and dark themes with persistent preferences
- **Responsive Design**: Works on desktop and mobile devices
- **PWA Ready**: Progressive Web App capabilities for mobile installation

## Dark Mode

The application includes a comprehensive dark mode feature:

- **Toggle Button**: Located in the navigation bar with a moon/sun icon
- **Persistent Preferences**: Your theme choice is saved in localStorage
- **System Preference Detection**: Automatically detects your system's dark mode preference
- **Smooth Transitions**: All theme changes include smooth CSS transitions
- **Comprehensive Styling**: All components, forms, tables, and modals support dark mode

### How to Use Dark Mode

1. Look for the moon/sun icon in the top navigation bar
2. Click the icon to toggle between light and dark themes
3. Your preference will be automatically saved and restored on future visits

## Data Seeding Tasks

Curated seeders for historical variants:

- All US denominations (coins and bills)
  - Seed:
    ```bash
    bin/rake us_denominations:seed
    ```

- U.S. Fractional Currency (1862–1876)
  - Seed:
    ```bash
    bin/rake us_fractional_denominations:seed
    ```

- Soviet denominations (USSR)
  - Seed (auto-creates `SUR` currency if missing):
    ```bash
    bin/rake soviet_denominations:seed
    ```

These tasks upsert records into `currency_denominations` using fields like `composition`, `design_type`, `series`, and `mint_mark`.

## Development Setup

### Prerequisites

- Ruby 3.2+
- Rails 7.0+
- PostgreSQL (recommended) or SQLite

### Installation

1. Clone the repository
2. Install dependencies: `bundle install`
3. Setup database: `bin/rails db:setup`
4. Start the server: `bin/rails server`

### Running Tests

```bash
bin/rails test
```

### Dark Mode Testing

```bash
bin/rails test test/system/dark_mode_test.rb
```

## Technology Stack

- **Backend**: Ruby on Rails 7
- **Frontend**: Bootstrap 5, Stimulus.js
- **Styling**: SCSS with CSS custom properties for theming
- **Database**: PostgreSQL/SQLite
- **Icons**: Bootstrap Icons

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License.
