import 'package:flutter/material.dart';

// class buat nyimpen data registrasi biar bisa dikirim ke halaman lain
class RegistrationData {
  final String name;
  final String email;
  final String city;
  final String gender;
  final DateTime? birthdate;
  final bool agree;

  const RegistrationData({
    required this.name,
    required this.email,
    required this.city,
    required this.gender,
    required this.birthdate,
    required this.agree
  });
}

// halaman registrasi
class RegisterPage extends StatefulWidget{
  const RegisterPage ({super.key});

  @override
  State<StatefulWidget>createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  // variabel buat handle input user
  bool _obscure = true; // buat hide/show password
  String? _gender; // simpan pilihan gender
  String? _kotalahir; // simpan pilihan kota lahir
  DateTime? _tanggalLahir; // simpan tanggal lahir
  bool _agree = false; // simpan apakah user setuju syarat & ketentuan

  // list pilihan kota yg bisa dipilih user
  final _kota = const ['Jakarta', 'Bandung', 'Surabaya', 'Denpasar', 'Makasar'];

  // controller buat ambil data dari textfield
  final _tgllhrText = TextEditingController();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  // kunci form biar bisa divalidasi
  final _formKey = GlobalKey<FormState>();

  // validator sederhana buat cek field wajib diisi
  String? _required(String? v) => (v == null || v.trim().isEmpty)
      ? 'Wajib Isi' : null;

  // fungsi buat munculin date picker dan ambil tanggal lahir
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 100); // range minimal 100 tahun lalu
    final last = DateTime(now.year + 1); // range maksimal tahun depan
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 20, now.month, now.day), // default 20 tahun lalu
      firstDate: first,
      lastDate: last,
    );
    if (picked != null){
      setState(() {
        _tanggalLahir = picked;
        // format tanggal biar lebih rapi dd-mm-yyyy
        _tgllhrText.text = '${picked.day.toString().padLeft(2,'0')}-'
            '${picked.month.toString().padLeft(2,'0')}-${picked.year}';
      });
    }
  }

  // fungsi buat submit form
  void _submit(){
    // cek kalau belum centang persetujuan, kasih snackbar
    if (!_agree){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Centang persetujuan terlebih dahulu!')),
      );
      return;
    }
    // cek validasi form
    if(_formKey.currentState!.validate()){
      // bikin objek data registrasi
      final data = RegistrationData(
        name: _name.text.trim(),
        email: _email.text.trim(),
        city: _kotalahir ?? '',
        gender: _gender ?? '-',
        birthdate: _tanggalLahir,
        agree: _agree,
      );
      // navigasi ke halaman home, sambil kirim data
      Navigator.of(context).pushNamed('/home', arguments: data);
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold (
      appBar: AppBar(
        title: const Text('Registrasi'),
        backgroundColor: const Color(0xFFFCD4D4),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // field input nama
                TextFormField(
                  controller: _name,
                  decoration:const InputDecoration(labelText: 'Nama'),
                  validator: _required,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 12),
                // field input email
                TextFormField(
                  controller: _email,
                  decoration:const InputDecoration(labelText: 'Email'),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 12),
                // field input password
                TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      // tombol untuk show/hide password
                      icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(()=> _obscure =!_obscure),
                      tooltip: _obscure ? 'Tampilkan': 'Sembunyikan',
                    ),
                  ),
                  obscureText: _obscure,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 12,),
                const Text('Jenis Kelamin', style: TextStyle(fontWeight: FontWeight.w600)),
                // radio button pilih gender
                Row(
                  children: [
                    Expanded(child: RadioListTile<String>(
                      title: const Text ('Laki-Laki'),
                      value: 'L',
                      groupValue: _gender,
                      onChanged: (v) => setState(() => _gender = v),
                      contentPadding: EdgeInsets.zero,
                    ),
                    ),
                    Expanded(child: RadioListTile<String>(
                      title: const Text ('Perempuan'),
                      value: 'P',
                      groupValue: _gender,
                      onChanged: (v) => setState(() => _gender = v),
                      contentPadding: EdgeInsets.zero,
                    ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // dropdown pilih kota lahir
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Kota Lahir'),
                  items: _kota.map((e) =>
                      DropdownMenuItem(value: e,child: Text(e))).toList(),
                  onChanged: (v) => setState(() => _kotalahir = v),
                ),
                const SizedBox(height: 12),
                // field input tanggal lahir (read only)
                TextFormField(
                  controller: _tgllhrText,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Lahir',
                    suffixIcon: IconButton(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.date_range),
                      tooltip: 'Pilih Tanggal',
                    ),
                  ),
                  onTap: _pickDate,
                ),
                const SizedBox(height: 12),
                // checkbox persetujuan
                CheckboxListTile(
                  value: _agree,
                  onChanged: (v) => setState(() => _agree = v ?? false),
                  title: const Text('Saya menyetujui syarat & ketentuan'),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 12),
                // tombol daftar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _submit,
                    icon: const Icon(Icons.check),
                    label: const Text('Daftar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF9A825),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
