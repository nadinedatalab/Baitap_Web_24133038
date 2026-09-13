package com.basicweb.shop.repository;

import com.basicweb.shop.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findTop10ByOrderByCreatedDateDesc();
    Page<Product> findAllByOrderByCreatedDateDesc(Pageable pageable);
}
