<?php
class Profesor
{
	private $tabla = "profesor";
	public $id;
	public $nombre;
	public $apellidos;	
	public $dni;
	public $foto;
	public $claveaccesoprof;
	public $idarea;
	private $conn;

	public function __construct($db)
	{
		$this->conn = $db;
	}

	// Método para leer registros de la base de datos
	function leer()
	{
		if (isset($this->id) && $this->id >= 0) {
			$stmt = $this->conn->prepare("SELECT * FROM " . $this->tabla . " WHERE id = ?");
			$stmt->bind_param("i", $this->id);
		} else { 
			$stmt = $this->conn->prepare("SELECT * FROM " . $this->tabla);
		}
		$stmt->execute();
		$result = $stmt->get_result();
		return $result;
	}

	function leerDNI()
	{
		if (isset($this->dni) && $this->dni >= 0) {
			$stmt = $this->conn->prepare("SELECT * FROM " . $this->tabla . " WHERE dni = ?");
			$stmt->bind_param("i", $this->dni);
		} else { 
			$stmt = $this->conn->prepare("SELECT * FROM " . $this->tabla);
		}
		$stmt->execute();
		$result = $stmt->get_result();
		return $result;
	}

	// Método para insertar un nuevo registro en la tabla alumno
	function insertar()
	{
		$stmt = $this->conn->prepare("INSERT INTO " . $this->tabla . "(`nombre`, `apellidos`, `dni`, `claveaccesoprof`,`foto`,`idarea`) VALUES(?,?,?,?,?,?)");

		$this->nombre = strip_tags($this->nombre);
		$this->apellidos = strip_tags($this->apellidos);
		$this->dni = strip_tags($this->dni);
		$this->foto = strip_tags($this->foto);
		$this->claveaccesoprof = strip_tags($this->claveaccesoprof);
		$this->idarea = strip_tags($this->idarea);

		$stmt->bind_param("ssssss", $this->nombre, $this->apellidos, $this->dni, $this->claveaccesoprof,$this->foto, $this->idarea);

		return $stmt->execute();

	}

	// Método para actualizar un registro existente
	function actualizar()
	{
		$stmt = $this->conn->prepare("UPDATE " . $this->tabla . " SET nombre = ?, apellidos = ?, dni = ?, claveaccesoprof = ?, foto = ?, idarea = ? WHERE id = ?");


		$this->nombre = strip_tags($this->nombre);
		$this->apellidos = strip_tags($this->apellidos);
		$this->dni = strip_tags($this->dni);
		$this->claveaccesoprof = strip_tags($this->claveaccesoprof);
		$this->foto = strip_tags($this->foto);
		$this->idarea = strip_tags($this->idarea);
		$this->id = strip_tags($this->id);
		
		$stmt->bind_param("ssssssi", $this->nombre, $this->apellidos, $this->dni, $this->claveaccesoprof,$this->foto, $this->idarea, $this->id);

		return $stmt->execute();
	}

	// Método para borrar un registro
	function borrar()
	{
		$stmt = $this->conn->prepare("DELETE FROM " . $this->tabla . " WHERE id = ?");
		$this->id = strip_tags($this->id);
		$stmt->bind_param("i", $this->id);
		return $stmt->execute();
	}
	function verificarCredenciales($dni, $contraseña) {
		// Ajustar la consulta para que use el método correcto de mysqli
		$query = "SELECT * FROM " . $this->tabla . " WHERE dni = ? AND claveaccesoprof = ?";
		$stmt = $this->conn->prepare($query);
		$stmt->bind_param("ss", $dni, $contraseña); // 'ss' para dos parámetros de tipo string
		$stmt->execute();
		
		// Verificar si la consulta ha encontrado algún registro
		$result = $stmt->get_result();
		return $result->num_rows > 0; // Si hay registros, las credenciales son correctas
	}

	public function obtenerDatosPorDNI($dni) {
		$query = "SELECT id, nombre, apellidos, isOrientador FROM " . $this->tabla . " WHERE dni = ? LIMIT 1";
		$stmt = $this->conn->prepare($query);
		$stmt->bind_param('s', $dni); // Cambiar bindParam a bind_param
		$stmt->execute();
		
		$result = $stmt->get_result();
		return $result->fetch_assoc(); // Retorna los datos como un array asociativo
	}
	
	
}
?>
