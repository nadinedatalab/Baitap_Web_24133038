package com.basicweb.shop.controller;

import com.basicweb.shop.entity.Category;
import com.basicweb.shop.entity.User;
import com.basicweb.shop.service.CategoryService;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/category")
public class AdminCategoryController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping
    public String list(@RequestParam(defaultValue = "") String keyword,
                       @RequestParam(defaultValue = "1") int page,
                       Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login"; 
        
        Pageable pageable = PageRequest.of(page - 1, 5); // 5 items per page
        Page<Category> categoryPage = categoryService.getCategoriesWithPagination(keyword, pageable);
        
        model.addAttribute("categories", categoryPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", categoryPage.getTotalPages());
        model.addAttribute("keyword", keyword);
        return "admin/category/list";
    }

    @GetMapping("/create")
    public String showCreateForm(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login";
        model.addAttribute("category", new Category());
        return "admin/category/form";
    }

    @PostMapping("/create")
    public String createCategory(@ModelAttribute Category category, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login";
        categoryService.saveCategory(category);
        return "redirect:/admin/category";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login";
        Category category = categoryService.getCategoryById(id);
        model.addAttribute("category", category);
        return "admin/category/form";
    }

    @PostMapping("/edit/{id}")
    public String editCategory(@PathVariable Long id, @ModelAttribute Category category, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login";
        Category existing = categoryService.getCategoryById(id);
        if (existing != null) {
            existing.setName(category.getName());
            categoryService.saveCategory(existing);
        }
        return "redirect:/admin/category";
    }

    @GetMapping("/delete/{id}")
    public String deleteCategory(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !"ADMIN".equals(user.getRole())) return "redirect:/login";
        categoryService.deleteCategory(id);
        return "redirect:/admin/category";
    }
}
