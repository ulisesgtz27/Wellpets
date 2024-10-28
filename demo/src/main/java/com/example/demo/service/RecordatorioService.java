package com.example.demo.service;

import com.example.demo.model.Recordatorio;
import com.example.demo.repository.RecordatorioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecordatorioService {
    @Autowired
    private RecordatorioRepository recordatorioRepository;

    public List<Recordatorio> getAllRecordatorios() {
        return recordatorioRepository.findAll();
    }

    public Recordatorio saveRecordatorio(Recordatorio recordatorio) {
        return recordatorioRepository.save(recordatorio);
    }

    public void deleteRecordatorio(Long id) {
        recordatorioRepository.deleteById(id);
    }
}
