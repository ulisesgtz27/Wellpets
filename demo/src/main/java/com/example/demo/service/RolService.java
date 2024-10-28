package com.example.demo.service;

import com.example.demo.model.Rol;
import com.example.demo.repository.RolRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RolService {
    @Autowired
    private RolRepository rolRepository;

    public List<Rol> getAllRoles() {
        return rolRepository.findAll();
    }

    public Rol saveRol(Rol rol) {
        return rolRepository.save(rol);
    }

    public void deleteRol(Long id) {
        rolRepository.deleteById(id);
    }
}
