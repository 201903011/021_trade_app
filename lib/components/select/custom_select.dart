import 'package:flutter/material.dart';
import 'package:minimals/theme/use_theme.dart';

/// A customizable select/dropdown component
class CustomSelect<T> extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final T? value;
  final List<SelectOption<T>> options;
  final Function(T?)? onChanged;
  final FormFieldValidator<T>? validator;
  final bool enabled;
  final bool required;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final SelectInputVariant variant;
  final SelectInputSize size;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double borderRadius;
  final bool searchable;
  final String? searchHint;
  final int? maxHeight;

  const CustomSelect({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.value,
    required this.options,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.required = false,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.variant = SelectInputVariant.outlined,
    this.size = SelectInputSize.medium,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius = 8.0,
    this.searchable = false,
    this.searchHint,
    this.maxHeight,
  });

  @override
  State<CustomSelect<T>> createState() => _CustomSelectState<T>();
}

class _CustomSelectState<T> extends State<CustomSelect<T>> {
  late List<SelectOption<T>> _filteredOptions;
  final TextEditingController _searchController = TextEditingController();
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _filteredOptions = widget.options;
    _searchController.addListener(_filterOptions);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterOptions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredOptions = widget.options.where((option) {
        return option.label.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = useTheme(context);
    final palette = theme.palette;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) _buildLabel(palette),
        _buildSelect(palette),
        if (widget.helperText != null || widget.errorText != null) _buildHelperText(palette),
      ],
    );
  }

  Widget _buildLabel(dynamic palette) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: widget.label,
          style: TextStyle(
            color: palette.text.primary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          children: [
            if (widget.required)
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: palette.common.error.main,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelect(dynamic palette) {
    final hasError = widget.errorText != null;
    final inputPadding = _getInputPadding();

    final selectedOption = widget.options.firstWhere(
      (option) => option.value == widget.value,
      orElse: () => SelectOption<T>(value: widget.value, label: ''),
    );

    return FormField<T>(
      initialValue: widget.value,
      validator: widget.validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: widget.enabled ? _toggleDropdown : null,
              child: Container(
                padding: widget.contentPadding ?? inputPadding,
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? _getBackgroundColor(palette),
                  border: _getBorder(palette, _isExpanded, hasError || field.hasError),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                child: Row(
                  children: [
                    if (widget.prefixIcon != null) ...[
                      widget.prefixIcon!,
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Text(
                        widget.value != null ? selectedOption.label : (widget.hint ?? ''),
                        style: TextStyle(
                          color: widget.value != null ? (widget.enabled ? palette.text.primary : palette.text.disabled) : palette.text.secondary,
                          fontSize: _getFontSize(),
                        ),
                      ),
                    ),
                    widget.suffixIcon ??
                        Icon(
                          _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          color: widget.enabled ? palette.text.secondary : palette.text.disabled,
                        ),
                  ],
                ),
              ),
            ),
            if (_isExpanded) _buildDropdown(palette, field),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: palette.common.error.main,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildDropdown(dynamic palette, FormFieldState<T> field) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      constraints: BoxConstraints(
        maxHeight: widget.maxHeight?.toDouble() ?? 200,
      ),
      decoration: BoxDecoration(
        color: palette.background.paper,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(color: palette.common.divider),
        boxShadow: [
          BoxShadow(
            color: palette.common.divider.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.searchable) _buildSearchField(palette),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredOptions.length,
              itemBuilder: (context, index) {
                final option = _filteredOptions[index];
                final isSelected = option.value == widget.value;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded = false;
                    });
                    field.didChange(option.value);
                    if (widget.onChanged != null) {
                      widget.onChanged!(option.value);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? palette.common.primary.main.withOpacity(0.1) : null,
                    ),
                    child: Row(
                      children: [
                        if (option.icon != null) ...[
                          option.icon!,
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          child: Text(
                            option.label,
                            style: TextStyle(
                              color: isSelected ? palette.common.primary.main : palette.text.primary,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check,
                            color: palette.common.primary.main,
                            size: 16,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(dynamic palette) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: palette.common.divider),
        ),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: widget.searchHint ?? 'Search...',
          prefixIcon: Icon(Icons.search, color: palette.text.secondary),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        ),
        style: TextStyle(
          color: palette.text.primary,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildHelperText(dynamic palette) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: widget.errorText != null
          ? Text(
              widget.errorText!,
              style: TextStyle(
                color: palette.common.error.main,
                fontSize: 12,
              ),
            )
          : widget.helperText != null
              ? Text(
                  widget.helperText!,
                  style: TextStyle(
                    color: palette.text.secondary,
                    fontSize: 12,
                  ),
                )
              : const SizedBox.shrink(),
    );
  }

  void _toggleDropdown() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (!_isExpanded) {
        _searchController.clear();
        _filteredOptions = widget.options;
      }
    });
  }

  EdgeInsetsGeometry _getInputPadding() {
    switch (widget.size) {
      case SelectInputSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case SelectInputSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case SelectInputSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 16);
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case SelectInputSize.small:
        return 13;
      case SelectInputSize.medium:
        return 14;
      case SelectInputSize.large:
        return 16;
    }
  }

  Color? _getBackgroundColor(dynamic palette) {
    if (widget.variant == SelectInputVariant.filled) {
      return palette.background.neutral;
    }
    return null;
  }

  Border _getBorder(dynamic palette, bool focused, bool hasError) {
    Color borderColor;

    if (hasError) {
      borderColor = palette.common.error.main;
    } else if (focused) {
      borderColor = widget.focusedBorderColor ?? palette.common.primary.main;
    } else {
      borderColor = widget.borderColor ?? palette.common.divider;
    }

    return Border.all(
      color: borderColor,
      width: focused ? 2.0 : 1.0,
    );
  }
}

/// Data class for select options
class SelectOption<T> {
  final T? value;
  final String label;
  final Widget? icon;
  final bool enabled;

  const SelectOption({
    required this.value,
    required this.label,
    this.icon,
    this.enabled = true,
  });

  SelectOption<T> copyWith({
    T? value,
    String? label,
    Widget? icon,
    bool? enabled,
  }) {
    return SelectOption<T>(
      value: value ?? this.value,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      enabled: enabled ?? this.enabled,
    );
  }
}

/// Select input variant enumeration
enum SelectInputVariant {
  outlined,
  filled,
  underline,
}

/// Select input size enumeration
enum SelectInputSize {
  small,
  medium,
  large,
}
