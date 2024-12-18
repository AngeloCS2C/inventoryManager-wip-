import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/stock_management/presentation/cubit/stock_cubit.dart';
import '../features/stock_management/domain/entities/stock.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StockCubit, StockState>(
        builder: (context, state) {
          if (state is StockLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StockLoaded) {
            return ListView.builder(
              itemCount: state.stocks.length,
              itemBuilder: (context, index) {
                final stock = state.stocks[index];
                final isEven = index % 2 == 0;
                return Card(
                  color:
                      isEven ? Colors.green.shade100 : Colors.yellow.shade100,
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: ListTile(
                    title: Text(
                      stock.itemName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('SKU: ${stock.sku}'),
                        Text(
                            'Cost Price: \$${stock.costPrice.toStringAsFixed(2)}'),
                        Text(
                            'Selling Price: \$${stock.sellingPrice.toStringAsFixed(2)}'),
                        Text('Quantity: ${stock.quantity}'),
                        Text('Minimum Stock Level: ${stock.minimumStockLevel}'),
                        Text('Description: ${stock.description}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.yellow),
                          onPressed: () {
                            _showEditStockDialog(context, stock);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<StockCubit>().deleteStock(stock.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is StockError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<StockCubit>().fetchStocks();
              },
              child: const Text('Load Stocks'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddStockDialog(context),
        backgroundColor: const Color.fromARGB(255, 144, 6, 165),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddStockDialog(BuildContext context) {
    final itemNameController = TextEditingController();
    final skuController = TextEditingController();
    final costPriceController = TextEditingController();
    final sellingPriceController = TextEditingController();
    final quantityController = TextEditingController();
    final minStockLevelController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Stock'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(itemNameController, 'Item Name'),
                _buildTextField(skuController, 'SKU'),
                _buildTextField(costPriceController, 'Cost Price',
                    isNumber: true),
                _buildTextField(sellingPriceController, 'Selling Price',
                    isNumber: true),
                _buildTextField(quantityController, 'Quantity', isNumber: true),
                _buildTextField(minStockLevelController, 'Min Stock Level',
                    isNumber: true),
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
                final stock = Stock(
                  id: DateTime.now().toString(),
                  itemName: itemNameController.text,
                  sku: skuController.text,
                  costPrice: double.tryParse(costPriceController.text) ?? 0.0,
                  sellingPrice:
                      double.tryParse(sellingPriceController.text) ?? 0.0,
                  quantity: int.tryParse(quantityController.text) ?? 0,
                  minimumStockLevel:
                      int.tryParse(minStockLevelController.text) ?? 0,
                  description: descriptionController.text,
                );
                context.read<StockCubit>().addStock(stock);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditStockDialog(BuildContext context, Stock stock) {
    final itemNameController = TextEditingController(text: stock.itemName);
    final skuController = TextEditingController(text: stock.sku);
    final costPriceController =
        TextEditingController(text: stock.costPrice.toString());
    final sellingPriceController =
        TextEditingController(text: stock.sellingPrice.toString());
    final quantityController =
        TextEditingController(text: stock.quantity.toString());
    final minStockLevelController =
        TextEditingController(text: stock.minimumStockLevel.toString());
    final descriptionController =
        TextEditingController(text: stock.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Stock'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(itemNameController, 'Item Name'),
                _buildTextField(skuController, 'SKU'),
                _buildTextField(costPriceController, 'Cost Price',
                    isNumber: true),
                _buildTextField(sellingPriceController, 'Selling Price',
                    isNumber: true),
                _buildTextField(quantityController, 'Quantity', isNumber: true),
                _buildTextField(minStockLevelController, 'Min Stock Level',
                    isNumber: true),
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
                final updatedStock = Stock(
                  id: stock.id,
                  itemName: itemNameController.text,
                  sku: skuController.text,
                  costPrice: double.tryParse(costPriceController.text) ?? 0.0,
                  sellingPrice:
                      double.tryParse(sellingPriceController.text) ?? 0.0,
                  quantity: int.tryParse(quantityController.text) ?? 0,
                  minimumStockLevel:
                      int.tryParse(minStockLevelController.text) ?? 0,
                  description: descriptionController.text,
                );
                context.read<StockCubit>().updateStock(stock.id, updatedStock);
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
