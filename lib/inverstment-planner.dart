import 'package:flutter/material.dart';
import 'package:investment_planner/text-field-provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Stock> stockList = [];

  void registerControllers(Stock stock) {
    if (stock.stockController.nameController == null) {
      stock.stockController.nameController = getTextEditingController();
      stock.stockController.unitsController = getTextEditingController();
      stock.stockController.priceController = getTextEditingController();
      stock.stockController.costController = getTextEditingController();
    }
  }

  TextEditingController getTextEditingController() {
    return TextEditingController()
      ..addListener(() {
        onChangeEvent();
      });
  }

  void disploseControllers(List<Stock> controllerList) {
    for (var controller in controllerList) {
      controller.stockController.nameController?.dispose();
      controller.stockController.unitsController?.dispose();
      controller.stockController.priceController?.dispose();
      controller.stockController.costController?.dispose();
    }
  }

  @override
  void dispose() {
    disploseControllers(stockList);
    super.dispose();
  }

  onChangeEvent() {
    for (var item in stockList) {
      var stockController = item.stockController;
      var units =
          double.tryParse(stockController.unitsController?.text ?? "") ?? 0;
      var price =
          double.tryParse(stockController.priceController?.text ?? "") ?? 0;
      var cost = units * price;
      item.stockController.costController?.value = item
              .stockController.costController?.value
              .copyWith(text: cost.toString()) ??
          const TextEditingValue();
    }
  }

  Widget singleItemList(Stock stock) {
    registerControllers(stock);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: TextFieldProvider.getControllerBasic(TextInputType.text,
                  stock.stockController.nameController, "Stock Name")),
          Expanded(
              flex: 2,
              child: TextFieldProvider.getControllerBasic(TextInputType.number,
                  stock.stockController.unitsController, "Units")),
          Expanded(
              flex: 2,
              child: TextFieldProvider.getControllerBasic(TextInputType.number,
                  stock.stockController.priceController, "Price")),
          Expanded(
              flex: 2,
              child: TextFieldProvider.getControllerBasic(TextInputType.number,
                  stock.stockController.costController, "Cost",
                  readOnly: true))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Investment Planner"),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white),
        body: Column(children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: stockList.length,
              itemBuilder: (context, index) {
                if (stockList.isEmpty) {
                  return const CircularProgressIndicator();
                } else {
                  return singleItemList(stockList[index]);
                }
              }),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: () {
              stockList.add(Stock());
              setState(() {});
            },
            child: const Text('Add Stocks'),
          )
        ]));
  }
}

class Stock {
  late String name;
  late int units = 0;
  late double price = 0;
  late double cost = 0;
  late StockController stockController = StockController();
}

class StockController {
  TextEditingController? nameController;
  TextEditingController? unitsController;
  TextEditingController? priceController;
  TextEditingController? costController;
}
