import 'package:flutter/material.dart';

void main() {
  runApp(const CampusReserveApp());
}

// ================= COLORS =================

const Color navy = Color(0xFF173B70);
const Color blue = Color(0xFF2864B4);
const Color background = Color(0xFFF4F7FC);

// ================= MAIN APP =================

class CampusReserveApp extends StatefulWidget {
  const CampusReserveApp({super.key});

  @override
  State<CampusReserveApp> createState() => _CampusReserveAppState();
}

class _CampusReserveAppState extends State<CampusReserveApp> {
  final List<Map<String, String>> accounts = [];
  Map<String, String>? currentUser;

  void register(String name, String email, String phone, String password) {
    accounts.add({
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'role': 'Étudiant',
    });
  }

  String? login(String email, String password) {
    for (final account in accounts) {
      if (account['email'] == email &&
          account['password'] == password) {
        setState(() {
          currentUser = account;
        });
        return null;
      }
    }
    return 'Email ou mot de passe incorrect.';
  }

  void logout() {
    setState(() {
      currentUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Reserve',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: navy),
      ),
      home: currentUser == null
          ? WelcomeScreen(
        onLogin: login,
        onRegister: register,
        accounts: accounts,
        onSuccess: () => setState(() {}),
      )
          : HomeScreen(
       user: currentUser!,
        onLogout: logout,
      ),
    );
  }
}

// ================= REUSABLE FIELD =================

Widget buildField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  TextInputType keyboardType = TextInputType.text,
  bool obscure = false,
  Widget? suffix,
  String? Function(String?)? validator,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 17),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: navy),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFE0E6EF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: navy, width: 1.5),
        ),
      ),
    ),
  );
}

// ================= WELCOME SCREEN =================

class WelcomeScreen extends StatelessWidget {
  final Function(String, String) onLogin;
  final Function(String, String, String, String) onRegister;
  final List<Map<String, String>> accounts;
  final VoidCallback onSuccess;

