package com.example.demo.controller;

import com.example.demo.model.Recordatorio;
import com.example.demo.service.RecordatorioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/recordatorios")
public class RecordatorioController {
    @Autowired
    private RecordatorioService recordatorioService;

    @GetMapping
    public List<Recordatorio> getAllRecordatorios() {
        return recordatorioService.getAllRecordatorios();
    }

    @PostMapping
    public ResponseEntity<Recordatorio> createRecordatorio(@RequestBody Recordatorio recordatorio) {
        Recordatorio newRecordatorio = recordatorioService.saveRecordatorio(recordatorio);
        return new ResponseEntity<>(newRecordatorio, HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteRecordatorio(@PathVariable Long id) {
        recordatorioService.deleteRecordatorio(id);
        return ResponseEntity.noContent().build();
    }
}
