import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/item_management/presentation/cubit/item_cubit.dart';
import '../features/item_management/domain/entities/item.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ItemCubit, ItemState>(
        builder: (context, state) {
          if (state is ItemLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ItemLoaded) {
            final items = state.items;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isEven = index % 2 == 0;

                return Card(
                  color: isEven ? Colors.green.shade50 : Colors.yellow.shade50,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SKU: ${item.sku}'),
                        Text('Category: ${item.category}'),
                        Text('Supplier: ${item.supplier}'),
                        Text(
                            'Cost Price: \$${item.costPrice.toStringAsFixed(2)}'),
                        Text(
                            'Selling Price: \$${item.sellingPrice.toStringAsFixed(2)}'),
                        Text('Quantity: ${item.quantity}'),
                        Text('Description: ${item.description}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.yellow),
                          onPressed: () {
                            _showEditItemDialog(context, item);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<ItemCubit>().deleteItem(item.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ItemError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<ItemCubit>().fetchItems();
              },
              child: const Text('Load Items'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddItemDialog(context),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Add Item Dialog
  void _showAddItemDialog(BuildContext context) {
    final nameController = TextEditingController();
    final skuController = TextEditingController();
    final categoryController = TextEditingController();
    final supplierController = TextEditingController();
    final costPriceController = TextEditingController();
    final sellingPriceController = TextEditingController();
    final quantityController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(nameController, 'Item Name'),
                _buildTextField(skuController, 'SKU'),
                _buildTextField(categoryController, 'Category'),
                _buildTextField(supplierController, 'Supplier'),
                _buildTextField(costPriceController, 'Cost Price',
                    isNumber: true),
                _buildTextField(sellingPriceController, 'Selling Price',
                    isNumber: true),
                _buildTextField(quantityController, 'Quantity', isNumber: true),
                _buildTextField(descriptionController, 'Description'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final item = Item(
                  id: DateTime.now().toString(),
                  name: nameController.text,
                  sku: skuController.text,
                  category: categoryController.text,
                  supplier: supplierController.text,
                  costPrice: double.tryParse(costPriceController.text) ?? 0.0,
                  sellingPrice:
                      double.tryParse(sellingPriceController.text) ?? 0.0,
                  quantity: int.tryParse(quantityController.text) ?? 0,
                  description: descriptionController.text,
                );
                context.read<ItemCubit>().addItem(item);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Edit Item Dialog
  void _showEditItemDialog(BuildContext context, Item item) {
    final nameController = TextEditingController(text: item.name);
    final skuController = TextEditingController(text: item.sku);
    final categoryController = TextEditingController(text: item.category);
    final supplierController = TextEditingController(text: item.supplier);
    final costPriceController =
        TextEditingController(text: item.costPrice.toString());
    final sellingPriceController =
        TextEditingController(text: item.sellingPrice.toString());
    final quantityController =
        TextEditingController(text: item.quantity.toString());
    final descriptionController = TextEditingController(text: item.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(nameController, 'Item Name'),
                _buildTextField(skuController, 'SKU'),
                _buildTextField(categoryController, 'Category'),
                _buildTextField(supplierController, 'Supplier'),
                _buildTextField(costPriceController, 'Cost Price',
                    isNumber: true),
                _buildTextField(sellingPriceController, 'Selling Price',
                    isNumber: true),
                _buildTextField(quantityController, 'Quantity', isNumber: true),
                _buildTextField(descriptionController, 'Description'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedItem = Item(
                  id: item.id,
                  name: nameController.text,
                  sku: skuController.text,
                  category: categoryController.text,
                  supplier: supplierController.text,
                  costPrice: double.tryParse(costPriceController.text) ?? 0.0,
                  sellingPrice:
                      double.tryParse(sellingPriceController.text) ?? 0.0,
                  quantity: int.tryParse(quantityController.text) ?? 0,
                  description: descriptionController.text,
                );
                context.read<ItemCubit>().updateItem(item.id, updatedItem);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    );
  }
}
