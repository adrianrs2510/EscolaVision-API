<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type");

include_once '../basedatos/EscolaVision.php';
include_once '../tablas/Alumnos.php';
include_once '../tablas/Profesor.php';

$database = new EscolaVision();
$conex = $database->dameConexion();
$response = array();

// Leer los datos de la solicitud POST
$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['tipo'], $data['usuario'], $data['contraseña'])) {
    $tipo = $data['tipo'];
    $usuario = $data['usuario'];
    $contraseña = $data['contraseña'];

    if ($tipo === 'alumno') {
        $alumnos = new Alumnos($conex);
        $resultado = $alumnos->verificarCredenciales($usuario, $contraseña);
        
        if ($resultado) {
            // Obtener detalles adicionales del alumno
            $alumnoData = $alumnos->obtenerDatosPorDNI($usuario); 
            if ($alumnoData) {
                $response['status'] = "success";
                $response['message'] = "Login exitoso";
                $response['id'] = $alumnoData['id'];
                $response['nombre'] = $alumnoData['nombre'];
                $response['apellidos'] = $alumnoData['apellidos'];
                $response['dni'] = $alumnoData['dni'];
                $response['idProfesor'] = $alumnoData['idProfesor'];
                $response['tipo'] = $tipo;
            } else {
                $response['status'] = "error";
                $response['message'] = "Error al obtener datos del alumno";
            }
        } else {
            $response['status'] = "error";
            $response['message'] = "Credenciales incorrectas";
        }

    } elseif ($tipo === 'profesor') {
        $profesores = new Profesor($conex);
        $resultado = $profesores->verificarCredenciales($usuario, $contraseña);
        
        if ($resultado) {
            // Obtener detalles adicionales del profesor
            $profesorData = $profesores->obtenerDatosPorDNI($usuario); // Asegúrate de que este método retorne también el `id`
            if ($profesorData) {
                $response['status'] = "success";
                $response['message'] = "Login exitoso";
                $response['id'] = $profesorData['id'];
                $response['nombre'] = $profesorData['nombre'];
                $response['apellidos'] = $profesorData['apellidos'];
                $response['dni'] = $profesorData['dni'];
                $response['idArea'] = $profesorData['idArea'];
                $response['isOrientador'] = $profesorData['isOrientador'];
                $response['tipo'] = $tipo;
            } else {
                $response['status'] = "error";
                $response['message'] = "Error al obtener datos del profesor";
            }
        } else {
            $response['status'] = "error";
            $response['message'] = "Credenciales incorrectas";
        }

    } else {
        $response['status'] = "error";
        $response['message'] = "Tipo de usuario no válido.";
    }

} else {
    $response['status'] = "error";
    $response['message'] = "Faltan parámetros necesarios";
}

echo json_encode($response);
?>