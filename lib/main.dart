import 'package:flutter/material.dart';
import 'src/data/database_helper.dart';
import 'estudiantes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    DatabaseHelper dbHelper = DatabaseHelper();
    Map<String, dynamic>? user = await dbHelper.getUser(username, password);

    if (user != null) {
      // Login successful, navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      setState(() {
        _message = 'Invalid credentials';
      });
    }
  }

  Future<void> _register() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    DatabaseHelper dbHelper = DatabaseHelper();
    await dbHelper.insertUser({'username': username, 'password': password});

    setState(() {
      _message = 'User registered';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proyecto de Metodologias'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent, // Color de fondo de la AppBar
        elevation: 0, // Sin sombra
        //Agregar icono
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
         /* child: Image.asset(
            'assets/img/BannerUTCweb.jpeg',
            fit: BoxFit.contain, // Ajusta la imagen dentro del contenedor
          ),
          */
        ),

      ),
      /*
      appBar: AppBar(
        title: SizedBox.shrink(), // Elimina el título del AppBar
        centerTitle: false,
        backgroundColor: Colors.blueAccent, // Color de fondo de la AppBar
        elevation: 0, // Sin sombra
        automaticallyImplyLeading: false, // Desactiva el botón de retroceso automático
        leading: Container(
          width: double.infinity, // Ocupa todo el ancho del AppBar
          height: AppBar().preferredSize.height, // Ajusta la altura de la imagen al alto del AppBar
          child: Image.asset(
            'assets/img/BannerUTCweb.jpeg',
            fit: BoxFit.cover, // Ajusta la imagen para cubrir todo el espacio del Container
            width: double.infinity, // Ajusta el ancho de la imagen para cubrir todo el espacio del Container
          ),
        ),
      ),
      */
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Aquí se agrega la imagen antes del campo de usuario y contraseña
            Image.asset(
              'assets/img/utc.png', // Asegúrate de que la ruta coincida con la ubicación real de tu imagen
              height: 100, // Ajusta la altura de la imagen según sea necesario
            ),
            SizedBox(height: 20), // Espacio entre la imagen y los campos de texto
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Aceptar',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                padding: EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Registrarse',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 20),
            Text(_message),
          ],
        ),
      ),
    );
  }
}
class HomeScreen extends StatelessWidget {
  //final String user;
  //HomeScreen({required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú Principal'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // Icono de flecha hacia atrás, puedes cambiarlo según tu preferencia
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/')); // Regresar a la pantalla inicial
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bienvenido XoloEstudiante\nSin miedo al éxito',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 250, // Ancho máximo para los botones
              child: ElevatedButton(
                onPressed: () {
                  // Acción para historial académico
                  // Ejemplo: Navigator.pushNamed(context, '/historial');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Calificaciones',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250, // Ancho máximo para los botones
              child: ElevatedButton(
                onPressed: () {
                  // Acción para becas
                  // Ejemplo: Navigator.pushNamed(context, '/becas');
                  // Navegar a la clase Estudiantes
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => EstudiantesScreen(),
                  ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Becas',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250, // Ancho máximo para los botones
              child: ElevatedButton(
                onPressed: () {
                  // Acción para pagos
                  // Ejemplo: Navigator.pushNamed(context, '/pagos');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Pagos',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}