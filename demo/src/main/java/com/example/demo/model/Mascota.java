package com.example.demo.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Mascota") // Asegúrate de que el nombre de la tabla sea correcto
public class Mascota {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_mascota")
    private Long idMascota;

    @Column(name = "id_usuario")
    private Long idUsuario; // Puedes usar el tipo adecuado dependiendo de la relación

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Enumerated(EnumType.STRING)
    @Column(name = "sexo", nullable = false)
    private Sexo sexo;

    @Enumerated(EnumType.STRING)
    @Column(name = "raza", nullable = false)
    private Raza raza;

    @Column(name = "edad", nullable = false)
    private int edad;

    @Column(name = "peso", nullable = false)
    private double peso;

    @Enumerated(EnumType.STRING)
    @Column(name = "talla", nullable = false)
    private Talla talla;

    @Column(name = "sano", nullable = false)
    private boolean sano;

    // Getters y Setters

    public Long getIdMascota() {
        return idMascota;
    }

    public void setIdMascota(Long idMascota) {
        this.idMascota = idMascota;
    }

    public Long getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Long idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Sexo getSexo() {
        return sexo;
    }

    public void setSexo(Sexo sexo) {
        this.sexo = sexo;
    }

    public Raza getRaza() {
        return raza;
    }

    public void setRaza(Raza raza) {
        this.raza = raza;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }

    public Talla getTalla() {
        return talla;
    }

    public void setTalla(Talla talla) {
        this.talla = talla;
    }

    public boolean isSano() {
        return sano;
    }

    public void setSano(boolean sano) {
        this.sano = sano;
    }
}

// Enumeraciones para sexo, raza y talla

enum Sexo {
    Macho,
    Hembra
}

enum Raza {
    Pug,
    Chihuahua,
    Golden_Retriever,
    Labrador_Retriever,
    Beagle,
    Sin_raza
}

enum Talla {
    Pequeña,
    Media,
    Grande
}
