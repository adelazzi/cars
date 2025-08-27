import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';

class CustomDropdown<T> extends StatefulWidget {
  final T value;
  final List<T> items;
  final String hint;
  final void Function(T?) onChanged;
  final String Function(T) itemToString;
  final double borderRadius;
  final Color borderColor;
  final Color fillColor;
  final bool enableSearch;
  final Color? selectedItemColor;
  final Widget? prefixIcon;
  final double? dropdownMaxHeight;

  const CustomDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.itemToString,
    this.hint = 'Select an option',
    this.borderRadius = 8.0,
    this.borderColor = Colors.grey,
    this.fillColor = MainColors.whiteColor,
    this.enableSearch = false,
    this.selectedItemColor,
    this.prefixIcon,
    this.dropdownMaxHeight,
  });
  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  bool _isDropdownOpen = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;
  OverlayEntry? _overlayEntry;
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = List<T>.from(widget.items);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation =
        Tween<double>(begin: 0.0, end: 0.5).animate(_expandAnimation);
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus && _isDropdownOpen) {
        _toggleDropdown(close: true);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    _removeDropdown();
    super.dispose();
  }

  void _toggleDropdown({bool close = false}) {
    if (_isDropdownOpen || close) {
      _removeDropdown();
      _animationController.reverse();
      _searchController.clear();
      _filteredItems = List<T>.from(widget.items);
    } else {
      _searchFocusNode.requestFocus();
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      _animationController.forward();
    }
    setState(() {
      _isDropdownOpen = !_isDropdownOpen && !close;
    });
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredItems = List<T>.from(widget.items);
      });
      return;
    }

    setState(() {
      _filteredItems = widget.items.where((item) {
        final itemText = widget.itemToString(item).toLowerCase();
        return itemText.contains(query.toLowerCase());
      }).toList();
    });

    // Update the overlay to reflect the filtered items
    _removeDropdown();
    if (_isDropdownOpen) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _selectItem(T item) {
    widget.onChanged(item);
    _toggleDropdown(close: true);
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            color: widget.fillColor,
            clipBehavior: Clip.antiAlias,
            child: SizeTransition(
              sizeFactor: _expandAnimation,
              axisAlignment: -1,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: widget.dropdownMaxHeight ?? 200.h,
                ),
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setStateOverlay) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        final isSelected = widget.value == item;

                        return InkWell(
                          onTap: () => _selectItem(item),
                          hoverColor: MainColors.primaryColor.withOpacity(0.1),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (widget.selectedItemColor ??
                                      MainColors.primaryColor.withOpacity(0.15))
                                  : Colors.transparent,
                              border: Border(
                                bottom: BorderSide(
                                  color: index == _filteredItems.length - 1
                                      ? Colors.transparent
                                      : Colors.grey.withOpacity(0.2),
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.itemToString(item),
                                    style:
                                        TextStyles.bodyMedium(context).copyWith(
                                      color: isSelected
                                          ? MainColors.primaryColor
                                          : MainColors.blackColor,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    Icons.check,
                                    color: MainColors.primaryColor,
                                    size: 18.sp,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () => _toggleDropdown(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 14.w),
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: _isDropdownOpen
                  ? MainColors.backgroundColor(context) ?? widget.borderColor
                  : widget.borderColor,
              width: _isDropdownOpen ? 1.5 : 1,
            ),
            color: MainColors.backgroundColor(context) ?? widget.fillColor,
            boxShadow: [
              BoxShadow(
                color: MainColors.shadowColor(context)!.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: _isDropdownOpen && widget.enableSearch
              ? _buildSearchField()
              : _buildDropdownDisplay(),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      focusNode: _searchFocusNode,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Search...',
        hintStyle: TextStyles.bodyMedium(context).copyWith(
          color: MainColors.textColor(context)!.withOpacity(0.3),
        ),
        prefixIcon: widget.prefixIcon ??
            Icon(
              Icons.search,
              color: MainColors.textColor(context),
              size: 20.sp,
            ),
        suffixIcon: RotationTransition(
          turns: _rotateAnimation,
          child: Icon(
            Icons.keyboard_arrow_down_sharp,
            color: MainColors.textColor(context),
          ),
        ),
      ),
      style: TextStyles.bodyMedium(context),
      onChanged: _onSearchChanged,
    );
  }

  Widget _buildDropdownDisplay() {
    return Row(
      children: [
        if (widget.prefixIcon != null)
          Padding(
            padding: EdgeInsets.only(right: 8.w, left: 8.w),
            child: widget.prefixIcon!,
          ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
            child: Text(
              widget.value != null
                  ? widget.itemToString(widget.value as T)
                  : widget.hint,
              style: TextStyles.bodyMedium(context).copyWith(
                color: widget.value != null
                    ? MainColors.textColor(context)
                    : MainColors.textColor(context)!.withOpacity(0.3),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: RotationTransition(
            turns: _rotateAnimation,
            child: Icon(
              Icons.keyboard_arrow_down_sharp,
              color: MainColors.textColor(context),
            ),
          ),
        ),
      ],
    );
  }
}

/*
Example usage:

// For a simple String dropdown
String selectedValue = 'Option 1';
final options = ['Option 1', 'Option 2', 'Option 3'];

CustomDropdown<String>(
  value: selectedValue,
  items: options,
  onChanged: (newValue) {
    setState(() {
      selectedValue = newValue!;
    });
  },
  itemToString: (item) => item,
  hint: 'Select an option',
  borderRadius: 10.0,
  borderColor: Colors.blue,
  fillColor: Colors.white,
  enableSearch: true,
  prefixIcon: Icon(Icons.category, color: MainColors.primaryColor),
  selectedItemColor: Colors.blue.withOpacity(0.1),
  dropdownMaxHeight: 300.h,
)

// For a custom object dropdown
class Category {
  final int id;
  final String name;
  
  Category(this.id, this.name);
}

Category selectedCategory = categories[0];
final categories = [
  Category(1, 'Electronics'),
  Category(2, 'Clothing'),
  Category(3, 'Books'),
];

CustomDropdown<Category>(
  value: selectedCategory,
  items: categories,
  onChanged: (newValue) {
    setState(() {
      selectedCategory = newValue!;
    });
  },
  itemToString: (category) => category.name,
  hint: 'Select a category',
  enableSearch: true,
  prefixIcon: Icon(Icons.category),
)
*/