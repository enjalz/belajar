void main(){
  // Dynamic itu tujuannya buat nambah semua jenis tipe data
  // Intinya dynamic itu kek bisa buat nampung data apapun
  // bahkan tanpa deklarasi value aja itu udh termasuk dynamic, contoh var contoh; itu termasuk tipe dynamic
  dynamic variable = 100;
  print(variable);

  variable = true;
  print(variable);

  variable = 'Angel';
  print(variable);

  // Konversi tipe data
  // kadang kita perlu konversi tipe data dari satu tipe ke tipe lain
  // biasanya ini di gunakan buat user inputnya sesuai gitu
  var inputString = '1000';
  var inputInt = int.parse(inputString); // parse itu buat ngubahnya
  var inputDouble = double.parse(inputString);

  var doubleFromInt = inputInt.toDouble();
  var intFromDouble = inputDouble.toInt();

  var intToString = inputInt.toString();
  var doubleToString = inputDouble.toString();

  print(inputString);
  print(inputInt);
  print(inputDouble);

  // kalo konversi boolean ke string itu pake toString()
  // kalo dari String to Boolean itu ga ada caranya
  var inputTulisan = true;
  var inputBoolean = inputTulisan.toString();
  var booleanToString = inputBoolean.toString();

  print(inputTulisan);
  print(inputBoolean);

  // Operator aritmatika
  // + Tambah
  // - Kurang
  // * Kali
  // (/) Pembagian, hasil Double
  // ~/ Pembagian, hasil Int
  // % Sisa Bagi

  var result1 = 10 + 10;
  var result2 = 100 - 10;
  var result3 = 5 * 5;
  var result4 = 10 / 3;
  var result5 = 10 ~/ 3;
  var result6 = 10 % 3;

  print('Result 1: $result1 \nResult 2: $result2 \nResult 3: $result3 \nResult 4: $result4 \nResult 5: $result5 \nResult 6: $result6');

  // Operator Perbandingan
  var number1 = 10;
  var number2 = 5;

  print(number1 == number2);
  print(number1 != number2);
  print(number1 > number2);
  print(number1 < number2);
  print(number1 >= number2);
  print(number1 <= number2);

  print('Angel' == 'Angel');
  print('Angel' != 'Angel');
}