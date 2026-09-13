package com.basicweb.shop.service;

import com.basicweb.shop.entity.Category;
import com.basicweb.shop.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

@Service
@SuppressWarnings("null")
public class CategoryService {
    @Autowired
    private CategoryRepository categoryRepository;

    public List<Category> getAllCategories() {
        return categoryRepository.findAll();
    }
    
    public Page<Category> getCategoriesWithPagination(String keyword, Pageable pageable) {
        if (keyword != null && !keyword.isEmpty()) {
            return categoryRepository.findByNameContainingIgnoreCase(keyword, pageable);
        }
        return categoryRepository.findAll(pageable);
    }
    
    public Category getCategoryById(Long id) {
        return categoryRepository.findById(id).orElse(null);
    }
    
    public Category saveCategory(Category category) {
        return categoryRepository.save(category);
    }
    
    public void deleteCategory(Long id) {
        categoryRepository.deleteById(id);
    }
}