  const WelcomeScreen({
    super.key,
    required this.onLogin,
    required this.onRegister,
    required this.accounts,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                const SizedBox(height: 35),
                Container(
                  height: 115,
                  width: 115,
                  decoration: BoxDecoration(
                    color: navy,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: navy.withOpacity(0.25),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.apartment_rounded,
                    color: Colors.white,
                    size: 65,
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Campus Reserve',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Réservation de salles et terrains',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                ),
                const SizedBox(height: 35),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Bienvenue !',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: navy,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Réservez facilement vos espaces universitaires.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: navy,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LoginScreen(
                                  onLogin: onLogin,
                                ),
                              ),
                            ).then((_) => onSuccess());
                          },
                          child: const Text(
                            'Se connecter',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: navy,
                            side: const BorderSide(color: navy),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RegisterScreen(
                                  onRegister: onRegister,
                                  accounts: accounts,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Créer un compte',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                const Text(
                  'Université de Gafsa',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= REGISTER SCREEN =================

class RegisterScreen extends StatefulWidget {
  final Function(String, String, String, String) onRegister;
  final List<Map<String, String>> accounts;

  const RegisterScreen({
    super.key,
    required this.onRegister,
    required this.accounts,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void createAccount() {
    if (!formKey.currentState!.validate()) return;

    final email = emailController.text.trim().toLowerCase();

    final exists = widget.accounts.any(
          (account) => account['email'] == email,
    );

    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cet email existe déjà.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    widget.onRegister(
      nameController.text.trim(),
      email,
      phoneController.text.trim(),
      passwordController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Compte créé avec succès !'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: navy,
        elevation: 0,
        title: const Text('Créer un compte'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Inscription',
                style: TextStyle(
                  color: navy,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Remplissez vos informations pour commencer.',
                style: TextStyle(color: Colors.blueGrey),
              ),
              const SizedBox(height: 30),
              buildField(
                controller: nameController,
                label: 'Nom complet',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Entrez votre nom.';
                  }
                  return null;
                },
              ),
              buildField(
                controller: emailController,
                label: 'Adresse Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null ||
                      !RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                          .hasMatch(value.trim())) {
                    return 'Email invalide.';
                  }
                  return null;
                },
              ),
              buildField(
                controller: phoneController,
                label: 'Numéro de téléphone',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Entrez votre numéro.';
                  }
                  return null;
                },
              ),
              buildField(
                controller: passwordController,
                label: 'Mot de passe',
                icon: Icons.lock_outline,
                obscure: hidePassword,
                suffix: IconButton(
                  onPressed: () {
                    setState(() => hidePassword = !hidePassword);
                  },
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Minimum 6 caractères.';
                  }
                  return null;
                },
              ),
              buildField(
                controller: confirmController,
                label: 'Confirmer le mot de passe',
                icon: Icons.lock_reset,
                obscure: true,
                validator: (value) {
                  if (value != passwordController.text) {
                    return 'Les mots de passe ne correspondent pas.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: createAccount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "S'inscrire",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= LOGIN SCREEN =================

class LoginScreen extends StatefulWidget {
  final Function(String, String) onLogin;

  const LoginScreen({
    super.key,
    required this.onLogin,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void connect() {
    final error = widget.onLogin(
      emailController.text.trim().toLowerCase(),
      passwordController.text,
    );

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: navy,
        elevation: 0,
        title: const Text('Connexion'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Icon(
              Icons.account_circle_rounded,
              size: 85,
              color: navy,
            ),
            const SizedBox(height: 20),
            const Text(
              'Bon retour !',
              style: TextStyle(
                fontSize: 29,
                color: navy,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Connectez-vous à votre compte.',
              style: TextStyle(color: Colors.blueGrey),
            ),
            const SizedBox(height: 35),
            buildField(
              controller: emailController,
              label: 'Adresse Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            buildField(
              controller: passwordController,
              label: 'Mot de passe',
              icon: Icons.lock_outline,
              obscure: hidePassword,
              suffix: IconButton(
                onPressed: () {
                  setState(() => hidePassword = !hidePassword);
                },
                icon: Icon(
                  hidePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: connect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: navy,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Se connecter',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class HomeScreen extends StatelessWidget {
  final Map<String,String> user;
  final VoidCallback onLogout;

  const HomeScreen({
    super.key,
    required this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Campus Reserve',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: navy,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Déconnexion'),
                  content: const Text(
                    'Voulez-vous vraiment vous déconnecter ?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Annuler'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onLogout();
                      },
                      child: const Text('Déconnexion'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Bienvenue, $user 👋',
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: navy,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Que souhaitez-vous faire aujourd’hui ?',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Premier bouton
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.meeting_room),
                label: const Text(
                  'Réserver une salle',
                  style: TextStyle(fontSize: 17),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RoomsScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.history),
                label: const Text(
                  'Mes réservations',
                  style: TextStyle(fontSize: 17),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fonctionnalité bientôt disponible'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- ROOMS SCREEN ----------------

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rooms = [
      {
        'name': 'Salle de cours',
        'icon': Icons.school,
        'description': 'Pour les cours et les réunions',
      },
      {
        'name': 'Salle informatique',
        'icon': Icons.computer,
        'description': 'Équipée d’ordinateurs',
      },
      {
        'name': 'Salle de réunion',
        'icon': Icons.groups,
        'description': 'Pour les travaux en groupe',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisir une salle'),
        backgroundColor: navy,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            elevation: 3,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: navy,
                child: Icon(
                  room['icon'] as IconData,
                  color: Colors.white,
                ),
              ),
              title: Text(
                room['name'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(room['description'] as String),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReservationScreen(
                      roomName: room['name'] as String,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ---------------- RESERVATION SCREEN ----------------

class ReservationScreen extends StatefulWidget {
  final String roomName;

  const ReservationScreen({
    super.key,
    required this.roomName,
  });

  @override
  State<ReservationScreen> createState() =>
      _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final nameController = TextEditingController();
  final purposeController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void dispose() {
    nameController.dispose();
    purposeController.dispose();
    super.dispose();
  }

  Future<void> chooseDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> chooseTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  void confirmReservation() {
    if (nameController.text.trim().isEmpty ||
        purposeController.text.trim().isEmpty ||
        selectedDate == null ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Réservation confirmée'),
        content: Text(
          'Votre demande pour ${widget.roomName} a été enregistrée.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réservation'),
        backgroundColor: navy,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.roomName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: navy,
              ),
            ),
            const SizedBox(height: 25),

            const Text(
              'Nom complet',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Entrez votre nom',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Motif de réservation',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: purposeController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Entrez le motif',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                onPressed: chooseDate,
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  selectedDate == null
                      ? 'Choisir une date'
                      : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                onPressed: chooseTime,
                icon: const Icon(Icons.access_time),
                label: Text(
                  selectedTime == null
                      ? 'Choisir une heure'
                      : selectedTime!.format(context),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: confirmReservation,
                child: const Text(
                  'Confirmer la réservation',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}