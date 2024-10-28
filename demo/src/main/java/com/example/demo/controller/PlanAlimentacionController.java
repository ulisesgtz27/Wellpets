package com.example.demo.controller;

import com.example.demo.model.PlanAlimentacion;
import com.example.demo.service.PlanAlimentacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/plan-alimentacion")
public class PlanAlimentacionController {
    @Autowired
    private PlanAlimentacionService planAlimentacionService;

    @GetMapping
    public List<PlanAlimentacion> getAllPlanes() {
        return planAlimentacionService.getAllPlanes();
    }

    @PostMapping
    public ResponseEntity<PlanAlimentacion> createPlan(@RequestBody PlanAlimentacion planAlimentacion) {
        PlanAlimentacion newPlan = planAlimentacionService.savePlan(planAlimentacion);
        return new ResponseEntity<>(newPlan, HttpStatus.CREATED);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePlan(@PathVariable Long id) {
        planAlimentacionService.deletePlan(id);
        return ResponseEntity.noContent().build();
    }
}
