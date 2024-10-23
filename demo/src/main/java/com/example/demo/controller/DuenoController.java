package com.example.demo.controller;

import com.example.demo.model.Dueno;
import com.example.demo.service.DuenoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/duenos")
public class DuenoController {
    @Autowired
    private DuenoService duenoService;

    @GetMapping
    public List<Dueno> getAllDuenos() {
        return duenoService.getAllDuenos();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Dueno> getDuenoById(@PathVariable Long id) {
        Optional<Dueno> dueno = duenoService.getDuenoById(id);
        return dueno.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Dueno> createDueno(@RequestBody Dueno dueno) {
        Dueno newDueno = duenoService.saveDueno(dueno);
        return new ResponseEntity<>(newDueno, HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteDueno(@PathVariable Long id) {
        duenoService.deleteDueno(id);
        return ResponseEntity.noContent().build();
    }
}
