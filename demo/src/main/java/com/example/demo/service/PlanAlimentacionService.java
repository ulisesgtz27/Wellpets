package com.example.demo.service;

import com.example.demo.model.PlanAlimentacion;
import com.example.demo.repository.PlanAlimentacionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PlanAlimentacionService {
    @Autowired
    private PlanAlimentacionRepository planAlimentacionRepository;

    public List<PlanAlimentacion> getAllPlanes() {
        return planAlimentacionRepository.findAll();
    }

    public PlanAlimentacion savePlan(PlanAlimentacion planAlimentacion) {
        return planAlimentacionRepository.save(planAlimentacion);
    }

    public void deletePlan(Long id) {
        planAlimentacionRepository.deleteById(id);
    }
}
