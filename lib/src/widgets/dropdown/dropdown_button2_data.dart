part of 'dropdown_button2.dart';

class ButtonStyleData {
  const ButtonStyleData({
    this.height,
    this.width,
    this.padding,
    this.decoration,
    this.elevation,
    this.overlayColor,
  });

  /// The height of the button
  final double? height;

  /// The width of the button
  final double? width;

  /// The inner padding of the Button
  final EdgeInsetsGeometry? padding;

  /// The decoration of the Button
  final BoxDecoration? decoration;

  /// The elevation of the Button
  final int? elevation;

  final WidgetStateProperty<Color?>? overlayColor;
}

class IconStyleData {
  const IconStyleData({
    this.icon = const Icon(Icons.arrow_drop_down),
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24,
    this.openMenuIcon,
  });

  /// The widget to use for the drop-down button's suffix icon.
  ///
  /// Defaults to an [Icon] with the [Icons.arrow_drop_down] glyph.
  final Widget icon;

  /// The color of any [Icon] descendant of [icon] if this button is disabled,
  /// i.e. if [onChanged] is null.
  ///
  /// Defaults to [MaterialColor.shade400] of [Colors.grey] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white10] when it is [Brightness.dark]
  final Color? iconDisabledColor;

  /// The color of any [Icon] descendant of [icon] if this button is enabled,
  /// i.e. if [onChanged] is defined.
  ///
  /// Defaults to [MaterialColor.shade700] of [Colors.grey] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white70] when it is [Brightness.dark]
  final Color? iconEnabledColor;

  /// The size to use for the drop-down button's icon.
  ///
  /// Defaults to 24.0.
  final double iconSize;

  /// Shows different icon when dropdown menu is open
  final Widget? openMenuIcon;
}

class DropdownStyleData {
  const DropdownStyleData({
    this.maxHeight,
    this.width,
    this.padding,
    this.scrollPadding,
    this.decoration,
    this.elevation = 8,
    this.direction = DropdownDirection.textDirection,
    this.offset = const Offset(0, 0),
    this.isOverButton = false,
    this.isFullScreen = false,
    this.scrollbarTheme,
    this.openInterval = const Interval(0.25, 0.5),
  });

  /// The maximum height of the dropdown menu
  ///
  /// The maximum height of the menu must be at least one row shorter than
  /// the height of the app's view. This ensures that a tappable area
  /// outside of the simple menu is present so the user can dismiss the menu.
  ///
  /// If this property is set above the maximum allowable height threshold
  /// mentioned above, then the menu defaults to being padded at the top
  /// and bottom of the menu by at one menu item's height.
  final double? maxHeight;

  /// The width of the dropdown menu
  final double? width;

  /// The inner padding of the dropdown menu
  final EdgeInsetsGeometry? padding;

  /// The inner padding of the dropdown menu including the scrollbar
  final EdgeInsetsGeometry? scrollPadding;

  /// The decoration of the dropdown menu
  final BoxDecoration? decoration;

  /// The z-coordinate at which to place the menu when open.
  ///
  /// The following elevations have defined shadows: 1, 2, 3, 4, 6, 8, 9, 12,
  /// 16, and 24. See [kElevationToShadow].
  ///
  /// Defaults to 8, the appropriate elevation for dropdown buttons.
  final int elevation;

  /// The direction of the dropdown menu in relation to the button.
  ///
  /// Default is [DropdownDirection.textDirection]
  final DropdownDirection direction;

  /// Changes the position of the dropdown menu
  final Offset offset;

  /// Opens the dropdown menu over the button instead of below it
  final bool isOverButton;

  /// Opens the dropdown menu in fullscreen mode (Above AppBar & TabBar)
  final bool isFullScreen;

  /// Configures the theme of the menu's scrollbar
  final ScrollbarThemeData? scrollbarTheme;

  /// The animation curve used for opening the dropdown menu (forward direction)
  final Interval openInterval;
}

class MenuItemStyleData {
  const MenuItemStyleData({
    this.height = _kMenuItemHeight,
    this.customHeights,
    this.padding,
    this.overlayColor,
    this.selectedMenuItemBuilder,
  });

  /// The height of the menu item, default value is [kMinInteractiveDimension]
  final double height;

  /// Define different heights for the menu items (useful for adding dividers)
  final List<double>? customHeights;

  /// The padding of menu items
  final EdgeInsetsGeometry? padding;


  final WidgetStateProperty<Color?>? overlayColor;

  /// A builder to customize the selected menu item.
  ///
  /// If this callback is null, the selected menu item will be displayed as other [items].
  ///
  /// You should return the child from the builder wrapped with the widget that
  /// customize your item, i.e:
  /// ```dart
  /// selectedMenuItemBuilder: (ctx, child) {
  ///   return Container(
  ///     color: Colors.blue,
  ///     child: child,
  ///   );
  /// },
  /// ```
  final SelectedMenuItemBuilder? selectedMenuItemBuilder;
}

class DropdownSearchData<T> {
  const DropdownSearchData({
    this.searchController,
    this.searchInnerWidget,
    this.searchInnerWidgetHeight,
    this.searchMatchFn,
  }) : assert(
          (searchInnerWidget == null) == (searchInnerWidgetHeight == null),
          "searchInnerWidgetHeight should not be null when using searchInnerWidget"
          "This is necessary to properly determine menu limits and scroll offset",
        );

  /// The TextEditingController used for searchable dropdowns. If this is null,
  /// then it'll perform as a normal dropdown without searching feature.
  final TextEditingController? searchController;

  /// The widget to use for searchable dropdowns, such as search bar.
  /// It will be shown at the top of the dropdown menu.
  final Widget? searchInnerWidget;

  /// The height of the searchInnerWidget if used.
  final double? searchInnerWidgetHeight;

  /// The match function used for searchable dropdowns. If this is null,
  /// then _defaultSearchMatchFn will be used.
  ///
  /// ```dart
  /// _defaultSearchMatchFn = (item, searchValue) =>
  ///   item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
  /// ```
  final SearchMatchFn<T>? searchMatchFn;
}
