# TODO: Implement Tabbed Navigation for Screens

## Completed Tasks
- [x] Modify MainScreen to pass tab change callback to HomeScreen
- [x] Update HomeScreen to accept onTabChange parameter and use it for action buttons
- [x] Fix action button onPressed to use onTabChange for nav bar screens (Support: index 1, Billing: index 2, More: index 3)
- [x] Use Navigator.pushNamed for page navigation (Schedule, Recycle, Events, Tips)
- [x] Remove Scaffold from SupportScreen to avoid double app bars
- [x] Remove Scaffold from BillingScreen to avoid double app bars
- [x] Remove Scaffold from MoreScreen to avoid double app bars

## Summary
The app now has a bottom navigation bar with Home, Support, Billing, and More screens. Clicking on action buttons in HomeScreen for Support, Billing, or More switches the tab while keeping the nav bar visible. Other buttons navigate to separate pages using Navigator.
