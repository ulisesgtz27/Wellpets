package com.example.demo.service;

import com.example.demo.model.Dueno;
import com.example.demo.repository.DuenoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DuenoService {
    @Autowired
    private DuenoRepository duenoRepository;

    public List<Dueno> getAllDuenos() {
        return duenoRepository.findAll();
    }

    public Optional<Dueno> getDuenoById(Long id) {
        return duenoRepository.findById(id);
    }

    public Dueno saveDueno(Dueno dueno) {
        return duenoRepository.save(dueno);
    }

    public void deleteDueno(Long id) {
        duenoRepository.deleteById(id);
    }
}
