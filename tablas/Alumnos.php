<?php
class Alumnos
{
	private $tabla = "alumno";
	public $id;
	public $nombre;
	public $apellidos;
	public $dni;
	public $foto;
	public $claveaccesoalumno;
	public $idprofesor;
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

	function insertar()
	{
		$stmt = $this->conn->prepare("INSERT INTO " . $this->tabla . "(`nombre`, `apellidos`, `dni`, `claveaccesoalum`, `foto`, `idprofesor`) VALUES(?,?,?,?,?,?)");

		$this->nombre = strip_tags($this->nombre);
		$this->apellidos = strip_tags($this->apellidos);
		$this->dni = strip_tags($this->dni);
		$this->foto = strip_tags($this->foto);
		$this->claveaccesoalumno = strip_tags($this->claveaccesoalumno);
		$this->idprofesor = strip_tags($this->idprofesor);

		$stmt->bind_param("sssssi", $this->nombre, $this->apellidos, $this->dni, $this->claveaccesoalumno, $this->foto, $this->idprofesor);

		return $stmt->execute();

	}

	function actualizar()
	{
		$stmt = $this->conn->prepare("UPDATE " . $this->tabla . " SET nombre = ?, apellidos = ?, dni = ?, claveaccesoalum = ?, foto = ?, idprofesor = ? WHERE id = ?");

		$this->nombre = strip_tags($this->nombre);
		$this->apellidos = strip_tags($this->apellidos);
		$this->dni = strip_tags($this->dni);
		$this->foto = strip_tags($this->foto);
		$this->claveaccesoalumo = strip_tags($this->claveaccesoalumno);
		$this->idprofesor = strip_tags($this->idprofesor);
		$this->id = strip_tags($this->id);

		$stmt->bind_param("ssssssi", $this->nombre, $this->apellidos, $this->dni, $this->claveaccesoalumno, $this->foto, $this->idprofesor, $this->id);

		return $stmt->execute();
	}

	function borrar()
	{
		$stmt = $this->conn->prepare("DELETE FROM " . $this->tabla . " WHERE id = ?");
		$this->id = strip_tags($this->id);
		$stmt->bind_param("i", $this->id);
		return $stmt->execute();
	}

	function verificarCredenciales($dni, $contraseña) {
		$query = "SELECT claveaccesoalum FROM " . $this->tabla . " WHERE dni = ?";
		$stmt = $this->conn->prepare($query);
		$stmt->bind_param("s", $dni);
		$stmt->execute();
		$stmt->bind_result($hashedPassword);
		if ($stmt->fetch()) {
			return password_verify($contraseña, $hashedPassword);
		}
		return false;
	}
	

	public function obtenerDatosPorDNI($dni) {
		$query = "SELECT id, nombre, apellidos FROM " . $this->tabla . " WHERE dni = ? LIMIT 1";
		$stmt = $this->conn->prepare($query);
		$stmt->bind_param('s', $dni); 
		$stmt->execute();
		
		$result = $stmt->get_result();
		return $result->fetch_assoc();
	}
	
}
?>
