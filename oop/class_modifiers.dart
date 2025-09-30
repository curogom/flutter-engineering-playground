// 생성 가능, 확장 가능하지만 구현 가능하며 mixin으로 사용 가능
class Testing {
  log() {}
}

abstract class Drawable {
  void draw() {}
  void paint();
}

class Circle extends Drawable {
  @override
  void paint() {
    // paint 메서드 구현
  }
}

// 생성 불가능, 확장 가능하고 구현 가능
abstract class Vehicle {
  void moveForward(int meters) {
    print('meters $meters');
  }
}

class Car extends Vehicle {}

// 생성 불가능, 확장 불가능하지만 구현 가능
interface class People {
  void moveForward(int meters) {}
}

// 생성 불가능, 확장 불가능하지만 구현 가능 - 순수 인터페이스
abstract interface class Person {
  void moveForward(int meters);
}

// 생성 가능, 확장 가능하지만 구현 불가능
base class Animal {
  void moveForward(int meters) {
    // ...
  }
}

// 생성 가능, 확장 불가능하고 구현 불가능
final class Customer {}

// 생성 불가능, 확장 가능하지만 구현 가능하며 완전(exhaustive)함
sealed class Product {}
// Product product = Product();

class Perfume extends Product {}

class Jewelry implements Product {}

// 서브클래스는 인스턴스화 가능
Perfume perfume = Perfume();
Jewelry jewelry = Jewelry();

// 생성 불가능, 확장 불가능하고 구현 불가능
// mixin으로 사용 가능
mixin Flyable {
  void fly() {}
}

class Airplane with Flyable {}

final Airplane airplane = Airplane();

main() {
  final car = Car();
  car.moveForward(10);
  airplane.fly();
}
