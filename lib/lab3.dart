import 'dart:async';
import 'dart:convert';

void runLab3() async {
  print("========== LAB 3 ==========\n");

  // =====================================================
  // Exercise 1 – Product Model & Repository
  // =====================================================

  print("Exercise 1: Product Model & Repository");

  ProductRepository repo = ProductRepository();

  // Listen to stream for newly added products
  repo.liveAdded().listen((product) {
    print("New Product Added: $product");
  });

  // Fetch all products using Future
  List<Product> products = await repo.getAll();

  print("Initial Products:");
  for (var product in products) {
    print(product);
  }

  // Add new products to stream
  repo.addProduct(Product(3, "Keyboard", 50.0));
  repo.addProduct(Product(4, "Mouse", 25.0));

  await Future.delayed(Duration(milliseconds: 500));

  print("\n");

  // =====================================================
  // Exercise 2 – User Repository with JSON
  // =====================================================

  print("Exercise 2: User Repository with JSON");

  UserRepository userRepo = UserRepository();

  List<User> users = await userRepo.fetchUsers();

  for (var user in users) {
    print(user);
  }

  print("\n");

  // =====================================================
  // Exercise 3 – Async + Microtask Debugging
  // =====================================================

  print("Exercise 3: Async + Microtask Debugging");

  print("Start");

  // Event queue
  Future(() {
    print("Future Event Executed");
  });

  // Microtask queue
  scheduleMicrotask(() {
    print("Microtask Executed");
  });

  print("End");

  // Expected Output:
  // Start
  // End
  // Microtask Executed
  // Future Event Executed

  await Future.delayed(Duration(milliseconds: 500));

  print("\n");

  // =====================================================
  // Exercise 4 – Stream Transformation
  // =====================================================

  print("Exercise 4: Stream Transformation");

  Stream<int> streamNumbers = Stream.fromIterable([1, 2, 3, 4, 5]);

  // Square numbers and filter even squares
  Stream<int> transformedStream = streamNumbers
      .map((number) => number * number)
      .where((number) => number % 2 == 0);

  await for (var value in transformedStream) {
    print("Output: $value");
  }

  print("\n");

  // =====================================================
  // Exercise 5 – Factory Constructors & Cache
  // =====================================================

  print("Exercise 5: Factory Constructors & Cache");

  Settings a = Settings();
  Settings b = Settings();

  print("Are a and b the same object?");
  print(identical(a, b)); // true

}

// =====================================================
// Exercise 1 Classes
// =====================================================

class Product {
  int id;
  String name;
  double price;

  Product(this.id, this.name, this.price);

  @override
  String toString() {
    return "Product(id: $id, name: $name, price: $price)";
  }
}

class ProductRepository {
  // Product list
  final List<Product> _products = [
    Product(1, "Laptop", 1200),
    Product(2, "Phone", 800),
  ];

  // Broadcast stream controller
  final StreamController<Product> _controller =
      StreamController<Product>.broadcast();

  // Simulate async fetching
  Future<List<Product>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    return _products;
  }

  // Return live stream
  Stream<Product> liveAdded() {
    return _controller.stream;
  }

  // Add product and emit stream event
  void addProduct(Product product) {
    _products.add(product);
    _controller.add(product);
  }
}

// =====================================================
// Exercise 2 Classes
// =====================================================

class User {
  String name;
  String email;

  User({required this.name, required this.email});

  // Factory constructor from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
    );
  }

  @override
  String toString() {
    return "User(name: $name, email: $email)";
  }
}

class UserRepository {
  Future<List<User>> fetchUsers() async {
    await Future.delayed(Duration(seconds: 1));

    // Simulated API JSON response
    String jsonString = '''
    [
      {"name":"Alice","email":"alice@gmail.com"},
      {"name":"Bob","email":"bob@gmail.com"}
    ]
    ''';

    // Decode JSON
    List<dynamic> jsonData = jsonDecode(jsonString);

    // Convert JSON to User objects
    return jsonData.map((item) => User.fromJson(item)).toList();
  }
}

// =====================================================
// Exercise 5 Class
// =====================================================

class Settings {
  // Singleton instance
  static final Settings _instance = Settings._internal();

  // Private constructor
  Settings._internal();

  // Factory constructor returns same instance
  factory Settings() {
    return _instance;
  }
}