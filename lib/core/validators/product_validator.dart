class ProductValidator {
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a procut name";
    }

    if (value.length < 3) {
      return "Product name must be at least 3 characters long.";
    }

    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return "Product name can only contain letters, numbers, and underscores";
    }
    return null;
  }

  String? validateBarcode(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a barcode";
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return "Product name can only contain numbers";
    }

    return null;
  }
}
