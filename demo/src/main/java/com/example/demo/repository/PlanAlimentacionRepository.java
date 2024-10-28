package com.example.demo.repository;

import com.example.demo.model.PlanAlimentacion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PlanAlimentacionRepository extends JpaRepository<PlanAlimentacion, Long> {
}
