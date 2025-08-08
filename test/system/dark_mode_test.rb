require "application_system_test_case"

class DarkModeTest < ApplicationSystemTestCase
  test "dark mode toggle functionality" do
    visit root_path
    
    # Check that the theme toggle button is present
    assert_selector "button.theme-toggle"
    assert_selector "i.bi-moon-fill"
    
    # Check initial theme (should be light by default)
    assert_equal "light", page.evaluate_script("document.documentElement.getAttribute('data-theme') || 'light'")
    
    # Click the toggle button
    find("button.theme-toggle").click
    
    # Check that theme changed to dark
    assert_equal "dark", page.evaluate_script("document.documentElement.getAttribute('data-theme')")
    assert_selector "i.bi-sun-fill"
    
    # Click again to toggle back to light
    find("button.theme-toggle").click
    
    # Check that theme changed back to light
    assert_equal "light", page.evaluate_script("document.documentElement.getAttribute('data-theme')")
    assert_selector "i.bi-moon-fill"
  end
  
  test "dark mode persistence" do
    visit root_path
    
    # Set theme to dark
    find("button.theme-toggle").click
    assert_equal "dark", page.evaluate_script("document.documentElement.getAttribute('data-theme')")
    
    # Navigate to another page
    visit currencies_path
    
    # Check that theme persists
    assert_equal "dark", page.evaluate_script("document.documentElement.getAttribute('data-theme')")
    assert_selector "i.bi-sun-fill"
  end
end
